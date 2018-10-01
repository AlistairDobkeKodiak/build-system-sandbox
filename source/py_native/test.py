"""A tiny example binary for the native Python rules of Bazel."""

import unittest
from source.py_native.lib import GetNumber
from fib import Fib


class TestGetNumber(unittest.TestCase):

  def test_ok(self):
    self.assertEquals(GetNumber(), 42)

  def test_fib(self):
    self.assertEquals(Fib(5), 8)

  def test_bad_fib(self):
    self.assertEquals(Fib(4), 3)

if __name__ == '__main__':
  unittest.main()
