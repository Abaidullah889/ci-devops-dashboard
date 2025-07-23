def add(a, b):
    return a + b

def subtract(a, b):
    return a - b

def powerof(x, e):
    result = 1
    for _ in range(abs(e)):
        result *= x
    if e < 0:
        return 1 / result
    return result

def multiply(a, b):
    return a * b

def divide(a, b):
    if b == 0:
        raise ValueError("Division by zero is undefined.")
    return a / b

def is_even(n):
    return n % 2 == 0

def reverse_string(s):
    return s[::-1]

def count_words(text):
    return len(text.split())

def is_palindrome(word):
    clean = ''.join(c.lower() for c in word if c.isalnum())
    return clean == clean[::-1]

def factorial(n):
    if n < 0:
        raise ValueError("Factorial is not defined for negative numbers.")
    if n == 0:
        return 1
    result = 1
    for i in range(1, n+1):
        result *= i
    return result
