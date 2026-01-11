#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = [
#   "pandas>=2.0.0",
#   "pyyaml>=6.0",
# ]
# ///
"""
CSF Stage 7a: Interpret Brand-Level Results

Generate structured YAML interpretations from Brand-Level Results CSV files.
Applies deterministic CSF, Price Elasticity, and MSP categorization rules.

Usage:
    ./interpret_results.py [input_csv] [output_yaml] [options]

Options:
    --project-name NAME     - Project name for YAML header
    --market MARKET         - Market identifier (uk, us, etc.)
    --categories CATS       - Comma-separated categories
    --level LEVEL           - Analysis level (brand_level, brand_variant_level, brand_variant_ppg_level)
    --help                  - Show this help

Examples:
    ./interpret_results.py 6.Brand_Level_Results.csv interpretation.yaml
    ./interpret_results.py results.csv output.yaml --project-name "UK BBQ" --market uk
"""

import sys
import pandas as pd
import yaml
from pathlib import Path
from typing import Dict, List, Any, Optional

# ============================================================================
# CONFIGURATION - Adapt these defaults for your project
# ============================================================================

DEFAULT_INPUT_FILE = "6.Brand_Level_Results.csv"
DEFAULT_OUTPUT_FILE = "interpretation.yaml"
DEFAULT_PROJECT_NAME = None  # Will prompt or leave blank for Claude to fill
DEFAULT_MARKET = None        # Will prompt or leave blank
DEFAULT_CATEGORIES = []      # Will infer from data or leave blank
DEFAULT_LEVEL = None         # Will auto-infer from data

# ============================================================================
# INTERPRETATION RULES - Based on presentation-generation.md
# ============================================================================

CSF_THRESHOLDS = {
    "high": 2.0,       # CSF >= 2.0
    "medium_low": 1.7,  # CSF < 1.7 (combined threshold for medium/low)
    "low": 1.6,        # CSF < 1.6
}

PE_THRESHOLDS = {
    "less_elastic": -4.0,      # PE >= -4
    "moderately_low": -5.0,     # PE between -5 and -7
    "moderately_high": -7.0,
    "highly_elastic": -8.0,     # PE < -8
}

MSP_THRESHOLD = 0.001  # Tolerance for "stable"

CSF_INTERPRETATIONS = {
    "high": "Strong customer loyalty, low switching risk, brand is relatively protected from competitive pressure",
    "medium": "Moderate loyalty, some switching risk exists if competitors offer better value, performance depends on pricing and promotions",
    "low": "Weak loyalty, high risk of switching to competing brands, vulnerable to price changes and competitive actions",
}

PE_INTERPRETATIONS = {
    "less_elastic": "Low price sensitivity, price increases are likely to be absorbed, limited volume loss expected",
    "moderately_elastic": "Customers respond noticeably to price changes, some volume decline may occur, pricing actions should be taken with caution",
    "highly_elastic": "Very price sensitive, even small price increases may lead to significant volume loss, high risk associated with price increases",
}

MSP_INTERPRETATIONS = {
    "positive": "Brand is gaining market share, indicates improving competitiveness or stronger customer preference",
    "stable": "Market share is stable, brand is maintaining its position within the channel",
    "negative": "Brand is losing market share, indicates competitive pressure or declining customer preference",
}

MARKET_POSITION_INTERPRETATIONS = {
    "leader": "Market leader, majority of customers prefer this brand, competitive pressure is low",
    "follower": "Not the market leader, customers are more spread across brands, competitive pressure is higher",
}

# ============================================================================
# CATEGORIZATION FUNCTIONS
# ============================================================================

def categorize_csf(csf: float) -> str:
    """Categorize CSF value into high/medium/low."""
    if csf >= CSF_THRESHOLDS["high"]:
        return "high"
    elif csf >= CSF_THRESHOLDS["medium_low"]:
        return "medium"
    else:
        return "low"


