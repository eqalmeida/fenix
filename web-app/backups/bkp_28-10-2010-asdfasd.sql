-- MySQL dump 10.13  Distrib 5.1.49, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: fenix
-- ------------------------------------------------------
-- Server version	5.1.49-1ubuntu8

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
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cliente` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `anotacoes` varchar(350) NOT NULL,
  `bairro` varchar(100) NOT NULL,
  `cargo` varchar(50) NOT NULL,
  `cep` varchar(12) NOT NULL,
  `cidade` varchar(100) NOT NULL,
  `cpf` varchar(15) NOT NULL,
  `email` varchar(100) NOT NULL,
  `empresa` varchar(100) NOT NULL,
  `endereco` varchar(100) NOT NULL,
  `endereco_empresa` varchar(350) NOT NULL,
  `estado` varchar(3) NOT NULL,
  `fax` varchar(12) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `pto_referencia` varchar(100) NOT NULL,
  `renda` decimal(19,2) DEFAULT NULL,
  `residencia` varchar(10) NOT NULL,
  `rg` varchar(14) NOT NULL,
  `saldo` decimal(19,2) NOT NULL,
  `telefone_cel` varchar(15) NOT NULL,
  `telefone_com` varchar(15) NOT NULL,
  `telefone_res` varchar(15) NOT NULL,
  `tempo_servico` varchar(12) DEFAULT NULL,
  `web_page` varchar(120) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cpf` (`cpf`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `data` datetime DEFAULT NULL,
  `empresa` varchar(100) DEFAULT NULL,
  `liberacao` varchar(20) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `pasta_backup` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES (1,0,'2010-10-11 16:41:26','FENIX MOTO','ok','xxx','c:\\fenix\\backups');
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emprestimo`
--

DROP TABLE IF EXISTS `emprestimo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emprestimo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `ano_fab` varchar(4) DEFAULT NULL,
  `ano_mod` varchar(4) DEFAULT NULL,
  `chassi` varchar(20) DEFAULT NULL,
  `cliente_id` bigint(20) NOT NULL,
  `cor` varchar(15) DEFAULT NULL,
  `data` datetime NOT NULL,
  `data_reg` datetime NOT NULL,
  `especie_id` int(11) NOT NULL,
  `intervalo` varchar(9) NOT NULL,
  `marca` varchar(20) DEFAULT NULL,
  `modelo` varchar(20) DEFAULT NULL,
  `num_parcelas` int(11) NOT NULL,
  `placa` varchar(10) DEFAULT NULL,
  `plano_id` int(11) NOT NULL,
  `primeiro_vencimento` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  `tac` decimal(19,2) NOT NULL,
  `tipo_combustivel` varchar(8) DEFAULT NULL,
  `tipo_emprestimo_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `valor_liberado` decimal(19,2) NOT NULL,
  `valor_parcela` decimal(19,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK360B41AF517F35EA` (`usuario_id`),
  KEY `FK360B41AF407AB26A` (`cliente_id`),
  KEY `FK360B41AF934D46EA` (`plano_id`),
  KEY `FK360B41AF70D5632A` (`especie_id`),
  KEY `FK360B41AF2E19AEF3` (`tipo_emprestimo_id`),
  CONSTRAINT `FK360B41AF2E19AEF3` FOREIGN KEY (`tipo_emprestimo_id`) REFERENCES `tipo_emprestimo` (`id`),
  CONSTRAINT `FK360B41AF407AB26A` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`),
  CONSTRAINT `FK360B41AF517F35EA` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`),
  CONSTRAINT `FK360B41AF70D5632A` FOREIGN KEY (`especie_id`) REFERENCES `especie` (`id`),
  CONSTRAINT `FK360B41AF934D46EA` FOREIGN KEY (`plano_id`) REFERENCES `plano` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emprestimo`
--

LOCK TABLES `emprestimo` WRITE;
/*!40000 ALTER TABLE `emprestimo` DISABLE KEYS */;
/*!40000 ALTER TABLE `emprestimo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `especie`
--

DROP TABLE IF EXISTS `especie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `especie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `ativo` bit(1) NOT NULL,
  `gera_boleto` bit(1) NOT NULL,
  `nome` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `especie`
--

