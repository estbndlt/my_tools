import os
import sys
import shutil
import argparse
import subprocess

MODE_INSTALLER = 'INSTALLER'


def gitify_installer(src_path, dest_path):
    if not os.path.exists(src_path):
        sys.exit('Path does not exist: {}'.format(src_path))

    # Get executable name: simplelink_XXXXXX_sdk_X_XX_XX_XX_eng.exe
    full_name = os.path.basename(src_path)

    # Split the name and extension
    name, ext = os.path.splitext(full_name)

    # Destination path: C:\ti\simplelink_XXXXXX_sdk_X_XX_XX_XX_eng\
    installer_dir = os.path.join(dest_path, name)

    # Copy executable to current working directory
    print('Copying...')
    shutil.copy(src_path, '.')

    # Run installer
    print('Installing...')
    os.system(full_name + ' --mode unattended')

    # Create repo
    print('Creating repo...')
    p = subprocess.Popen('git init',
                         cwd=installer_dir, shell=True)
    p.wait()

    # Stage all installer files
    print('Adding all files...')
    p = subprocess.Popen('git add *',
                         cwd=installer_dir, shell=True)
    p.wait()

    # Commit everything
    print('Initial commit...')
    p = subprocess.Popen('git commit -m "Initial commit"',
                         cwd=installer_dir, shell=True)
    p.wait()

    # Delete copy of executable
    print('Removing executable...')
    os.remove(full_name)


def main(args):
    if args.mode == MODE_INSTALLER:
        gitify_installer(args.src_path, args.dest_path)
    else:
        print('Invalid mode selected!'
              '\nCurrent available modes:'
              '\n\t- {}'
              .format(MODE_INSTALLER))


def parse_args():
    """
    Parses input parameters and displays help message
    :return: args: dict
    """
    script_description = ('this script creates a repo (gitifies) '
                          'installers')
    parser = argparse.ArgumentParser(description=script_description)
    parser.add_argument('mode',
                        help='available modes: INSTALLER')
    parser.add_argument('src_path', metavar='PATH',
                        help='source path')
    parser.add_argument('--dest_path', metavar='PATH',
                        default=r'C:\ti',
                        help='destination path')
    args = parser.parse_args()
    return args


if "__main__" in __name__:
    installer_args = parse_args()
    main(installer_args)