def categorize_pe(pe: float) -> str:
    """Categorize Price Elasticity into less/moderately/highly elastic."""
    if pe >= PE_THRESHOLDS["less_elastic"]:
        return "less_elastic"
    elif pe >= PE_THRESHOLDS["highly_elastic"]:
        return "moderately_elastic"
    else:
        return "highly_elastic"


def categorize_msp(msp: float) -> str:
    """Categorize MSP into positive/stable/negative."""
    if abs(msp) <= MSP_THRESHOLD:
        return "stable"
    elif msp > 0:
        return "positive"
    else:
        return "negative"


def determine_level_of_analysis(df: pd.DataFrame) -> str:
    """Infer the level of analysis from data."""
    # Check if all rows have Variant = "all" and PPG = "all"
    all_variant_all = (df["Variant"] == "all").all()
    all_ppg_all = (df["PPG"] == "all").all()

    if all_variant_all and all_ppg_all:
        return "brand_level"
    elif all_ppg_all and not all_variant_all:
        return "brand_variant_level"
    elif not all_ppg_all:
        return "brand_variant_ppg_level"
    else:
        return "brand_level"  # Fallback


# ============================================================================
# MAIN INTERPRETATION LOGIC
# ============================================================================

def extract_channels_and_brands(df: pd.DataFrame) -> Dict[str, List[str]]:
    """Extract unique channels and their brands."""
    channels_brands = {}

    for channel in df["Channel"].unique():
        channel_df = df[df["Channel"] == channel]
        brands = channel_df["Brand"].unique().tolist()
        channels_brands[channel] = brands

    return channels_brands


def get_competitors(df: pd.DataFrame, channel: str, brand: str) -> List[str]:
    """Get all competitors for a brand in a channel."""
    channel_df = df[df["Channel"] == channel]
    all_brands = channel_df["Brand"].unique().tolist()
    competitors = [b for b in all_brands if b != brand]
    return competitors


def get_brand_metrics(df: pd.DataFrame, channel: str, brand: str) -> Dict[str, Any]:
    """Extract metrics for a specific brand-channel combination."""
    row = df[(df["Channel"] == channel) & (df["Brand"] == brand)]

    if row.empty:
        return {}

    row = row.iloc[0]

    return {
        "csf": round(float(row["CSF"]), 2),
        "price_elasticity": round(float(row["Price_elas"]), 2),
        "market_share": round(float(row["MShare"]), 4),
        "new_market_share": round(float(row["NewMShare"]), 4),
        "msp": round(float(row["MSP"]), 4),
        "mcv": round(float(row["MCV"]), 2),
        "price": round(float(row["Price"]), 2),
        "revenue": round(float(row["Revenue"]), 2),
        "volume": round(float(row["Volume"]), 2),
    }


def compare_with_competitors(df: pd.DataFrame, channel: str, brand: str,
                             competitors: List[str]) -> List[Dict[str, Any]]:
    """Generate competitive comparisons."""
    brand_row = df[(df["Channel"] == channel) & (df["Brand"] == brand)]
    if brand_row.empty:
        return []

    brand_csf = float(brand_row.iloc[0]["CSF"])
    brand_mshare = float(brand_row.iloc[0]["MShare"])

    comparisons = []

    for competitor in competitors:
        comp_row = df[(df["Channel"] == channel) & (df["Brand"] == competitor)]
        if comp_row.empty:
            continue

        comp_csf = float(comp_row.iloc[0]["CSF"])
        comp_mshare = float(comp_row.iloc[0]["MShare"])

        csf_diff = round(brand_csf - comp_csf, 2)

        if csf_diff > 0.1:
            comparison = "higher_than_competition"
        elif csf_diff < -0.1:
            comparison = "lower_than_competition"
        else:
            comparison = "equal_to_competition"

        comparisons.append({
            "competitor": competitor,
            "csf": round(comp_csf, 2),
            "csf_difference": csf_diff,
            "csf_comparison": comparison,
            "market_share": round(comp_mshare, 4),
        })

    return comparisons


