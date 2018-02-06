# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.5.42)
# Database: coin_manager
# Generation Time: 2018-02-05 18:54:42 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table coins
# ------------------------------------------------------------

DROP TABLE IF EXISTS `coins`;

CREATE TABLE `coins` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `coin_name` varchar(50) DEFAULT NULL,
  `symbol` varchar(50) DEFAULT NULL,
  `alg` varchar(50) DEFAULT NULL,
  `crpyto_compare_id` int(11) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `cc_sort_order` int(11) DEFAULT NULL,
  `total_coin_supply` varchar(20) DEFAULT NULL,
  `cc_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `coins` WRITE;
/*!40000 ALTER TABLE `coins` DISABLE KEYS */;

INSERT INTO `coins` (`id`, `coin_name`, `symbol`, `alg`, `crpyto_compare_id`, `image_url`, `cc_sort_order`, `total_coin_supply`, `cc_url`)
VALUES
	(3967,'Bitstake','XBS','X11',5023,'/media/351060/xbs_1.png',16,'1300000','/coins/xbs/overview'),
	(3968,'Aegis','AGS','X13',4326,'/media/19595/ags.png',39,'0','/coins/ags/overview'),
	(3969,'Spreadcoin','SPR','X11',3649,'/media/20438/spr.png',29,'20000000','/coins/spr/overview'),
	(3970,'CleverHash','CHASH','N/A',3648,'/media/20231/chash.png',28,'0','/coins/chash/overview'),
	(3971,'PetroDollar','XPD','SHA256D',3646,'/media/20162/xpd.png',26,'122107462','/coins/xpd/overview'),
	(3972,'PayCoin','XPY','SHA256',5030,'/media/20076/xpy_1.png',17,'12500000','/coins/xpy/overview'),
	(3973,'Benjamins','BEN','SHA256',4336,'/media/19617/ben.png',50,'12800000','/coins/ben/overview'),
	(3974,'YbCoin','YBC','Multiple',3639,'/media/19975/ybc.png',19,'200000000','/coins/ybc/overview'),
	(3975,'BetaCoin','BET','SHA256',4337,'/media/19621/bet.png',51,'32000000','/coins/bet/overview'),
	(3976,'MoonCoin','MOON','Scrypt',4346,'/media/19802/moon.png',59,'384000000000','/coins/moon/overview'),
	(3977,'ProsperCoin','PRC','Scrypt',3638,'/media/20393/prc.png',18,'21000000','/coins/prc/overview'),
	(3978,'Bitshares','BTS','SHA-512',5039,'/media/20705/bts.png',10,'2511953117','/coins/bts/overview'),
	(3979,'BitMark','BTM','Scrypt',4403,'/media/20084/btm.png',73,'27580000','/coins/btm/overview'),
	(3980,'CannaCoin','CCN','Scrypt',4412,'/media/19643/ccn.png',81,'13140000','/coins/ccn/overview'),
	(3981,'Diamond','DMD','Groestl',4431,'/media/19680/dmd.png',98,'4380000','/coins/dmd/overview'),
	(3982,'ACoin','ACOIN','SHA256',4323,'/media/20079/acoin.png',36,'1600000','/coins/acoin/overview'),
	(3983,'CryptoBuk','BUK','Scrypt',4404,'/media/19637/buk.png',74,'100000000','/coins/buk/overview'),
	(3984,'DogeParty','XDP','N/A',3655,'/media/20560/xdp.png',32,'0','/coins/xdp/overview'),
	(3985,'Ripple','XRP','N/A',5031,'/media/19972/ripple.png',12,'38305873865','/coins/xrp/overview'),
	(3986,'GiveCoin','GIVE','X11',3641,'/media/20297/give.png',21,'500000000','/coins/give/overview'),
	(3987,'Ethereum Classic','ETC','Ethash',5324,'/media/20275/etc2.png',7,'N/A','/coins/etc/overview'),
	(3988,'BattleCoin','BCX','SHA256',4335,'/media/19620/bcx.png',49,'100000000','/coins/bcx/overview'),
	(3989,'Ethereum','ETH','Ethash',7605,'/media/20646/eth_logo.png',2,'0','/coins/eth/overview'),
	(3990,'QuarkCoin','QRK','Multiple',4351,'/media/19882/qrk.png',64,'247000000','/coins/qrk/overview'),
	(3991,'CannabisCoin','CANN','X11',4407,'/media/20015/cann.png',76,'N/A','/coins/cann/overview'),
	(3992,'CheckCoin','CXC','N/A',4415,'/media/20246/cxc.png',84,'100000000','/coins/cxc/overview'),
	(3993,'Supcoin','SUP','N/A',3645,'/media/20442/sup.png',25,'0','/coins/sup/overview'),
	(3994,'BitGem','BTG*','Scrypt',4402,'/media/19634/btg.png',72,'1500000','/coins/btgstar/overview'),
	(3995,'CosmosCoin','CMC','Scrypt',4419,'/media/20019/cmc.png',88,'100000000','/coins/cmc/overview'),
	(3996,'Insanity Coin','WOLF','X11',3653,'/media/20559/wolf.png',31,'50000000','/coins/wolf/overview'),
	(3997,'CoolCoin','COOL','Scrypt',4423,'/media/19658/cool.png',92,'100000000','/coins/cool/overview'),
	(3998,'Aurora Coin','AUR','Scrypt',4333,'/media/19608/aur.png',47,'21000000','/coins/aur/overview'),
	(3999,'DarkToken','DT','NIST5',3643,'/media/20031/dt.png',23,'0','/coins/dt/overview'),
	(4000,'CopperLark','CLR','SHA256',4418,'/media/19657/clr.png',87,'27200000','/coins/clr/overview'),
	(4001,'ZCash','ZEC','Equihash',24854,'/media/351360/zec.png',9,'21000000','/coins/zec/overview'),
	(4002,'ZetaCoin','ZET','SHA256',4347,'/media/19993/zet.png',60,'N/A','/coins/zet/overview'),
	(4003,'Riecoin','RIC','Groestl',4352,'/media/19888/ric.jpg',65,'84000000','/coins/ric/overview'),
	(4004,'CashCoin','CASH','Scrypt',4409,'/media/20016/cash.png',78,'47433600','/coins/cash/overview'),
	(4005,'Community Coin','COMM','Scrypt',4422,'/media/19661/comm.png',91,'1000000000','/coins/comm/overview'),
	(4006,'Aero Coin','AERO','X13',4324,'/media/19594/aero.png',37,'7000000','/coins/aero/overview'),
	(4007,'Verge','XVG','Multiple',4433,'/media/12318032/xvg.png',99,'16555000000','/coins/xvg/overview'),
	(4008,'SexCoin','SXC','Scrypt',4348,'/media/19924/sxc.png',61,'250000000','/coins/sxc/overview'),
	(4009,'BQCoin','BQC','Scrypt',4343,'/media/19631/bqc.png',57,'88000000','/coins/bqc/overview'),
	(4010,'KoboCoin','KOBO','X15',3642,'/media/20329/kobo.png',22,'350000000','/coins/kobo/overview'),
	(4011,'NXTI','NXTI','N/A',3650,'/media/20376/nxti.png',30,'N/A','/coins/nxti/overview'),
	(4012,'Catcoin','CAT1','Scrypt',4410,'/media/19644/cat.png',79,'21000000 ','/coins/cat1/overview'),
	(4013,'ChinaCoin','CNC','Scrypt',4420,'/media/20021/cnc.png',89,'462500000','/coins/cnc/overview'),
	(4014,'ConcealCoin','CNL','X11',4421,'/media/20024/cnl.png',90,'8500000','/coins/cnl/overview'),
	(4015,'BitcoinDark','BTCD','SHA256',4400,'/media/19630/btcd_1.png',13,'22000000','/coins/btcd/overview'),
	(4016,'BlueCoin','BLU','X11',4340,'/media/19624/blu.png',53,'500000000','/coins/blu/overview'),
	(4017,'BlackCoin','BLK','Scrypt',4339,'/media/351795/blk.png',54,'N/A','/coins/blk/overview'),
	(4018,'CrackCoin','CRACK','X11',4424,'/media/20023/crack.png',93,'6000000','/coins/crack/overview'),
	(4019,'CLAMS','CLAM','N/A',4416,'/media/20020/clam.png',85,'N/A','/coins/clam/overview'),
	(4020,'Litecoin','LTC','Scrypt',3808,'/media/19782/litecoin-logo.png',3,'84000000','/coins/ltc/overview'),
	(4021,'BottleCaps','CAP','Scrypt',4408,'/media/20017/cap.png',77,'47433600','/coins/cap/overview'),
	(4022,'Cachecoin','CACH','Scrypt',4405,'/media/19642/cach.png',75,'2000000000','/coins/cach/overview'),
	(4023,'BitBean','BITB','SHA256',4338,'/media/350879/bitb.png',52,'50000000000','/coins/bitb/overview'),
	(4024,'Quatloo','QTL','Scrypt',4349,'/media/19879/qtl.png',62,'100000000','/coins/qtl/overview'),
	(4025,'ByteCoin','BTE','SHA256',4401,'/media/19632/bte.png',71,'21000000 ','/coins/bte/overview'),
	(4026,'Bitcoin','BTC','SHA256',1182,'/media/19633/btc.png',1,'21000000','/coins/btc/overview'),
	(4027,'AXRON','AXR','N/A',4334,'/media/20086/axr.png',48,'0','/coins/axr/overview'),
	(4028,'BitBar','BTB','Scrypt',4399,'/media/20083/bitb.png',69,'500000','/coins/btb/overview'),
	(4029,'DigitalCash','DASH','X11',3807,'/media/20626/imageedit_27_4355944719.png',4,'22000000','/coins/dash/overview'),
	(4030,'GeoCoin','GEO','Scrypt',3647,'/media/20292/geo.png',27,'1000000000','/coins/geo/overview'),
	(4031,'LimeCoinX','LIMX','X11',4354,'/media/19769/limx.png',67,'21000000 ','/coins/limx/overview'),
	(4032,'MyriadCoin','XMY','Multiple',4345,'/media/19815/myr.png',58,'2000000000','/coins/xmy/overview'),
	(4033,'Monero','XMR','CryptoNight',5038,'/media/19969/xmr.png',5,'0','/coins/xmr/overview'),
	(4034,'ArchCoin','ARCH','Scrypt',4331,'/media/20085/arch.png',44,'16403135','/coins/arch/overview'),
	(4035,'CloakCoin','CLOAK','X13',4417,'/media/19994/cloak.png',86,'N/A','/coins/cloak/overview'),
	(4036,'eMark','DEM','SHA256',4429,'/media/20028/dem.png',97,'210000000','/coins/dem/overview'),
	(4037,'AmericanCoin','AMC','Scrypt',4327,'/media/19601/amc.png',40,'168000000','/coins/amc/overview'),
	(4038,'EnergyCoin','ENRG','Scrypt',4350,'/media/19697/enrg.png',63,'0','/coins/enrg/overview'),
	(4039,'Asia Coin','AC','Scrypt',4322,'/media/19593/ac.png',35,'N/A','/coins/ac/overview'),
	(4040,'CryptoBullion','CBX','Scrypt',4411,'/media/20697/cbx.png',80,'1000000','/coins/cbx/overview'),
	(4041,'CryptCoin','CRYPT','X11',4427,'/media/19664/crypt.png',95,'18000000','/coins/crypt/overview'),
	(4042,'AlienCoin','ALN','Scrypt',4328,'/media/20080/aln.png',41,'200000000','/coins/aln/overview'),
	(4043,'AlphaCoin','ALF','Scrypt',4325,'/media/19600/alf.png',38,'210182000','/coins/alf/overview'),
	(4044,'2015 coin','2015','X11',3744,'/media/20180/2015.png',33,'0','/coins/2015/overview'),
	(4045,'CAIx','CAIX','Scrypt',4406,'/media/20226/caix.png',70,'0','/coins/caix/overview'),
	(4046,'CasinoCoin','CSC','Scrypt',4428,'/media/19667/csc.png',96,'336000000','/coins/csc/overview'),
	(4047,'Dogecoin','DOGE','Scrypt',4432,'/media/19684/doge.png',8,'N/A','/coins/doge/overview'),
	(4048,'DigiByte','DGB','Multiple',4430,'/media/12318264/7638-nty_400x400.jpg',11,'21000000000','/coins/dgb/overview'),
	(4049,'DigiCoin','DGC','Scrypt',4353,'/media/19676/dgc.png',66,'48166000','/coins/dgc/overview'),
	(4050,'DarkKush','DANK','X13',3640,'/media/20247/dank.png',20,'3000000','/coins/dank/overview'),
	(4051,'BoostCoin','BOST','X13',4342,'/media/19626/bost.png',56,'N/A','/coins/bost/overview'),
	(4052,'CETUS Coin','CETI','Scrypt',3644,'/media/20228/ceti.png',24,'0','/coins/ceti/overview'),
	(4053,'CINNICOIN','CINNI','Scrypt',4414,'/media/19651/cinni.jpeg',83,'15000000','/coins/cinni/overview'),
	(4054,'PeerCoin','PPC','N/A',2349,'/media/19864/peercoin-logo.png',14,'N/A','/coins/ppc/overview'),
	(4055,'Argentum','ARG','Scrypt',4371,'/media/19602/arg.png',45,'64000000','/coins/arg/overview'),
	(4056,'AriCoin','ARI','Scrypt',4332,'/media/20082/ari.png',46,'322649400','/coins/ari/overview'),
	(4057,'CraftCoin','CRC*','Scrypt',4426,'/media/19665/crc.png',94,'100000000','/coins/crcstar/overview'),
	(4058,'ApexCoin','APEX','X13',4330,'/media/19599/apex.png',43,'6000000','/coins/apex/overview'),
	(4059,'Nxt','NXT','PoS',1183,'/media/20627/nxt.png',6,'1000000000','/coins/nxt/overview'),
	(4060,'CraigsCoin','CRAIG','X11',4425,'/media/20022/craig.png',15,'30000000','/coins/craig/overview'),
	(4061,'CinderCoin','CIN','Multiple',4413,'/media/20698/cinder.png',82,'114000000','/coins/cin/overview'),
	(4062,'42 Coin','42','Scrypt',4321,'/media/12318415/42.png',34,'42','/coins/42/overview');

/*!40000 ALTER TABLE `coins` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user_coins
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_coins`;

CREATE TABLE `user_coins` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL,
  `cid` int(11) unsigned NOT NULL,
  `ammount` float NOT NULL,
  PRIMARY KEY (`id`),
  KEY `coin_user` (`uid`),
  KEY `coin_coin` (`cid`),
  CONSTRAINT `coin_coin` FOREIGN KEY (`cid`) REFERENCES `coins` (`id`),
  CONSTRAINT `coin_user` FOREIGN KEY (`uid`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `full_name` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `coin` varchar(10) NOT NULL DEFAULT '',
  `email` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
