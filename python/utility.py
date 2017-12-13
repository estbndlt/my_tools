

def auto_int(x):
    '''
    this function is needed for argparse to detect hex values
    :param x: hex number (string)
    :return:
    '''
    return int(x, 0)