def generate_competitive_position_text(brand: str, comparisons: List[Dict]) -> str:
    """Generate competitive position narrative."""
    if not comparisons:
        return "No direct competitors in this channel"

    higher_count = sum(1 for c in comparisons if c["csf_comparison"] == "higher_than_competition")
    lower_count = sum(1 for c in comparisons if c["csf_comparison"] == "lower_than_competition")

    if higher_count > lower_count:
        # Build list of advantages
        advantages = [f"{c['competitor']}: +{c['csf_difference']}"
                     for c in comparisons if c["csf_comparison"] == "higher_than_competition"]
        return f"Loyalty advantage - CSF higher than competitors ({', '.join(advantages[:3])})"
    elif lower_count > higher_count:
        # Build list of disadvantages
        disadvantages = [f"{c['competitor']}: {c['csf_difference']}"
                        for c in comparisons if c["csf_comparison"] == "lower_than_competition"]
        return f"CSF lower than key competitors ({', '.join(disadvantages[:3])}), switching threat exists"
    else:
        return "Competitive parity - CSF similar to most competitors"


def determine_market_position(df: pd.DataFrame, channel: str, brand: str,
                              competitors: List[str]) -> Dict[str, Any]:
    """Determine if brand is leader or follower in channel."""
    brand_row = df[(df["Channel"] == channel) & (df["Brand"] == brand)]
    if brand_row.empty:
        return {}

    brand_mshare = float(brand_row.iloc[0]["MShare"])

    # Check if brand has highest market share
    is_leader = True
    for competitor in competitors:
        comp_row = df[(df["Channel"] == channel) & (df["Brand"] == competitor)]
        if not comp_row.empty:
            comp_mshare = float(comp_row.iloc[0]["MShare"])
            if comp_mshare > brand_mshare:
                is_leader = False
                break

    return {
        "is_leader": is_leader,
        "position": "leader" if is_leader else "follower",
        "competitive_pressure": "low" if is_leader else "high",
        "share_vs_competition": "highest" if is_leader else "lower",
    }


def generate_interpretation(metrics: Dict, comparisons: List, position: Dict,
                           brand: str) -> Dict[str, str]:
    """Generate complete interpretation text."""
    csf_cat = categorize_csf(metrics["csf"])
    pe_cat = categorize_pe(metrics["price_elasticity"])
    msp_cat = categorize_msp(metrics["msp"])

    interpretation = {
        "csf_insight": CSF_INTERPRETATIONS[csf_cat],
        "pe_insight": PE_INTERPRETATIONS[pe_cat],
        "msp_insight": MSP_INTERPRETATIONS[msp_cat],
        "market_share_position": MARKET_POSITION_INTERPRETATIONS[position.get("position", "follower")],
        "competitive_position": generate_competitive_position_text(brand, comparisons),
        "overall_assessment": f"[Claude: Provide strategic assessment for {brand}]",
    }

    return interpretation


def process_csv(input_file: Path, project_name: Optional[str], market: Optional[str],
                categories: List[str], level: Optional[str]) -> Dict[str, Any]:
    """Main processing function."""
    # Read CSV
    df = pd.read_csv(input_file)

    # Clean column names (remove quotes if present)
    df.columns = df.columns.str.strip().str.strip('"')

    # Infer level of analysis
    if level is None:
        level = determine_level_of_analysis(df)

    # Extract channels and brands
    channels_brands = extract_channels_and_brands(df)

    # Build YAML structure
    result = {
        "project": {
            "name": project_name or "[Claude: Provide project name]",
            "market": market or "[Claude: Provide market]",
            "categories": categories or ["[Claude: Provide categories]"],
            "level_of_analysis": level,
            "channels": list(channels_brands.keys()),
        },
        "channels": []
    }

    # Process each channel
    for channel, brands in channels_brands.items():
        channel_data = {
            "channel_name": channel,
            "brands": []
        }

        for brand in brands:
            # Get metrics
            metrics = get_brand_metrics(df, channel, brand)
            if not metrics:
                continue

            # Get competitors
            competitors = get_competitors(df, channel, brand)

            # Generate comparisons
            comparisons = compare_with_competitors(df, channel, brand, competitors)

            # Determine market position
            position = determine_market_position(df, channel, brand, competitors)

            # Generate interpretation
            interpretation = generate_interpretation(metrics, comparisons, position, brand)

            # Add categorizations
            metrics["csf_category"] = categorize_csf(metrics["csf"])
            metrics["pe_category"] = categorize_pe(metrics["price_elasticity"])
            metrics["msp_category"] = categorize_msp(metrics["msp"])

            brand_data = {
                "brand": brand,
                "metrics": metrics,
                "competition": comparisons,
                "market_share_position": position,
                "interpretation": interpretation,
            }

            channel_data["brands"].append(brand_data)

        result["channels"].append(channel_data)

    return result


