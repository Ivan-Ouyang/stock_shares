#!/opt/rh/rh-python36/root/usr/bin/python
# define global variable or constants which will be used
# in the system

# the user name and password for accessing to mysql database
g_str_db_username = 'IT271350_5'
g_str_db_password = 'IT271350_5'
g_str_db_hostname = '192.168.1.200'
g_str_db_name = 'stock_shares'

# number of threads to initialize the thread pool
g_num_threads = 1000

# path of log files
g_str_path='/u01/build/code/log'
g_logger_name='MyLogger'
g_log_file_max_size=10048576  # Bytes

# stock share k date since date (from this date onward)
g_k_data_since='2000-01-01'
