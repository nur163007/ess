

CREATE TABLE `accounts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_no` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `initial_balance` double DEFAULT NULL,
  `total_balance` double NOT NULL,
  `note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO accounts VALUES("1","100101","Aibl","100000","100000","All sales should goes under this account head","0","1","2018-12-18 08:58:02","2022-11-29 22:20:53");
INSERT INTO accounts VALUES("3","200201","Cash in Hand","","0","Company Cash account-handover to owner","0","0","2018-12-18 08:58:56","2022-11-29 09:14:29");
INSERT INTO accounts VALUES("5","200202","Bank Account","","0","Company Bank Account","0","1","2022-10-20 16:47:09","2022-11-29 22:19:14");
INSERT INTO accounts VALUES("6","300101","Company Expenses","","0","All company expenses should goes in this account","","0","2022-10-20 16:49:37","2022-11-29 09:14:42");
INSERT INTO accounts VALUES("7","01","Cash","5000","5000","","1","1","2022-11-29 22:18:54","2022-12-02 01:07:21");
INSERT INTO accounts VALUES("8","02","ucbl","100000","100000","","0","1","2022-11-29 22:20:13","2022-12-02 01:07:21");
INSERT INTO accounts VALUES("9","098474","Ceylon","100000","100000","","","1","2022-11-29 22:21:41","2022-11-29 22:21:41");
INSERT INTO accounts VALUES("10","9001001","Helping Money Fund","1000000","1000000","","","0","2023-01-06 00:25:24","2023-01-07 22:57:49");
INSERT INTO accounts VALUES("11","9002001","Help Loan 1","0","0","","","0","2023-01-06 00:26:11","2023-01-08 05:49:25");
INSERT INTO accounts VALUES("12","5678990","Iscl","0","0","Sister concern","","1","2023-01-07 22:51:56","2023-01-07 22:51:56");
INSERT INTO accounts VALUES("13","654188","Scsl","0","0","SC","","1","2023-01-07 22:56:29","2023-01-07 22:56:29");
INSERT INTO accounts VALUES("14","10992900","Star pacific","0","0","SC","","1","2023-01-07 22:59:03","2023-01-07 22:59:03");



CREATE TABLE `adjustments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `document` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_qty` double NOT NULL,
  `item` int(11) NOT NULL,
  `note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `agencies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vat_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postal_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO agencies VALUES("1","Nur Mohammad","aqatech.jpg","Aqa technology","346763456","nur.mohammad@aaqa.co","01985964113","khilgoan","dhaka","dhaka","1219","Bangladesh","1","2023-01-09 17:13:16","2023-01-10 12:09:59");



CREATE TABLE `attendances` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `employee_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `checkin` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `checkout` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int(11) NOT NULL,
  `note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `billers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vat_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postal_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO billers VALUES("1","sutarkandi","","fakhor bros","","fakhor@gmail.com","000000","darga","sylhet","sylhet","","bangladesh","1","2022-11-29 22:28:56","2022-11-29 22:28:56");
INSERT INTO billers VALUES("2","Anam","","TnT co","Noman","anam@gmail.com","01689574356","malibag","dhaka","","1217","Bangladesh","1","2023-01-16 12:39:30","2023-01-16 12:48:54");



CREATE TABLE `brands` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO brands VALUES("1","SA coal","","1","2022-11-29 22:15:28","2022-11-29 22:15:28");
INSERT INTO brands VALUES("2","indo coal","","1","2022-11-29 22:15:42","2022-11-29 22:15:42");
INSERT INTO brands VALUES("3","indian coal","","1","2022-11-29 22:15:58","2022-11-29 22:15:58");



CREATE TABLE `cash_registers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cash_in_hand` double NOT NULL,
  `user_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO cash_registers VALUES("1","100","2","1","1","2022-11-29 22:39:54","2022-11-29 22:39:54");
INSERT INTO cash_registers VALUES("2","0","2","3","1","2022-11-29 23:21:24","2022-11-29 23:21:24");
INSERT INTO cash_registers VALUES("3","1000","1","4","1","2023-01-10 18:24:34","2023-01-10 18:24:34");



CREATE TABLE `categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO categories VALUES("1","Coal","","","1","2022-11-29 22:08:33","2022-11-29 22:08:33");
INSERT INTO categories VALUES("2","Stone","","","1","2022-11-29 22:08:52","2022-11-29 22:08:52");



CREATE TABLE `coupons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` double NOT NULL,
  `minimum_amount` double DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `used` int(11) NOT NULL,
  `expired_date` date NOT NULL,
  `user_id` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `currencies` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `exchange_rate` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO currencies VALUES("1","US Dollar","USD","1","2020-11-01 06:22:58","2020-11-01 06:34:55");
INSERT INTO currencies VALUES("2","Euro","Euro","1","2020-11-01 07:29:12","2022-10-20 07:46:35");
INSERT INTO currencies VALUES("3","Bangladesh Taka","BDT","1","2022-10-17 04:29:21","2022-10-20 07:46:27");



CREATE TABLE `customer_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `percentage` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO customer_groups VALUES("1","old","10","1","2022-11-29 22:36:41","2022-11-29 22:36:41");
INSERT INTO customer_groups VALUES("2","Cash Sale","0","1","2022-11-29 22:37:43","2022-11-29 22:37:43");
INSERT INTO customer_groups VALUES("3","listed customer","0","1","2022-11-29 22:38:17","2022-11-29 22:38:17");



CREATE TABLE `customers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer_group_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tax_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postal_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `points` double DEFAULT NULL,
  `deposit` double DEFAULT NULL,
  `expense` double DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO customers VALUES("1","3","","monir","monir bricks","","0999","","comilla","coilla","","","","","1000","","1","2022-11-29 22:39:07","2022-11-30 00:11:51");
INSERT INTO customers VALUES("2","1","","Nur1","","","01789786453","","malibag","dhaka","","1217","Bangladesh","","","","1","2023-01-16 11:51:56","2023-01-16 11:51:56");
INSERT INTO customers VALUES("3","1","","Noman123","NA cor","noman@gmail.com","01789786459","","malibag","dhaka","","1217","Bangladesh","","","","1","2023-01-16 11:59:23","2023-01-16 12:51:30");
INSERT INTO customers VALUES("4","1","12","Noman","NA corporation","noman@gmail.com","01789786490","","malibag","dhaka","dhaka","1217","Bangladesh","","","","1","2023-01-16 12:00:14","2023-01-16 12:33:17");
INSERT INTO customers VALUES("5","1","","Hanif2","h","","01897349853","","malibag","dhaka","","1217","Bangladesh","","","","1","2023-01-16 13:07:32","2023-01-16 13:07:32");



CREATE TABLE `deliveries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sale_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `delivered_by` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recieved_by` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `departments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO departments VALUES("1","Sales","1","2023-01-16 09:53:24","2023-01-16 09:53:24");



CREATE TABLE `deposits` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `amount` double NOT NULL,
  `customer_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO deposits VALUES("1","1000","1","2","","2022-11-30 00:11:51","2022-11-30 00:11:51");



CREATE TABLE `discount_plan_customers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `discount_plan_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `discount_plan_discounts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `discount_id` int(11) NOT NULL,
  `discount_plan_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `discount_plans` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `discounts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `applicable_for` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_list` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `valid_from` date NOT NULL,
  `valid_till` date NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` double NOT NULL,
  `minimum_qty` double NOT NULL,
  `maximum_qty` double NOT NULL,
  `days` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `dso_alerts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `product_info` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `number_of_products` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `employees` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `department_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO employees VALUES("1","Abir","","01783923452","1","7","","","","","1","2023-01-16 10:06:36","2023-01-16 10:06:36");
INSERT INTO employees VALUES("2","Nur","","01789786453","1","8","","malibag","dhaka","Bangladesh","1","2023-01-16 10:13:00","2023-01-16 10:13:00");
INSERT INTO employees VALUES("3","Noman","","01789786453","1","9","","malibag","dhaka","Bangladesh","1","2023-01-16 11:30:22","2023-01-16 11:30:22");
INSERT INTO employees VALUES("4","Hanif","","01987654532","1","10","","","","","1","2023-01-16 11:33:55","2023-01-16 11:33:55");



CREATE TABLE `expense_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO expense_categories VALUES("1","0989","iscl","1","2022-11-29 22:54:01","2022-11-29 22:54:01");
INSERT INTO expense_categories VALUES("2","012","Star pacific","1","2022-11-29 22:54:23","2022-11-29 22:54:23");
INSERT INTO expense_categories VALUES("3","013","Scsl","1","2022-11-29 22:54:36","2022-11-29 22:54:36");



CREATE TABLE `expenses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expense_category_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `amount` double NOT NULL,
  `note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO expenses VALUES("1","er-20221129-115649","1","4","9","2","","50000","lend money for 1wk","2022-11-29 11:00:00","2022-11-29 22:56:49");



CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `general_settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `site_logo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_rtl` tinyint(1) DEFAULT NULL,
  `currency` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `staff_access` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_format` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `developed_by` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_format` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `theme` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `currency_position` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO general_settings VALUES("1","Fakhor Uddin Brothers","20230107064237.jpg","0","3","own","d/m/Y","iiTBL Ltd.","standard","1","default.css","2018-07-06 12:13:11","2023-01-08 05:42:37","prefix");



CREATE TABLE `gift_card_recharges` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `gift_card_id` int(11) NOT NULL,
  `amount` double NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `gift_cards` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `card_no` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` double NOT NULL,
  `expense` double NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `expired_date` date DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `holidays` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_approved` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `hrm_settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `checkin` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `checkout` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO hrm_settings VALUES("1","10:00am","6:00pm","2019-01-02 08:20:08","2019-01-02 10:20:53");



