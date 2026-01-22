#!/usr/bin/env python3
"""
File handling utilities for transcript processing.

Provides safe file reading with proper error handling and encoding fallback.
"""

import os
from typing import Optional


def read_transcript_file(file_path: str) -> str:
    """
    Read transcript content from file path safely.

    Args:
        file_path: Absolute path to transcript file

    Returns:
        str: File content

    Raises:
        FileNotFoundError: If file doesn't exist
        UnicodeDecodeError: If file encoding is invalid
        IOError: If file cannot be read
    """
    if not os.path.exists(file_path):
        raise FileNotFoundError(f"Transcript not found: {file_path}")

    if not os.path.isfile(file_path):
        raise ValueError(f"Path is not a file: {file_path}")

    # Try UTF-8 first, fallback to latin-1 for broader compatibility
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            return f.read()
    except UnicodeDecodeError:
        with open(file_path, 'r', encoding='latin-1') as f:
            return f.read()


if __name__ == "__main__":
    # Test the file handler
    import tempfile

    # Create test file
    test_content = "Doctor: What brings you in today?\nPatient: I've been having headaches."
    with tempfile.NamedTemporaryFile(mode='w', delete=False, suffix='.txt') as f:
        f.write(test_content)
        test_file = f.name

    try:
        # Test reading
        content = read_transcript_file(test_file)
        assert "headaches" in content
        print(f"✓ File read successful: {content[:50]}...")

        # Test error handling
        try:
            read_transcript_file("/tmp/nonexistent.txt")
            print("✗ Should have raised FileNotFoundError")
        except FileNotFoundError as e:
            print(f"✓ Correctly raised: {e}")

        print("All tests passed!")

    finally:
        # Cleanup
        os.unlink(test_file)
