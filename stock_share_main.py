#!/opt/rh/rh-python36/root/usr/bin/python
import db_data_processor as dp

if __name__ == '__main__':
    data_processor_in = dp.db_data_processor_in()
    data_processor_in.download_all_data()