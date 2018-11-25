-- MySQL dump 10.13  Distrib 5.7.21, for Linux (x86_64)
--
-- Host: localhost    Database: stock_shares
-- Author: Ouyang zhilin
-- ------------------------------------------------------
-- Server version	5.7.21-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- ts_code,symbol,name,area,industry,fullname,enname,market,exchange,curr_type,list_date,is_hs
DROP TABLE IF EXISTS `stock_shares`.`pro_stock_basic_info`;
CREATE TABLE  `stock_shares`.`pro_stock_basic_info` (
  `index` bigint(20) DEFAULT NULL,
  `ts_code` varchar(15) COLLATE utf8_bin NOT NULL,
  `symbol` varchar(8) COLLATE utf8_bin NOT NULL,
  `name` varchar(30) COLLATE utf8_bin NOT NULL,  
  `area` varchar(10) COLLATE utf8_bin NOT NULL,
  `industry` varchar(50) COLLATE utf8_bin NOT NULL,
  `fullname` varchar(256) COLLATE utf8_bin NOT NULL,
  `enname` varchar(256) COLLATE utf8_bin NOT NULL,
  `market` varchar(20) COLLATE utf8_bin NOT NULL,
  `exchange` varchar(5) COLLATE utf8_bin NOT NULL,
  `curr_type` varchar(5) COLLATE utf8_bin NOT NULL,
  `list_date` DATE DEFAULT NULL,
  `is_hs` varchar(2) COLLATE utf8_bin NOT NULL,  
  PRIMARY KEY (`symbol`),
  UNIQUE KEY `code_UNIQUE` (`ts_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ts_code,exchange,chairman,manager,secretary,reg_capital,setup_date,province,city,introduction,website,email,office,employees,main_business,business_scope
DROP TABLE IF EXISTS `stock_shares`.`pro_stock_company_info`;
CREATE TABLE  `stock_shares`.`pro_stock_company_info` (
  `index` bigint(20) DEFAULT NULL,
  `ts_code` varchar(15) COLLATE utf8_bin NOT NULL,
  `exchange` varchar(5) COLLATE utf8_bin NOT NULL,
  `chairman` varchar(20) COLLATE utf8_bin DEFAULT NULL, 
  `manager` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `secretary` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  `reg_capital` float DEFAULT 0.0,
  `setup_date` DATE DEFAULT NULL,
  `province` varchar(40) COLLATE utf8_bin NOT NULL,
  `city` varchar(20) COLLATE utf8_bin NOT NULL,
  `introduction` varchar(2500) COLLATE utf8_bin NOT NULL,
  `website` varchar(60) COLLATE utf8_bin DEFAULT NULL,
  `email` varchar(80) COLLATE utf8_bin DEFAULT NULL,
  `office` varchar(80) COLLATE utf8_bin DEFAULT NULL,
  `employees` int(9) NOT NULL,
  `main_business` varchar(2500) COLLATE utf8_bin DEFAULT NULL,
  `business_scope` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ts_code`),
  UNIQUE KEY `ts_code_UNIQUE`(`ts_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- new_share(start_date='20181022', end_date='20181122')
DROP TABLE IF EXISTS `stock_shares`.`pro_new_share_info`;
CREATE TABLE  `stock_shares`.`pro_new_share_info` (
  `index` bigint(20) DEFAULT NULL,
  `ts_code` varchar(15) COLLATE utf8_bin NOT NULL,
  `sub_code` varchar(8) COLLATE utf8_bin NOT NULL,
  `name` varchar(15) COLLATE utf8_bin NOT NULL,  
  `ipo_date` DATE DEFAULT NULL,
  `issue_date` varchar(15) COLLATE utf8_bin DEFAULT NULL,
  `amount` float DEFAULT 0.0,
  `market_amount` float DEFAULT 0.0,
  `price` float DEFAULT 0.0,
  `pe` float DEFAULT 0.0,
  `limit_amount` float DEFAULT 0.0,
  `funds` float DEFAULT 0.0,
  `ballot` float DEFAULT 0.0,
  PRIMARY KEY (`ts_code`),
  UNIQUE KEY `ts_code_UNIQUE`(`ts_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `stock_shares`.`pro_stock_daily_data`;
CREATE TABLE  `stock_shares`.`pro_stock_daily_data` (
  `index` bigint(20) DEFAULT NULL,
  `ts_code` varchar(15) COLLATE utf8_bin NOT NULL,
  `trade_date` date DEFAULT NULL,
  `open` float DEFAULT '0',
  `high` float DEFAULT '0',
  `low` float DEFAULT '0',
  `close` float DEFAULT '0',
  `pre_close` float DEFAULT '0',
  `change` float DEFAULT '0',
  `pct_change` float DEFAULT '0',
  `vol` float DEFAULT '0',
  `amount` float DEFAULT '0',
  UNIQUE KEY `unique_key` (`ts_code`,`trade_date`),
  KEY `idx_trade_date` (`trade_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `stock_shares`.`pro_stock_daily_basic`;
CREATE TABLE  `stock_shares`.`pro_stock_daily_basic` (
  `index` bigint(20) DEFAULT NULL,
  `ts_code` varchar(15) COLLATE utf8_bin NOT NULL,
  `trade_date` DATE DEFAULT NULL,
  `close` float DEFAULT 0.0,
  `turnover_rate` float DEFAULT 0.0,
  `turnover_rate_f` float DEFAULT 0.0,
  `volume_ratio` float DEFAULT 0.0,
  `pe` float DEFAULT 0.0,
  `pe_ttm` float DEFAULT 0.0,
  `pb` float DEFAULT 0.0,
  `ps` float DEFAULT 0.0,
  `ps_ttm` float DEFAULT 0.0,
  `total_share` float DEFAULT 0.0,
  `float_share` float DEFAULT 0.0,
  `free_share` float DEFAULT 0.0,
  `total_mv` float DEFAULT 0.0,
  `circ_mv` float DEFAULT 0.0,
  PRIMARY KEY (`ts_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `stock_shares`.`stock_k_data`;
CREATE TABLE  `stock_shares`.`stock_k_data` (
  `index` bigint(20) DEFAULT NULL,
  `date` date NOT NULL,
  `open` double DEFAULT NULL,
  `close` double DEFAULT NULL,
  `high` double DEFAULT NULL,
  `low` double DEFAULT NULL,
  `volume` double DEFAULT NULL,
  `code` varchar(10) COLLATE utf8_bin NOT NULL,
  KEY `ix_k_data_index` (`index`),
  KEY `idx_date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `stock_shares`.`stock_basic_info`;
CREATE TABLE  `stock_shares`.`stock_basic_info` (
  `index` bigint(20) DEFAULT NULL,
  `code` varchar(10) COLLATE utf8_bin NOT NULL,
  `name` varchar(30) COLLATE utf8_bin NOT NULL,
  `industry` varchar(50) COLLATE utf8_bin NOT NULL,
  `area` varchar(10) COLLATE utf8_bin NOT NULL,
  `pe` double DEFAULT NULL,
  `outstanding` double DEFAULT NULL,
  `totals` double DEFAULT NULL,
  `totalAssets` double DEFAULT NULL,
  `liquidAssets` double DEFAULT NULL,
  `fixedAssets` double DEFAULT NULL,
  `reserved` double DEFAULT NULL,
  `reservedPerShare` double DEFAULT NULL,
  `esp` double DEFAULT NULL,
  `bvps` double DEFAULT NULL,
  `pb` double DEFAULT NULL,
  `timeToMarket` datetime DEFAULT NULL,
  `undp` double DEFAULT NULL,
  `perundp` double DEFAULT NULL,
  `rev` double DEFAULT NULL,
  `profit` double DEFAULT NULL,
  `gpr` double DEFAULT NULL,
  `npr` double DEFAULT NULL,
  `holders` double DEFAULT NULL,
  PRIMARY KEY (`code`),
  UNIQUE KEY `code_UNIQUE` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `stock_shares`.`realtime_quotes_data`;
CREATE TABLE  `stock_shares`.`realtime_quotes_data` (
  `index` bigint(20) DEFAULT NULL,
  `name` varchar(15) COLLATE utf8_bin NOT NULL DEFAULT '',
  `open` double DEFAULT NULL,
  `pre_close` double DEFAULT NULL,
  `price` double DEFAULT NULL,
  `high` double DEFAULT NULL,
  `low` double DEFAULT NULL,
  `bid` double DEFAULT NULL,
  `ask` double DEFAULT NULL,
  `volume` double DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `b1_v` double DEFAULT NULL,
  `b1_p` double DEFAULT NULL,
  `b2_v` double DEFAULT NULL,
  `b2_p` double DEFAULT NULL,
  `b3_v` double DEFAULT NULL,
  `b3_p` double DEFAULT NULL,
  `b4_v` double DEFAULT NULL,
  `b4_p` double DEFAULT NULL,
  `b5_v` double DEFAULT NULL,
  `b5_p` double DEFAULT NULL,
  `a1_v` double DEFAULT NULL,
  `a1_p` double DEFAULT NULL,
  `a2_v` double DEFAULT NULL,
  `a2_p` double DEFAULT NULL,
  `a3_v` double DEFAULT NULL,
  `a3_p` double DEFAULT NULL,
  `a4_v` double DEFAULT NULL,
  `a4_p` double DEFAULT NULL,
  `a5_v` double DEFAULT NULL,
  `a5_p` double DEFAULT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `code` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '',
  KEY `ix_realtime_quotes_data_index` (`index`),
  KEY `idx_code` (`code`),
  KEY `idx_date_time` (`date`,`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `stock_shares`.`stock_market_index`;
CREATE TABLE  `stock_shares`.`stock_market_index` (
  `index` bigint(20) DEFAULT NULL,
  `code` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '',
  `name` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `change` double DEFAULT NULL,
  `open` double DEFAULT NULL,
  `preclose` double DEFAULT NULL,
  `close` double DEFAULT NULL,
  `high` double DEFAULT NULL,
  `low` double DEFAULT NULL,
  `volume` bigint(20) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  KEY `ix_stock_market_index_index` (`index`),
  KEY `idx_code` (`code`),
  KEY `idx_vol` (`volume`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `stock_shares`.`share_big_vol_data`;
CREATE TABLE  `stock_shares`.`share_big_vol_data` (
  `index` bigint(20) DEFAULT NULL,
  `code` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '',
  `name` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `time` time DEFAULT NULL,
  `price` double DEFAULT NULL,
  `volume` bigint(20) DEFAULT NULL,
  `preprice` double DEFAULT NULL,
  `type` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  KEY `ix_share_big_vol_data_index` (`index`),
  KEY `idx_code` (`code`),
  KEY `idx_time` (`time`),
  KEY `idx_vol` (`volume`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `stock_shares`.`share_profit_data`;
CREATE TABLE  `stock_shares`.`share_profit_data` (
  `index` bigint(20) DEFAULT NULL,
  `code` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '',
  `name` varchar(15) COLLATE utf8_bin DEFAULT NULL,
  `year` bigint(20) DEFAULT NULL,
  `report_date` date DEFAULT NULL,
  `divi` double DEFAULT NULL,
  `shares` double DEFAULT NULL,
  KEY `ix_share_profit_data_index` (`index`),
  KEY `idx_code` (`code`),
  KEY `idx_report_d` (`report_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `stock_shares`.`share_industry_classified`;
CREATE TABLE  `stock_shares`.`share_industry_classified` (
  `index` bigint(20) DEFAULT NULL,
  `code` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '',
  `name` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `c_name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  KEY `ix_share_industry_classified_index` (`index`),
  KEY `Idx_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `stock_shares`.`share_concept_classified`;
CREATE TABLE  `stock_shares`.`share_concept_classified` (
  `index` bigint(20) DEFAULT NULL,
  `code` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '',
  `name` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `c_name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  KEY `ix_share_concept_classified_index` (`index`),
  KEY `Idx_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `stock_shares`.`share_area_classified`;
CREATE TABLE  `stock_shares`.`share_area_classified` (
  `index` bigint(20) DEFAULT NULL,
  `code` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '',
  `name` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `area` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  KEY `ix_share_area_classified_index` (`index`),
  KEY `Idx_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `stock_shares`.`share_sme_classified`;
CREATE TABLE  `stock_shares`.`share_sme_classified` (
  `index` bigint(20) DEFAULT NULL,
  `code` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '',
  `name` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  KEY `ix_share_sme_classified_index` (`index`),
  KEY `Idx_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `stock_shares`.`share_gem_classified`;
CREATE TABLE  `stock_shares`.`share_gem_classified` (
  `index` bigint(20) DEFAULT NULL,
  `code` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '',
  `name` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  KEY `ix_share_gem_classified_index` (`index`),
  KEY `Idx_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `stock_shares`.`share_hs300s`;
CREATE TABLE  `stock_shares`.`share_hs300s` (
  `index` bigint(20) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `code` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '',
  `name` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `weight` double DEFAULT NULL,
  KEY `ix_share_hs300s_index` (`index`),
  KEY `Idx_code` (`code`),
  KEY `Idx_date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `stock_shares`.`share_sz50s`;
CREATE TABLE  `stock_shares`.`share_sz50s` (
  `index` bigint(20) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `code` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '',
  `name` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  KEY `ix_share_sz50s_index` (`index`),
  KEY `Idx_code` (`code`),
  KEY `Idx_date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `stock_shares`.`share_zz500s`;
CREATE TABLE  `stock_shares`.`share_zz500s` (
  `index` bigint(20) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `code` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '',
  `name` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `weight` double DEFAULT NULL,
  KEY `ix_share_zz500s_index` (`index`),
  KEY `Idx_code` (`code`),
  KEY `Idx_date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `stock_shares`.`share_st_classified`;
CREATE TABLE  `stock_shares`.`share_st_classified` (
  `index` bigint(20) DEFAULT NULL,
  `code` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '',
  `name` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  KEY `ix_share_st_classified_index` (`index`),
  KEY `Idx_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `stock_shares`.`nation_loan_rate`;
CREATE TABLE  `stock_shares`.`nation_loan_rate` (
  `index` bigint(20) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `loan_type` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `rate` double DEFAULT NULL,
  KEY `ix_nation_loan_rate_index` (`index`),
  KEY `Idx_date` (`date`),
  KEY `Idx_rate` (`rate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `stock_shares`.`nation_deposit_rate`;
CREATE TABLE  `stock_shares`.`nation_deposit_rate` (
  `index` bigint(20) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `deposit_type` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `rate` double DEFAULT NULL,
  KEY `ix_nation_deposit_rate_index` (`index`),
  KEY `Idx_date` (`date`),
  KEY `Idx_rate` (`rate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `stock_shares`.`nation_deposit_base_rate`;
CREATE TABLE  `stock_shares`.`nation_deposit_base_rate` (
  `index` bigint(20) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `before` double DEFAULT NULL,
  `now` double DEFAULT NULL,
  `changed` double DEFAULT NULL,
  KEY `ix_nation_deposit_base_rate_index` (`index`),
  KEY `Idx_date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `stock_shares`.`nation_money_supply`;
CREATE TABLE  `stock_shares`.`nation_money_supply` (
  `index` bigint(20) DEFAULT NULL,
  `month` varchar(8) COLLATE utf8_bin DEFAULT NULL,
  `m2` double DEFAULT NULL,
  `m2_yoy` double DEFAULT NULL,
  `m1` double DEFAULT NULL,
  `m1_yoy` double DEFAULT NULL,
  `m0` double DEFAULT NULL,
  `m0_yoy` double DEFAULT NULL,
  `cd` double DEFAULT NULL,
  `cd_yoy` double DEFAULT NULL,
  `qm` double DEFAULT NULL,
  `qm_yoy` double DEFAULT NULL,
  `ftd` double DEFAULT NULL,
  `ftd_yoy` double DEFAULT NULL,
  `sd` double DEFAULT NULL,
  `sd_yoy` double DEFAULT NULL,
  `rests` double DEFAULT NULL,
  `rests_yoy` double DEFAULT NULL,
  KEY `ix_nation_money_supply_index` (`index`),
  KEY `Idx_mon` (`month`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `stock_shares`.`nation_money_supply_bal`;
CREATE TABLE  `stock_shares`.`nation_money_supply_bal` (
  `index` bigint(20) DEFAULT NULL,
  `year` varchar(5) COLLATE utf8_bin DEFAULT NULL,
  `m2` double DEFAULT NULL,
  `m1` double DEFAULT NULL,
  `m0` double DEFAULT NULL,
  `cd` double DEFAULT NULL,
  `qm` double DEFAULT NULL,
  `ftd` double DEFAULT NULL,
  `sd` double DEFAULT NULL,
  `rests` double DEFAULT NULL,
  KEY `ix_nation_money_supply_bal_index` (`index`),
  KEY `Idx_year` (`year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `stock_shares`.`nation_gdp_year`;
CREATE TABLE  `stock_shares`.`nation_gdp_year` (
  `index` bigint(20) DEFAULT NULL,
  `year` bigint(20) DEFAULT NULL,
  `gdp` double DEFAULT NULL,
  `pc_gdp` double DEFAULT NULL,
  `gnp` double DEFAULT NULL,
  `pi` double DEFAULT NULL,
  `si` double DEFAULT NULL,
  `industry` double DEFAULT NULL,
  `cons_industry` double DEFAULT NULL,
  `ti` double DEFAULT NULL,
  `trans_industry` double DEFAULT NULL,
  `lbdy` double DEFAULT NULL,
  KEY `ix_nation_gdp_year_index` (`index`),
  KEY `Idx_year` (`year`),
  KEY `Idx_gdp` (`gdp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `stock_shares`.`nation_gdp_quarter`;
CREATE TABLE  `stock_shares`.`nation_gdp_quarter` (
  `index` bigint(20) DEFAULT NULL,
  `quarter` varchar(8) COLLATE utf8_bin DEFAULT NULL,
  `gdp` double DEFAULT NULL,
  `gdp_yoy` double DEFAULT NULL,
  `pi` double DEFAULT NULL,
  `pi_yoy` double DEFAULT NULL,
  `si` double DEFAULT NULL,
  `si_yoy` double DEFAULT NULL,
  `ti` double DEFAULT NULL,
  `ti_yoy` double DEFAULT NULL,
  KEY `ix_nation_gdp_quarter_index` (`index`),
  KEY `Idx_quater` (`quarter`),
  KEY `Idx_gdp` (`gdp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `stock_shares`.`nation_gdp_for`;
CREATE TABLE  `stock_shares`.`nation_gdp_for` (
  `index` bigint(20) DEFAULT NULL,
  `year` bigint(20) DEFAULT NULL,
  `end_for` double DEFAULT NULL,
  `for_rate` double DEFAULT NULL,
  `asset_for` double DEFAULT NULL,
  `asset_rate` double DEFAULT NULL,
  `goods_for` double DEFAULT NULL,
  `goods_rate` double DEFAULT NULL,
  KEY `ix_nation_gdp_for_index` (`index`),
  KEY `Idx_year` (`year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `stock_shares`.`nation_gdp_pull`;
CREATE TABLE  `stock_shares`.`nation_gdp_pull` (
  `index` bigint(20) DEFAULT NULL,
  `year` bigint(20) DEFAULT NULL,
  `gdp_yoy` double DEFAULT NULL,
  `pi` double DEFAULT NULL,
  `si` double DEFAULT NULL,
  `industry` double DEFAULT NULL,
  `ti` double DEFAULT NULL,
  KEY `ix_nation_gdp_pull_index` (`index`),
  KEY `Idx_year` (`year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `stock_shares`.`nation_gdp_contrib`;
CREATE TABLE  `stock_shares`.`nation_gdp_contrib` (
  `index` bigint(20) DEFAULT NULL,
  `year` bigint(20) DEFAULT NULL,
  `gdp_yoy` double DEFAULT NULL,
  `pi` double DEFAULT NULL,
  `si` double DEFAULT NULL,
  `industry` double DEFAULT NULL,
  `ti` double DEFAULT NULL,
  KEY `ix_nation_gdp_contrib_index` (`index`),
  KEY `Idx_year` (`year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `stock_shares`.`nation_cpi`;
CREATE TABLE  `stock_shares`.`nation_cpi` (
  `index` bigint(20) DEFAULT NULL,
  `month` varchar(8) COLLATE utf8_bin DEFAULT NULL,
  `cpi` double DEFAULT NULL,
  KEY `ix_nation_cpi_index` (`index`),
  KEY `Idx_cpi` (`cpi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `stock_shares`.`nation_ppi`;
CREATE TABLE  `stock_shares`.`nation_ppi` (
  `index` bigint(20) DEFAULT NULL,
  `month` varchar(8) COLLATE utf8_bin DEFAULT NULL,
  `ppiip` double DEFAULT NULL,
  `ppi` double DEFAULT NULL,
  `qm` double DEFAULT NULL,
  `rmi` double DEFAULT NULL,
  `pi` double DEFAULT NULL,
  `cg` double DEFAULT NULL,
  `food` double DEFAULT NULL,
  `clothing` double DEFAULT NULL,
  `roeu` double DEFAULT NULL,
  `dcg` double DEFAULT NULL,
  KEY `ix_nation_ppi_index` (`index`),
  KEY `Idx_mon` (`month`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `stock_shares`.`share_top_list`;
CREATE TABLE  `stock_shares`.`share_top_list` (
  `index` bigint(20) DEFAULT NULL,
  `code` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '',
  `name` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `pchange` double DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `buy` double DEFAULT NULL,
  `sell` double DEFAULT NULL,
  `reason` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `bratio` double DEFAULT NULL,
  `sratio` double DEFAULT NULL,
  `date` date DEFAULT NULL,
  KEY `ix_share_top_list_index` (`index`),
  KEY `Idx_code` (`code`),
  KEY `Idx_amount` (`amount`),
  KEY `Idx_date` (`date`),
  KEY `Idx_pchange` (`pchange`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `stock_shares`.`pro_index_basic_info`;
CREATE TABLE  `stock_shares`.`pro_index_basic_info` (
  `index` bigint(20) DEFAULT NULL,
  `ts_code` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT 'TS代码',
  `name` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `market` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `publisher` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `category` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  `base_date` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  `base_point` double DEFAULT NULL,
  `list_date` date DEFAULT NULL,
  KEY `ix_pro_index_basic_info_index` (`index`),
  KEY `Index_code` (`ts_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `stock_shares`.`pro_index_daily_data`;
CREATE TABLE  `stock_shares`.`pro_index_daily_data` (
  `index` bigint(20) DEFAULT NULL,
  `ts_code` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `trade_date` date DEFAULT NULL,
  `close` double DEFAULT NULL,
  `open` double DEFAULT NULL,
  `high` double DEFAULT NULL,
  `low` double DEFAULT NULL,
  `pre_close` double DEFAULT NULL,
  `change` double DEFAULT NULL,
  `pct_change` double DEFAULT NULL,
  `vol` double DEFAULT NULL,
  `amount` double DEFAULT NULL,
  KEY `ix_pro_index_daily_data_index` (`index`),
  KEY `Index_code` (`ts_code`),
  KEY `Index_date` (`trade_date`),
  KEY `Index_close` (`close`),
  KEY `Index_change` (`pct_change`,`change`),
  KEY `Index_vol` (`vol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `stock_shares`.`pro_money_flow_hsgt`;
CREATE TABLE  `stock_shares`.`pro_money_flow_hsgt` (
  `index` bigint(20) DEFAULT NULL,
  `trade_date` date DEFAULT NULL,
  `ggt_ss` double DEFAULT NULL,
  `ggt_sz` double DEFAULT NULL,
  `hgt` double DEFAULT NULL,
  `sgt` double DEFAULT NULL,
  `north_money` double DEFAULT NULL,
  `south_money` double DEFAULT NULL,
  KEY `ix_pro_money_flow_hsgt_index` (`index`),
  KEY `Index_date` (`trade_date`),
  KEY `Index_ggt_ss` (`ggt_ss`),
  KEY `Index_ggt_sz` (`ggt_sz`),
  KEY `Index_hgt` (`hgt`),
  KEY `Index_sgt` (`sgt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `stock_shares`.`pro_hs_const_info`;
CREATE TABLE  `stock_shares`.`pro_hs_const_info` (
  `index` bigint(20) DEFAULT NULL,
  `ts_code` varchar(12) COLLATE utf8_bin NOT NULL DEFAULT '',
  `hs_type` varchar(4) COLLATE utf8_bin DEFAULT NULL,
  `in_date` date DEFAULT NULL,
  `out_date` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `is_new` tinyint(1) DEFAULT NULL,
  UNIQUE KEY `Index_code` (`ts_code`),
  KEY `ix_pro_hs_const_index` (`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `stock_shares`.`pro_hsgt_top10_data`;
CREATE TABLE  `stock_shares`.`pro_hsgt_top10_data` (
  `index` bigint(20) DEFAULT NULL,
  `trade_date` date DEFAULT NULL,
  `ts_code` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `close` double DEFAULT NULL,
  `p_change` double DEFAULT NULL,
  `rank` bigint(20) DEFAULT NULL,
  `market_type` bigint(20) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `net_amount` double DEFAULT NULL,
  `buy` double DEFAULT NULL,
  `sell` double DEFAULT NULL,
  KEY `ix_pro_hsgt_top10_index` (`index`),
  KEY `Index_trade_date` (`trade_date`),
  KEY `Index_code` (`ts_code`),
  KEY `Index_change` (`p_change`),
  KEY `Index_amount` (`amount`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;