CREATE TABLE `languages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO languages VALUES("1","en","2018-07-08 04:59:17","2019-12-24 23:34:20");



CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO migrations VALUES("1","2014_10_12_000000_create_users_table","1");
INSERT INTO migrations VALUES("2","2014_10_12_100000_create_password_resets_table","1");
INSERT INTO migrations VALUES("3","2018_02_17_060412_create_categories_table","1");
INSERT INTO migrations VALUES("4","2018_02_20_035727_create_brands_table","1");
INSERT INTO migrations VALUES("5","2018_02_25_100635_create_suppliers_table","1");
INSERT INTO migrations VALUES("6","2018_02_27_101619_create_warehouse_table","1");
INSERT INTO migrations VALUES("7","2018_03_03_040448_create_units_table","1");
INSERT INTO migrations VALUES("8","2018_03_04_041317_create_taxes_table","1");
INSERT INTO migrations VALUES("9","2018_03_10_061915_create_customer_groups_table","1");
INSERT INTO migrations VALUES("10","2018_03_10_090534_create_customers_table","1");
INSERT INTO migrations VALUES("11","2018_03_11_095547_create_billers_table","1");
INSERT INTO migrations VALUES("12","2018_04_05_054401_create_products_table","1");
INSERT INTO migrations VALUES("13","2018_04_06_133606_create_purchases_table","1");
INSERT INTO migrations VALUES("14","2018_04_06_154600_create_product_purchases_table","1");
INSERT INTO migrations VALUES("15","2018_04_06_154915_create_product_warhouse_table","1");
INSERT INTO migrations VALUES("16","2018_04_10_085927_create_sales_table","1");
INSERT INTO migrations VALUES("17","2018_04_10_090133_create_product_sales_table","1");
INSERT INTO migrations VALUES("18","2018_04_10_090254_create_payments_table","1");
INSERT INTO migrations VALUES("19","2018_04_10_090341_create_payment_with_cheque_table","1");
INSERT INTO migrations VALUES("20","2018_04_10_090509_create_payment_with_credit_card_table","1");
INSERT INTO migrations VALUES("21","2018_04_13_121436_create_quotation_table","1");
INSERT INTO migrations VALUES("22","2018_04_13_122324_create_product_quotation_table","1");
INSERT INTO migrations VALUES("23","2018_04_14_121802_create_transfers_table","1");
INSERT INTO migrations VALUES("24","2018_04_14_121913_create_product_transfer_table","1");
INSERT INTO migrations VALUES("25","2018_05_13_082847_add_payment_id_and_change_sale_id_to_payments_table","2");
INSERT INTO migrations VALUES("26","2018_05_13_090906_change_customer_id_to_payment_with_credit_card_table","3");
INSERT INTO migrations VALUES("27","2018_05_20_054532_create_adjustments_table","4");
INSERT INTO migrations VALUES("28","2018_05_20_054859_create_product_adjustments_table","4");
INSERT INTO migrations VALUES("29","2018_05_21_163419_create_returns_table","5");
INSERT INTO migrations VALUES("30","2018_05_21_163443_create_product_returns_table","5");
INSERT INTO migrations VALUES("31","2018_06_02_050905_create_roles_table","6");
INSERT INTO migrations VALUES("32","2018_06_02_073430_add_columns_to_users_table","7");
INSERT INTO migrations VALUES("33","2018_06_03_053738_create_permission_tables","8");
INSERT INTO migrations VALUES("36","2018_06_21_063736_create_pos_setting_table","9");
INSERT INTO migrations VALUES("37","2018_06_21_094155_add_user_id_to_sales_table","10");
INSERT INTO migrations VALUES("38","2018_06_21_101529_add_user_id_to_purchases_table","11");
INSERT INTO migrations VALUES("39","2018_06_21_103512_add_user_id_to_transfers_table","12");
INSERT INTO migrations VALUES("40","2018_06_23_061058_add_user_id_to_quotations_table","13");
INSERT INTO migrations VALUES("41","2018_06_23_082427_add_is_deleted_to_users_table","14");
INSERT INTO migrations VALUES("42","2018_06_25_043308_change_email_to_users_table","15");
INSERT INTO migrations VALUES("43","2018_07_06_115449_create_general_settings_table","16");
INSERT INTO migrations VALUES("44","2018_07_08_043944_create_languages_table","17");
INSERT INTO migrations VALUES("45","2018_07_11_102144_add_user_id_to_returns_table","18");
INSERT INTO migrations VALUES("46","2018_07_11_102334_add_user_id_to_payments_table","18");
INSERT INTO migrations VALUES("47","2018_07_22_130541_add_digital_to_products_table","19");
INSERT INTO migrations VALUES("49","2018_07_24_154250_create_deliveries_table","20");
INSERT INTO migrations VALUES("50","2018_08_16_053336_create_expense_categories_table","21");
INSERT INTO migrations VALUES("51","2018_08_17_115415_create_expenses_table","22");
INSERT INTO migrations VALUES("55","2018_08_18_050418_create_gift_cards_table","23");
INSERT INTO migrations VALUES("56","2018_08_19_063119_create_payment_with_gift_card_table","24");
INSERT INTO migrations VALUES("57","2018_08_25_042333_create_gift_card_recharges_table","25");
INSERT INTO migrations VALUES("58","2018_08_25_101354_add_deposit_expense_to_customers_table","26");
INSERT INTO migrations VALUES("59","2018_08_26_043801_create_deposits_table","27");
INSERT INTO migrations VALUES("60","2018_09_02_044042_add_keybord_active_to_pos_setting_table","28");
INSERT INTO migrations VALUES("61","2018_09_09_092713_create_payment_with_paypal_table","29");
INSERT INTO migrations VALUES("62","2018_09_10_051254_add_currency_to_general_settings_table","30");
INSERT INTO migrations VALUES("63","2018_10_22_084118_add_biller_and_store_id_to_users_table","31");
INSERT INTO migrations VALUES("65","2018_10_26_034927_create_coupons_table","32");
INSERT INTO migrations VALUES("66","2018_10_27_090857_add_coupon_to_sales_table","33");
INSERT INTO migrations VALUES("67","2018_11_07_070155_add_currency_position_to_general_settings_table","34");
INSERT INTO migrations VALUES("68","2018_11_19_094650_add_combo_to_products_table","35");
INSERT INTO migrations VALUES("69","2018_12_09_043712_create_accounts_table","36");
INSERT INTO migrations VALUES("70","2018_12_17_112253_add_is_default_to_accounts_table","37");
INSERT INTO migrations VALUES("71","2018_12_19_103941_add_account_id_to_payments_table","38");
INSERT INTO migrations VALUES("72","2018_12_20_065900_add_account_id_to_expenses_table","39");
INSERT INTO migrations VALUES("73","2018_12_20_082753_add_account_id_to_returns_table","40");
INSERT INTO migrations VALUES("74","2018_12_26_064330_create_return_purchases_table","41");
INSERT INTO migrations VALUES("75","2018_12_26_144210_create_purchase_product_return_table","42");
INSERT INTO migrations VALUES("76","2018_12_26_144708_create_purchase_product_return_table","43");
INSERT INTO migrations VALUES("77","2018_12_27_110018_create_departments_table","44");
INSERT INTO migrations VALUES("78","2018_12_30_054844_create_employees_table","45");
INSERT INTO migrations VALUES("79","2018_12_31_125210_create_payrolls_table","46");
INSERT INTO migrations VALUES("80","2018_12_31_150446_add_department_id_to_employees_table","47");
INSERT INTO migrations VALUES("81","2019_01_01_062708_add_user_id_to_expenses_table","48");
INSERT INTO migrations VALUES("82","2019_01_02_075644_create_hrm_settings_table","49");
INSERT INTO migrations VALUES("83","2019_01_02_090334_create_attendances_table","50");
INSERT INTO migrations VALUES("84","2019_01_27_160956_add_three_columns_to_general_settings_table","51");
INSERT INTO migrations VALUES("85","2019_02_15_183303_create_stock_counts_table","52");
INSERT INTO migrations VALUES("86","2019_02_17_101604_add_is_adjusted_to_stock_counts_table","53");
INSERT INTO migrations VALUES("87","2019_04_13_101707_add_tax_no_to_customers_table","54");
INSERT INTO migrations VALUES("89","2019_10_14_111455_create_holidays_table","55");
INSERT INTO migrations VALUES("90","2019_11_13_145619_add_is_variant_to_products_table","56");
INSERT INTO migrations VALUES("91","2019_11_13_150206_create_product_variants_table","57");
INSERT INTO migrations VALUES("92","2019_11_13_153828_create_variants_table","57");
INSERT INTO migrations VALUES("93","2019_11_25_134041_add_qty_to_product_variants_table","58");
INSERT INTO migrations VALUES("94","2019_11_25_134922_add_variant_id_to_product_purchases_table","58");
INSERT INTO migrations VALUES("95","2019_11_25_145341_add_variant_id_to_product_warehouse_table","58");
INSERT INTO migrations VALUES("96","2019_11_29_182201_add_variant_id_to_product_sales_table","59");
INSERT INTO migrations VALUES("97","2019_12_04_121311_add_variant_id_to_product_quotation_table","60");
INSERT INTO migrations VALUES("98","2019_12_05_123802_add_variant_id_to_product_transfer_table","61");
INSERT INTO migrations VALUES("100","2019_12_08_114954_add_variant_id_to_product_returns_table","62");
INSERT INTO migrations VALUES("101","2019_12_08_203146_add_variant_id_to_purchase_product_return_table","63");
INSERT INTO migrations VALUES("102","2020_02_28_103340_create_money_transfers_table","64");
INSERT INTO migrations VALUES("103","2020_07_01_193151_add_image_to_categories_table","65");
INSERT INTO migrations VALUES("105","2020_09_26_130426_add_user_id_to_deliveries_table","66");
INSERT INTO migrations VALUES("107","2020_10_11_125457_create_cash_registers_table","67");
INSERT INTO migrations VALUES("108","2020_10_13_155019_add_cash_register_id_to_sales_table","68");
INSERT INTO migrations VALUES("109","2020_10_13_172624_add_cash_register_id_to_returns_table","69");
INSERT INTO migrations VALUES("110","2020_10_17_212338_add_cash_register_id_to_payments_table","70");
INSERT INTO migrations VALUES("111","2020_10_18_124200_add_cash_register_id_to_expenses_table","71");
INSERT INTO migrations VALUES("112","2020_10_21_121632_add_developed_by_to_general_settings_table","72");
INSERT INTO migrations VALUES("113","2019_08_19_000000_create_failed_jobs_table","73");
INSERT INTO migrations VALUES("114","2020_10_30_135557_create_notifications_table","73");
INSERT INTO migrations VALUES("115","2020_11_01_044954_create_currencies_table","74");
INSERT INTO migrations VALUES("116","2020_11_01_140736_add_price_to_product_warehouse_table","75");
INSERT INTO migrations VALUES("117","2020_11_02_050633_add_is_diff_price_to_products_table","76");
INSERT INTO migrations VALUES("118","2020_11_09_055222_add_user_id_to_customers_table","77");
INSERT INTO migrations VALUES("119","2020_11_17_054806_add_invoice_format_to_general_settings_table","78");
INSERT INTO migrations VALUES("120","2021_02_10_074859_add_variant_id_to_product_adjustments_table","79");
INSERT INTO migrations VALUES("121","2021_03_07_093606_create_product_batches_table","80");
INSERT INTO migrations VALUES("122","2021_03_07_093759_add_product_batch_id_to_product_warehouse_table","80");
INSERT INTO migrations VALUES("123","2021_03_07_093900_add_product_batch_id_to_product_purchases_table","80");
INSERT INTO migrations VALUES("124","2021_03_11_132603_add_product_batch_id_to_product_sales_table","81");
INSERT INTO migrations VALUES("127","2021_03_25_125421_add_is_batch_to_products_table","82");
INSERT INTO migrations VALUES("128","2021_05_19_120127_add_product_batch_id_to_product_returns_table","82");
INSERT INTO migrations VALUES("130","2021_05_22_105611_add_product_batch_id_to_purchase_product_return_table","83");
INSERT INTO migrations VALUES("131","2021_05_23_124848_add_product_batch_id_to_product_transfer_table","84");
INSERT INTO migrations VALUES("132","2021_05_26_153106_add_product_batch_id_to_product_quotation_table","85");
INSERT INTO migrations VALUES("133","2021_06_08_213007_create_reward_point_settings_table","86");
INSERT INTO migrations VALUES("134","2021_06_16_104155_add_points_to_customers_table","87");
INSERT INTO migrations VALUES("135","2021_06_17_101057_add_used_points_to_payments_table","88");
INSERT INTO migrations VALUES("136","2021_07_06_132716_add_variant_list_to_products_table","89");
INSERT INTO migrations VALUES("137","2021_09_27_161141_add_is_imei_to_products_table","90");
INSERT INTO migrations VALUES("138","2021_09_28_170052_add_imei_number_to_product_warehouse_table","91");
INSERT INTO migrations VALUES("139","2021_09_28_170126_add_imei_number_to_product_purchases_table","91");
INSERT INTO migrations VALUES("140","2021_10_03_170652_add_imei_number_to_product_sales_table","92");
INSERT INTO migrations VALUES("141","2021_10_10_145214_add_imei_number_to_product_returns_table","93");
INSERT INTO migrations VALUES("142","2021_10_11_104504_add_imei_number_to_product_transfer_table","94");
INSERT INTO migrations VALUES("143","2021_10_12_160107_add_imei_number_to_purchase_product_return_table","95");
INSERT INTO migrations VALUES("144","2021_10_12_205146_add_is_rtl_to_general_settings_table","96");
INSERT INTO migrations VALUES("145","2021_10_23_142451_add_is_approve_to_payments_table","97");
INSERT INTO migrations VALUES("146","2022_01_13_191242_create_discount_plans_table","97");
INSERT INTO migrations VALUES("147","2022_01_14_174318_create_discount_plan_customers_table","97");
INSERT INTO migrations VALUES("148","2022_01_14_202439_create_discounts_table","98");
INSERT INTO migrations VALUES("149","2022_01_16_153506_create_discount_plan_discounts_table","98");
INSERT INTO migrations VALUES("150","2022_02_05_174210_add_order_discount_type_and_value_to_sales_table","99");
INSERT INTO migrations VALUES("154","2022_05_26_195506_add_daily_sale_objective_to_products_table","100");
INSERT INTO migrations VALUES("155","2022_05_28_104209_create_dso_alerts_table","101");
INSERT INTO migrations VALUES("156","2022_06_01_112100_add_is_embeded_to_products_table","102");
INSERT INTO migrations VALUES("157","2022_06_14_130505_add_sale_id_to_returns_table","103");
INSERT INTO migrations VALUES("159","2022_07_19_115504_add_variant_data_to_products_table","104");
INSERT INTO migrations VALUES("160","2022_07_25_194300_add_additional_cost_to_product_variants_table","104");
INSERT INTO migrations VALUES("161","2022_09_04_195610_add_purchase_id_to_return_purchases_table","105");
INSERT INTO migrations VALUES("162","2022_11_10_204430_create_sessions_table","106");
INSERT INTO migrations VALUES("163","2023_01_09_162049_create_agencies_table","107");
INSERT INTO migrations VALUES("164","2023_01_09_170010_create_agencies_table","108");



CREATE TABLE `money_transfers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `from_account_id` int(11) NOT NULL,
  `to_account_id` int(11) NOT NULL,
  `amount` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO money_transfers VALUES("6","mtr-20230107-121117","1","13","50000","2023-01-07 23:11:17","2023-01-07 23:11:17");
