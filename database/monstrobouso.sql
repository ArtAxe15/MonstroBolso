-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: monstrobouso
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `batalha_log`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `batalha_log` (
  `id_batalha` int(11) NOT NULL AUTO_INCREMENT,
  `id_perfil` int(11) NOT NULL,
  `id_desafio` int(11) DEFAULT NULL,
  `resultado` varchar(20) NOT NULL,
  `dinheiro_ganho` int(11) NOT NULL DEFAULT 0,
  `detalhes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`detalhes`)),
  `iniciada_em` datetime NOT NULL DEFAULT current_timestamp(),
  `finalizada_em` datetime DEFAULT NULL,
  PRIMARY KEY (`id_batalha`),
  KEY `fk_batalha_log_perfil` (`id_perfil`),
  KEY `fk_batalha_log_desafio` (`id_desafio`),
  CONSTRAINT `fk_batalha_log_desafio` FOREIGN KEY (`id_desafio`) REFERENCES `desafio` (`id_desafio`) ON UPDATE CASCADE,
  CONSTRAINT `fk_batalha_log_perfil` FOREIGN KEY (`id_perfil`) REFERENCES `perfil` (`id_perfil`) ON UPDATE CASCADE,
  CONSTRAINT `chk_batalha_resultado` CHECK (`resultado` in ('VITORIA','DERROTA')),
  CONSTRAINT `chk_batalha_dinheiro` CHECK (`dinheiro_ganho` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batalha_log`
--

LOCK TABLES `batalha_log` WRITE;
/*!40000 ALTER TABLE `batalha_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `batalha_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batalha_pokemon`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `batalha_pokemon` (
  `id_batalha_pokemon` int(11) NOT NULL AUTO_INCREMENT,
  `id_batalha` int(11) NOT NULL,
  `id_pokemon_time` int(11) DEFAULT NULL,
  `id_pokemon_especie` int(11) NOT NULL,
  `lado` varchar(20) NOT NULL,
  `ordem` int(11) NOT NULL,
  `nivel` int(11) NOT NULL,
  `hp_inicial` int(11) NOT NULL,
  `hp_final` int(11) NOT NULL,
  `id_status_final` int(11) DEFAULT NULL,
  `id_held_item` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_batalha_pokemon`),
  UNIQUE KEY `uq_batalha_lado_ordem` (`id_batalha`,`lado`,`ordem`),
  KEY `fk_batalha_pokemon_time` (`id_pokemon_time`),
  KEY `fk_batalha_pokemon_especie` (`id_pokemon_especie`),
  KEY `fk_batalha_pokemon_status` (`id_status_final`),
  KEY `fk_batalha_pokemon_held_item` (`id_held_item`),
  CONSTRAINT `fk_batalha_pokemon_batalha` FOREIGN KEY (`id_batalha`) REFERENCES `batalha_log` (`id_batalha`) ON DELETE CASCADE,
  CONSTRAINT `fk_batalha_pokemon_especie` FOREIGN KEY (`id_pokemon_especie`) REFERENCES `pokemon_especie` (`id_pokemon_especie`) ON UPDATE CASCADE,
  CONSTRAINT `fk_batalha_pokemon_held_item` FOREIGN KEY (`id_held_item`) REFERENCES `held_item` (`id_held_item`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_batalha_pokemon_status` FOREIGN KEY (`id_status_final`) REFERENCES `status_pokemon` (`id_status`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_batalha_pokemon_time` FOREIGN KEY (`id_pokemon_time`) REFERENCES `pokemon_time` (`id_pokemon_time`) ON DELETE SET NULL,
  CONSTRAINT `chk_batalha_lado` CHECK (`lado` in ('JOGADOR','INIMIGO')),
  CONSTRAINT `chk_batalha_ordem` CHECK (`ordem` >= 1),
  CONSTRAINT `chk_batalha_nivel` CHECK (`nivel` between 1 and 100),
  CONSTRAINT `chk_batalha_hp_inicial` CHECK (`hp_inicial` >= 0),
  CONSTRAINT `chk_batalha_hp_final` CHECK (`hp_final` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batalha_pokemon`
--

LOCK TABLES `batalha_pokemon` WRITE;
/*!40000 ALTER TABLE `batalha_pokemon` DISABLE KEYS */;
/*!40000 ALTER TABLE `batalha_pokemon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compra`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compra` (
  `id_compra` int(11) NOT NULL AUTO_INCREMENT,
  `id_perfil` int(11) NOT NULL,
  `id_item` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `valor_unitario` int(11) NOT NULL,
  `valor_total` int(11) NOT NULL,
  `realizada_em` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_compra`),
  KEY `fk_compra_perfil` (`id_perfil`),
  KEY `fk_compra_item` (`id_item`),
  CONSTRAINT `fk_compra_item` FOREIGN KEY (`id_item`) REFERENCES `item` (`id_item`) ON UPDATE CASCADE,
  CONSTRAINT `fk_compra_perfil` FOREIGN KEY (`id_perfil`) REFERENCES `perfil` (`id_perfil`) ON UPDATE CASCADE,
  CONSTRAINT `chk_compra_quantidade` CHECK (`quantidade` > 0),
  CONSTRAINT `chk_compra_valor_unitario` CHECK (`valor_unitario` >= 0),
  CONSTRAINT `chk_compra_valor_total` CHECK (`valor_total` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compra`
--

LOCK TABLES `compra` WRITE;
/*!40000 ALTER TABLE `compra` DISABLE KEYS */;
/*!40000 ALTER TABLE `compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `desafio`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `desafio` (
  `id_desafio` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `tipo` varchar(30) NOT NULL,
  PRIMARY KEY (`id_desafio`),
  UNIQUE KEY `ordem` (`ordem`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `desafio`
--

LOCK TABLES `desafio` WRITE;
/*!40000 ALTER TABLE `desafio` DISABLE KEYS */;
INSERT INTO `desafio` VALUES (1,1,'Ginásio 1','ginasio'),(2,2,'Ginásio 2','ginasio'),(3,3,'Ginásio 3','ginasio'),(4,4,'Ginásio 4','ginasio'),(5,5,'Ex-Campeão','final'),(6,6,'Rival','rival');
/*!40000 ALTER TABLE `desafio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `desafio_pokemon`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `desafio_pokemon` (
  `id_desafio_pokemon` int(11) NOT NULL AUTO_INCREMENT,
  `id_desafio` int(11) NOT NULL,
  `id_pokemon_especie` int(11) NOT NULL,
  `id_held_item` int(11) DEFAULT NULL,
  `nivel` int(11) NOT NULL,
  `ordem` int(11) NOT NULL,
  PRIMARY KEY (`id_desafio_pokemon`),
  UNIQUE KEY `uq_desafio_ordem` (`id_desafio`,`ordem`),
  KEY `fk_desafio_pokemon_especie` (`id_pokemon_especie`),
  KEY `fk_desafio_pokemon_held_item` (`id_held_item`),
  CONSTRAINT `fk_desafio_pokemon_desafio` FOREIGN KEY (`id_desafio`) REFERENCES `desafio` (`id_desafio`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_desafio_pokemon_especie` FOREIGN KEY (`id_pokemon_especie`) REFERENCES `pokemon_especie` (`id_pokemon_especie`) ON UPDATE CASCADE,
  CONSTRAINT `fk_desafio_pokemon_held_item` FOREIGN KEY (`id_held_item`) REFERENCES `held_item` (`id_held_item`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `chk_desafio_pokemon_nivel` CHECK (`nivel` between 1 and 100),
  CONSTRAINT `chk_desafio_pokemon_ordem` CHECK (`ordem` >= 1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `desafio_pokemon`
--

LOCK TABLES `desafio_pokemon` WRITE;
/*!40000 ALTER TABLE `desafio_pokemon` DISABLE KEYS */;
/*!40000 ALTER TABLE `desafio_pokemon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evolucao`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evolucao` (
  `id_evolucao` int(11) NOT NULL AUTO_INCREMENT,
  `id_item` int(11) NOT NULL,
  `id_pokemon_origem` int(11) NOT NULL,
  `id_pokemon_destino` int(11) NOT NULL,
  PRIMARY KEY (`id_evolucao`),
  UNIQUE KEY `uq_evolucao` (`id_item`,`id_pokemon_origem`),
  KEY `fk_evolucao_origem` (`id_pokemon_origem`),
  KEY `fk_evolucao_destino` (`id_pokemon_destino`),
  CONSTRAINT `fk_evolucao_destino` FOREIGN KEY (`id_pokemon_destino`) REFERENCES `pokemon_especie` (`id_pokemon_especie`) ON UPDATE CASCADE,
  CONSTRAINT `fk_evolucao_item` FOREIGN KEY (`id_item`) REFERENCES `item` (`id_item`) ON UPDATE CASCADE,
  CONSTRAINT `fk_evolucao_origem` FOREIGN KEY (`id_pokemon_origem`) REFERENCES `pokemon_especie` (`id_pokemon_especie`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evolucao`
--

LOCK TABLES `evolucao` WRITE;
/*!40000 ALTER TABLE `evolucao` DISABLE KEYS */;
/*!40000 ALTER TABLE `evolucao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `golpe`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `golpe` (
  `id_golpe` int(11) NOT NULL AUTO_INCREMENT,
  `api_id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `id_tipo` int(11) NOT NULL,
  `categoria` varchar(20) NOT NULL,
  `poder` int(11) DEFAULT NULL,
  `precisao` int(11) DEFAULT NULL,
  `pp` int(11) DEFAULT NULL,
  `prioridade` int(11) NOT NULL DEFAULT 0,
  `descricao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_golpe`),
  UNIQUE KEY `api_id` (`api_id`),
  UNIQUE KEY `nome` (`nome`),
  KEY `fk_golpe_tipo` (`id_tipo`),
  CONSTRAINT `fk_golpe_tipo` FOREIGN KEY (`id_tipo`) REFERENCES `tipo` (`id_tipo`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `golpe`
--

LOCK TABLES `golpe` WRITE;
/*!40000 ALTER TABLE `golpe` DISABLE KEYS */;
/*!40000 ALTER TABLE `golpe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `golpe_efeito`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `golpe_efeito` (
  `id_golpe_efeito` int(11) NOT NULL AUTO_INCREMENT,
  `id_golpe` int(11) NOT NULL,
  `tipo_efeito` varchar(30) NOT NULL,
  `id_status` int(11) DEFAULT NULL,
  `atributo` varchar(30) DEFAULT NULL,
  `alteracao` int(11) DEFAULT NULL,
  `chance` int(11) NOT NULL DEFAULT 100,
  PRIMARY KEY (`id_golpe_efeito`),
  KEY `fk_golpe_efeito_golpe` (`id_golpe`),
  KEY `fk_golpe_efeito_status` (`id_status`),
  CONSTRAINT `fk_golpe_efeito_golpe` FOREIGN KEY (`id_golpe`) REFERENCES `golpe` (`id_golpe`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_golpe_efeito_status` FOREIGN KEY (`id_status`) REFERENCES `status_pokemon` (`id_status`) ON UPDATE CASCADE,
  CONSTRAINT `chk_golpe_efeito_chance` CHECK (`chance` between 0 and 100)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `golpe_efeito`
--

LOCK TABLES `golpe_efeito` WRITE;
/*!40000 ALTER TABLE `golpe_efeito` DISABLE KEYS */;
/*!40000 ALTER TABLE `golpe_efeito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `held_item`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `held_item` (
  `id_held_item` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `tipo_efeito` varchar(30) NOT NULL,
  `base_calculo` varchar(30) NOT NULL,
  `numerador` int(11) NOT NULL,
  `denominador` int(11) NOT NULL,
  `gatilho` varchar(30) NOT NULL,
  `limiar_hp` int(11) DEFAULT NULL,
  `descricao` varchar(255) NOT NULL,
  `consumivel` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_held_item`),
  UNIQUE KEY `nome` (`nome`),
  CONSTRAINT `chk_held_tipo` CHECK (`tipo_efeito` = 'CURA_HP'),
  CONSTRAINT `chk_held_base` CHECK (`base_calculo` in ('HP_MAXIMO','DANO_CAUSADO')),
  CONSTRAINT `chk_held_numerador` CHECK (`numerador` > 0),
  CONSTRAINT `chk_held_denominador` CHECK (`denominador` > 0),
  CONSTRAINT `chk_held_limiar_hp` CHECK (`limiar_hp` is null or `limiar_hp` between 0 and 100)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `held_item`
--

LOCK TABLES `held_item` WRITE;
/*!40000 ALTER TABLE `held_item` DISABLE KEYS */;
INSERT INTO `held_item` VALUES (1,'Leftovers','CURA_HP','HP_MAXIMO',1,16,'FINAL_TURNO',NULL,'Recupera 1/16 do HP máximo ao final do turno.',0),(2,'Shell Bell','CURA_HP','DANO_CAUSADO',1,8,'CAUSAR_DANO',NULL,'Recupera 1/8 do dano causado.',0),(3,'Oran Berry','CURA_HP','HP_MAXIMO',10,100,'CONDICAO_HP',70,'Recupera 10% do HP máximo.',1),(4,'Sitrus Berry','CURA_HP','HP_MAXIMO',25,100,'CONDICAO_HP',50,'Recupera 25% do HP máximo.',1);
/*!40000 ALTER TABLE `held_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventario` (
  `id_perfil` int(11) NOT NULL,
  `id_item` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_perfil`,`id_item`),
  KEY `fk_inventario_item` (`id_item`),
  CONSTRAINT `fk_inventario_item` FOREIGN KEY (`id_item`) REFERENCES `item` (`id_item`) ON UPDATE CASCADE,
  CONSTRAINT `fk_inventario_perfil` FOREIGN KEY (`id_perfil`) REFERENCES `perfil` (`id_perfil`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario`
--

LOCK TABLES `inventario` WRITE;
/*!40000 ALTER TABLE `inventario` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item` (
  `id_item` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `categoria` varchar(30) NOT NULL,
  `preco` int(11) NOT NULL,
  `valor_efeito` int(11) DEFAULT NULL,
  `descricao` varchar(255) NOT NULL,
  `tipo_efeito` varchar(20) NOT NULL,
  PRIMARY KEY (`id_item`),
  UNIQUE KEY `nome` (`nome`),
  CONSTRAINT `chk_item_preco` CHECK (`preco` >= 0),
  CONSTRAINT `chk_item_tipo_efeito` CHECK (`tipo_efeito` in ('ABSOLUTO','PERCENTUAL','STATUS')),
  CONSTRAINT `chk_item_categoria` CHECK (`categoria` in ('HP','HP_STATUS','STATUS','REVIVE'))
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (1,'Potion','HP',300,20,'Recupera 20 HP.','ABSOLUTO'),(2,'Super Potion','HP',700,50,'Recupera 50 HP.','ABSOLUTO'),(3,'Hyper Potion','HP',1200,200,'Recupera 200 HP.','ABSOLUTO'),(4,'Max Potion','HP',2500,100,'Recupera 100% do HP.','PERCENTUAL'),(5,'Full Restore','HP_STATUS',3000,100,'Recupera 100% do HP e cura todas as condições de status.','PERCENTUAL'),(6,'Antidote','STATUS',100,NULL,'Cura envenenamento.','STATUS'),(7,'Burn Heal','STATUS',100,NULL,'Cura queimadura.','STATUS'),(8,'Ice Heal','STATUS',100,NULL,'Cura congelamento.','STATUS'),(9,'Awakening','STATUS',100,NULL,'Cura sono.','STATUS'),(10,'Paralyze Heal','STATUS',100,NULL,'Cura paralisia.','STATUS'),(11,'Full Heal','STATUS',300,NULL,'Cura todas as condições de status.','STATUS'),(12,'Revive','REVIVE',2000,50,'Revive um Pokémon desmaiado com 50% do HP máximo.','PERCENTUAL');
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_status_cura`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_status_cura` (
  `id_item` int(11) NOT NULL,
  `id_status` int(11) NOT NULL,
  PRIMARY KEY (`id_item`,`id_status`),
  KEY `fk_isc_status` (`id_status`),
  CONSTRAINT `fk_isc_item` FOREIGN KEY (`id_item`) REFERENCES `item` (`id_item`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_isc_status` FOREIGN KEY (`id_status`) REFERENCES `status_pokemon` (`id_status`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_status_cura`
--

LOCK TABLES `item_status_cura` WRITE;
/*!40000 ALTER TABLE `item_status_cura` DISABLE KEYS */;
INSERT INTO `item_status_cura` VALUES (5,1),(5,2),(5,3),(5,4),(5,5),(6,1),(7,2),(8,3),(9,4),(10,5),(11,1),(11,2),(11,3),(11,4),(11,5);
/*!40000 ALTER TABLE `item_status_cura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `perfil`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perfil` (
  `id_perfil` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `dinheiro` int(11) NOT NULL DEFAULT 0,
  `criado_em` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_perfil`),
  UNIQUE KEY `uq_usuario_nome_perfil` (`id_usuario`,`nome`),
  CONSTRAINT `fk_perfil_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chk_perfil_dinheiro` CHECK (`dinheiro` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perfil`
--

LOCK TABLES `perfil` WRITE;
/*!40000 ALTER TABLE `perfil` DISABLE KEYS */;
/*!40000 ALTER TABLE `perfil` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `perfil_log`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perfil_log` (
  `id_perfil_log` int(11) NOT NULL AUTO_INCREMENT,
  `id_perfil` int(11) NOT NULL,
  `acao` varchar(50) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `detalhes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`detalhes`)),
  `criado_em` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_perfil_log`),
  KEY `fk_perfil_log_perfil` (`id_perfil`),
  CONSTRAINT `fk_perfil_log_perfil` FOREIGN KEY (`id_perfil`) REFERENCES `perfil` (`id_perfil`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perfil_log`
--

LOCK TABLES `perfil_log` WRITE;
/*!40000 ALTER TABLE `perfil_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `perfil_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pokemon_especie`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pokemon_especie` (
  `id_pokemon_especie` int(11) NOT NULL AUTO_INCREMENT,
  `api_id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `hp_base` int(11) NOT NULL,
  `ataque_base` int(11) NOT NULL,
  `defesa_base` int(11) NOT NULL,
  `ataque_especial_base` int(11) NOT NULL,
  `defesa_especial_base` int(11) NOT NULL,
  `velocidade_base` int(11) NOT NULL,
  `imagem_url` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id_pokemon_especie`),
  UNIQUE KEY `api_id` (`api_id`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pokemon_especie`
--

LOCK TABLES `pokemon_especie` WRITE;
/*!40000 ALTER TABLE `pokemon_especie` DISABLE KEYS */;
/*!40000 ALTER TABLE `pokemon_especie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pokemon_especie_golpe`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pokemon_especie_golpe` (
  `id_pokemon_especie` int(11) NOT NULL,
  `id_golpe` int(11) NOT NULL,
  `slot` int(11) NOT NULL,
  PRIMARY KEY (`id_pokemon_especie`,`id_golpe`),
  UNIQUE KEY `uq_pokemon_slot` (`id_pokemon_especie`,`slot`),
  KEY `fk_peg_golpe` (`id_golpe`),
  CONSTRAINT `fk_peg_golpe` FOREIGN KEY (`id_golpe`) REFERENCES `golpe` (`id_golpe`) ON UPDATE CASCADE,
  CONSTRAINT `fk_peg_pokemon` FOREIGN KEY (`id_pokemon_especie`) REFERENCES `pokemon_especie` (`id_pokemon_especie`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chk_pokemon_slot` CHECK (`slot` between 1 and 3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pokemon_especie_golpe`
--

LOCK TABLES `pokemon_especie_golpe` WRITE;
/*!40000 ALTER TABLE `pokemon_especie_golpe` DISABLE KEYS */;
/*!40000 ALTER TABLE `pokemon_especie_golpe` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_validar_golpe_pokemon
BEFORE INSERT ON pokemon_especie_golpe
FOR EACH ROW
BEGIN
    DECLARE v_categoria VARCHAR(20);

    SELECT categoria
    INTO v_categoria
    FROM golpe
    WHERE id_golpe = NEW.id_golpe;

    IF NEW.slot IN (1, 2) AND v_categoria <> 'DANO' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Os slots 1 e 2 devem conter golpes de dano.';
    END IF;

    IF NEW.slot = 3 AND v_categoria <> 'STATUS' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O slot 3 deve conter um golpe de status.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_validar_golpe_pokemon_update
BEFORE UPDATE ON pokemon_especie_golpe
FOR EACH ROW
BEGIN
    DECLARE v_categoria VARCHAR(20);

    SELECT categoria
    INTO v_categoria
    FROM golpe
    WHERE id_golpe = NEW.id_golpe;

    IF NEW.slot IN (1, 2) AND v_categoria <> 'DANO' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Os slots 1 e 2 devem conter golpes de dano.';
    END IF;

    IF NEW.slot = 3 AND v_categoria <> 'STATUS' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O slot 3 deve conter um golpe de status.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pokemon_especie_tipo`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pokemon_especie_tipo` (
  `id_pokemon_especie` int(11) NOT NULL,
  `id_tipo` int(11) NOT NULL,
  PRIMARY KEY (`id_pokemon_especie`,`id_tipo`),
  KEY `fk_pet_tipo` (`id_tipo`),
  CONSTRAINT `fk_pet_pokemon` FOREIGN KEY (`id_pokemon_especie`) REFERENCES `pokemon_especie` (`id_pokemon_especie`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_pet_tipo` FOREIGN KEY (`id_tipo`) REFERENCES `tipo` (`id_tipo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pokemon_especie_tipo`
--

LOCK TABLES `pokemon_especie_tipo` WRITE;
/*!40000 ALTER TABLE `pokemon_especie_tipo` DISABLE KEYS */;
/*!40000 ALTER TABLE `pokemon_especie_tipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pokemon_time`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pokemon_time` (
  `id_pokemon_time` int(11) NOT NULL AUTO_INCREMENT,
  `id_perfil` int(11) NOT NULL,
  `id_pokemon_especie` int(11) NOT NULL,
  `id_held_item` int(11) DEFAULT NULL,
  `apelido` varchar(50) DEFAULT NULL,
  `nivel` int(11) NOT NULL DEFAULT 1,
  `hp_max` int(11) NOT NULL,
  `hp_atual` int(11) NOT NULL,
  `ataque` int(11) NOT NULL,
  `defesa` int(11) NOT NULL,
  `ataque_especial` int(11) NOT NULL,
  `defesa_especial` int(11) NOT NULL,
  `velocidade` int(11) NOT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'normal',
  `posicao` int(11) NOT NULL,
  PRIMARY KEY (`id_pokemon_time`),
  UNIQUE KEY `uq_perfil_posicao` (`id_perfil`,`posicao`),
  KEY `fk_time_especie` (`id_pokemon_especie`),
  KEY `fk_pokemon_time_held_item` (`id_held_item`),
  CONSTRAINT `fk_pokemon_time_held_item` FOREIGN KEY (`id_held_item`) REFERENCES `held_item` (`id_held_item`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_time_especie` FOREIGN KEY (`id_pokemon_especie`) REFERENCES `pokemon_especie` (`id_pokemon_especie`) ON UPDATE CASCADE,
  CONSTRAINT `fk_time_perfil` FOREIGN KEY (`id_perfil`) REFERENCES `perfil` (`id_perfil`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chk_pokemon_posicao` CHECK (`posicao` between 1 and 6),
  CONSTRAINT `chk_pokemon_nivel` CHECK (`nivel` between 1 and 100),
  CONSTRAINT `chk_pokemon_hp_max` CHECK (`hp_max` >= 0),
  CONSTRAINT `chk_pokemon_hp_atual` CHECK (`hp_atual` >= 0 and `hp_atual` <= `hp_max`),
  CONSTRAINT `chk_pokemon_ataque` CHECK (`ataque` >= 0),
  CONSTRAINT `chk_pokemon_defesa` CHECK (`defesa` >= 0),
  CONSTRAINT `chk_pokemon_ataque_especial` CHECK (`ataque_especial` >= 0),
  CONSTRAINT `chk_pokemon_defesa_especial` CHECK (`defesa_especial` >= 0),
  CONSTRAINT `chk_pokemon_velocidade` CHECK (`velocidade` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pokemon_time`
--

LOCK TABLES `pokemon_time` WRITE;
/*!40000 ALTER TABLE `pokemon_time` DISABLE KEYS */;
/*!40000 ALTER TABLE `pokemon_time` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `progresso_desafio`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `progresso_desafio` (
  `id_perfil` int(11) NOT NULL,
  `id_desafio` int(11) NOT NULL,
  `concluido` tinyint(1) NOT NULL DEFAULT 0,
  `concluido_em` datetime DEFAULT NULL,
  PRIMARY KEY (`id_perfil`,`id_desafio`),
  KEY `fk_progresso_desafio` (`id_desafio`),
  CONSTRAINT `fk_progresso_desafio` FOREIGN KEY (`id_desafio`) REFERENCES `desafio` (`id_desafio`) ON UPDATE CASCADE,
  CONSTRAINT `fk_progresso_perfil` FOREIGN KEY (`id_perfil`) REFERENCES `perfil` (`id_perfil`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `progresso_desafio`
--

LOCK TABLES `progresso_desafio` WRITE;
/*!40000 ALTER TABLE `progresso_desafio` DISABLE KEYS */;
/*!40000 ALTER TABLE `progresso_desafio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status_pokemon`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `status_pokemon` (
  `id_status` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(30) NOT NULL,
  PRIMARY KEY (`id_status`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status_pokemon`
--

LOCK TABLES `status_pokemon` WRITE;
/*!40000 ALTER TABLE `status_pokemon` DISABLE KEYS */;
INSERT INTO `status_pokemon` VALUES (3,'Congelamento'),(1,'Envenenamento'),(5,'Paralisia'),(2,'Queimadura'),(4,'Sono');
/*!40000 ALTER TABLE `status_pokemon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo` (
  `id_tipo` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(30) NOT NULL,
  `api_nome` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id_tipo`),
  UNIQUE KEY `nome` (`nome`),
  UNIQUE KEY `api_nome` (`api_nome`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo`
--

LOCK TABLES `tipo` WRITE;
/*!40000 ALTER TABLE `tipo` DISABLE KEYS */;
INSERT INTO `tipo` VALUES (1,'Normal','normal'),(2,'Fogo','fire'),(3,'Eletrico','electric'),(4,'Agua','water'),(5,'Grama','grass'),(6,'Lutador','fighting'),(7,'Aco','steel'),(8,'Psiquico','psychic'),(9,'Sombrio','dark'),(10,'Dragao','dragon'),(11,'Gelo','ice'),(12,'Veneno','poison'),(13,'Fantasma','ghost'),(14,'Inseto','bug'),(15,'Voador','flying'),(16,'Pedra','rock'),(17,'Terra','ground'),(18,'Fada','fairy');
/*!40000 ALTER TABLE `tipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_efetividade`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_efetividade` (
  `id_tipo_atacante` int(11) NOT NULL,
  `id_tipo_defensor` int(11) NOT NULL,
  `multiplicador` decimal(3,2) NOT NULL,
  PRIMARY KEY (`id_tipo_atacante`,`id_tipo_defensor`),
  KEY `fk_efetividade_defensor` (`id_tipo_defensor`),
  CONSTRAINT `fk_efetividade_atacante` FOREIGN KEY (`id_tipo_atacante`) REFERENCES `tipo` (`id_tipo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_efetividade_defensor` FOREIGN KEY (`id_tipo_defensor`) REFERENCES `tipo` (`id_tipo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chk_efetividade_multiplicador` CHECK (`multiplicador` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_efetividade`
--

LOCK TABLES `tipo_efetividade` WRITE;
/*!40000 ALTER TABLE `tipo_efetividade` DISABLE KEYS */;
INSERT INTO `tipo_efetividade` VALUES (1,1,1.00),(1,2,1.00),(1,3,1.00),(1,4,1.00),(1,5,1.00),(1,6,1.00),(1,7,0.50),(1,8,1.00),(1,9,1.00),(1,10,1.00),(1,11,1.00),(1,12,1.00),(1,13,0.00),(1,14,1.00),(1,15,1.00),(1,16,0.50),(1,17,1.00),(1,18,1.00),(2,1,1.00),(2,2,0.50),(2,3,1.00),(2,4,0.50),(2,5,2.00),(2,6,1.00),(2,7,2.00),(2,8,1.00),(2,9,1.00),(2,10,0.50),(2,11,2.00),(2,12,1.00),(2,13,1.00),(2,14,2.00),(2,15,1.00),(2,16,0.50),(2,17,1.00),(2,18,1.00),(3,1,1.00),(3,2,1.00),(3,3,0.50),(3,4,2.00),(3,5,0.50),(3,6,1.00),(3,7,1.00),(3,8,1.00),(3,9,1.00),(3,10,0.50),(3,11,1.00),(3,12,1.00),(3,13,1.00),(3,14,1.00),(3,15,2.00),(3,16,1.00),(3,17,0.00),(3,18,1.00),(4,1,1.00),(4,2,2.00),(4,3,1.00),(4,4,0.50),(4,5,0.50),(4,6,1.00),(4,7,1.00),(4,8,1.00),(4,9,1.00),(4,10,0.50),(4,11,1.00),(4,12,1.00),(4,13,1.00),(4,14,1.00),(4,15,1.00),(4,16,2.00),(4,17,2.00),(4,18,1.00),(5,1,1.00),(5,2,0.50),(5,3,1.00),(5,4,2.00),(5,5,0.50),(5,6,1.00),(5,7,0.50),(5,8,1.00),(5,9,1.00),(5,10,0.50),(5,11,1.00),(5,12,0.50),(5,13,1.00),(5,14,0.50),(5,15,0.50),(5,16,2.00),(5,17,2.00),(5,18,1.00),(6,1,2.00),(6,2,1.00),(6,3,1.00),(6,4,1.00),(6,5,1.00),(6,6,1.00),(6,7,2.00),(6,8,0.50),(6,9,2.00),(6,10,1.00),(6,11,2.00),(6,12,0.50),(6,13,0.00),(6,14,0.50),(6,15,0.50),(6,16,2.00),(6,17,1.00),(6,18,0.50),(7,1,1.00),(7,2,0.50),(7,3,0.50),(7,4,0.50),(7,5,1.00),(7,6,1.00),(7,7,0.50),(7,8,1.00),(7,9,1.00),(7,10,1.00),(7,11,2.00),(7,12,1.00),(7,13,1.00),(7,14,1.00),(7,15,1.00),(7,16,2.00),(7,17,1.00),(7,18,2.00),(8,1,1.00),(8,2,1.00),(8,3,1.00),(8,4,1.00),(8,5,1.00),(8,6,2.00),(8,7,0.50),(8,8,0.50),(8,9,0.00),(8,10,1.00),(8,11,1.00),(8,12,2.00),(8,13,1.00),(8,14,1.00),(8,15,1.00),(8,16,1.00),(8,17,1.00),(8,18,1.00),(9,1,1.00),(9,2,1.00),(9,3,1.00),(9,4,1.00),(9,5,1.00),(9,6,0.50),(9,7,1.00),(9,8,2.00),(9,9,0.50),(9,10,1.00),(9,11,1.00),(9,12,1.00),(9,13,2.00),(9,14,1.00),(9,15,1.00),(9,16,1.00),(9,17,1.00),(9,18,0.50),(10,1,1.00),(10,2,1.00),(10,3,1.00),(10,4,1.00),(10,5,1.00),(10,6,1.00),(10,7,0.50),(10,8,1.00),(10,9,1.00),(10,10,2.00),(10,11,1.00),(10,12,1.00),(10,13,1.00),(10,14,1.00),(10,15,1.00),(10,16,1.00),(10,17,1.00),(10,18,0.00),(11,1,1.00),(11,2,0.50),(11,3,1.00),(11,4,0.50),(11,5,2.00),(11,6,1.00),(11,7,0.50),(11,8,1.00),(11,9,1.00),(11,10,2.00),(11,11,0.50),(11,12,1.00),(11,13,1.00),(11,14,1.00),(11,15,2.00),(11,16,1.00),(11,17,2.00),(11,18,1.00),(12,1,1.00),(12,2,1.00),(12,3,1.00),(12,4,1.00),(12,5,2.00),(12,6,1.00),(12,7,0.00),(12,8,1.00),(12,9,1.00),(12,10,1.00),(12,11,1.00),(12,12,0.50),(12,13,0.50),(12,14,1.00),(12,15,1.00),(12,16,0.50),(12,17,0.50),(12,18,2.00),(13,1,0.00),(13,2,1.00),(13,3,1.00),(13,4,1.00),(13,5,1.00),(13,6,1.00),(13,7,1.00),(13,8,2.00),(13,9,0.50),(13,10,1.00),(13,11,1.00),(13,12,1.00),(13,13,2.00),(13,14,1.00),(13,15,1.00),(13,16,1.00),(13,17,1.00),(13,18,1.00),(14,1,1.00),(14,2,0.50),(14,3,1.00),(14,4,1.00),(14,5,2.00),(14,6,0.50),(14,7,0.50),(14,8,2.00),(14,9,2.00),(14,10,1.00),(14,11,1.00),(14,12,0.50),(14,13,0.50),(14,14,1.00),(14,15,0.50),(14,16,1.00),(14,17,1.00),(14,18,0.50),(15,1,1.00),(15,2,1.00),(15,3,0.50),(15,4,1.00),(15,5,2.00),(15,6,2.00),(15,7,0.50),(15,8,1.00),(15,9,1.00),(15,10,1.00),(15,11,1.00),(15,12,1.00),(15,13,1.00),(15,14,2.00),(15,15,1.00),(15,16,0.50),(15,17,1.00),(15,18,1.00),(16,1,1.00),(16,2,2.00),(16,3,1.00),(16,4,1.00),(16,5,1.00),(16,6,0.50),(16,7,0.50),(16,8,1.00),(16,9,1.00),(16,10,1.00),(16,11,2.00),(16,12,1.00),(16,13,1.00),(16,14,2.00),(16,15,2.00),(16,16,1.00),(16,17,0.50),(16,18,1.00),(17,1,1.00),(17,2,2.00),(17,3,2.00),(17,4,1.00),(17,5,0.50),(17,6,1.00),(17,7,2.00),(17,8,1.00),(17,9,1.00),(17,10,1.00),(17,11,1.00),(17,12,2.00),(17,13,1.00),(17,14,0.50),(17,15,0.00),(17,16,2.00),(17,17,1.00),(17,18,1.00),(18,1,1.00),(18,2,0.50),(18,3,1.00),(18,4,1.00),(18,5,1.00),(18,6,2.00),(18,7,0.50),(18,8,1.00),(18,9,2.00),(18,10,2.00),(18,11,1.00),(18,12,0.50),(18,13,1.00),(18,14,1.00),(18,15,1.00),(18,16,1.00),(18,17,1.00),(18,18,1.00);
/*!40000 ALTER TABLE `tipo_efetividade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nome_usuario` varchar(50) NOT NULL,
  `senha_hash` varchar(255) NOT NULL,
  `criado_em` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `nome_usuario` (`nome_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'monstrobouso'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-05 16:53:11
