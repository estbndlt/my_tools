# https://stackoverflow.com/questions/7152428/can-python-unittest-automatically-reattempt-a-failed-testcase-suite
import unittest


class MyTest(unittest.TestCase):
    ###
    ### Insert test methods here
    ###

    # Wrapping each test method so that a retry would take place.
    def run(self, result=None):
        self.original_method_name = self._test_method_name
        self._test_method_name = "_test_retry_wrapper"
        super(MyTest, self).run(result)
        self._test_method_name = self.original_method_name

    def _test_retry_wrapper(self):
        test_method = getattr(self, self.original_method_name)
        retries_left = settings.test_retry_count

        while True:
            try:
                test_method()
                break
            except:
                if retries_left == 0:
                    raise
                else:
                    retries_left = retries_left - 1

def main():
    print('hello')
    x = MyTest()
    return


if __name__ == '__main__':
    main()