INSERT INTO money_transfers VALUES("8","mtr-20230107-073836","13","1","20000","2023-01-08 06:38:36","2023-01-08 06:38:36");



CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint(20) unsigned NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `payment_with_cheque` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `payment_id` int(11) NOT NULL,
  `cheque_no` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO payment_with_cheque VALUES("1","3","334546","2022-11-29 23:17:04","2022-11-29 23:17:04");
INSERT INTO payment_with_cheque VALUES("2","4","27809","2022-11-29 23:58:01","2022-11-29 23:58:01");



CREATE TABLE `payment_with_credit_card` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `payment_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `customer_stripe_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `charge_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `payment_with_gift_card` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `payment_id` int(11) NOT NULL,
  `gift_card_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `payment_with_paypal` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `payment_id` int(11) NOT NULL,
  `transaction_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `payments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `payment_reference` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `sale_id` int(11) DEFAULT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `account_id` int(11) NOT NULL,
  `amount` double NOT NULL,
  `used_points` double DEFAULT NULL,
  `change` double NOT NULL,
  `paying_method` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO payments VALUES("1","spr-20221129-114456","2","","1","1","8","11000","","0","Cash","","2022-11-29 22:44:56","2022-11-29 22:44:56");
INSERT INTO payments VALUES("2","ppr-20221129-114925","2","1","","","8","20500","","0","Cash","tp","2022-11-29 22:49:25","2022-11-29 22:49:25");
INSERT INTO payments VALUES("3","ppr-20221129-121704","2","2","","","9","35000","","0","Cheque","","2022-11-29 23:17:04","2022-11-29 23:17:04");
INSERT INTO payments VALUES("4","spr-20221129-125801","2","","2","2","7","3100","","0","Cheque","","2022-11-29 23:58:01","2022-11-29 23:58:01");
INSERT INTO payments VALUES("5","spr-20221129-010952","2","","3","1","7","3998","","1502","Cash","","2022-11-30 00:09:52","2022-11-30 00:09:52");
INSERT INTO payments VALUES("6","ppr-20230111-050119","1","7","","","7","199","","1000","Cash","cash payment","2023-01-11 17:01:19","2023-01-11 17:01:19");
INSERT INTO payments VALUES("9","ppr-20230111-052232","1","7","","","7","1000","","0","Cash","","2023-01-11 17:22:32","2023-01-11 17:22:32");
INSERT INTO payments VALUES("11","ppr-20230111-065152","1","3","","3","7","5000","","0","Cash","done","2023-01-11 18:51:52","2023-01-11 18:51:52");
INSERT INTO payments VALUES("12","ppr-20230111-065427","1","3","","3","7","12000","","0","Cash","","2023-01-11 18:54:27","2023-01-11 18:54:27");
INSERT INTO payments VALUES("13","ppr-20230111-065427","1","4","","","7","2500","","0","Cash","","2023-01-11 18:54:27","2023-01-11 18:54:27");
INSERT INTO payments VALUES("14","ppr-20230111-065427","1","5","","3","7","500","","0","Cash","","2023-01-11 18:54:27","2023-01-11 18:54:27");
INSERT INTO payments VALUES("15","ppr-20230112-025932","1","9","","","7","1500","","997","Cash","","2023-01-12 14:59:32","2023-01-12 14:59:32");
INSERT INTO payments VALUES("16","ppr-20230112-034017","1","9","","","7","997","","0","Cash","","2023-01-12 15:40:17","2023-01-12 15:40:17");