LOCK TABLES `especie` WRITE;
/*!40000 ALTER TABLE `especie` DISABLE KEYS */;
INSERT INTO `especie` VALUES (1,0,'','','CHEQUE'),(2,0,'','','BOLETO'),(3,0,'','','PROMISSÓRIA');
/*!40000 ALTER TABLE `especie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `data` datetime NOT NULL,
  `descricao` varchar(300) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1A344517F35EA` (`usuario_id`),
  CONSTRAINT `FK1A344517F35EA` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
/*!40000 ALTER TABLE `log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `observacao`
--

DROP TABLE IF EXISTS `observacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `observacao` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `data` datetime NOT NULL,
  `emprestimo_id` bigint(20) NOT NULL,
  `obs` varchar(255) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK3BF7B9517F35EA` (`usuario_id`),
  KEY `FK3BF7B965E67E6A` (`emprestimo_id`),
  CONSTRAINT `FK3BF7B9517F35EA` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`),
  CONSTRAINT `FK3BF7B965E67E6A` FOREIGN KEY (`emprestimo_id`) REFERENCES `emprestimo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `observacao`
--

LOCK TABLES `observacao` WRITE;
/*!40000 ALTER TABLE `observacao` DISABLE KEYS */;
/*!40000 ALTER TABLE `observacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parcela`
--

DROP TABLE IF EXISTS `parcela`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parcela` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `acrescimos` decimal(19,2) NOT NULL,
  `data_pagamento` datetime DEFAULT NULL,
  `emprestimo_id` bigint(20) NOT NULL,
  `multa_atraso` decimal(19,2) NOT NULL,
  `numero` int(11) NOT NULL,
  `pago` bit(1) NOT NULL,
  `parcela_ant_id` bigint(20) DEFAULT NULL,
  `previsao_de_pagamento` datetime DEFAULT NULL,
  `taxa_juros_atraso` decimal(19,3) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `valor` decimal(19,2) NOT NULL,
  `valor_pago` decimal(19,2) DEFAULT NULL,
  `vencimento` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKD0B50178517F35EA` (`usuario_id`),
  KEY `FKD0B5017865C5FB82` (`parcela_ant_id`),
  KEY `FKD0B5017865E67E6A` (`emprestimo_id`),
  CONSTRAINT `FKD0B50178517F35EA` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`),
  CONSTRAINT `FKD0B5017865C5FB82` FOREIGN KEY (`parcela_ant_id`) REFERENCES `parcela` (`id`),
  CONSTRAINT `FKD0B5017865E67E6A` FOREIGN KEY (`emprestimo_id`) REFERENCES `emprestimo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parcela`
--

LOCK TABLES `parcela` WRITE;
/*!40000 ALTER TABLE `parcela` DISABLE KEYS */;
/*!40000 ALTER TABLE `parcela` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plano`
--

DROP TABLE IF EXISTS `plano`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plano` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `coeficiente` decimal(19,6) NOT NULL,
  `num_parcelas` int(11) NOT NULL,
  `tac` decimal(19,2) NOT NULL,
  `tipo_emprestimo_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tipo_emprestimo_id` (`tipo_emprestimo_id`,`num_parcelas`),
  KEY `FK65CDA662E19AEF3` (`tipo_emprestimo_id`),
  CONSTRAINT `FK65CDA662E19AEF3` FOREIGN KEY (`tipo_emprestimo_id`) REFERENCES `tipo_emprestimo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plano`
--

LOCK TABLES `plano` WRITE;
/*!40000 ALTER TABLE `plano` DISABLE KEYS */;
/*!40000 ALTER TABLE `plano` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_emprestimo`
--

DROP TABLE IF EXISTS `tipo_emprestimo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_emprestimo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `ativo` bit(1) NOT NULL,
  `multa_atraso` decimal(19,2) NOT NULL,
  `nome` varchar(30) NOT NULL,
  `taxa_juros_atraso` decimal(19,4) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_emprestimo`
--

LOCK TABLES `tipo_emprestimo` WRITE;
/*!40000 ALTER TABLE `tipo_emprestimo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_emprestimo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `ativo` bit(1) NOT NULL,
  `login` varchar(12) NOT NULL,
  `nome` varchar(60) NOT NULL,
  `perfil` varchar(11) NOT NULL,
  `senha` varchar(12) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `login` (`login`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,0,'','admin','Administrador','admin','admin');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-10-28 21:46:19