def main():
    """Main entry point."""
    # Parse arguments
    args = sys.argv[1:]

    input_file = DEFAULT_INPUT_FILE
    output_file = DEFAULT_OUTPUT_FILE
    project_name = DEFAULT_PROJECT_NAME
    market = DEFAULT_MARKET
    categories = DEFAULT_CATEGORIES
    level = DEFAULT_LEVEL

    positional_args = []

    while args:
        arg = args.pop(0)

        if arg.startswith("--"):
            if arg == "--help":
                print(__doc__)
                sys.exit(0)
            elif arg.startswith("--project-name"):
                if "=" in arg:
                    project_name = arg.split("=", 1)[1]
                else:
                    project_name = args.pop(0) if args else None
            elif arg.startswith("--market"):
                if "=" in arg:
                    market = arg.split("=", 1)[1]
                else:
                    market = args.pop(0) if args else None
            elif arg.startswith("--categories"):
                if "=" in arg:
                    cats_str = arg.split("=", 1)[1]
                else:
                    cats_str = args.pop(0) if args else ""
                categories = [c.strip() for c in cats_str.split(",")]
            elif arg.startswith("--level"):
                if "=" in arg:
                    level = arg.split("=", 1)[1]
                else:
                    level = args.pop(0) if args else None
            else:
                print(f"Error: Unknown option {arg}")
                print("Use --help for usage information")
                sys.exit(1)
        else:
            positional_args.append(arg)

    if len(positional_args) >= 1:
        input_file = positional_args[0]
    if len(positional_args) >= 2:
        output_file = positional_args[1]
    if len(positional_args) > 2:
        print(f"Error: Too many positional arguments")
        print("Use --help for usage information")
        sys.exit(1)

    # Validate input file
    input_path = Path(input_file)
    if not input_path.exists():
        print(f"Error: Input file not found: {input_file}")
        sys.exit(1)

    output_path = Path(output_file)

    print("=" * 80)
    print("CSF STAGE 7A: INTERPRETATION OF RESULTS")
    print("=" * 80)
    print(f"Input:  {input_path}")
    print(f"Output: {output_path}")
    print()

    try:
        # Process CSV
        result = process_csv(input_path, project_name, market, categories, level)

        # Write YAML
        output_path.parent.mkdir(parents=True, exist_ok=True)

        with open(output_path, "w") as f:
            yaml.dump(result, f, default_flow_style=False, sort_keys=False, allow_unicode=True)

        print(f"✓ Interpretation generated successfully")
        print(f"  Level of analysis: {result['project']['level_of_analysis']}")
        print(f"  Channels: {len(result['channels'])}")

        total_brands = sum(len(ch['brands']) for ch in result['channels'])
        print(f"  Total brand-channel combinations: {total_brands}")
        print()
        print(f"Output saved to: {output_path}")
        print()
        print("Next steps:")
        print("1. Review generated YAML file")
        print("2. Fill in project metadata (name, market, categories) if needed")
        print("3. Enhance overall_assessment fields with business context")
        print("4. Validate interpretations match your business understanding")
        print("=" * 80)

        return 0

    except Exception as e:
        print(f"Error: {str(e)}")
        import traceback
        traceback.print_exc()
        return 1


if __name__ == "__main__":
    sys.exit(main())
