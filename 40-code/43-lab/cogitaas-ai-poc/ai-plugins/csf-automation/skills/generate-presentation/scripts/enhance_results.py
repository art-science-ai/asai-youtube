#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = [
#   "pandas>=2.0.0",
# ]
# ///

"""
CSF Results Enhancement Script

Reads Result CSV files at any granularity level and adds interpretation columns:
- CSF_Category (high/medium/low)
- PE_Category (less_elastic/moderately_elastic/highly_elastic)
- MSP_Category (positive/stable/negative)
- IsLeader (true/false at appropriate granularity)
- Competitive_Position (higher_than_avg/equal_to_avg/lower_than_avg)

Supports multiple granularity levels:
- Brand-level: Aggregated brand performance
- Variant-level: Brand × Variant breakdown
- PPG-level: Brand × Pack/Pack Group breakdown
- Variant×PPG-level: Brand × Variant × Pack breakdown

Categorization rules from client's Summary.docx.
"""

import sys
import argparse
import pandas as pd
from pathlib import Path


# Column requirements
REQUIRED_COLS = ['Channel', 'Brand', 'CSF', 'Price_elas', 'MShare', 'MSP']
OPTIONAL_COLS = ['Variant', 'PPG', 'PackType']


def categorize_csf(csf_value):
    """Categorize CSF based on client thresholds."""
    if pd.isna(csf_value):
        return "unknown"
    if csf_value >= 2.0:
        return "high"
    elif csf_value >= 1.7:
        return "medium"
    else:
        return "low"


def categorize_pe(pe_value):
    """Categorize Price Elasticity based on client thresholds."""
    if pd.isna(pe_value):
        return "unknown"
    if pe_value >= -4:
        return "less_elastic"
    elif pe_value >= -7:
        return "moderately_elastic"
    else:
        return "highly_elastic"


def categorize_msp(msp_value):
    """Categorize Market Share Potential."""
    if pd.isna(msp_value):
        return "unknown"
    if msp_value > 0.001:
        return "positive"
    elif msp_value < -0.001:
        return "negative"
    else:
        return "stable"


def detect_granularity(df):
    """
    Detect granularity level of the CSV file.

    Returns:
        dict with keys: level, has_variant, has_ppg, group_dims
    """
    # Check if optional columns exist and have meaningful variation
    has_variant = (
        'Variant' in df.columns
        and df['Variant'].notna().any()
        and (df['Variant'] != 'all').any()
        and df['Variant'].nunique() > 1
    )

    has_ppg = (
        'PPG' in df.columns
        and df['PPG'].notna().any()
        and (df['PPG'] != 'all').any()
        and df['PPG'].nunique() > 1
    )

    # Determine grouping dimensions for leader/competitive analysis
    group_dims = ['Channel']
    if has_variant:
        group_dims.append('Variant')
    if has_ppg:
        group_dims.append('PPG')

    # Determine level name
    if has_variant and has_ppg:
        level = "Variant×PPG-level"
    elif has_variant:
        level = "Variant-level"
    elif has_ppg:
        level = "PPG-level"
    else:
        level = "Brand-level"

    return {
        'level': level,
        'has_variant': has_variant,
        'has_ppg': has_ppg,
        'group_dims': group_dims
    }


def report_granularity(granularity_info, filename):
    """Print human-readable granularity detection summary."""
    print(f"\n{'─'*60}")
    print(f"Granularity Detection: {filename}")
    print(f"{'─'*60}")
    print(f"  Variant dimension: {'✓' if granularity_info['has_variant'] else '✗'}")
    print(f"  PPG dimension:     {'✓' if granularity_info['has_ppg'] else '✗'}")
    print(f"  → Detected: {granularity_info['level']}")
    print(f"  → Grouping by: {', '.join(granularity_info['group_dims'])}")
    print(f"{'─'*60}")


def identify_leaders(df, group_dims):
    """
    Identify market leader at appropriate granularity.

    Grouping logic:
    - Brand-level: Group by Channel
    - PPG-level: Group by Channel + PPG
    - Variant-level: Group by Channel + Variant
    - Variant×PPG-level: Group by Channel + Variant + PPG

    Leader = highest MShare within each group

    Args:
        df: DataFrame with CSF results
        group_dims: List of column names to group by

    Returns:
        List of boolean values indicating leadership status
    """
    is_leader = pd.Series([False] * len(df), index=df.index)

    # Group by the appropriate dimensions
    for group_values, group_df in df.groupby(group_dims, dropna=False):
        # Find maximum market share in this group
        max_share = group_df['MShare'].max()

        # Mark all rows with max share as leaders (handles ties)
        leader_mask = (df.index.isin(group_df.index)) & (df['MShare'] == max_share)
        is_leader[leader_mask] = True

    return is_leader.tolist()


