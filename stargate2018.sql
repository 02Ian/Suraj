-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 34.236.109.151    Database: stargate
-- ------------------------------------------------------
-- Server version	5.5.59-0ubuntu0.14.04.1

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

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account` (
  `AccountMasterId` int(11) NOT NULL,
  `ParentAccountId` varchar(128) DEFAULT NULL,
  `Nickname` varchar(45) DEFAULT NULL,
  `LineOfBusiness` varchar(45) DEFAULT NULL,
  `AccountNumber` varchar(128) DEFAULT NULL,
  `InterestRate` int(11) NOT NULL,
  `Currency` varchar(45) NOT NULL,
  `AccDescriptorId` int(11) DEFAULT NULL,
  `TransferIn` tinyint(1) DEFAULT NULL,
  `TransferOut` tinyint(1) DEFAULT NULL,
  `InterestRateType` enum('FIXED','VARIABLE') DEFAULT NULL,
  PRIMARY KEY (`AccountMasterId`),
  UNIQUE KEY `AccountNumber_UNIQUE` (`AccountNumber`),
  KEY `FK_AccountDescriptor_idx` (`AccDescriptorId`),
  CONSTRAINT `AccountDescriptorId` FOREIGN KEY (`AccDescriptorId`) REFERENCES `accountdescriptor` (`AccountDescriptorId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (200,'2468135790','My Savings Account ','consumer','4561237890',3,'INR',111,1,1,'FIXED'),(201,'2468135791','My Savings Account ','small business','4561237891',3,'INR',112,1,1,'VARIABLE'),(202,'2468135792','My Investment Account','consumer','4561237892',8,'INR',113,1,1,'FIXED'),(203,'2468135793','My Loan Account','consumer','4561237893',8,'INR',114,1,1,'VARIABLE');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accountdescriptor`
--

DROP TABLE IF EXISTS `accountdescriptor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accountdescriptor` (
  `AccountId` varchar(128) DEFAULT NULL,
  `AccountType` enum('ESOP','GUARDIAN','HOMEEQUITYLOAN','HOMELINEOFCREDIT','INSITUTIONALTRUST','INSTALLMENT','IRA','KEOGH','LINEOFCREDIT','LOAN','MILATARYLOAN','MONEYMARKET','MORTGAGE','PERSONALLOAN','ROLLOVER','ROTH','SARSEP','SAVINGS','SMBLOAN','STUDENTLOAN','TAXABLE','TDA','TRUST','UGMA','UTMA','401A','401K','403B','529','AUTOLOAN','CD','CHARGE','CHECKING','COMMERCIALLINEOFCREDIT','COMMERCIALLOAN','COVERDELL','CREDITCARD','ESCROW') DEFAULT NULL,
  `DisplayName` varchar(45) DEFAULT NULL,
  `Description` varchar(45) DEFAULT NULL,
  `Status` enum('CLOSED','DELINQUENT','NEGATIVECURRENTBALANCE','OPEN','PAID','PENDINGCLOSE','PENDINGOPEN') DEFAULT NULL,
  `AccountDescriptorId` int(11) NOT NULL,
  `CustomerId` varchar(128) NOT NULL,
  PRIMARY KEY (`AccountDescriptorId`),
  UNIQUE KEY `AccountId_UNIQUE` (`AccountId`),
  KEY `acct_customer` (`CustomerId`),
  CONSTRAINT `acct_customer` FOREIGN KEY (`CustomerId`) REFERENCES `customer` (`CustomerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accountdescriptor`
--

LOCK TABLES `accountdescriptor` WRITE;
/*!40000 ALTER TABLE `accountdescriptor` DISABLE KEYS */;
INSERT INTO `accountdescriptor` VALUES ('1357902468','SAVINGS','Savings Account','Savings Account','OPEN',111,'111111101'),('1357902469','LOAN','Loan Account','Loan Account','OPEN',112,'111111102'),('1357902470','401K','investment account','investment account','OPEN',113,'111111103'),('1357902471','LOAN','Loan Account','Loan Account','OPEN',114,'111111104');
/*!40000 ALTER TABLE `accountdescriptor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bank`
--

DROP TABLE IF EXISTS `bank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bank` (
  `BankId` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`BankId`)
) ENGINE=InnoDB AUTO_INCREMENT=111113 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank`
--