CREATE TABLE `payrolls` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `employee_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `amount` double NOT NULL,
  `paying_method` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO permissions VALUES("4","products-edit","web","2018-06-03 07:00:09","2018-06-03 07:00:09");
INSERT INTO permissions VALUES("5","products-delete","web","2018-06-04 04:54:22","2018-06-04 04:54:22");
INSERT INTO permissions VALUES("6","products-add","web","2018-06-04 06:34:14","2018-06-04 06:34:14");
INSERT INTO permissions VALUES("7","products-index","web","2018-06-04 09:34:27","2018-06-04 09:34:27");
INSERT INTO permissions VALUES("8","purchases-index","web","2018-06-04 14:03:19","2018-06-04 14:03:19");
INSERT INTO permissions VALUES("9","purchases-add","web","2018-06-04 14:12:25","2018-06-04 14:12:25");
INSERT INTO permissions VALUES("10","purchases-edit","web","2018-06-04 15:47:36","2018-06-04 15:47:36");
INSERT INTO permissions VALUES("11","purchases-delete","web","2018-06-04 15:47:36","2018-06-04 15:47:36");
INSERT INTO permissions VALUES("12","sales-index","web","2018-06-04 16:49:08","2018-06-04 16:49:08");
INSERT INTO permissions VALUES("13","sales-add","web","2018-06-04 16:49:52","2018-06-04 16:49:52");
INSERT INTO permissions VALUES("14","sales-edit","web","2018-06-04 16:49:52","2018-06-04 16:49:52");
INSERT INTO permissions VALUES("15","sales-delete","web","2018-06-04 16:49:53","2018-06-04 16:49:53");
INSERT INTO permissions VALUES("16","quotes-index","web","2018-06-05 04:05:10","2018-06-05 04:05:10");
INSERT INTO permissions VALUES("17","quotes-add","web","2018-06-05 04:05:10","2018-06-05 04:05:10");
INSERT INTO permissions VALUES("18","quotes-edit","web","2018-06-05 04:05:10","2018-06-05 04:05:10");
INSERT INTO permissions VALUES("19","quotes-delete","web","2018-06-05 04:05:10","2018-06-05 04:05:10");
INSERT INTO permissions VALUES("20","transfers-index","web","2018-06-05 04:30:03","2018-06-05 04:30:03");
INSERT INTO permissions VALUES("21","transfers-add","web","2018-06-05 04:30:03","2018-06-05 04:30:03");
INSERT INTO permissions VALUES("22","transfers-edit","web","2018-06-05 04:30:03","2018-06-05 04:30:03");
INSERT INTO permissions VALUES("23","transfers-delete","web","2018-06-05 04:30:03","2018-06-05 04:30:03");
INSERT INTO permissions VALUES("24","returns-index","web","2018-06-05 04:50:24","2018-06-05 04:50:24");
INSERT INTO permissions VALUES("25","returns-add","web","2018-06-05 04:50:24","2018-06-05 04:50:24");
INSERT INTO permissions VALUES("26","returns-edit","web","2018-06-05 04:50:25","2018-06-05 04:50:25");
INSERT INTO permissions VALUES("27","returns-delete","web","2018-06-05 04:50:25","2018-06-05 04:50:25");
INSERT INTO permissions VALUES("28","customers-index","web","2018-06-05 05:15:54","2018-06-05 05:15:54");
INSERT INTO permissions VALUES("29","customers-add","web","2018-06-05 05:15:55","2018-06-05 05:15:55");
INSERT INTO permissions VALUES("30","customers-edit","web","2018-06-05 05:15:55","2018-06-05 05:15:55");
INSERT INTO permissions VALUES("31","customers-delete","web","2018-06-05 05:15:55","2018-06-05 05:15:55");
INSERT INTO permissions VALUES("32","suppliers-index","web","2018-06-05 05:40:12","2018-06-05 05:40:12");
INSERT INTO permissions VALUES("33","suppliers-add","web","2018-06-05 05:40:12","2018-06-05 05:40:12");
INSERT INTO permissions VALUES("34","suppliers-edit","web","2018-06-05 05:40:12","2018-06-05 05:40:12");
INSERT INTO permissions VALUES("35","suppliers-delete","web","2018-06-05 05:40:12","2018-06-05 05:40:12");
INSERT INTO permissions VALUES("36","product-report","web","2018-06-25 05:05:33","2018-06-25 05:05:33");
INSERT INTO permissions VALUES("37","purchase-report","web","2018-06-25 05:24:56","2018-06-25 05:24:56");
INSERT INTO permissions VALUES("38","sale-report","web","2018-06-25 05:33:13","2018-06-25 05:33:13");
INSERT INTO permissions VALUES("39","customer-report","web","2018-06-25 05:36:51","2018-06-25 05:36:51");
INSERT INTO permissions VALUES("40","due-report","web","2018-06-25 05:39:52","2018-06-25 05:39:52");
INSERT INTO permissions VALUES("41","users-index","web","2018-06-25 06:00:10","2018-06-25 06:00:10");
INSERT INTO permissions VALUES("42","users-add","web","2018-06-25 06:00:10","2018-06-25 06:00:10");
INSERT INTO permissions VALUES("43","users-edit","web","2018-06-25 06:01:30","2018-06-25 06:01:30");
INSERT INTO permissions VALUES("44","users-delete","web","2018-06-25 06:01:30","2018-06-25 06:01:30");
INSERT INTO permissions VALUES("45","profit-loss","web","2018-07-15 03:50:05","2018-07-15 03:50:05");
INSERT INTO permissions VALUES("46","best-seller","web","2018-07-15 04:01:38","2018-07-15 04:01:38");
INSERT INTO permissions VALUES("47","daily-sale","web","2018-07-15 04:24:21","2018-07-15 04:24:21");
INSERT INTO permissions VALUES("48","monthly-sale","web","2018-07-15 04:30:41","2018-07-15 04:30:41");
INSERT INTO permissions VALUES("49","daily-purchase","web","2018-07-15 04:36:46","2018-07-15 04:36:46");
INSERT INTO permissions VALUES("50","monthly-purchase","web","2018-07-15 04:48:17","2018-07-15 04:48:17");
INSERT INTO permissions VALUES("51","payment-report","web","2018-07-15 05:10:41","2018-07-15 05:10:41");
INSERT INTO permissions VALUES("52","warehouse-stock-report","web","2018-07-15 05:16:55","2018-07-15 05:16:55");
INSERT INTO permissions VALUES("53","product-qty-alert","web","2018-07-15 05:33:21","2018-07-15 05:33:21");
INSERT INTO permissions VALUES("54","supplier-report","web","2018-07-30 09:00:01","2018-07-30 09:00:01");
INSERT INTO permissions VALUES("55","expenses-index","web","2018-09-05 07:07:10","2018-09-05 07:07:10");
INSERT INTO permissions VALUES("56","expenses-add","web","2018-09-05 07:07:10","2018-09-05 07:07:10");
INSERT INTO permissions VALUES("57","expenses-edit","web","2018-09-05 07:07:10","2018-09-05 07:07:10");
INSERT INTO permissions VALUES("58","expenses-delete","web","2018-09-05 07:07:11","2018-09-05 07:07:11");
INSERT INTO permissions VALUES("59","general_setting","web","2018-10-20 05:10:04","2018-10-20 05:10:04");
INSERT INTO permissions VALUES("60","mail_setting","web","2018-10-20 05:10:04","2018-10-20 05:10:04");
INSERT INTO permissions VALUES("61","pos_setting","web","2018-10-20 05:10:04","2018-10-20 05:10:04");
INSERT INTO permissions VALUES("62","hrm_setting","web","2019-01-02 16:30:23","2019-01-02 16:30:23");
INSERT INTO permissions VALUES("63","purchase-return-index","web","2019-01-03 03:45:14","2019-01-03 03:45:14");
INSERT INTO permissions VALUES("64","purchase-return-add","web","2019-01-03 03:45:14","2019-01-03 03:45:14");
INSERT INTO permissions VALUES("65","purchase-return-edit","web","2019-01-03 03:45:14","2019-01-03 03:45:14");
INSERT INTO permissions VALUES("66","purchase-return-delete","web","2019-01-03 03:45:14","2019-01-03 03:45:14");
INSERT INTO permissions VALUES("67","account-index","web","2019-01-03 04:06:13","2019-01-03 04:06:13");
INSERT INTO permissions VALUES("68","balance-sheet","web","2019-01-03 04:06:14","2019-01-03 04:06:14");
INSERT INTO permissions VALUES("69","account-statement","web","2019-01-03 04:06:14","2019-01-03 04:06:14");
INSERT INTO permissions VALUES("70","department","web","2019-01-03 04:30:01","2019-01-03 04:30:01");
INSERT INTO permissions VALUES("71","attendance","web","2019-01-03 04:30:01","2019-01-03 04:30:01");
INSERT INTO permissions VALUES("72","payroll","web","2019-01-03 04:30:01","2019-01-03 04:30:01");
INSERT INTO permissions VALUES("73","employees-index","web","2019-01-03 04:52:19","2019-01-03 04:52:19");
INSERT INTO permissions VALUES("74","employees-add","web","2019-01-03 04:52:19","2019-01-03 04:52:19");
INSERT INTO permissions VALUES("75","employees-edit","web","2019-01-03 04:52:19","2019-01-03 04:52:19");
INSERT INTO permissions VALUES("76","employees-delete","web","2019-01-03 04:52:19","2019-01-03 04:52:19");
INSERT INTO permissions VALUES("77","user-report","web","2019-01-16 12:48:18","2019-01-16 12:48:18");
INSERT INTO permissions VALUES("78","stock_count","web","2019-02-17 16:32:01","2019-02-17 16:32:01");
INSERT INTO permissions VALUES("79","adjustment","web","2019-02-17 16:32:02","2019-02-17 16:32:02");
INSERT INTO permissions VALUES("80","sms_setting","web","2019-02-22 11:18:03","2019-02-22 11:18:03");
INSERT INTO permissions VALUES("81","create_sms","web","2019-02-22 11:18:03","2019-02-22 11:18:03");
INSERT INTO permissions VALUES("82","print_barcode","web","2019-03-07 11:02:19","2019-03-07 11:02:19");
INSERT INTO permissions VALUES("83","empty_database","web","2019-03-07 11:02:19","2019-03-07 11:02:19");
INSERT INTO permissions VALUES("84","customer_group","web","2019-03-07 11:37:15","2019-03-07 11:37:15");
INSERT INTO permissions VALUES("85","unit","web","2019-03-07 11:37:15","2019-03-07 11:37:15");
INSERT INTO permissions VALUES("86","tax","web","2019-03-07 11:37:15","2019-03-07 11:37:15");
INSERT INTO permissions VALUES("87","gift_card","web","2019-03-07 12:29:38","2019-03-07 12:29:38");
INSERT INTO permissions VALUES("88","coupon","web","2019-03-07 12:29:38","2019-03-07 12:29:38");
INSERT INTO permissions VALUES("89","holiday","web","2019-10-19 14:57:15","2019-10-19 14:57:15");
INSERT INTO permissions VALUES("90","warehouse-report","web","2019-10-22 12:00:23","2019-10-22 12:00:23");
INSERT INTO permissions VALUES("91","warehouse","web","2020-02-26 12:47:32","2020-02-26 12:47:32");
INSERT INTO permissions VALUES("92","brand","web","2020-02-26 12:59:59","2020-02-26 12:59:59");
INSERT INTO permissions VALUES("93","billers-index","web","2020-02-26 13:11:15","2020-02-26 13:11:15");
INSERT INTO permissions VALUES("94","billers-add","web","2020-02-26 13:11:15","2020-02-26 13:11:15");
INSERT INTO permissions VALUES("95","billers-edit","web","2020-02-26 13:11:15","2020-02-26 13:11:15");
INSERT INTO permissions VALUES("96","billers-delete","web","2020-02-26 13:11:15","2020-02-26 13:11:15");
INSERT INTO permissions VALUES("97","money-transfer","web","2020-03-02 11:41:48","2020-03-02 11:41:48");
INSERT INTO permissions VALUES("98","category","web","2020-07-13 18:13:16","2020-07-13 18:13:16");
INSERT INTO permissions VALUES("99","delivery","web","2020-07-13 18:13:16","2020-07-13 18:13:16");
INSERT INTO permissions VALUES("100","send_notification","web","2020-10-31 12:21:31","2020-10-31 12:21:31");
INSERT INTO permissions VALUES("101","today_sale","web","2020-10-31 12:57:04","2020-10-31 12:57:04");
INSERT INTO permissions VALUES("102","today_profit","web","2020-10-31 12:57:04","2020-10-31 12:57:04");
INSERT INTO permissions VALUES("103","currency","web","2020-11-09 06:23:11","2020-11-09 06:23:11");
INSERT INTO permissions VALUES("104","backup_database","web","2020-11-15 06:16:55","2020-11-15 06:16:55");
INSERT INTO permissions VALUES("105","reward_point_setting","web","2021-06-27 10:34:42","2021-06-27 10:34:42");
INSERT INTO permissions VALUES("106","revenue_profit_summary","web","2022-02-08 19:57:21","2022-02-08 19:57:21");
INSERT INTO permissions VALUES("107","cash_flow","web","2022-02-08 19:57:22","2022-02-08 19:57:22");
INSERT INTO permissions VALUES("108","monthly_summary","web","2022-02-08 19:57:22","2022-02-08 19:57:22");
INSERT INTO permissions VALUES("109","yearly_report","web","2022-02-08 19:57:22","2022-02-08 19:57:22");
INSERT INTO permissions VALUES("110","discount_plan","web","2022-02-16 15:12:26","2022-02-16 15:12:26");
INSERT INTO permissions VALUES("111","discount","web","2022-02-16 15:12:38","2022-02-16 15:12:38");
INSERT INTO permissions VALUES("112","product-expiry-report","web","2022-03-30 11:39:20","2022-03-30 11:39:20");
INSERT INTO permissions VALUES("113","purchase-payment-index","web","2022-06-05 20:12:27","2022-06-05 20:12:27");
INSERT INTO permissions VALUES("114","purchase-payment-add","web","2022-06-05 20:12:28","2022-06-05 20:12:28");
INSERT INTO permissions VALUES("115","purchase-payment-edit","web","2022-06-05 20:12:28","2022-06-05 20:12:28");
INSERT INTO permissions VALUES("116","purchase-payment-delete","web","2022-06-05 20:12:28","2022-06-05 20:12:28");
INSERT INTO permissions VALUES("117","sale-payment-index","web","2022-06-05 20:12:28","2022-06-05 20:12:28");
INSERT INTO permissions VALUES("118","sale-payment-add","web","2022-06-05 20:12:28","2022-06-05 20:12:28");
INSERT INTO permissions VALUES("119","sale-payment-edit","web","2022-06-05 20:12:28","2022-06-05 20:12:28");
INSERT INTO permissions VALUES("120","sale-payment-delete","web","2022-06-05 20:12:28","2022-06-05 20:12:28");
INSERT INTO permissions VALUES("121","all_notification","web","2022-06-05 20:12:29","2022-06-05 20:12:29");
INSERT INTO permissions VALUES("122","sale-report-chart","web","2022-06-05 20:12:29","2022-06-05 20:12:29");
INSERT INTO permissions VALUES("123","dso-report","web","2022-06-05 20:12:29","2022-06-05 20:12:29");
INSERT INTO permissions VALUES("124","product_history","web","2022-08-25 20:04:05","2022-08-25 20:04:05");
INSERT INTO permissions VALUES("125","supplier-due-report","web","2022-08-31 15:46:33","2022-08-31 15:46:33");
INSERT INTO permissions VALUES("126","card","web","2022-10-27 20:07:16","2022-10-27 20:07:30");
INSERT INTO permissions VALUES("127","cash","web","2022-10-27 20:07:38","2022-10-27 20:07:45");
INSERT INTO permissions VALUES("128","paypal","web","2022-10-27 20:07:53","2022-10-27 20:08:04");
INSERT INTO permissions VALUES("129","cheque","web","2022-10-27 20:08:10","2022-10-27 20:08:18");
INSERT INTO permissions VALUES("134","agency-index","web","2023-01-09 14:36:01","2023-01-09 14:36:01");
INSERT INTO permissions VALUES("135","agency-add","web","2023-01-09 14:36:01","2023-01-09 14:36:01");
INSERT INTO permissions VALUES("136","agency-edit","web","2023-01-09 14:36:01","2023-01-09 14:36:01");
INSERT INTO permissions VALUES("137","agency-delete","web","2023-01-09 14:36:01","2023-01-09 14:36:01");



CREATE TABLE `pos_setting` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `biller_id` int(11) NOT NULL,
  `product_number` int(11) NOT NULL,
  `keybord_active` tinyint(1) NOT NULL,
  `stripe_public_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stripe_secret_key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  UNIQUE KEY `pos_setting_id_unique` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO pos_setting VALUES("1","1","1","1","3","0","pk_test_ITN7KOYiIsHSCQ0UMRcgaYUB","sk_test_TtQQaawhEYRwa3mU9CzttrEy","2018-09-02 09:17:04","2022-10-19 22:58:12");



