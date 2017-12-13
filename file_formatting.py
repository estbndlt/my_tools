# Import os module
import os
import fileinput
import sys


def search_files_for_string():
    add_space_file_list = []

    # search_path_list = ["C:/Users/a0227114/Desktop/Custom Code/"]
    search_path_list = ["C:/Users/a0227114/athena",
                        "C:/Users/a0227114/athena/scripts",
                        "C:/Users/a0227114/athena/scripts/ble",
                        "C:/Users/a0227114/athena/scripts/ble/common",
                        "C:/Users/a0227114/athena/scripts/harness",
                        "C:/Users/a0227114/athena/scripts/harness/dut",
                        "C:/Users/a0227114/athena/scripts/harness/gpio",
                        "C:/Users/a0227114/athena/scripts/harness/mtpacket",
                        "C:/Users/a0227114/athena/scripts/harness/stim",
                        "C:/Users/a0227114/athena/scripts/tests",
                        "C:/Users/a0227114/athena/scripts/thread",
                        "C:/Users/a0227114/athena/firmware/dut/cc26xxr2/multi_role_cc2640r2lp_app",
                        "C:/Users/a0227114/athena/firmware/dut/cc26xxr2/multi_role_cc2640r2lp_app/Application",
                        "C:/Users/a0227114/athena/firmware/dut/cc26xxr2/multi_role_cc2640r2lp_app/Startup",
                        "C:/Users/a0227114/athena/firmware/dut/cc26xxr2/simple_central_cc2640r2lp_app/Application",
                        "C:/Users/a0227114/athena/firmware/dut/cc26xxr2/simple_central_cc2640r2lp_app/Startup",
                        "C:/Users/a0227114/athena/firmware/dut/cc26xxr2/simple_observer_cc2640r2lp_app/Application",
                        "C:/Users/a0227114/athena/firmware/dut/cc26xxr2/simple_observer_cc2640r2lp_app/Startup",
                        "C:/Users/a0227114/athena/firmware/dut/cc26xxr2/simple_peripheral_cc2640r2lp_app/Application",
                        "C:/Users/a0227114/athena/firmware/dut/cc26xxr2/simple_peripheral_cc2640r2lp_app/Startup",
                        "C:/Users/a0227114/athena/firmware/dut/cc26xxr2/simple_peripheral_cc2640r2lp_app/Startup",
                        "C:/Users/a0227114/athena/firmware/stimulus/tiva/npi_gpio",
                        "C:/Users/a0227114/athena/firmware/stimulus/tiva/npi_gpio/stimulus_tool",
                        "C:/Users/a0227114/athena/firmware/stimulus/tiva/npi_gpio/utils",
                        ]

    file_type_list = [".py", ".c", ".h"]

    search_str_list = ["#duane_code_review_051617", "//duane_code_review_051617"]

    for search_path in search_path_list:
        for file_type in file_type_list:
            for search_str in search_str_list:
                # Append a directory separator if not already present
                if not (search_path.endswith("/") or search_path.endswith("\\")):
                    search_path = search_path + "/"

                # If path does not exist, set search path to current directory
                if not os.path.exists(search_path):
                    search_path = "."

                # Repeat for each file in the directory
                for fname in os.listdir(search_path):

                    # Apply file type filter
                    if fname.endswith(file_type):

                        # Open file for reading
                        fo = open(search_path + fname)

                        # Read the first line from the file
                        line = fo.readline()

                        # Initialize counter for line number
                        line_no = 1

                        # Loop until EOF
                        while line != '':
                            # Search for string in line
                            index = line.find(search_str)
                            if (index != -1):
                                # print(fname, "[", line_no, ",", index, "] ", line)
                                add_space_file_list.append(str(search_path+fname))

                            # Read next line
                            line = fo.readline()

                            # Increment line counter
                            line_no += 1
                        # Close the files
                        fo.close()
    print(add_space_file_list)
    return add_space_file_list

def add_space_to_file(path_list):
    # return
    for path in path_list:
        for line in fileinput.input(path, inplace=True):
            sys.stdout.write("{} \n".format(line.rstrip()))

# add_space_to_file(search_files_for_string())
