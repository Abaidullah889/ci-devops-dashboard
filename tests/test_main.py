import unittest
from app.main import (
    add, subtract, multiply, divide,
    is_even, reverse_string, count_words,
    is_palindrome, factorial
)

class TestMathOperations(unittest.TestCase):
    def test_add(self):
        self.assertEqual(add(2, 3), 5)

    def test_subtract(self):
        self.assertEqual(subtract(5, 2), 3)

    def test_multiply(self):
        self.assertEqual(multiply(3, 4), 12)

    def test_divide(self):
        self.assertEqual(divide(10, 2), 5)
        with self.assertRaises(ValueError):
            divide(5, 0)

    def test_factorial(self):
        self.assertEqual(factorial(5), 120)
        self.assertEqual(factorial(0), 1)
        with self.assertRaises(ValueError):
            factorial(-3)

class TestUtils(unittest.TestCase):
    def test_is_even(self):
        self.assertTrue(is_even(4))
        self.assertFalse(is_even(5))

    def test_reverse_string(self):
        self.assertEqual(reverse_string("hello"), "olleh")

    def test_count_words(self):
        self.assertEqual(count_words("hello world"), 2)

    def test_is_palindrome(self):
        self.assertTrue(is_palindrome("Racecar"))
        self.assertFalse(is_palindrome("hello"))

if __name__ == '__main__':
    unittest.main()