CREATE TABLE `product_adjustments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `adjustment_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `qty` double NOT NULL,
  `action` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `product_batches` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `batch_no` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expired_date` date NOT NULL,
  `qty` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `product_purchases` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `purchase_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qty` double NOT NULL,
  `recieved` double NOT NULL,
  `purchase_unit_id` int(11) NOT NULL,
  `net_unit_cost` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO product_purchases VALUES("1","1","1","","","","20","20","1","1000","0","0","0","20000","2022-11-29 22:42:22","2022-11-29 22:42:22");
INSERT INTO product_purchases VALUES("3","2","2","","","","20","20","1","1500","0","0","0","30000","2022-11-29 23:18:16","2022-11-29 23:18:16");
INSERT INTO product_purchases VALUES("6","3","2","","","","10","10","1","1700","0","0","0","17000","2022-11-29 23:39:47","2022-11-29 23:39:47");
INSERT INTO product_purchases VALUES("8","5","1","","","","1","0","1","1000","0","0","0","1000","2023-01-10 15:51:15","2023-01-10 15:51:15");
INSERT INTO product_purchases VALUES("9","6","2","","","","1","0","1","1500","0","0","0","1500","2023-01-10 16:02:38","2023-01-10 16:02:38");
INSERT INTO product_purchases VALUES("10","6","1","","","","1","0","1","1000","0","0","0","1000","2023-01-10 16:02:38","2023-01-10 16:02:38");
INSERT INTO product_purchases VALUES("11","7","1","","","","1","0","1","1000","0","0","0","1000","2023-01-10 16:06:50","2023-01-10 16:06:50");
INSERT INTO product_purchases VALUES("26","8","2","","","","1","0","1","1500","0","0","0","1500","2023-01-10 17:59:32","2023-01-10 17:59:32");
INSERT INTO product_purchases VALUES("27","8","1","","","","1","0","1","1000","0","0","0","1000","2023-01-10 17:59:32","2023-01-10 17:59:32");
INSERT INTO product_purchases VALUES("30","4","2","","","","1","1","1","1500","0","0","0","1500","2023-01-11 18:58:00","2023-01-11 18:58:00");
INSERT INTO product_purchases VALUES("31","9","2","","","","1","1","1","1500","0","0","0","1500","2023-01-12 13:51:42","2023-01-12 13:51:42");
INSERT INTO product_purchases VALUES("32","9","1","","","","1","1","1","1000","0","0","0","1000","2023-01-12 13:51:42","2023-01-12 13:51:42");
INSERT INTO product_purchases VALUES("33","10","1","","","","1.44","0","1","1000","0","0","0","1440","2023-01-15 14:47:34","2023-01-15 14:47:34");
INSERT INTO product_purchases VALUES("36","11","3","","","","2","0","1","399","2","0","0","798","2023-01-15 15:40:26","2023-01-15 15:40:26");



CREATE TABLE `product_quotation` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `quotation_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `qty` double NOT NULL,
  `sale_unit_id` int(11) NOT NULL,
  `net_unit_price` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `product_returns` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `return_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qty` double NOT NULL,
  `sale_unit_id` int(11) NOT NULL,
  `net_unit_price` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `product_sales` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sale_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qty` double NOT NULL,
  `sale_unit_id` int(11) NOT NULL,
  `net_unit_price` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO product_sales VALUES("1","1","1","","","","10","1","1100","0","0","0","11000","2022-11-29 22:44:14","2022-11-29 22:44:14");
INSERT INTO product_sales VALUES("2","2","2","","","","1","1","2600","0","0","0","2600","2022-11-29 23:58:01","2022-11-29 23:58:01");
INSERT INTO product_sales VALUES("3","3","1","","","","5","1","1100","0","0","0","5500","2022-11-30 00:09:52","2022-11-30 00:09:52");
INSERT INTO product_sales VALUES("4","4","1","","","","1","1","1100","0","0","0","1100","2022-12-02 00:48:03","2022-12-02 00:48:03");
INSERT INTO product_sales VALUES("5","5","2","","","","2","1","2200","0","0","0","4400","2023-01-10 18:29:41","2023-01-10 18:42:07");
INSERT INTO product_sales VALUES("6","6","2","","","","3","1","2199","3","0","0","6597","2023-01-15 16:32:07","2023-01-15 16:57:32");



CREATE TABLE `product_transfer` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `transfer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qty` double NOT NULL,
  `purchase_unit_id` int(11) NOT NULL,
  `net_unit_cost` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO product_transfer VALUES("1","1","1","","","","1","1","1000","0","0","1000","2022-11-29 23:01:23","2022-11-29 23:01:23");
INSERT INTO product_transfer VALUES("2","2","2","","","","3","1","1500","0","0","4500","2022-11-29 23:20:06","2022-11-29 23:20:06");
INSERT INTO product_transfer VALUES("4","4","2","","","","1","1","1500","0","0","1500","2023-01-11 09:50:08","2023-01-11 09:50:41");
INSERT INTO product_transfer VALUES("5","5","2","","","","1","1","1500","0","0","1500","2023-01-11 09:51:58","2023-01-11 09:51:58");
INSERT INTO product_transfer VALUES("6","6","2","","","","1","1","1500","0","0","1500","2023-01-11 13:00:19","2023-01-11 13:00:19");
INSERT INTO product_transfer VALUES("7","7","2","","","","2","1","1500","0","0","3000","2023-01-15 17:42:49","2023-01-15 18:21:17");
INSERT INTO product_transfer VALUES("8","8","2","","","","3.2","1","1500","0","0","4800","2023-01-15 17:44:48","2023-01-15 17:44:48");
INSERT INTO product_transfer VALUES("9","9","2","","","","1","1","1500","0","0","1500","2023-01-15 18:12:14","2023-01-15 18:12:14");
INSERT INTO product_transfer VALUES("10","10","2","","","","1","1","1500","0","0","1500","2023-01-15 18:13:02","2023-01-15 18:13:02");



CREATE TABLE `product_variants` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `variant_id` int(11) NOT NULL,
  `position` int(11) NOT NULL,
  `item_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `additional_cost` double DEFAULT NULL,
  `additional_price` double DEFAULT NULL,
  `qty` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `product_warehouse` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `warehouse_id` int(11) NOT NULL,
  `qty` double NOT NULL,
  `price` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO product_warehouse VALUES("1","1","","","","1","3","","2022-11-29 22:42:22","2022-12-02 00:48:03");
INSERT INTO product_warehouse VALUES("2","1","","","","2","1","","2022-11-29 23:01:23","2022-11-29 23:01:23");
INSERT INTO product_warehouse VALUES("3","2","","","","1","2","2400","2022-11-29 23:12:49","2023-01-11 09:51:58");
INSERT INTO product_warehouse VALUES("4","2","","","","2","2","2500","2022-11-29 23:12:49","2023-01-11 18:58:00");
INSERT INTO product_warehouse VALUES("5","2","","","","4","17.8","","2022-11-29 23:15:16","2023-01-15 18:21:17");
INSERT INTO product_warehouse VALUES("6","2","","","","3","1","","2022-11-29 23:20:06","2023-01-12 13:51:42");
INSERT INTO product_warehouse VALUES("7","1","","","","4","0","","2023-01-10 15:51:15","2023-01-10 15:51:15");
INSERT INTO product_warehouse VALUES("8","1","","","","3","1","","2023-01-10 16:06:50","2023-01-12 13:51:42");
INSERT INTO product_warehouse VALUES("9","3","","","","4","0","","2023-01-15 15:13:38","2023-01-15 15:13:38");



CREATE TABLE `products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `barcode_symbology` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `purchase_unit_id` int(11) NOT NULL,
  `sale_unit_id` int(11) NOT NULL,
  `cost` double NOT NULL,
  `price` double DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `alert_quantity` double DEFAULT NULL,
  `daily_sale_objective` double DEFAULT NULL,
  `promotion` tinyint(4) DEFAULT NULL,
  `promotion_price` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `starting_date` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_date` date DEFAULT NULL,
  `tax_id` int(11) DEFAULT NULL,
  `tax_method` int(11) DEFAULT NULL,
  `image` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_embeded` tinyint(1) DEFAULT NULL,
  `is_variant` tinyint(1) DEFAULT NULL,
  `is_batch` tinyint(1) DEFAULT NULL,
  `is_diffPrice` tinyint(1) DEFAULT NULL,
  `is_imei` tinyint(1) DEFAULT NULL,
  `featured` tinyint(4) DEFAULT NULL,
  `product_list` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `variant_list` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qty_list` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price_list` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_details` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `variant_option` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `variant_value` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO products VALUES("1","Sa coal","11","standard","C128","1","1","1","1","1","1000","1100","5","2","","","","","","","1","zummXD2dvAtI.png","","","","","","","","","","","","","","","1","2022-11-29 22:34:05","2023-01-12 13:51:42");
INSERT INTO products VALUES("2","Indo Coal","02","standard","C128","","1","1","1","1","1500","2200","29","","","","","","","","1","zummXD2dvAtI.png","","","","","1","","","","","","","","","","1","2022-11-29 23:12:49","2023-01-12 13:51:42");
INSERT INTO products VALUES("3","Indian coal","64082312","standard","C128","3","1","1","1","1","0","0","0","5","","","","","","","1","zummXD2dvAtI.png","","1","","","","","1","","","","","","","","1","2023-01-15 12:51:28","2023-01-15 12:51:28");



CREATE TABLE `purchase_product_return` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `return_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qty` double NOT NULL,
  `purchase_unit_id` int(11) NOT NULL,
  `net_unit_cost` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `purchases` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_cost` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `order_discount` double DEFAULT NULL,
  `shipping_agency` int(11) DEFAULT NULL,
  `shipping_type` int(11) DEFAULT NULL,
  `shipping_vehicle_no` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_cost` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `paid_amount` double NOT NULL,
  `status` int(11) NOT NULL,
  `payment_status` int(11) NOT NULL,
  `document` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO purchases VALUES("1","pr-20221129-114222","2","1","1","1","20","0","0","20000","0","0","","","","","500","20500","20500","1","2","","","2022-11-29 11:00:00","2022-11-29 22:49:25");
