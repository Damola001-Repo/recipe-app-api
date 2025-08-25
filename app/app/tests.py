from django.test import SimpleTestCase
from .calc import add, sub

"""Creating test case."""
class CalcTest(SimpleTestCase):

    """Testing add function."""
    def test_add(self):
        res = add(5, 6)

        """Checking if res is equals to expected output."""
        self.assertEqual(res, 11)

    
    def test_sub(self):
        res = sub(10, 15)

        self.assertEqual(res, 5)