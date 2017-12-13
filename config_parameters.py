import ConfigParser
import platform

NUM_OF_DEVICES = 10


class dut_parameters():
    def __init__(self, section, data):
        self.comport = data.get(section, 'dut_comport')
        self.stimport = data.get(section, 'dut_stimport')
        self.id = data.get(section, 'dut_deviceId')


class test_device_parameters():
    def __init__(self, idx, section, data):
        self.comport = data.get(section, 'device%s_comport' % idx)
        self.stimport = data.get(section, 'device%s_stimport' % idx)
        self.id = data.get(section, 'device%s_deviceId' % idx)


class multirole_parameters():
    def __init__(self, data):
        self.max_connections = data.getint('multirole', 'max_connections')
        self.stress_timeout = data.getint('multirole', 'stress_timeout_seconds')


class gpio_parameters():
    def __init__(self, data):
        self.left_pin = data.getint('gpio', 'left_pin')
        self.right_pin = data.getint('gpio', 'right_pin')
        self.reset_pin = data.getint('gpio', 'reset_pin')


class multirole_cache_as_ram_parameters():
    def __init__(self, data):
        self.max_connections = data.getint('multirole_cache_as_ram', 'max_connections')
        self.stress_timeout = data.getint('multirole_cache_as_ram', 'stress_timeout_seconds')


def windows_config(data):
    global dut
    global device
    device = []
    dut = dut_parameters('comports.windows', data)
    for device_num in range(0, NUM_OF_DEVICES):
        device.append(test_device_parameters(device_num, 'comports.windows', data))


def mac_config(data):
    global dut
    global device
    device = []
    dut = dut_parameters('comports.mac', data)
    for device_num in range(0, NUM_OF_DEVICES):
        device.append(test_device_parameters(device_num, 'comports.mac', data))


def linux_config(data):
    global dut
    global device
    device = []
    dut = dut_parameters('comports.linux', data)
    for device_num in range(0, NUM_OF_DEVICES):
        device.append(test_device_parameters(device_num, 'comports.linux', data))


def cli_config(data):
    global dut
    global device
    device = []
    dut = dut_parameters('comports.cli', data)
    for device_num in range(0, NUM_OF_DEVICES):
        device.append(test_device_parameters(device_num, 'comports.cli', data))


def configure_self(data):
    global multirole
    global multirole_cache_as_ram
    global gpio

    system = platform.system()
    if system == 'Windows':
        windows_config(data)
    if system == 'Darwin':
        mac_config(data)
    if system == 'Linux':
        linux_config(data)
    if system == 'cli':
        cli_config(data)

    multirole = multirole_parameters(data)
    multirole_cache_as_ram = multirole_cache_as_ram_parameters(data)
    gpio = gpio_parameters(data)


def read_config_file(filename):
    data = ConfigParser.ConfigParser()
    data.read(filename)
    configure_self(data)


def print_parameters():
    print('DUT: [comport: %s stimport: %s id: %s]' % (dut.comport, dut.stimport, dut.id))

    for index, deviceX in enumerate(device):
        print('DEVICE %s: [comport: %s stimport: %s id: %s]' %
              (index, deviceX.comport, deviceX.stimport, deviceX.id))

    print('GPIO: [left_pin: %s right_pin: %s reset_pin: %s]' %
          (gpio.left_pin, gpio.right_pin, gpio.reset_pin))
    print('MULTIROLE: [stress_timeout: %s max_connections: %s]' %
          (multirole.stress_timeout, multirole.max_connections))
    print('MULTIROLE_CAR: [stress_timeout: %s max_connections: %s]' %
          (multirole_cache_as_ram.stress_timeout, multirole_cache_as_ram.max_connections))


if __name__ == '__main__':
    read_config_file('config.ini')
    print_parameters()