INSERT INTO purchases VALUES("2","pr-20221129-121516","2","4","1","1","20","0","0","30000","0","0","0","","","","5000","35000","35000","1","2","","","2022-11-29 11:00:00","2022-11-29 23:18:16");
INSERT INTO purchases VALUES("3","pr-20221129-123442","2","4","1","1","10","0","0","17000","0","0","0","","","","0","17000","17000","1","2","","","2022-11-29 11:00:00","2023-01-11 18:54:27");
INSERT INTO purchases VALUES("4","pr-20221201-015645","2","2","1","1","1","0","0","1500","0","0","0","1","1","","1000","2500","2500","1","2","","","2022-12-01 00:00:00","2023-01-11 18:58:00");
INSERT INTO purchases VALUES("5","pr-20230110-035115","1","4","1","1","1","0","0","1000","0","0","4","","","","150","1146","500","4","1","Fakhor Uddin Brothers (2).pdf","OK","2023-01-10 00:00:00","2023-01-11 18:54:27");
INSERT INTO purchases VALUES("6","pr-20230110-040238","1","4","1","2","2","0","0","2500","0","0","2","","","","400","2898","0","4","1","Fakhor Uddin Brothers (1).pdf","ALL OK","2023-01-10 00:00:00","2023-01-10 16:02:38");
INSERT INTO purchases VALUES("7","pr-20230110-040650","1","3","1","1","1","0","0","1000","0","0","1","1","2","MH093555","200","1199","1199","4","2","Fakhor Uddin Brothers (1).pdf","OK","2023-01-11 00:00:00","2023-01-11 17:22:32");
INSERT INTO purchases VALUES("8","pr-20230110-045514","1","4","1","2","2","0","0","2500","0","0","1","1","2","MH0935900","300","2799","0","4","1","Fakhor Uddin Brothers (2).pdf","done","2023-01-10 00:00:00","2023-01-10 17:59:32");
INSERT INTO purchases VALUES("9","pr-20230111-055945","1","3","2","2","2","0","0","2500","0","0","3","1","1","MH093590","500","2997","2497","1","1","","","2023-01-11 00:00:00","2023-01-12 15:40:17");
INSERT INTO purchases VALUES("10","pr-20230115-024734","1","4","2","1","1.44","0","0","1440","0","0","1","1","1","MH093555","200","1639","0","4","1","","","2023-01-15 00:00:00","2023-01-15 14:47:34");
INSERT INTO purchases VALUES("11","pr-20230115-031338","1","4","2","1","2","2","0","798","0","0","2","1","1","MH09355","500","1296","0","4","1","","","2023-01-15 00:00:00","2023-01-15 15:40:26");



CREATE TABLE `quotations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `biller_id` int(11) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_price` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `order_discount` double DEFAULT NULL,
  `shipping_cost` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `quotation_status` int(11) NOT NULL,
  `document` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `return_purchases` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `warehouse_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `account_id` int(11) NOT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_cost` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `document` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `return_note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `staff_note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `returns` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `sale_id` int(11) DEFAULT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `biller_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_price` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `document` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `return_note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `staff_note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `reward_point_settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `per_point_amount` double NOT NULL,
  `minimum_amount` double NOT NULL,
  `duration` int(11) DEFAULT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO reward_point_settings VALUES("1","300","1000","1","Year","0","2021-06-08 21:40:15","2022-10-20 20:10:45");



CREATE TABLE `role_has_permissions` (
  `permission_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO role_has_permissions VALUES("4","1");
