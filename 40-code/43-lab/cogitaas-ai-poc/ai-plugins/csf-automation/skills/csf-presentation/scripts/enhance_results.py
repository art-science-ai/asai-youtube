#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = [
#   "pandas>=2.0.0",
# ]
# ///

"""
CSF Results Enhancement Script

Reads Brand-Level Results CSV and adds interpretation columns:
- CSF_Category (high/medium/low)
- PE_Category (less_elastic/moderately_elastic/highly_elastic)
- MSP_Category (positive/stable/negative)
- IsLeader (true/false)
- Competitive_Position (higher_than_avg/equal_to_avg/lower_than_avg)

Categorization rules from client's Summary.docx.
"""

import sys
import argparse
import pandas as pd
from pathlib import Path


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


def identify_leaders(df):
    """Identify market leader (highest MShare) within each channel."""
    is_leader = []

    for channel in df['Channel'].unique():
        channel_data = df[df['Channel'] == channel]
        max_share = channel_data['MShare'].max()

        for idx, row in df.iterrows():
            if row['Channel'] == channel:
                # Leader is the brand with highest market share in channel
                is_leader.append(row['MShare'] == max_share)

    return is_leader


def calculate_competitive_position(df):
    """Calculate competitive position based on CSF vs top 3 competitors."""
    competitive_positions = []

    for idx, row in df.iterrows():
        channel = row['Channel']
        brand = row['Brand']
        csf = row['CSF']

        # Get all competitors in same channel
        competitors = df[(df['Channel'] == channel) & (df['Brand'] != brand)]

        if len(competitors) == 0:
            # No competitors in channel
            competitive_positions.append("only_brand")
            continue

        # Get top 3 competitors by market share
        top_competitors = competitors.nlargest(min(3, len(competitors)), 'MShare')
        avg_competitor_csf = top_competitors['CSF'].mean()

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
    required_columns = ['Channel', 'Brand', 'CSF', 'Price_elas', 'MShare', 'MSP']
    missing = [col for col in required_columns if col not in df.columns]

    if missing:
        raise ValueError(f"CSV missing required columns: {', '.join(missing)}")

    print(f"✓ CSV validation passed")
    print(f"  Channels: {df['Channel'].nunique()}")
    print(f"  Brands: {df['Brand'].nunique()}")
    print(f"  Rows: {len(df)}")


def enhance_results(input_csv, output_csv, project_name=None):
    """
    Main function to enhance Brand-Level Results CSV.

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

    # Add categorization columns
    print(f"\nApplying categorizations...")
    df['CSF_Category'] = df['CSF'].apply(categorize_csf)
    df['PE_Category'] = df['Price_elas'].apply(categorize_pe)
    df['MSP_Category'] = df['MSP'].apply(categorize_msp)

    # Identify leaders
    print(f"Identifying market leaders...")
    df['IsLeader'] = identify_leaders(df)

    # Calculate competitive positions
    print(f"Calculating competitive positions...")
    df['Competitive_Position'] = calculate_competitive_position(df)

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
    print(f"\nMarket Leaders: {df['IsLeader'].sum()}")
    print(f"\nCompetitive Positions:")
    print(df['Competitive_Position'].value_counts().to_string())
    print(f"\n{'='*60}")
    print(f"✓ Enhancement complete!")
    print(f"{'='*60}\n")


def main():
    parser = argparse.ArgumentParser(
        description='Enhance Brand-Level Results CSV with interpretation categories'
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
        sys.exit(1)


if __name__ == '__main__':
    main()
