import os

here = os.path.abspath(os.path.dirname(__file__))


def auto_int(x):
    """
    this function is needed for argparse to detect hex values
    :param x: hex number (string)
    :return:
    """
    return int(x, 0)


def main(args=None):
    """ Handles args to run script properly. """
    args = parse_args(args)

    if not args.config or not os.path.isfile(args.config):
        config_path = os.path.abspath(os.path.join(here, 'config.ini'))
    else:
        config_path = args.config

    result = reset_devices(config_path)
    return result


def parse_args(args=None):
    """ Parses input parameters and displays help message. """
    script_description = ('This tool will reset all devices used in the '
                          'config file.')
    parser = argparse.ArgumentParser(description=script_description)
    parser.add_argument('--config', metavar='PATH',
                        help='path to config file if different from: '
                             'athena/scripts/tests/config.ini')
    args = parser.parse_args(args)
    return args


if "__main__" in __name__:
    result_val = main()
    sys.exit(result_val)
