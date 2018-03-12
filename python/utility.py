import os
import struct

here = os.path.abspath(os.path.dirname(__file__))


def bit_range_mask_uint32_t(a, b):
    """ Creates a bit range mask from bit a to bit b.

    Args:
         a: bit index in range [a, b]
         b: bit index in range [a, b]

    Return:
        bytes string of the bit mask (use struct.unpack() to convert to int)
    """
    if not 0 <= a <= 31 or not 0 <= b <= 31 or a > b:
        raise Exception('Requires a <= b and 0 <= a,b, <= 31')
    return struct.pack('>I', (((0x00ffffffff >> (31-b)) >> a) << a))


def bit_range_mask_uint16_t(a, b):
    """ Creates a bit range mask from bit a to bit b.

    Args:
         a: bit index in range [a, b]
         b: bit index in range [a, b]

    Return:
        bytes string of the bit mask (use struct.unpack() to convert to int)
    """
    if not 0 <= a <= 15 or not 0 <= b <= 15 or a > b:
        raise Exception('Requires a <= b and 0 <= a,b, <= 15')
    return struct.pack('>H', (((0x00ffff >> (15-b)) >> a) << a))


def bit_range_mask_uint8_t(a, b):
    """ Creates a bit range mask from bit a to bit b.

    Args:
         a: bit index in range [a, b]
         b: bit index in range [a, b]

    Return:
        bytes string of the bit mask (use struct.unpack() to convert to int)
    """
    if not 0 <= a <= 7 or not 0 <= b <= 7 or a > b:
        raise Exception('Requires a <= b and 0 <= a,b, <= 7')
    return struct.pack('>B', (((0x00ff >> (7-b)) >> a) << a))


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
    script_description = 'this program runs oad test suites'
    parser = argparse.ArgumentParser(
        description=script_description,
        formatter_class=argparse.ArgumentDefaultsHelpFormatter
    )
    parser = argparse.ArgumentParser(description=script_description)
    parser.add_argument('--config', metavar='PATH',
                        help='path to config file if different from: '
                             'athena/scripts/tests/config.ini')
    args = parser.parse_args(args)
    return args


if "__main__" in __name__:
    result_val = main()
    sys.exit(result_val)
