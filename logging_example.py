# myapp.py
import logging

def main():
    logging.basicConfig(filename='myapp.log', level=logging.INFO)
    logging.info('Started')
    print('hello')
    logging.info('Finished')

if __name__ == '__main__':
    main()