def calculate_competitive_position(df, group_dims):
    """
    Calculate competitive position based on CSF vs top 3 competitors at same granularity.

    Compares within the same group dimensions used for leader identification.

    Args:
        df: DataFrame with CSF results
        group_dims: List of column names to group by

    Returns:
        List of competitive position categories
    """
    competitive_positions = []

    for idx, row in df.iterrows():
        # Get this row's group values
        group_values = tuple(row[dim] for dim in group_dims)

        # Get all rows in the same group
        mask = pd.Series([True] * len(df), index=df.index)
        for dim, val in zip(group_dims, group_values):
            mask &= (df[dim] == val)

        same_group = df[mask]

        # Get competitors (exclude current brand)
        competitors = same_group[same_group['Brand'] != row['Brand']]

        if len(competitors) == 0:
            # No competitors in this group
            competitive_positions.append("only_brand")
            continue

        # Get top 3 competitors by market share
        top_competitors = competitors.nlargest(min(3, len(competitors)), 'MShare')
        avg_competitor_csf = top_competitors['CSF'].mean()

        csf = row['CSF']

        if pd.isna(csf) or pd.isna(avg_competitor_csf):
            competitive_positions.append("unknown")
        elif csf > avg_competitor_csf + 0.1:
            competitive_positions.append("higher_than_avg")
        elif csf < avg_competitor_csf - 0.1:
            competitive_positions.append("lower_than_avg")
        else:
            competitive_positions.append("equal_to_avg")

    return competitive_positions


def validate_csv(df):
    """Validate CSV has required columns."""
    missing = [col for col in REQUIRED_COLS if col not in df.columns]

    if missing:
        raise ValueError(f"CSV missing required columns: {', '.join(missing)}")

    print(f"\n✓ CSV validation passed")
    print(f"  Channels: {df['Channel'].nunique()}")
    print(f"  Brands: {df['Brand'].nunique()}")
    print(f"  Rows: {len(df)}")

    # Report optional columns present
    optional_present = [col for col in OPTIONAL_COLS if col in df.columns]
    if optional_present:
        print(f"  Optional columns: {', '.join(optional_present)}")


def enhance_results(input_csv, output_csv, project_name=None):
    """
    Main function to enhance Results CSV at any granularity level.

    Args:
        input_csv: Path to input CSV file
        output_csv: Path to output enhanced CSV file
        project_name: Optional project name for logging
    """
    print(f"\n{'='*60}")
    print(f"CSF Results Enhancement")
    if project_name:
        print(f"Project: {project_name}")
    print(f"{'='*60}\n")

    # Read CSV
    print(f"Reading: {input_csv}")
    df = pd.read_csv(input_csv)

    # Validate
    validate_csv(df)

    # Detect granularity
    granularity = detect_granularity(df)
    report_granularity(granularity, Path(input_csv).name)

    # Add categorization columns
    print(f"\nApplying categorizations...")
    df['CSF_Category'] = df['CSF'].apply(categorize_csf)
    df['PE_Category'] = df['Price_elas'].apply(categorize_pe)
    df['MSP_Category'] = df['MSP'].apply(categorize_msp)

    # Identify leaders at appropriate granularity
    print(f"Identifying market leaders at {granularity['level']}...")
    df['IsLeader'] = identify_leaders(df, granularity['group_dims'])

    # Calculate competitive positions at appropriate granularity
    print(f"Calculating competitive positions at {granularity['level']}...")
    df['Competitive_Position'] = calculate_competitive_position(df, granularity['group_dims'])

    # Write enhanced CSV
    print(f"\nWriting enhanced CSV: {output_csv}")
    df.to_csv(output_csv, index=False)

    # Summary statistics
    print(f"\n{'='*60}")
    print(f"Enhancement Summary")
    print(f"{'='*60}")
    print(f"\nCSF Categories:")
    print(df['CSF_Category'].value_counts().to_string())
    print(f"\nPE Categories:")
    print(df['PE_Category'].value_counts().to_string())
    print(f"\nMSP Categories:")
    print(df['MSP_Category'].value_counts().to_string())
    print(f"\nMarket Leaders: {df['IsLeader'].sum()} (at {granularity['level']})")
    print(f"\nCompetitive Positions:")
    print(df['Competitive_Position'].value_counts().to_string())
    print(f"\n{'='*60}")
    print(f"✓ Enhancement complete!")
    print(f"{'='*60}\n")


def main():
    parser = argparse.ArgumentParser(
        description='Enhance Results CSV with interpretation categories at any granularity level'
    )
    parser.add_argument('input_csv', help='Input CSV file path')
    parser.add_argument('output_csv', help='Output CSV file path')
    parser.add_argument('--project-name', help='Project name for logging')

    args = parser.parse_args()

    # Validate input file exists
    if not Path(args.input_csv).exists():
        print(f"Error: Input file not found: {args.input_csv}")
        sys.exit(1)

    # Run enhancement
    try:
        enhance_results(args.input_csv, args.output_csv, args.project_name)
    except Exception as e:
        print(f"\nError during enhancement: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)


if __name__ == '__main__':
    main()
