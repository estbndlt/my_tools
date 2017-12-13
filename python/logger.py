import os
import sys
import time
from datetime import datetime


class Logger:
    def __init__(self, name='',
                 debug=False,
                 create_log=False,
                 write_mode='w',
                 result_path=r'C:\testresults\athena',
                 create_folder=False,
                 log_timestamp=False):
        self.debug_enabled = debug
        self.log = create_log
        self.stdout = sys.stdout
        self.start_time = time.time()
        sys.stdout = self

        if self.log:
            filename = name
            extension = '.log'
            foldername = filename

            # append timestamp to log file name
            if log_timestamp:
                log_name = (filename +
                            datetime.today().strftime('_%y-%m-%d_%H.%M.%S') +
                            extension)
            else:
                log_name = filename + extension

            testcase_path = result_path

            # place the testcase in its own folder
            # results_path\testname_year_month_day_time\
            if create_folder:
                testcase_path = os.path.join(result_path, foldername)

            # or place the testcase in the Current directory
            # results_path\Current\
            elif os.path.exists(testcase_path):
                testcase_path = os.path.join(testcase_path, 'Current')
                if not os.path.exists(testcase_path):
                    os.makedirs(testcase_path)

            result_path = os.path.join(testcase_path, log_name)
            self.file = open(result_path, write_mode)

    def __del__(self):
        sys.stdout = self.stdout
        if self.log:
            self.file.close()

    def write(self, data):
        self.stdout.write(data+'\n')
        if self.log:
            self.file.write(data+'\n')

    def write_noline(self, data):
        self.stdout.write(data)
        if self.log:
            self.file.write(data)

    def debug(self, data):
        if self.debug_enabled:
            self.stdout.write(datetime.today().
                              strftime('%Y-%m-%d %H:%M:%S.%f')[:-3]
                              + ' - DEBUG: ' + data)

    def close(self):
        execution_time = time.time() - self.start_time
        self.stdout.write('\n{} Execution Time = {}\n'
                          .format(datetime.today().
                                  strftime('%Y-%m-%d %H:%M:%S.%f')[:-3],
                                  time.strftime(
                                      '%H hours %M minutes %S seconds',
                                      time.gmtime(execution_time))))
        if self.log:
            self.file.write('\n{} Execution Time = {}\n'
                            .format(datetime.today().
                                    strftime('%Y-%m-%d %H:%M:%S.%f')[:-3],
                                    time.strftime(
                                        '%H hours %M minutes %S seconds',
                                        time.gmtime(execution_time))))
            self.file.close()
