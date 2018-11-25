#!/opt/rh/rh-python36/root/usr/bin/python
# define all the sql statements which are used in the system

g_sql_str_dict = {
    'stock_basic_info_select_1001':'select code,name from stock_basic_info',
    'stock_basic_info_select_1002':'select count(*) as count from stock_basic_info',    
    'stock_k_data_select_1001':'select code, date from stock_k_data where code=:in_code order by date desc limit 1',
    'pro_stock_basic_info_select_1001':'select ts_code,name from pro_stock_basic_info',
    'pro_stock_basic_info_select_1002':'select count(*) as count from pro_stock_basic_info',
    'pro_stock_company_info_select_1001':'select count(*) as count from pro_stock_company_info',
    'pro_new_share_info_select_1001':'select count(*) as count from pro_new_share_info',
    'pro_stock_daily_basic_select_1001':'select count(*) as count from pro_stock_daily_basic',
    'pro_stock_daily_data_select_1001':'select ts_code, trade_date from pro_stock_daily_data where ts_code=:in_code order by trade_date desc limit 1',
    'pro_index_basic_info_select_1001':'select ts_code from pro_index_basic_info where market=:in_market_code limit 1',
    'pro_index_basic_info_select_1002':'select ts_code, name from pro_index_basic_info',
    'pro_index_daily_data_select_1001':'select ts_code, trade_date from pro_index_daily_data where ts_code=:in_code order by trade_date desc limit 1',
    'pro_money_flow_hsgt_select_1001':'select trade_date from pro_money_flow_hsgt order by trade_date desc limit 1',
    'pro_hs_const_info_select_1001':'select ts_code from pro_hs_const_info where hs_type=:in_hs_type limit 1',
    'pro_hs_const_info_select_1002':'select ts_code, hs_type from pro_hs_const_info',
    'pro_hsgt_top10_data_select_1001':'select ts_code, trade_date from pro_hsgt_top10_data where ts_code=:in_code order by trade_date desc limit 1'
    }
