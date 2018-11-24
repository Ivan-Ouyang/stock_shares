#!/opt/rh/rh-python36/root/usr/bin/python
import tushare as ts
import pandas as pd 
import os
import sys
from sqlalchemy import create_engine
from sqlalchemy.sql import text
import gvariables as gv
import glob
import numpy as np
import zipfile
import thread_pool as tp
import logging
import logging.handlers
import sqlcode as sqlstmt
from datetime import date,timedelta,datetime
from pandas.tseries import offsets

class db_data_processor_in:
    def __init__(self,):
        self.stock_code_count = 0
        self.pro_stock_code_count = 0
        self.share_code_year_dict_df = {}
        self.share_code_name_dict = {}
        self.pro_share_code_name_dict = {}
        self.share_code_lst = list()
        self.pro_share_code_lst = list()
        self.engine = create_engine('mysql://%s:%s@%s/%s?charset=utf8'%(gv.g_str_db_username, gv.g_str_db_password,gv.g_str_db_hostname,gv.g_str_db_name))
        self.thrpool = tp.thread_pool(gv.g_num_threads)
        self.tablelst = {'stock_basic':'stock_basic_info', 'stock_k_data':'stock_k_data',
                         'pro_stock_basic':'pro_stock_basic_info',
                         'pro_stock_company':'pro_stock_company_info',
                         'pro_new_share':'pro_new_share_info',
                         'pro_stock_daily_data':'pro_stock_daily_data',
                         'pro_stock_daily_basic':'pro_stock_daily_basic'}
        self.ts_pro_api = ts.pro_api()
        
        # setup configuration for log file
        self.my_logger = logging.getLogger(gv.g_logger_name)
        self.my_logger.setLevel(logging.DEBUG)        
        self.log_file_name='%s/db_data_processor.log'%gv.g_str_path
        tmp_log_handler = logging.handlers.RotatingFileHandler(self.log_file_name, maxBytes=gv.g_log_file_max_size)
        tmp_log_format = logging.Formatter('%(asctime)s- %(lineno)d: [Thread:%(thread)d] %(levelname)s:%(message)s')
        tmp_log_handler.setFormatter(tmp_log_format)
        self.my_logger.addHandler(tmp_log_handler)

    def __del__(self):
        self.my_logger.debug('class db_data_processor_in destructor')
    
    """ functions for handling stock share source data """
    
    def __Load_stock_basics(self,):
        """ check if the stock basics data available in database or not """
        if not self.engine.dialect.has_table(self.engine, self.tablelst['stock_basic']):
            self.my_logger.warn('table %s is not in the database, will re-create into the database.'%self.tablelst['stock_basic'])
            tmp_df = ts.get_stock_basics()
            if tmp_df is not None:
                tmp_df.to_sql(self.tablelst['stock_basic'], self.engine, if_exists='append')
        else:
            self.my_logger.info('begin to load data from database.')
            loc_con = self.engine.connect()
            loc_sql_ret = None            
            try:
                self.my_logger.debug('execute sql: %s'%sqlstmt.g_sql_str_dict['stock_basic_info_select_1002'])
                loc_sql_ret = loc_con.execute(text(sqlstmt.g_sql_str_dict['stock_basic_info_select_1002']))
                loc_ret_data = loc_sql_ret.fetchone()
                tmp_rows = loc_ret_data[0]
                if (tmp_rows == 0):
                    self.my_logger.warn('table %s is empty, will re-download into the database.'%self.tablelst['stock_basic'])
                    tmp_df = ts.get_stock_basics()
                    if tmp_df is not None:
                        tmp_df.to_sql(self.tablelst['stock_basic'],self.engine,if_exists='append')
                
                self.my_logger.debug('execute sql: %s'%sqlstmt.g_sql_str_dict['stock_basic_info_select_1001'])
                loc_sql_ret = loc_con.execute(text(sqlstmt.g_sql_str_dict['stock_basic_info_select_1001']))
                for loc_code, loc_name in loc_sql_ret:
                    self.share_code_name_dict[loc_code] = loc_name
                    self.share_code_lst.append(loc_code)
                    self.stock_code_count += 1
                self.my_logger.info('there are %s shares were loaded.'%self.stock_code_count)
            except:
                self.my_logger('Oops! %s occured.'%sys.exc_info()[0])
                pass
            self.my_logger.info('exit function: _Load_stock_basics')

    def __Load_pro_stock_basics(self,):
        """ check if the stock basics data available in database or not """
        if not self.engine.dialect.has_table(self.engine, self.tablelst['pro_stock_basic']):
            self.my_logger.warn('table %s is not in the database, will re-create into the database.'%self.tablelst['pro_stock_basic'])
            tmp_df = self.ts_pro_api.stock_basic(exchange='', list_status='L', fields='ts_code,symbol,name,area,industry,fullname,enname,market,exchange,curr_type,list_date,is_hs')
            if tmp_df is not None:
                tmp_df.to_sql(self.tablelst['pro_stock_basic'], self.engine, if_exists='append')
        else:
            self.my_logger.info('begin to load data from database.')
            loc_con = self.engine.connect()
            loc_sql_ret = None            
            try:
                self.my_logger.debug('execute sql: %s'%sqlstmt.g_sql_str_dict['pro_stock_basic_info_select_1002'])
                loc_sql_ret = loc_con.execute(text(sqlstmt.g_sql_str_dict['pro_stock_basic_info_select_1002']))
                loc_ret_data = loc_sql_ret.fetchone()
                tmp_rows = loc_ret_data[0]
                if (tmp_rows == 0):
                    self.my_logger.warn('table %s is empty, will re-download into the database.'%self.tablelst['pro_stock_basic'])
                    tmp_df = self.ts_pro_api.stock_basic(exchange='', list_status='L', fields='ts_code,symbol,name,area,industry,fullname,enname,market,exchange,curr_type,list_date,is_hs')
                    if tmp_df is not None:
                        tmp_df.to_sql(self.tablelst['pro_stock_basic'],self.engine,if_exists='append')
                        
                self.my_logger.debug('execute sql: %s'%sqlstmt.g_sql_str_dict['pro_stock_basic_info_select_1001'])
                loc_sql_ret = loc_con.execute(text(sqlstmt.g_sql_str_dict['pro_stock_basic_info_select_1001']))               
                for loc_code, loc_name in loc_sql_ret:
                    tmp_code = loc_code.strip()
                    self.pro_share_code_name_dict[tmp_code] = loc_name
                    self.pro_share_code_lst.append(tmp_code)
                    self.pro_stock_code_count += 1
                self.my_logger.info('there are %s shares were loaded, share list size:%s'%(self.pro_stock_code_count,len(self.pro_share_code_lst)))
            except:
                self.my_logger.error('Oops! something wrong occurred.')
                pass
            self.my_logger.info('exit function: _Load_pro_stock_basics')

    def __Load_pro_company_info(self,):
        """ check if the stock company info available in database or not """
        if not self.engine.dialect.has_table(self.engine, self.tablelst['pro_stock_company']):
            self.my_logger.warn('table %s is not in the database, will re-create into the database.'%self.tablelst['pro_stock_company'])
            tmp_df = self.ts_pro_api.stock_company(exchange='', fields='ts_code,exchange,chairman,manager,secretary,reg_capital,setup_date,province,city,introduction,website,email,office,employees,main_business,business_scope')
            if tmp_df is not None:
                tmp_df.to_sql(self.tablelst['pro_stock_company'], self.engine, if_exists='append')
        else:
            self.my_logger.info('check if the table is empty or not.')
            loc_con = self.engine.connect()
            loc_sql_ret = None            
            try:
                self.my_logger.debug('execute sql: %s'%sqlstmt.g_sql_str_dict['pro_stock_company_info_select_1001'])
                loc_sql_ret = loc_con.execute(txt(sqlstmt.g_sql_str_dict['pro_stock_company_info_select_1001']))
                loc_ret_data = loc_sql_ret.fetchone()
                tmp_rows = loc_ret_data[0]
                if (tmp_rows == 0):
                    self.my_logger.warn('table %s is empty, will re-download into the database.'%self.tablelst['pro_stock_company'])
                    tmp_df = self.ts_pro_api.stock_company(exchange='', fields='ts_code,exchange,chairman,manager,secretary,reg_capital,setup_date,province,city,introduction,website,email,office,employees,main_business,business_scope')
                    if tmp_df is not None:
                        tmp_df.to_sql(self.tablelst['pro_stock_company'],self.engine,if_exists='append')
                        
                # TODO: load in data from database                
            except:
                self.my_logger('Oops! %s occured.'%sys.exc_info()[0])
                pass
            self.my_logger.info('exit function: _Load_pro_stock_basics')

    def __Load_pro_new_share_info(self,):
        """ check if the new share info available in database or not """
        if not self.engine.dialect.has_table(self.engine, self.tablelst['pro_new_share']):
            self.my_logger.warn('table %s is not in the database, will re-create into the database.'%self.tablelst['pro_new_share'])
            loc_end_date = date.today()
            loc_start_date = loc_end_date - timedelta(30)
            tmp_df = self.ts_pro_api.new_share(start_date=loc_start_date.strftime('%Y%m%d'), end_date=loc_end_date.strftime('%Y%m%d'))
            if tmp_df is not None:
                tmp_df.to_sql(self.tablelst['pro_new_share'], self.engine, if_exists='append')
        else:
            self.my_logger.info('check if the table is empty or not.')
            loc_con = self.engine.connect()
            loc_sql_ret = None            
            try:
                self.my_logger.debug('execute sql: %s'%sqlstmt.g_sql_str_dict['pro_new_share_info_select_1001'])
                loc_sql_ret = loc_con.execute(txt(sqlstmt.g_sql_str_dict['pro_new_share_info_select_1001']))
                loc_ret_data = loc_sql_ret.fetchone()
                tmp_rows = loc_ret_data[0]
                if (tmp_rows == 0):
                    self.my_logger.warn('table %s is empty, will re-download into the database.'%self.tablelst['pro_new_share'])
                    tmp_df = self.ts_pro_api.new_share(start_date=loc_start_date.strftime('%Y%m%d'), end_date=loc_end_date.strftime('%Y%m%d'))
                    if tmp_df is not None:
                        tmp_df.to_sql(self.tablelst['pro_new_share'],self.engine,if_exists='append')
                        
                # TODO: load in data from database                
            except:
                self.my_logger('Oops! something wrong occurred.')
                pass
            self.my_logger.info('exit function: __Load_pro_new_share_info')
    
    # this interface needs 300 above credits to download
    def __Load_pro_stock_daily_basic(self,):
        """ check if the stock daily basic available in database or not """
        if not self.engine.dialect.has_table(self.engine, self.tablelst['pro_stock_daily_basic']):
            self.my_logger.warn('table %s is not in the database, will re-create into the database.'%self.tablelst['pro_stock_daily_basic'])
            loc_trade_date = date.today()
            tmp_df = self.ts_pro_api.daily_basic(ts_code='', trade_date = loc_trade_date.strftime('%Y%m%d'), fields='ts_code,trade_date,close,turnover_rate,turnover_rate_f,volume_ratio,pe,pe_ttm,pb,ps,ps_ttm,total_share,float_share,free_share,total_mv,circ_mv')
            if tmp_df is not None:
                tmp_df.to_sql(self.tablelst['pro_stock_daily_basic'], self.engine, if_exists='append')
        else:
            self.my_logger.info('check if the table is empty or not.')
            loc_con = self.engine.connect()
            loc_sql_ret = None            
            try:
                self.my_logger.debug('execute sql: %s'%sqlstmt.g_sql_str_dict['pro_stock_daily_basic_select_1001'])
                loc_sql_ret = loc_con.execute(txt(sqlstmt.g_sql_str_dict['pro_stock_daily_basic_select_1001']))
                loc_ret_data = loc_sql_ret.fetchone()
                tmp_rows = loc_ret_data[0]
                if (tmp_rows == 0):
                    self.my_logger.warn('table %s is empty, will re-download into the database.'%self.tablelst['pro_stock_daily_basic'])
                    tmp_df = self.ts_pro_api.stock_company(exchange='', fields='ts_code,trade_date,close,turnover_rate,turnover_rate_f,volume_ratio,pe,pe_ttm,pb,ps,ps_ttm,total_share,float_share,free_share,total_mv,circ_mv')
                    if tmp_df is not None:
                        tmp_df.to_sql(self.tablelst['pro_stock_daily_basic'],self.engine,if_exists='append')
                        
                # TODO: load in data from database                
            except:
                self.my_logger('Oops! %s occured.'%sys.exc_info()[0])
                pass
            self.my_logger.info('exit function: __Load_pro_stock_daily_basic')
    
    def __Check_k_data_of_last_trade_day(self, code):
        last_trade_day = date.today()
        loc_ret_data = None
        num_of_tries = 0
        while True:
            num_of_tries += 1
            if (num_of_tries > 100):
                loc_ret_data = ts.get_k_data(code,start=gv.g_k_data_since)
                if (len(loc_ret_data) > 0):
                    last_one_row = loc_ret_data.tail(1)
                    last_trade_day_str = last_one_row.iat[0,0]
                    last_trade_day = datetime.strptime(last_trade_day_str, '%Y-%m-%d')
                    break;
                else:
                    last_trade_day = None
                    break;
            loc_ret_data = ts.get_k_data(code, start=last_trade_day.strftime('%Y-%m-%d'))
            if (len(loc_ret_data) > 0):
                last_one_row = loc_ret_data.tail(1)
                last_trade_day_str = last_one_row.iat[0,0]
                last_trade_day = datetime.strptime(last_trade_day_str, '%Y-%m-%d')
                break
            else:
                last_trade_day = last_trade_day - timedelta(1)            
        return last_trade_day

    def __Check_last_daily_trade_day(self, code):
        self.my_logger.debug('begin to check last daily trade day for share: %s'%code)
        loc_today = date.today()
        last_trade_day = date.today()
        loc_ret_data = None
        num_of_tries = 0
        while True:
            num_of_tries += 1
            if (num_of_tries > 100):
                loc_start_date = gv.g_k_data_since
                loc_start_date = datetime.strptime(loc_start_date, '%Y-%m-%d')
                try:
                    loc_ret_data = self.ts_pro_api.daily(ts_code=code,start_date=loc_start_date.strftime('%Y%m%d'), end_date=loc_today.strftime('%Y%m%d'))
                except:
                    self.my_logger.error('failed to call pro api daily.')
                    last_trade_day = None
                    break
                if (len(loc_ret_data) > 0):
                    last_one_row = loc_ret_data.tail(1)
                    last_trade_day_str = last_one_row.iat[0,1]
                    last_trade_day = datetime.strptime(last_trade_day_str, '%Y%m%d')
                    break;
                else:
                    last_trade_day = None
                    break;            
            try:
                self.my_logger.debug('begin to call pro api daily for share: %s'%code)
                loc_ret_data = self.ts_pro_api.daily(ts_code=code, start_date=last_trade_day.strftime('%Y%m%d'),end_date=loc_today.strftime('%Y%m%d'))
            except:
                self.my_logger.error('failed to call pro api daily.')
                last_trade_day = None
                break
            loc_ret_data_len = len(loc_ret_data)
            self.my_logger.debug('after call pro api daily for share: %s, and length of return is:%s'%(code,loc_ret_data_len))
            if (loc_ret_data_len > 0):
                last_one_row = loc_ret_data.tail(1)
                last_trade_day_str = last_one_row.iat[0,1]
                last_trade_day = datetime.strptime(last_trade_day_str, '%Y%m%d')
                break
            else:
                last_trade_day = last_trade_day - timedelta(1)    
        self.my_logger.debug('the last trade day is: %s'%last_trade_day)        
        return last_trade_day
            
    def __Update_k_data(self, code_list):
        self.my_logger.info("begin update stock k data.")
        loc_con = self.engine.connect()
        loc_download_since = date.today()
        for loc_share_code in code_list:
            # first check if current share code data update to date or not in database            
            self.my_logger.debug('execute sql: %s'%sqlstmt.g_sql_str_dict['stock_k_data_select_1001'])
            loc_db_rs = loc_con.execute(text(sqlstmt.g_sql_str_dict['stock_k_data_select_1001']),in_code=loc_share_code)
            loc_ret_data = loc_db_rs.fetchone()
            if (loc_ret_data is None):
                self.my_logger.debug('Currently no data found for share: %s in database, will try to update.'%loc_share_code)
                loc_download_since = datetime.strptime(gv.g_k_data_since,'%Y-%m-%d')
            else:
                loc_ret_ts_code, loc_ret_trade_date = loc_ret_data
                loc_download_since = loc_ret_trade_date + timedelta(days=1)
            self.__Process_download_k_data(loc_share_code, loc_download_since)             
            
        self.my_logger.debug('exit funtion:__Update_k_data()')
    
    def __Process_download_k_data(self, in_code, in_download_start_date):
        loc_start_date = in_download_start_date
        loc_end_date = loc_start_date + offsets.YearEnd()
        loc_today = date.today()
        nYearStep = 1
        while True:            
            tmp_df = ts.get_k_data(loc_share_code, start=loc_start_date.strftime('%Y-%m-%d'),end=loc_end_date.strftime('%Y-%m-%d'))
            if tmp_df is not None:
                self.my_logger.debug('save new data to database for share code: %s of year: %s'%(in_code, loc_start_date.year))
                tmp_df.to_sql(self.tablelst['stock_k_data'], self.engine, if_exists='append')
                
            loc_start_date = date(loc_start_date.year + nYearStep, loc_start_date.month, loc_start_date.day)
            loc_end_date = date(loc_end_date.year + nYearStep, loc_end_date.month, loc_end_date.day)   
            if (loc_start_date.year >= loc_today.year):
                self.my_logger.debug('date for share code: %s is up to date to year: %s'%(in_code, loc_start_date.year))
                break        

    def __Update_stock_daily_data(self, code_list):
        self.my_logger.info("begin update stock daily data.")
        loc_con = self.engine.connect()
        loc_download_since = date.today()
        for loc_share_code in code_list:
            # first check if current share code data update to date or not in database            
            self.my_logger.debug('execute sql: %s'%sqlstmt.g_sql_str_dict['pro_stock_daily_data_select_1001'])
            loc_db_rs = loc_con.execute(text(sqlstmt.g_sql_str_dict['pro_stock_daily_data_select_1001']),in_code=loc_share_code)
            loc_ret_data = loc_db_rs.fetchone()
            if (loc_ret_data is None):
                self.my_logger.debug('Currently no data found for share: %s in database, will try to update.'%loc_share_code)
                loc_download_since = datetime.strptime(gv.g_k_data_since,'%Y-%m-%d')
            else:
                loc_ret_ts_code, loc_ret_trade_date = loc_ret_data
                loc_download_since = loc_ret_trade_date + timedelta(days=1)                               
            
            self.__Process_download_pro_daily_data(loc_share_code, loc_download_since)
        self.my_logger.debug('exit funtion:__Update_stock_daily_data()')
    
    def __Process_download_pro_daily_data(self, in_code, in_download_start_date):
        loc_start_date = in_download_start_date
        loc_end_date = loc_start_date + offsets.YearEnd()
        loc_today = date.today()
        nYearStep = 1
        while True:            
            tmp_df = self.ts_pro_api.daily(ts_code=in_code, start_date=loc_start_date.strftime('%Y%m%d'),end_date=loc_end_date.strftime('%Y%m%d'))
            if tmp_df is not None:
                self.my_logger.debug('save new data to database for share code: %s of year: %s'%(in_code, loc_start_date.year))
                tmp_df.to_sql(self.tablelst['pro_stock_daily_data'], self.engine, if_exists='append')
                
            loc_start_date = date(loc_start_date.year + nYearStep, loc_start_date.month, loc_start_date.day)
            loc_end_date = date(loc_end_date.year + nYearStep, loc_end_date.month, loc_end_date.day)   
            if (loc_start_date.year >= loc_today.year):
                self.my_logger.debug('date for share code: %s is up to date to year: %s'%(in_code, loc_start_date.year))
                break                                
    
    def __Download_k_data(self,):
        nTmpLstSize = 50
        if self.stock_code_count == 0:
            self.__Load_stock_basics()
        
        for i in range(0, self.stock_code_count, nTmpLstSize):
            local_start = i
            local_end = i + nTmpLstSize
            if local_end > self.stock_code_count:
                local_end = self.stock_code_count
            self.thrpool.add_task(self.__Update_k_data, self.share_code_lst[local_start:local_end])             
        
        #self.thrpool.wait_completion()  
        self.my_logger.debug('exit funtion: __Download_k_data()') 
        
    def __Download_stock_daily_data(self,):
        nTmpLstSize = 50
        if self.pro_stock_code_count == 0:
            self.__Load_pro_stock_basics()
            
        for i in range(0, self.pro_stock_code_count, nTmpLstSize):
            local_start = i
            local_end = i + nTmpLstSize
            if local_end > self.pro_stock_code_count:
                local_end = self.pro_stock_code_count
            self.thrpool.add_task(self.__Update_stock_daily_data, self.pro_share_code_lst[local_start:local_end])            
        
        # self.thrpool.wait_completion()  
        self.my_logger.debug('exit funtion: __Download_stock_daily_data()')   
        
    def __Download_all_pro_basic_info(self,):
        self.__Load_pro_stock_basics()
        self.__Load_pro_company_info()
        self.__Load_pro_new_share_info()
        self.__Load_stock_basics()
    
    def download_all_data(self,):
        self.__Download_stock_daily_data()
        self.__Download_k_data()
        
        self.thrpool.add_task(self.__Download_all_pro_basic_info(),)
        # wait until everything is updated  
        self.thrpool.wait_completion()
        self.my_logger.debug('exit funtion: download_all_data()')                                
    
    def get_share_code_and_name(self,):
        if len(self.share_code_name_dict) == 0:
            self.__Load_stock_basics()        
        return self.share_code_name_dict
    
    def get_share_name_by_code(self, code):
        if len(self.share_code_name_dict) == 0:
            self.__Load_stock_basics()
        return self.share_code_name_dict[code]
