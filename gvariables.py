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
g_db_connection_pool_size=500
g_db_max_overflow_size=10

# path of log files
g_str_path='/u01/build/code/log'
g_logger_name='MyLogger'
g_log_file_max_size=10048576  # Bytes

# stock share k date since date (from this date onward)
g_k_data_since='2000-01-01'
g_pro_hsgt_top10_data_since='2010-01-01'
g_pro_index_daily_data_since='2014-01-01'
g_pro_money_flow_data_since='2015-01-01'

# index market code
g_market_code_dict = {
    'CODE_MARKET_MSCI':'MSCI',  #MSCI指数
    'CODE_MARKET_CSI':'CSI',    #中证指数
    'CODE_MARKET_SSE':'SSE',    #上交所指数
    'CODE_MARKET_SZSE':'SZSE',  #深交所指数
    'CODE_MARKET_CICC':'CICC',  #中金所指数
    'CODE_MARKET_SW':'SW',      #申万指数
    'CODE_MARKET_CNI':'CNI',    #国证指数
    'CODE_MARKET_OTH':'OTH'     #其他指数
    }

# hs_type: market type 类型SH沪股通SZ深股通
g_market_hs_type_dict = {
    'TYPE_SH':'SH',
    'TYPE_SZ':'SZ'
    }