LOCK TABLES `bank` WRITE;
/*!40000 ALTER TABLE `bank` DISABLE KEYS */;
INSERT INTO `bank` VALUES (111111,'Axis Bank'),(111112,'HDFC');
/*!40000 ALTER TABLE `bank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branch`
--

DROP TABLE IF EXISTS `branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `branch` (
  `BranchId` int(11) NOT NULL AUTO_INCREMENT,
  `IFSC` varchar(30) DEFAULT NULL,
  `Address` varchar(200) DEFAULT NULL,
  `City` varchar(30) DEFAULT NULL,
  `State` varchar(40) DEFAULT NULL,
  `Country` varchar(60) DEFAULT NULL,
  `Zip` varchar(20) DEFAULT NULL,
  `Telephone` varchar(14) DEFAULT NULL,
  `Email` varchar(30) DEFAULT NULL,
  `BankId` int(11) DEFAULT NULL,
  `BranchName` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`BranchId`),
  KEY `BankId` (`BankId`),
  CONSTRAINT `branch_ibfk_1` FOREIGN KEY (`BankId`) REFERENCES `bank` (`BankId`)
) ENGINE=InnoDB AUTO_INCREMENT=22224 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branch`
--

LOCK TABLES `branch` WRITE;
/*!40000 ALTER TABLE `branch` DISABLE KEYS */;
INSERT INTO `branch` VALUES (22222,' UTIB0001494','Nigdi','Pune','Maharashtra','India','411044','020-276420125','customer.service@axisbank.com',111111,'Nigdi'),(22223,' UTIB0001495','Akurdi','Pune','Maharashtra','India','411045','020-276420566','customer.service@hdfc.com',111112,'Akurdi');
/*!40000 ALTER TABLE `branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `CustomerId` varchar(128) NOT NULL,
  `DateOfBirth` date DEFAULT NULL,
  `TaxId` varchar(128) DEFAULT NULL,
  `GovernmentId` varchar(128) DEFAULT NULL,
  `Email` varchar(128) DEFAULT NULL,
  `Password` varchar(128) DEFAULT NULL,
  `BranchId` int(11) DEFAULT NULL,
  PRIMARY KEY (`CustomerId`),
  KEY `BranchId` (`BranchId`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`BranchId`) REFERENCES `branch` (`BranchId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES ('111111101','1990-01-10','144-27-7471','123457890645','isla@abc.com','abc@12345#',22222),('111111102','1991-05-19','144-27-7472','923457890645','john@abc.com','abc@164#',22223),('111111103','1989-03-14','144-27-7473','873457890645','jack@abc.com','abc@1945#',22222),('111111104','1970-08-20','144-27-7474','673457890645','jimmy@abc.com','abc@1045#',22222),('111111105','1984-09-30','144-27-7475','453457890645','emily@abc.com','abc@1345#',22222);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customername`
--

DROP TABLE IF EXISTS `customername`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customername` (
  `CustomerNameId` int(11) NOT NULL,
  `Prefix` varchar(10) DEFAULT NULL,
  `First` varchar(45) DEFAULT NULL,
  `Middle` varchar(50) DEFAULT NULL,
  `Last` varchar(45) DEFAULT NULL,
  `Suffix` varchar(28) DEFAULT NULL,
  `Company` varchar(50) DEFAULT NULL,
  `CustomerId` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`CustomerNameId`),
  KEY `customerid_cn_fk_idx` (`CustomerId`),
  CONSTRAINT `customerid_cn_fk` FOREIGN KEY (`CustomerId`) REFERENCES `customer` (`CustomerId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customername`
--

LOCK TABLES `customername` WRITE;
/*!40000 ALTER TABLE `customername` DISABLE KEYS */;
INSERT INTO `customername` VALUES (101,'Mrs','Isla','J','Jackson','captain','acme','111111101'),(102,'Mr','John','M','Miller',NULL,'Berkshire ','111111102'),(103,'Mr','Jack','K','Jack',NULL,'	ExxonMobil','111111103'),(104,'Mr','Jimmy','A','Smith',NULL,'Apple','111111104'),(105,'Mrs','Emily','B','Johns',NULL,'Walmart','111111105');
/*!40000 ALTER TABLE `customername` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deliveryaddress`
--

DROP TABLE IF EXISTS `deliveryaddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deliveryaddress` (
  `DeliveryAddressId` int(11) NOT NULL,
  `Type` enum('HOME','BUSINESS','MAILING') DEFAULT NULL,
  `Line1` varchar(45) DEFAULT NULL,
  `Line2` varchar(45) DEFAULT NULL,
  `City` varchar(45) DEFAULT NULL,
  `State` varchar(45) DEFAULT NULL,
  `Zip` varchar(45) DEFAULT NULL,
  `Country` varchar(45) DEFAULT NULL,
  `CustomerId` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`DeliveryAddressId`),
  KEY `customerid_fk` (`CustomerId`),
  CONSTRAINT `deliveryaddress_ibfk_1` FOREIGN KEY (`CustomerId`) REFERENCES `customer` (`CustomerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deliveryaddress`
--

LOCK TABLES `deliveryaddress` WRITE;
/*!40000 ALTER TABLE `deliveryaddress` DISABLE KEYS */;
INSERT INTO `deliveryaddress` VALUES (201,'HOME','963 Lovelace Road','Tampa Bay','California','US','90001','United states','111111101'),(202,'BUSINESS','964 Lovelace Road','Tampa1 Bay','California','US','90001','United states','111111101'),(203,'MAILING','965 Lovelace Road','Tampa2 Bay','California','US','90001','United states','111111101'),(204,'HOME','964 Lovelace Road','Tampa Bay','California','US','90001','United states','111111102'),(205,'BUSINESS','178 Lovelace Road','Tampa Bay','California','US','90001','United states','111111102'),(206,'MAILING','963 Lovelace Road','Tampa Bay','California','US','90001','United states','111111102'),(207,'HOME','964 Lovelace Road','Tampa Bay','California','US','90001','United states','111111103'),(208,'BUSINESS','963 Lovelace Road','Tampa Bay','California','US','90001','United states','111111103'),(209,'MAILING','963 Lovelace Road','Tampa Bay','California','US','90001','United states','111111103'),(210,'HOME','964 Lovelace Road','Tampa Bay','California','US','90001','United states','111111104'),(211,'BUSINESS','963 Lovelace Road','Tampa Bay','California','US','90001','United states','111111104'),(212,'MAILING','963 Lovelace Road','Tampa Bay','California','US','90001','United states','111111104');
/*!40000 ALTER TABLE `deliveryaddress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `depositaccount`
--

DROP TABLE IF EXISTS `depositaccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `depositaccount` (
  `RefAccountId` int(11) DEFAULT NULL,
  `BalanceAsOf` date DEFAULT NULL,
  `CurrentBalance` int(11) DEFAULT NULL,
  `Term` int(11) DEFAULT NULL,
  `AvailableBalance` int(11) DEFAULT NULL,
  `DepositAccountId` int(11) NOT NULL,
  `MaturityDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`DepositAccountId`),
  KEY `FK_Account_idx` (`RefAccountId`),
  CONSTRAINT `FK_Account_DA` FOREIGN KEY (`RefAccountId`) REFERENCES `account` (`AccountMasterId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `depositaccount`
--

LOCK TABLES `depositaccount` WRITE;
/*!40000 ALTER TABLE `depositaccount` DISABLE KEYS */;
INSERT INTO `depositaccount` VALUES (200,'2018-08-14',1000,12,500,600,'2018-09-13 18:30:00');
/*!40000 ALTER TABLE `depositaccount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deposittransaction`
--

DROP TABLE IF EXISTS `deposittransaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deposittransaction` (
  `DepositTransactionId` int(11) NOT NULL,
  `TransactionId` varchar(128) NOT NULL,
  `TransactionType` enum('CHECK',' WITHDRAWAL',' TRANSFER',' POSDEBIT',' ATMWITHDRAWAL',' BILLPAYMENT',' FEE',' DEPOSIT',' ADJUSTMENT',' INTEREST',' DIVIDEND',' DIRECTDEPOSIT','ATMDEPOSIT',' POSCREDIT') DEFAULT NULL,
  `Payee` varchar(45) DEFAULT NULL,
  `CheckNumber` int(11) DEFAULT NULL,
  `Amount` double DEFAULT NULL,
  PRIMARY KEY (`DepositTransactionId`),
  KEY `TransactionId` (`TransactionId`),
  CONSTRAINT `deposittransaction_ibfk_1` FOREIGN KEY (`TransactionId`) REFERENCES `transaction` (`TransactionId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deposittransaction`
--

LOCK TABLES `deposittransaction` WRITE;
/*!40000 ALTER TABLE `deposittransaction` DISABLE KEYS */;
INSERT INTO `deposittransaction` VALUES (222,'111222333444555','CHECK','Johns',1234,1000);
/*!40000 ALTER TABLE `deposittransaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `error`
--

DROP TABLE IF EXISTS `error`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `error` (
  `ErrorId` int(11) NOT NULL,
  `Code` varchar(45) DEFAULT NULL,
  `Message` varchar(100) DEFAULT NULL,
  `HttpStatus` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`ErrorId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `error`
--

LOCK TABLES `error` WRITE;
/*!40000 ALTER TABLE `error` DISABLE KEYS */;
INSERT INTO `error` VALUES (301,'601','Custmor not found','404'),(303,'602','Custmor not authorized','401'),(304,'701','Account not found','404'),(305,'702','Invalid start or end date ','400'),(306,'703','Invalid date range ','400'),(307,'901','Source account not found ','404'),(308,'902','Source account closed ','404'),(309,'903','Source account not authorized for transfer','401'),(310,'904','Destination account not found','404'),(311,'905','Destination account closed','404'),(312,'906','Destination account not authorized for transfer','401'),(313,'907','Invalid amount','404'),(314,'908','Duplicate transfer request','409'),(315,'909','Transfer not available due to EOD processing','503'),(316,'910','Insufficient funds','400'),(317,'911','Transaction limit exceeded','400'),(318,'950','Transfer not found','404'),(344,'316','Tranfer failed','500'),(345,'2','account not found','404');
/*!40000 ALTER TABLE `error` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `holding`
--

DROP TABLE IF EXISTS `holding`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `holding` (
  `HoldingId` varchar(128) NOT NULL,
  `SecurityId` varchar(128) DEFAULT NULL,
  `SecurityIdType` varchar(50) DEFAULT NULL,
  `HoldingType` varchar(50) DEFAULT NULL,
  `OriginalPurchaseDate` date DEFAULT NULL,
  `PurchasedPrice` double DEFAULT NULL,
  `CurrentUnitPrice` double DEFAULT NULL,
  `ChangeInPrice` double DEFAULT NULL,
  `Units` double DEFAULT NULL,
  `MarketValue` double DEFAULT NULL,
  PRIMARY KEY (`HoldingId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `holding`
--

LOCK TABLES `holding` WRITE;
/*!40000 ALTER TABLE `holding` DISABLE KEYS */;
/*!40000 ALTER TABLE `holding` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `investmentaccount`
--

DROP TABLE IF EXISTS `investmentaccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `investmentaccount` (
  `InvestmentAccountId` int(11) NOT NULL,
  `RefIAccountId` int(11) NOT NULL,
  `BalanceAsOf` date DEFAULT NULL,
  `CurrentValue` int(11) NOT NULL,
  `EmployerName` varchar(45) DEFAULT NULL,
  `AllowedCheckWriting` tinyint(1) DEFAULT NULL,
  `AllowedOptionTrade` tinyint(1) DEFAULT NULL,
  `Holdings` varchar(18) DEFAULT NULL,
  `OpenOrders` varchar(30) DEFAULT NULL,
  `Contribution` varchar(30) DEFAULT NULL,
  `Vesting` varchar(30) DEFAULT NULL,
  `InvestmentLoans` varchar(30) DEFAULT NULL,
  `AvailableCashBalance` double DEFAULT NULL,
  `Margin` tinyint(1) DEFAULT NULL,
  `MarginBalance` double DEFAULT NULL,
  `ShortBalance` double DEFAULT NULL,
  `RolloverAmount` tinyint(1) DEFAULT NULL,
  `BrokerId` varchar(30) DEFAULT NULL,
  `PlanId` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`InvestmentAccountId`),
  KEY `FK_Account_IA` (`RefIAccountId`),
  CONSTRAINT `FK_Account_IA` FOREIGN KEY (`RefIAccountId`) REFERENCES `account` (`AccountMasterId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `investmentaccount`
--

LOCK TABLES `investmentaccount` WRITE;
/*!40000 ALTER TABLE `investmentaccount` DISABLE KEYS */;
INSERT INTO `investmentaccount` VALUES (700,202,'2018-08-15',20000,'John',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `investmentaccount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `investmentbalance`
--

DROP TABLE IF EXISTS `investmentbalance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `investmentbalance` (
  `InvestmentBalanceId` int(11) NOT NULL,
  `BalanceName` varchar(45) DEFAULT NULL,
  `BalanceDescription` varchar(128) DEFAULT NULL,
  `BalanceType` enum('AMOUNT','PERCENTAGE') DEFAULT NULL,
  `BalanceValue` int(11) DEFAULT NULL,
  `BalanceDate` datetime DEFAULT NULL,
  `Currency` varchar(45) DEFAULT NULL,
  `InvenstmentAccountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`InvestmentBalanceId`),
  KEY `FKInvestmentAccount_idx` (`InvenstmentAccountId`),
  CONSTRAINT `FKInvestmentAccount` FOREIGN KEY (`InvenstmentAccountId`) REFERENCES `investmentaccount` (`InvestmentAccountId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='InvestmentBalance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `investmentbalance`
--

LOCK TABLES `investmentbalance` WRITE;
/*!40000 ALTER TABLE `investmentbalance` DISABLE KEYS */;
INSERT INTO `investmentbalance` VALUES (999,NULL,NULL,NULL,NULL,NULL,NULL,700);
/*!40000 ALTER TABLE `investmentbalance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loanaccount`
--

DROP TABLE IF EXISTS `loanaccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `loanaccount` (
  `LoanAccountId` int(11) NOT NULL AUTO_INCREMENT,
  `AccountId` int(11) DEFAULT NULL,
  `BalanceAsOf` date DEFAULT NULL,
  `PrincipalBalance` int(11) DEFAULT NULL,
  `OriginalPrincipal` int(11) DEFAULT NULL,
  `LoanTerm` int(11) DEFAULT NULL,
  `TotalNumberOfPayments` int(11) DEFAULT NULL,
  `NextPaymentAmount` double DEFAULT NULL,
  `NextPaymentDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `LastPaymentAmount` double DEFAULT NULL,
  `LastPaymentDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `PaymentFrequency` enum('DAILY','WEEKLY','BIWEEKLY','SEMIMONTHLY','MONTHLY','SEMIANNUALLY','ANNUALLY') DEFAULT NULL,
  PRIMARY KEY (`LoanAccountId`),
  KEY `FK_ACCOUNT_LOCA` (`AccountId`),
  CONSTRAINT `FK_ACCOUNT_LOCA` FOREIGN KEY (`AccountId`) REFERENCES `account` (`AccountMasterId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=latin1 COMMENT='LoanAccountId';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loanaccount`
--

LOCK TABLES `loanaccount` WRITE;
/*!40000 ALTER TABLE `loanaccount` DISABLE KEYS */;
INSERT INTO `loanaccount` VALUES (101,201,'2018-08-15',200000,300000,5,12,10000,'2018-09-14 18:30:00',10000,'2018-08-14 18:30:00','MONTHLY'),(102,203,'2018-08-15',400000,500000,6,12,5000,'2018-09-14 18:30:00',5000,'2018-08-14 18:30:00','WEEKLY');
/*!40000 ALTER TABLE `loanaccount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loantransaction`
--

DROP TABLE IF EXISTS `loantransaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `loantransaction` (
  `LoanTransactionId` varchar(128) NOT NULL,
  `TransactionId` varchar(128) DEFAULT NULL,
  `TransactionType` enum('PAYMENT','FEE','ADJUSTMENT','INTEREST') DEFAULT NULL,
  PRIMARY KEY (`LoanTransactionId`),
  KEY `PK_LocTransaction_idx` (`LoanTransactionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loantransaction`
--

LOCK TABLES `loantransaction` WRITE;
/*!40000 ALTER TABLE `loantransaction` DISABLE KEYS */;
INSERT INTO `loantransaction` VALUES ('111222333444334','111222333444561','PAYMENT'),('111222333444335','111222333444563','PAYMENT');
/*!40000 ALTER TABLE `loantransaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locaccount`
--

DROP TABLE IF EXISTS `locaccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locaccount` (
  `LocAccountId` int(11) NOT NULL,
  `AccountId` int(11) DEFAULT NULL,
  `BalanceAsOf` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CreditLine` int(11) DEFAULT NULL,
  `AvailableCredit` int(11) DEFAULT NULL,
  `NextPaymentAmount` double DEFAULT NULL,
  `NextPaymentDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `PrincipalBalance` int(11) DEFAULT NULL,
  `CurrentBalance` int(11) DEFAULT NULL,
  `LastPaymentAmount` double DEFAULT NULL,
  `LastPaymentDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`LocAccountId`),
  KEY `AccountId` (`AccountId`),
  CONSTRAINT `locaccount_ibfk_1` FOREIGN KEY (`AccountId`) REFERENCES `account` (`AccountMasterId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='LoanAccountId';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locaccount`
--

LOCK TABLES `locaccount` WRITE;
/*!40000 ALTER TABLE `locaccount` DISABLE KEYS */;
/*!40000 ALTER TABLE `locaccount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paymentdetails`
--

DROP TABLE IF EXISTS `paymentdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paymentdetails` (
  `LoanTransactionId` varchar(128) DEFAULT NULL,
  `PaymentId` varchar(128) NOT NULL,
  `PrincipalAmount` double DEFAULT NULL,
  `InterestAmount` double DEFAULT NULL,
  `InsuranceAmount` double DEFAULT NULL,
  `EscrowAmount` double DEFAULT NULL,
  `PmiAmount` double DEFAULT NULL,
  `FeesAmount` double DEFAULT NULL,
  PRIMARY KEY (`PaymentId`),
  KEY `LoanTransactionId` (`LoanTransactionId`),
  CONSTRAINT `paymentdetails_ibfk_1` FOREIGN KEY (`LoanTransactionId`) REFERENCES `loantransaction` (`LoanTransactionId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paymentdetails`
--

LOCK TABLES `paymentdetails` WRITE;
/*!40000 ALTER TABLE `paymentdetails` DISABLE KEYS */;
INSERT INTO `paymentdetails` VALUES ('111222333444334','33444334',200000,1000,10000,5000,200,220),('111222333444335','33444335',500000,2500,500,500,200,220),('111222333444335','33444336',500000,2500,500,500,200,220);
/*!40000 ALTER TABLE `paymentdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statement`
--

DROP TABLE IF EXISTS `statement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statement` (
  `AccountId` varchar(128) DEFAULT NULL,
  `StatementId` varchar(128) NOT NULL,
  `Description` varchar(50) DEFAULT NULL,
  `StatementDate` date DEFAULT NULL,
  PRIMARY KEY (`StatementId`),
  KEY `AccountId_idx` (`AccountId`),
  CONSTRAINT `statement_ibfk_1` FOREIGN KEY (`AccountId`) REFERENCES `accountdescriptor` (`AccountId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statement`
--

LOCK TABLES `statement` WRITE;
/*!40000 ALTER TABLE `statement` DISABLE KEYS */;
INSERT INTO `statement` VALUES ('1357902468','ST875376081768363584636','Statement for 2018-01-01','2018-01-01'),('1357902468','ST875376081768363584637','Statement for 2018-02-02','2018-02-02'),('1357902468','ST875376081768363584638','Statement for 2018-03-03','2018-03-03'),('1357902468','ST875376081768363584639','Statement for 2018-04-04','2018-04-04');
/*!40000 ALTER TABLE `statement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `telephonenumber`
--

DROP TABLE IF EXISTS `telephonenumber`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `telephonenumber` (
  `TelephoneNumberId` int(11) NOT NULL,
  `Type` enum('HOME','BUSINESS','CELL','FAX') DEFAULT NULL,
  `Country` varchar(20) DEFAULT NULL,
  `Number` varchar(10) DEFAULT NULL,
  `CustomerId_FK` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`TelephoneNumberId`),
  KEY `customerid_fk` (`CustomerId_FK`),
  CONSTRAINT `telephonenumber_ibfk_1` FOREIGN KEY (`CustomerId_FK`) REFERENCES `customer` (`CustomerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `telephonenumber`
--

LOCK TABLES `telephonenumber` WRITE;
/*!40000 ALTER TABLE `telephonenumber` DISABLE KEYS */;
INSERT INTO `telephonenumber` VALUES (401,'HOME','916','8004771477','111111101'),(402,'CELL','916','8004777477','111111102'),(403,'HOME','916','8004771477','111111102'),(404,'CELL','916','8004777477','111111102'),(405,'HOME','916','8004771477','111111102'),(406,'BUSINESS','916','8004771477','111111103'),(407,'HOME','916','8004771477','111111103'),(408,'BUSINESS','916','8004071477','111111104'),(409,'HOME','916','8004671477','111111104'),(410,'BUSINESS','916','8008771477','111111105'),(411,'HOME','916','8006771477','111111105');
/*!40000 ALTER TABLE `telephonenumber` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction` (
  `AccountId` varchar(128) DEFAULT NULL,
  `TransactionId` varchar(128) NOT NULL,
  `ReferenceTransactionId` varchar(128) DEFAULT NULL,
  `TransactionTimestamp` datetime DEFAULT NULL,
  `Description` varchar(45) DEFAULT NULL,
  `Amount` double NOT NULL,
  `Status` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`TransactionId`),
  KEY `FK_ACCOUNT_idx` (`AccountId`),
  CONSTRAINT `AccountId` FOREIGN KEY (`AccountId`) REFERENCES `accountdescriptor` (`AccountId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='TransactionMaster';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES ('1357902468','111222333444555','111222333444556','2018-07-12 10:30:00','Check Transfer',1000,'POSTED'),('1357902468','111222333444557','111222333444558','2018-08-17 10:30:00','Transfer',200.5,'POSTED'),('1357902468','111222333444559','111222333444560','2018-08-18 18:30:00','Transfer',348.89,'PENDING'),('1357902469','111222333444561','111222333444562','2018-08-19 08:30:00','Loan Payment',10000,'POSTED'),('1357902471','111222333444563','111222333444564','2018-08-18 18:30:00','Loan Payment',5000,'POSTED');
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactionimage`
--

DROP TABLE IF EXISTS `transactionimage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactionimage` (
  `TransationId` varchar(128) DEFAULT NULL,
  `ImageId` int(11) NOT NULL,
  `Image` blob,
  PRIMARY KEY (`ImageId`),
  KEY `TransationId_idx` (`TransationId`),
  CONSTRAINT `TransationId` FOREIGN KEY (`TransationId`) REFERENCES `transaction` (`TransactionId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactionimage`
--

LOCK TABLES `transactionimage` WRITE;
/*!40000 ALTER TABLE `transactionimage` DISABLE KEYS */;
/*!40000 ALTER TABLE `transactionimage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transfer`
--

DROP TABLE IF EXISTS `transfer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transfer` (
  `TransferId` varchar(128) NOT NULL,
  `FromAccountId` varchar(128) DEFAULT NULL,
  `ToAccountId` varchar(128) DEFAULT NULL,
  `Amount` int(11) DEFAULT NULL,
  `Memo` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`TransferId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transfer`
--

LOCK TABLES `transfer` WRITE;
/*!40000 ALTER TABLE `transfer` DISABLE KEYS */;
INSERT INTO `transfer` VALUES ('111222333444555','1357902468','1357902469',50,'check #123'),('111222333444556','1357902469','1357902468',1000,'bill payment'),('111222333444557','1357902469','1357902468',2000,'check#456'),('111222333444558','1357902468','1357902467',5000,'bill payment');
/*!40000 ALTER TABLE `transfer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transferstatus`
--

DROP TABLE IF EXISTS `transferstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transferstatus` (
  `TransferId` varchar(128) DEFAULT NULL,
  `ReferenceId` varchar(128) NOT NULL,
  `Status` varchar(128) DEFAULT NULL,
  `TransferDate` datetime DEFAULT NULL,
  PRIMARY KEY (`ReferenceId`),
  KEY `TransferId` (`TransferId`),
  CONSTRAINT `TransferId` FOREIGN KEY (`TransferId`) REFERENCES `transfer` (`TransferId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transferstatus`
--

LOCK TABLES `transferstatus` WRITE;
/*!40000 ALTER TABLE `transferstatus` DISABLE KEYS */;
INSERT INTO `transferstatus` VALUES ('111222333444555','8453935582','PENDING','2018-08-14 10:00:00'),('111222333444556','8453935583','SUCCESS','2018-08-14 16:40:00'),('111222333444557','8453935584','SUCCESS','2018-08-13 20:00:00'),('111222333444558','8453935585','FAILURE','2018-09-13 18:00:00');
/*!40000 ALTER TABLE `transferstatus` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-09-21 10:37:58
