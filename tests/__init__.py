# SPDX-FileCopyrightText: 2024-present barrettMCW <mjbarrett@mcw.edu>
#
# SPDX-License-Identifier: MIT
"""example pytest module"""
import pytest
from src.python_template import example
def test_example():
    """tests pytest"""
    assert example(True) is True
