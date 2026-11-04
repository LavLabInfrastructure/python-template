"""Example library function."""

from typing import TypeVar

_Value = TypeVar("_Value")


def example(value: _Value) -> _Value:
    """Return the given value unchanged.

    :param value: value to pass through
    :return: the same value
    """
    return value