INSERT INTO role_has_permissions VALUES("4","2");
INSERT INTO role_has_permissions VALUES("4","4");
INSERT INTO role_has_permissions VALUES("5","1");
INSERT INTO role_has_permissions VALUES("5","2");
INSERT INTO role_has_permissions VALUES("5","4");
INSERT INTO role_has_permissions VALUES("6","1");
INSERT INTO role_has_permissions VALUES("6","2");
INSERT INTO role_has_permissions VALUES("6","4");
INSERT INTO role_has_permissions VALUES("7","1");
INSERT INTO role_has_permissions VALUES("7","2");
INSERT INTO role_has_permissions VALUES("7","4");
INSERT INTO role_has_permissions VALUES("8","1");
INSERT INTO role_has_permissions VALUES("8","2");
INSERT INTO role_has_permissions VALUES("8","4");
INSERT INTO role_has_permissions VALUES("9","1");
INSERT INTO role_has_permissions VALUES("9","2");
INSERT INTO role_has_permissions VALUES("9","4");
INSERT INTO role_has_permissions VALUES("10","1");
INSERT INTO role_has_permissions VALUES("10","2");
INSERT INTO role_has_permissions VALUES("10","4");
INSERT INTO role_has_permissions VALUES("11","1");
INSERT INTO role_has_permissions VALUES("11","2");
INSERT INTO role_has_permissions VALUES("11","4");
INSERT INTO role_has_permissions VALUES("12","1");
INSERT INTO role_has_permissions VALUES("12","2");
INSERT INTO role_has_permissions VALUES("12","4");
INSERT INTO role_has_permissions VALUES("13","1");
INSERT INTO role_has_permissions VALUES("13","2");
INSERT INTO role_has_permissions VALUES("13","4");
INSERT INTO role_has_permissions VALUES("14","1");
INSERT INTO role_has_permissions VALUES("14","2");
INSERT INTO role_has_permissions VALUES("14","4");
INSERT INTO role_has_permissions VALUES("15","1");
INSERT INTO role_has_permissions VALUES("15","2");
INSERT INTO role_has_permissions VALUES("15","4");
INSERT INTO role_has_permissions VALUES("16","1");
INSERT INTO role_has_permissions VALUES("16","2");
INSERT INTO role_has_permissions VALUES("16","4");
INSERT INTO role_has_permissions VALUES("16","7");
INSERT INTO role_has_permissions VALUES("17","1");
INSERT INTO role_has_permissions VALUES("17","2");
INSERT INTO role_has_permissions VALUES("17","4");
INSERT INTO role_has_permissions VALUES("17","7");
INSERT INTO role_has_permissions VALUES("18","1");
INSERT INTO role_has_permissions VALUES("18","2");
INSERT INTO role_has_permissions VALUES("18","4");
INSERT INTO role_has_permissions VALUES("19","1");
INSERT INTO role_has_permissions VALUES("19","2");
INSERT INTO role_has_permissions VALUES("19","4");
INSERT INTO role_has_permissions VALUES("20","1");
INSERT INTO role_has_permissions VALUES("20","2");
INSERT INTO role_has_permissions VALUES("20","4");
INSERT INTO role_has_permissions VALUES("21","1");
INSERT INTO role_has_permissions VALUES("21","2");
INSERT INTO role_has_permissions VALUES("21","4");
INSERT INTO role_has_permissions VALUES("22","1");
INSERT INTO role_has_permissions VALUES("22","2");
INSERT INTO role_has_permissions VALUES("22","4");
INSERT INTO role_has_permissions VALUES("23","1");
INSERT INTO role_has_permissions VALUES("23","2");
INSERT INTO role_has_permissions VALUES("23","4");
INSERT INTO role_has_permissions VALUES("24","1");
INSERT INTO role_has_permissions VALUES("24","2");
INSERT INTO role_has_permissions VALUES("24","4");
INSERT INTO role_has_permissions VALUES("25","1");
INSERT INTO role_has_permissions VALUES("25","2");
INSERT INTO role_has_permissions VALUES("25","4");
INSERT INTO role_has_permissions VALUES("26","1");
INSERT INTO role_has_permissions VALUES("26","2");
INSERT INTO role_has_permissions VALUES("26","4");
INSERT INTO role_has_permissions VALUES("27","1");
INSERT INTO role_has_permissions VALUES("27","2");
INSERT INTO role_has_permissions VALUES("27","4");
INSERT INTO role_has_permissions VALUES("28","1");
INSERT INTO role_has_permissions VALUES("28","2");
INSERT INTO role_has_permissions VALUES("28","4");
INSERT INTO role_has_permissions VALUES("29","1");
INSERT INTO role_has_permissions VALUES("29","2");
INSERT INTO role_has_permissions VALUES("29","4");
INSERT INTO role_has_permissions VALUES("30","1");
INSERT INTO role_has_permissions VALUES("30","2");
INSERT INTO role_has_permissions VALUES("30","4");
INSERT INTO role_has_permissions VALUES("31","1");
INSERT INTO role_has_permissions VALUES("31","2");
INSERT INTO role_has_permissions VALUES("31","4");
INSERT INTO role_has_permissions VALUES("32","1");
INSERT INTO role_has_permissions VALUES("32","2");
INSERT INTO role_has_permissions VALUES("32","4");
INSERT INTO role_has_permissions VALUES("33","1");
INSERT INTO role_has_permissions VALUES("33","2");
INSERT INTO role_has_permissions VALUES("33","4");
INSERT INTO role_has_permissions VALUES("34","1");
INSERT INTO role_has_permissions VALUES("34","2");
INSERT INTO role_has_permissions VALUES("34","4");
INSERT INTO role_has_permissions VALUES("35","1");
INSERT INTO role_has_permissions VALUES("35","2");
INSERT INTO role_has_permissions VALUES("35","4");
INSERT INTO role_has_permissions VALUES("36","1");
INSERT INTO role_has_permissions VALUES("36","2");
INSERT INTO role_has_permissions VALUES("36","4");
INSERT INTO role_has_permissions VALUES("37","1");
INSERT INTO role_has_permissions VALUES("37","2");
INSERT INTO role_has_permissions VALUES("37","4");
INSERT INTO role_has_permissions VALUES("38","1");
INSERT INTO role_has_permissions VALUES("38","2");
INSERT INTO role_has_permissions VALUES("38","4");
INSERT INTO role_has_permissions VALUES("39","1");
INSERT INTO role_has_permissions VALUES("39","2");
INSERT INTO role_has_permissions VALUES("39","4");
INSERT INTO role_has_permissions VALUES("40","1");
INSERT INTO role_has_permissions VALUES("40","2");
INSERT INTO role_has_permissions VALUES("40","4");
INSERT INTO role_has_permissions VALUES("41","1");
INSERT INTO role_has_permissions VALUES("41","2");
INSERT INTO role_has_permissions VALUES("41","4");
INSERT INTO role_has_permissions VALUES("42","1");
INSERT INTO role_has_permissions VALUES("42","2");
INSERT INTO role_has_permissions VALUES("43","1");
INSERT INTO role_has_permissions VALUES("43","2");
INSERT INTO role_has_permissions VALUES("44","1");
INSERT INTO role_has_permissions VALUES("44","2");
INSERT INTO role_has_permissions VALUES("45","1");
INSERT INTO role_has_permissions VALUES("45","2");
INSERT INTO role_has_permissions VALUES("45","4");
INSERT INTO role_has_permissions VALUES("46","1");
INSERT INTO role_has_permissions VALUES("46","2");
INSERT INTO role_has_permissions VALUES("46","4");
INSERT INTO role_has_permissions VALUES("47","1");
INSERT INTO role_has_permissions VALUES("47","2");
INSERT INTO role_has_permissions VALUES("47","4");
INSERT INTO role_has_permissions VALUES("48","1");
INSERT INTO role_has_permissions VALUES("48","2");
INSERT INTO role_has_permissions VALUES("48","4");
INSERT INTO role_has_permissions VALUES("49","1");
INSERT INTO role_has_permissions VALUES("49","2");
INSERT INTO role_has_permissions VALUES("49","4");
INSERT INTO role_has_permissions VALUES("50","1");
INSERT INTO role_has_permissions VALUES("50","2");
INSERT INTO role_has_permissions VALUES("50","4");
INSERT INTO role_has_permissions VALUES("51","1");
INSERT INTO role_has_permissions VALUES("51","2");
INSERT INTO role_has_permissions VALUES("51","4");
INSERT INTO role_has_permissions VALUES("52","1");
INSERT INTO role_has_permissions VALUES("52","2");
INSERT INTO role_has_permissions VALUES("52","4");
INSERT INTO role_has_permissions VALUES("53","1");
INSERT INTO role_has_permissions VALUES("53","2");
INSERT INTO role_has_permissions VALUES("53","4");
INSERT INTO role_has_permissions VALUES("54","1");
INSERT INTO role_has_permissions VALUES("54","2");
INSERT INTO role_has_permissions VALUES("54","4");
INSERT INTO role_has_permissions VALUES("55","1");
INSERT INTO role_has_permissions VALUES("55","2");
INSERT INTO role_has_permissions VALUES("55","4");
INSERT INTO role_has_permissions VALUES("56","1");
INSERT INTO role_has_permissions VALUES("56","2");
INSERT INTO role_has_permissions VALUES("56","4");
INSERT INTO role_has_permissions VALUES("57","1");
INSERT INTO role_has_permissions VALUES("57","2");
INSERT INTO role_has_permissions VALUES("57","4");
INSERT INTO role_has_permissions VALUES("58","1");
INSERT INTO role_has_permissions VALUES("58","2");
INSERT INTO role_has_permissions VALUES("58","4");
INSERT INTO role_has_permissions VALUES("59","1");
INSERT INTO role_has_permissions VALUES("60","1");
INSERT INTO role_has_permissions VALUES("61","1");
INSERT INTO role_has_permissions VALUES("61","2");
INSERT INTO role_has_permissions VALUES("62","1");
INSERT INTO role_has_permissions VALUES("62","2");
INSERT INTO role_has_permissions VALUES("63","1");
INSERT INTO role_has_permissions VALUES("63","2");
INSERT INTO role_has_permissions VALUES("63","4");
INSERT INTO role_has_permissions VALUES("64","1");
INSERT INTO role_has_permissions VALUES("64","2");
INSERT INTO role_has_permissions VALUES("64","4");
INSERT INTO role_has_permissions VALUES("65","1");
INSERT INTO role_has_permissions VALUES("65","2");
INSERT INTO role_has_permissions VALUES("65","4");
INSERT INTO role_has_permissions VALUES("66","1");
INSERT INTO role_has_permissions VALUES("66","2");
INSERT INTO role_has_permissions VALUES("66","4");
INSERT INTO role_has_permissions VALUES("67","1");
INSERT INTO role_has_permissions VALUES("67","2");
INSERT INTO role_has_permissions VALUES("67","4");
INSERT INTO role_has_permissions VALUES("68","1");
INSERT INTO role_has_permissions VALUES("68","2");
INSERT INTO role_has_permissions VALUES("68","4");
INSERT INTO role_has_permissions VALUES("69","1");
INSERT INTO role_has_permissions VALUES("69","2");
INSERT INTO role_has_permissions VALUES("69","4");
INSERT INTO role_has_permissions VALUES("70","1");
INSERT INTO role_has_permissions VALUES("70","2");
INSERT INTO role_has_permissions VALUES("71","1");
INSERT INTO role_has_permissions VALUES("71","2");
INSERT INTO role_has_permissions VALUES("71","4");
INSERT INTO role_has_permissions VALUES("72","1");
INSERT INTO role_has_permissions VALUES("72","2");
INSERT INTO role_has_permissions VALUES("72","4");
INSERT INTO role_has_permissions VALUES("73","1");
INSERT INTO role_has_permissions VALUES("73","2");
INSERT INTO role_has_permissions VALUES("73","4");
INSERT INTO role_has_permissions VALUES("74","1");
INSERT INTO role_has_permissions VALUES("74","2");
INSERT INTO role_has_permissions VALUES("75","1");
INSERT INTO role_has_permissions VALUES("75","2");
INSERT INTO role_has_permissions VALUES("76","1");
INSERT INTO role_has_permissions VALUES("76","2");
INSERT INTO role_has_permissions VALUES("77","1");
INSERT INTO role_has_permissions VALUES("77","2");
INSERT INTO role_has_permissions VALUES("77","4");
INSERT INTO role_has_permissions VALUES("78","1");
INSERT INTO role_has_permissions VALUES("78","2");
INSERT INTO role_has_permissions VALUES("78","4");
INSERT INTO role_has_permissions VALUES("79","1");
INSERT INTO role_has_permissions VALUES("79","2");
INSERT INTO role_has_permissions VALUES("79","4");
INSERT INTO role_has_permissions VALUES("80","1");
INSERT INTO role_has_permissions VALUES("81","1");
INSERT INTO role_has_permissions VALUES("82","1");
INSERT INTO role_has_permissions VALUES("82","2");
INSERT INTO role_has_permissions VALUES("82","4");
INSERT INTO role_has_permissions VALUES("83","1");
INSERT INTO role_has_permissions VALUES("84","1");
INSERT INTO role_has_permissions VALUES("84","2");
INSERT INTO role_has_permissions VALUES("85","1");
INSERT INTO role_has_permissions VALUES("85","2");
INSERT INTO role_has_permissions VALUES("86","1");
INSERT INTO role_has_permissions VALUES("86","2");
INSERT INTO role_has_permissions VALUES("87","1");
INSERT INTO role_has_permissions VALUES("87","2");
INSERT INTO role_has_permissions VALUES("87","4");
INSERT INTO role_has_permissions VALUES("88","1");
INSERT INTO role_has_permissions VALUES("88","2");
INSERT INTO role_has_permissions VALUES("88","4");
INSERT INTO role_has_permissions VALUES("89","1");
INSERT INTO role_has_permissions VALUES("89","2");
INSERT INTO role_has_permissions VALUES("89","4");
INSERT INTO role_has_permissions VALUES("90","1");
INSERT INTO role_has_permissions VALUES("90","2");
INSERT INTO role_has_permissions VALUES("90","4");
INSERT INTO role_has_permissions VALUES("91","1");
INSERT INTO role_has_permissions VALUES("91","2");
INSERT INTO role_has_permissions VALUES("92","1");
INSERT INTO role_has_permissions VALUES("92","2");
INSERT INTO role_has_permissions VALUES("92","4");
INSERT INTO role_has_permissions VALUES("93","1");
INSERT INTO role_has_permissions VALUES("93","2");
INSERT INTO role_has_permissions VALUES("93","4");
INSERT INTO role_has_permissions VALUES("94","1");
INSERT INTO role_has_permissions VALUES("94","2");
INSERT INTO role_has_permissions VALUES("95","1");
INSERT INTO role_has_permissions VALUES("95","2");
INSERT INTO role_has_permissions VALUES("96","1");
INSERT INTO role_has_permissions VALUES("96","2");
INSERT INTO role_has_permissions VALUES("97","1");
INSERT INTO role_has_permissions VALUES("97","2");
INSERT INTO role_has_permissions VALUES("97","4");
INSERT INTO role_has_permissions VALUES("98","1");
INSERT INTO role_has_permissions VALUES("98","2");
INSERT INTO role_has_permissions VALUES("99","1");
INSERT INTO role_has_permissions VALUES("99","2");
INSERT INTO role_has_permissions VALUES("99","4");
INSERT INTO role_has_permissions VALUES("100","1");
INSERT INTO role_has_permissions VALUES("100","2");
INSERT INTO role_has_permissions VALUES("101","1");
INSERT INTO role_has_permissions VALUES("101","2");
INSERT INTO role_has_permissions VALUES("101","4");
INSERT INTO role_has_permissions VALUES("102","1");
INSERT INTO role_has_permissions VALUES("102","2");
INSERT INTO role_has_permissions VALUES("102","4");
INSERT INTO role_has_permissions VALUES("103","1");
INSERT INTO role_has_permissions VALUES("103","2");
INSERT INTO role_has_permissions VALUES("104","1");
INSERT INTO role_has_permissions VALUES("105","1");
INSERT INTO role_has_permissions VALUES("105","2");
INSERT INTO role_has_permissions VALUES("106","1");
INSERT INTO role_has_permissions VALUES("106","2");
INSERT INTO role_has_permissions VALUES("106","4");
INSERT INTO role_has_permissions VALUES("107","1");
INSERT INTO role_has_permissions VALUES("107","2");
INSERT INTO role_has_permissions VALUES("107","4");
INSERT INTO role_has_permissions VALUES("108","1");
INSERT INTO role_has_permissions VALUES("108","2");
INSERT INTO role_has_permissions VALUES("108","4");
INSERT INTO role_has_permissions VALUES("109","1");
INSERT INTO role_has_permissions VALUES("109","2");
INSERT INTO role_has_permissions VALUES("109","4");
INSERT INTO role_has_permissions VALUES("110","1");
INSERT INTO role_has_permissions VALUES("110","2");
INSERT INTO role_has_permissions VALUES("110","4");
INSERT INTO role_has_permissions VALUES("111","1");
INSERT INTO role_has_permissions VALUES("111","2");
INSERT INTO role_has_permissions VALUES("111","4");
INSERT INTO role_has_permissions VALUES("112","1");
INSERT INTO role_has_permissions VALUES("112","2");
INSERT INTO role_has_permissions VALUES("112","4");
INSERT INTO role_has_permissions VALUES("113","1");
INSERT INTO role_has_permissions VALUES("113","2");
INSERT INTO role_has_permissions VALUES("113","4");
INSERT INTO role_has_permissions VALUES("114","1");
INSERT INTO role_has_permissions VALUES("114","2");
INSERT INTO role_has_permissions VALUES("114","4");
INSERT INTO role_has_permissions VALUES("115","1");
INSERT INTO role_has_permissions VALUES("115","2");
INSERT INTO role_has_permissions VALUES("115","4");
INSERT INTO role_has_permissions VALUES("116","1");
INSERT INTO role_has_permissions VALUES("116","2");
INSERT INTO role_has_permissions VALUES("116","4");
INSERT INTO role_has_permissions VALUES("117","1");
INSERT INTO role_has_permissions VALUES("117","2");
INSERT INTO role_has_permissions VALUES("117","4");
INSERT INTO role_has_permissions VALUES("118","1");
INSERT INTO role_has_permissions VALUES("118","2");
INSERT INTO role_has_permissions VALUES("118","4");
INSERT INTO role_has_permissions VALUES("119","1");
INSERT INTO role_has_permissions VALUES("119","2");
INSERT INTO role_has_permissions VALUES("119","4");
INSERT INTO role_has_permissions VALUES("120","1");
INSERT INTO role_has_permissions VALUES("120","2");
INSERT INTO role_has_permissions VALUES("120","4");
INSERT INTO role_has_permissions VALUES("121","1");
INSERT INTO role_has_permissions VALUES("121","2");
INSERT INTO role_has_permissions VALUES("122","1");
INSERT INTO role_has_permissions VALUES("122","2");
INSERT INTO role_has_permissions VALUES("122","4");
INSERT INTO role_has_permissions VALUES("123","1");
INSERT INTO role_has_permissions VALUES("123","2");
INSERT INTO role_has_permissions VALUES("123","4");
INSERT INTO role_has_permissions VALUES("124","1");
INSERT INTO role_has_permissions VALUES("124","2");
INSERT INTO role_has_permissions VALUES("124","4");
INSERT INTO role_has_permissions VALUES("125","1");
INSERT INTO role_has_permissions VALUES("125","2");
INSERT INTO role_has_permissions VALUES("125","4");
INSERT INTO role_has_permissions VALUES("134","1");
INSERT INTO role_has_permissions VALUES("135","1");
INSERT INTO role_has_permissions VALUES("136","1");
INSERT INTO role_has_permissions VALUES("137","1");



CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO roles VALUES("1","Super Admin","super admin can access all data...","web","1","2018-06-02 05:46:44","2022-10-17 04:32:51");
INSERT INTO roles VALUES("2","System Admin","iiTBL Ltd & Dingi Tech","web","1","2018-10-22 08:38:13","2022-10-17 15:58:54");
INSERT INTO roles VALUES("4","Shop Owner","Shop owner to view the status","web","1","2018-06-02 06:05:27","2022-10-17 15:59:45");
INSERT INTO roles VALUES("5","Shop Manager","Responsible for operational activities","web","1","2020-11-05 12:43:16","2022-10-17 16:00:12");
INSERT INTO roles VALUES("6","Staff","POS user with limited permission on other features","web","1","2022-10-17 04:33:20","2022-10-17 16:01:23");
INSERT INTO roles VALUES("7","Customer","","web","1","2022-10-17 04:40:33","2022-10-17 15:58:22");



CREATE TABLE `sales` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `biller_id` int(11) DEFAULT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_price` double NOT NULL,
  `grand_total` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `order_discount_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_discount_value` double DEFAULT NULL,
  `order_discount` double DEFAULT NULL,
  `coupon_id` int(11) DEFAULT NULL,
  `coupon_discount` double DEFAULT NULL,
  `shipping_agency` int(11) DEFAULT NULL,
  `shipping_type` int(11) DEFAULT NULL,
  `shipping_vehicle_no` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_cost` double DEFAULT NULL,
  `sale_status` int(11) NOT NULL,
  `payment_status` int(11) NOT NULL,
  `document` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid_amount` double DEFAULT NULL,
  `sale_note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `staff_note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO sales VALUES("1","sr-20221129-114414","2","1","1","1","1","1","10","0","0","11000","11000","0","0","Flat","","0","","","","","","","1","4","","11000","","","2022-11-29 11:00:00","2022-11-29 22:44:56");
INSERT INTO sales VALUES("2","sr-20221129-125801","2","2","1","3","1","1","1","0","0","2600","3100","0","0","Flat","","0","","","","","","500","1","4","","3100","","","2022-11-29 11:00:00","2022-11-29 23:58:01");
INSERT INTO sales VALUES("3","sr-20221129-010952","2","1","1","1","1","1","5","0","0","5500","5500","0","0","Flat","","0","","","","","","0","1","3","","3998","","","2022-11-29 11:00:00","2022-11-30 00:09:52");
INSERT INTO sales VALUES("4","sr-20221201-014803","2","1","1","1","1","1","1","0","0","1100","2100","0","0","Flat","","0","","","","","","1000","1","1","","","","","2022-12-01 11:00:00","2022-12-02 00:48:03");
INSERT INTO sales VALUES("5","12345","1","3","1","4","1","1","2","0","0","4400","4656","0","0","Percentage","1","44","","","1","1","MH09","300","1","2","Fakhor Uddin Brothers (1).pdf","","done","payment due","2023-01-10 00:00:00","2023-01-10 18:42:07");
INSERT INTO sales VALUES("6","123458","1","3","1","4","1","1","3","3","0","6597","6896","0","0","Flat","1","1","","","1","1","MH0935900","300","2","2","","","","","2023-01-15 00:00:00","2023-01-15 16:57:32");



CREATE TABLE `sessions` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payload` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO sessions VALUES("S4DfVS2lDy1KmZAoP9y6bed7bYtVsYWYidbpl31l","1","::1","Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36","YTo0OntzOjY6Il90b2tlbiI7czo0MDoiazB2U21Hd21KT2RlaUt3WmdVN291dU1LYlVwU1lQTVpXMlo5ZGplOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDQ6Imh0dHA6Ly9sb2NhbGhvc3QvZXNzL3NldHRpbmcvZ2VuZXJhbF9zZXR0aW5nIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTt9","1673853108");



CREATE TABLE `stock_counts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `category_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `brand_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `initial_file` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `final_file` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_adjusted` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `suppliers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vat_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postal_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO suppliers VALUES("1","SA","","SA","","sa@gmail.co","0999899","south africa","south africa","S","","","1","2022-11-29 22:30:16","2022-11-29 22:30:16");
INSERT INTO suppliers VALUES("2","Noman","","NA corporation","4922053","noman@gmail.com","01789786453","malibag","dhaka","dhaka","1217","Bangladesh","1","2023-01-11 17:58:34","2023-01-11 17:58:34");
INSERT INTO suppliers VALUES("3","Noman","","NA corporation ltd","Noman","noman1@gmail.com","01789786453","malibag","dhaka","","1217","Bangladesh","1","2023-01-16 12:00:14","2023-01-16 13:05:10");
INSERT INTO suppliers VALUES("4","Hanif2","","h","","","01897349853","malibag","dhaka","","1217","Bangladesh","1","2023-01-16 13:07:32","2023-01-16 13:07:32");



CREATE TABLE `taxes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rate` double NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `transfers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `from_warehouse_id` int(11) NOT NULL,
  `to_warehouse_id` int(11) NOT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_cost` double NOT NULL,
  `shipping_agency` int(11) DEFAULT NULL,
  `shipping_type` int(11) DEFAULT NULL,
  `shipping_vehicle_no` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_cost` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `document` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO transfers VALUES("1","tr-20221129-120123","2","1","1","2","1","1","0","1000","","","","1000","2000","","","2022-11-29 11:00:00","2022-11-29 23:01:23");
INSERT INTO transfers VALUES("2","tr-20221129-122006","2","1","4","3","1","3","0","4500","","","","500","5000","","","2022-11-29 11:00:00","2022-11-29 23:20:06");
INSERT INTO transfers VALUES("4","tr-20230111-095008","1","1","4","1","1","1","0","1500","1","2","MH093555","250","1750","Fakhor Uddin Brothers (2).pdf","ok","2023-01-11 00:00:00","2023-01-11 09:50:41");
INSERT INTO transfers VALUES("5","tr-20230111-095158","1","1","3","1","1","1","0","1500","1","1","MH09355","100","1600","","","2023-01-11 00:00:00","2023-01-11 09:51:58");
INSERT INTO transfers VALUES("6","tr-20230111-010019","1","1","3","2","1","1","0","1500","1","1","MH093555","200","1700","","","2023-01-11 00:00:00","2023-01-11 13:00:19");
INSERT INTO transfers VALUES("7","tr-20230115-054249","1","3","4","1","1","2","0","3000","1","1","MH0935552","200","3200","","","2023-01-15 00:00:00","2023-01-15 18:21:17");
INSERT INTO transfers VALUES("8","tr-20230115-054448","1","3","4","1","1","3.2","0","4800","1","2","MH093590","250","5050","","","2023-01-15 00:00:00","2023-01-15 17:44:48");
INSERT INTO transfers VALUES("9","tr-20230115-061214","1","2","4","3","1","1","0","1500","1","1","MH0935552","200","1700","","","2023-01-15 00:00:00","2023-01-15 18:12:14");
INSERT INTO transfers VALUES("10","tr-20230115-061302","1","3","4","3","1","1","0","1500","1","1","MH09355","250","1750","","","2023-01-15 00:00:00","2023-01-15 18:13:02");



CREATE TABLE `units` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `unit_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `base_unit` int(11) DEFAULT NULL,
  `operator` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `operation_value` double DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO units VALUES("1","01","Ton","","*","1","1","2022-11-29 22:16:38","2022-11-29 22:16:38");
INSERT INTO units VALUES("2","02","Cft","","*","1","1","2022-11-29 22:16:50","2022-11-29 22:16:50");



CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  `biller_id` int(11) DEFAULT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO users VALUES("1","aaqatech","shohelic@outlook.com","$2y$10$9Er/S59La1pT85qxeKoEHOMf.fa09eTT7ZumoMUznj6GW1vtYQCt2","","+8801717001086","Aqa Technology","1","","","1","0","2018-06-02 09:24:15","2022-10-18 21:19:40");
INSERT INTO users VALUES("2","iitbladmin","thirtysevenit@gmail.com","$2y$10$l7odPIqGlPD5iiqXQQUjLuhpy/5ZNCa7f0CJi8fnQDsFnsvYLqv8a","OLKFRRWOdmFze1XN9Hm48z5WTs1RVDHfNb64f0fPdPWTONDVXEPqnHmyJlEQ","+8801712166508","Smart Electonics","2","","","1","0","2018-07-02 07:08:08","2022-10-19 20:37:27");
INSERT INTO users VALUES("3","shopowner","shoowner@smartelectonics.com","$2y$10$SjzF7wuTAYm5PPfkGW3kpOxJUdtJBzohoVOqDpNKvQVEiz4VJ5326","x7HlttI5bM0vSKViqATaowHFJkLS3PHwfvl7iJdFl5Z1SsyUgWCVbLSgAoi0","1234","Smart Electonics","4","","","1","0","2018-09-08 05:44:48","2022-10-19 20:37:56");
INSERT INTO users VALUES("4","shopman","shopman@smartelectonics.com","$2y$10$QIKAQDtvDZqi.HzaPq3Y2.C32jBAy/lxWyNRKMJKG5/QTvVRCxRbu","","0127","Smart Electonics","5","1","1","1","0","2022-10-17 19:02:48","2022-10-19 20:38:17");
INSERT INTO users VALUES("5","salesman","salesman1@smartelectonics.com","$2y$10$2PzWTR//gpQDMQK3rjYY5OH7qcO.WYeQD5ed68mU4axKxHoEIbMX.","","012345678","","6","1","1","1","0","2022-10-19 20:39:19","2022-10-19 20:39:19");
INSERT INTO users VALUES("6","DemoCustomer","asd@asaf.com","$2y$10$9iQRyjN7eRY1Qv5UIwBv/.22lK0jAIIPSeXshhAd73I7iR9UQab1G","","0023435746","","7","1","1","0","1","2022-10-31 01:25:04","2022-10-31 19:25:18");
INSERT INTO users VALUES("7","abir123","","$2y$10$/uRERF.FAmjnXUpIp8gRvOrTN.baeFAFLMg.R4qD9rQWYoz1gl77.","","01783923452","","5","1","4","1","0","2023-01-16 10:06:36","2023-01-16 10:06:36");
INSERT INTO users VALUES("8","nur12","","$2y$10$LewaX1FULyRru1Eb0740reHjD7fvonLq.2O4rJ74/7clclEvPoBgC","","01789786453","","7","1","4","1","0","2023-01-16 10:13:00","2023-01-16 10:13:00");
INSERT INTO users VALUES("9","noman","","$2y$10$0F69eDkyJ5oqWa83X.199OO0YwIeEhNxI.VrjXvdkiOUSKUgZSIRm","","01789786453","","6","1","4","1","0","2023-01-16 11:30:22","2023-01-16 11:30:22");
INSERT INTO users VALUES("10","hanif1","","$2y$10$RdYYlBAMoMJrAyuZZYtIbO1S1W5R7giYu2SwUxRoyYGc78B.daA4a","","01987654532","","6","1","3","1","0","2023-01-16 11:33:55","2023-01-16 11:33:55");
INSERT INTO users VALUES("11","noman12","","$2y$10$1mCNgoFKd4qQjPwwKxqD2.DydIqDRTzOpE7I6gb4BF3AXklEyKIv.","","01789786453","NA corporation","7","1","1","1","0","2023-01-16 11:38:21","2023-01-16 11:48:28");
INSERT INTO users VALUES("12","noman12345","","$2y$10$V/iXf9taIZyzSfJSBMEfY.Js..J/f9JPT7YZslsX8LvRERcd8QlgC","","01789786490","NA co","5","","","1","0","2023-01-16 12:00:14","2023-01-16 12:00:14");



CREATE TABLE `variants` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE `warehouses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO warehouses VALUES("1","Sutarkandi","0100000","sutar@gmail.com","sutarkandi","1","2022-11-29 22:14:04","2022-11-29 22:14:04");
INSERT INTO warehouses VALUES("2","Daodkandi","0999","","daaodkandi","1","2022-11-29 22:14:25","2022-11-29 22:14:25");
INSERT INTO warehouses VALUES("3","Vairab","08888","","vairab","1","2022-11-29 22:14:44","2022-11-29 22:14:44");
INSERT INTO warehouses VALUES("4","Fakhor uddin bros.","0171177373","","darga","1","2022-11-29 22:56:01","2022-11-29 22:56:01");

