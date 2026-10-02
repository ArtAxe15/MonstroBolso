/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.7.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: monstrobouso
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `batalha_log`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = utf8mb4 */;
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
  PRIMARY KEY (`id_batalha_pokemon`),
  UNIQUE KEY `uq_batalha_lado_ordem` (`id_batalha`,`lado`,`ordem`),
  KEY `fk_batalha_pokemon_time` (`id_pokemon_time`),
  KEY `fk_batalha_pokemon_especie` (`id_pokemon_especie`),
  KEY `fk_batalha_pokemon_status` (`id_status_final`),
  CONSTRAINT `fk_batalha_pokemon_batalha` FOREIGN KEY (`id_batalha`) REFERENCES `batalha_log` (`id_batalha`) ON DELETE CASCADE,
  CONSTRAINT `fk_batalha_pokemon_especie` FOREIGN KEY (`id_pokemon_especie`) REFERENCES `pokemon_especie` (`id_pokemon_especie`) ON UPDATE CASCADE,
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
/*!40101 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = utf8mb4 */;
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
INSERT INTO `desafio` VALUES
(1,1,'Ginásio 1','ginasio'),
(2,2,'Ginásio 2','ginasio'),
(3,3,'Ginásio 3','ginasio'),
(4,4,'Ginásio 4','ginasio'),
(5,5,'Ex-Campeão','final'),
(6,6,'Rival','rival');
/*!40000 ALTER TABLE `desafio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `desafio_pokemon`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = utf8mb4 */;
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
-- Table structure for table `held_item`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
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
INSERT INTO `held_item` VALUES
(1,'Leftovers','CURA_HP','HP_MAXIMO',1,16,'FINAL_TURNO',NULL,'Recupera 1/16 do HP máximo ao final do turno.',0),
(2,'Shell Bell','CURA_HP','DANO_CAUSADO',1,8,'CAUSAR_DANO',NULL,'Recupera 1/8 do dano causado.',0),
(3,'Oran Berry','CURA_HP','HP_MAXIMO',10,100,'CONDICAO_HP',70,'Recupera 10% do HP máximo.',1),
(4,'Sitrus Berry','CURA_HP','HP_MAXIMO',25,100,'CONDICAO_HP',50,'Recupera 25% do HP máximo.',1);
/*!40000 ALTER TABLE `held_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = utf8mb4 */;
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
INSERT INTO `item` VALUES
(1,'Potion','HP',300,20,'Recupera 20 HP.','ABSOLUTO'),
(2,'Super Potion','HP',700,50,'Recupera 50 HP.','ABSOLUTO'),
(3,'Hyper Potion','HP',1200,200,'Recupera 200 HP.','ABSOLUTO'),
(4,'Max Potion','HP',2500,100,'Recupera 100% do HP.','PERCENTUAL'),
(5,'Full Restore','HP_STATUS',3000,100,'Recupera 100% do HP e cura todas as condições de status.','PERCENTUAL'),
(6,'Antidote','STATUS',100,NULL,'Cura envenenamento.','STATUS'),
(7,'Burn Heal','STATUS',100,NULL,'Cura queimadura.','STATUS'),
(8,'Ice Heal','STATUS',100,NULL,'Cura congelamento.','STATUS'),
(9,'Awakening','STATUS',100,NULL,'Cura sono.','STATUS'),
(10,'Paralyze Heal','STATUS',100,NULL,'Cura paralisia.','STATUS'),
(11,'Full Heal','STATUS',300,NULL,'Cura todas as condições de status.','STATUS'),
(12,'Revive','REVIVE',2000,50,'Revive um Pokémon desmaiado com 50% do HP máximo.','PERCENTUAL');
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_status_cura`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
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
INSERT INTO `item_status_cura` VALUES
(5,1),
(5,2),
(5,3),
(5,4),
(5,5),
(6,1),
(7,2),
(8,3),
(9,4),
(10,5),
(11,1),
(11,2),
(11,3),
(11,4),
(11,5);
/*!40000 ALTER TABLE `item_status_cura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `perfil`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pokemon_especie_golpe` (
  `id_pokemon_especie` int(11) NOT NULL,
  `id_golpe` int(11) NOT NULL,
  `slot` int(11) NOT NULL,
  PRIMARY KEY (`id_pokemon_especie`,`id_golpe`),
  UNIQUE KEY `uq_pokemon_slot` (`id_pokemon_especie`,`slot`),
  KEY `fk_peg_golpe` (`id_golpe`),
  CONSTRAINT `fk_peg_golpe` FOREIGN KEY (`id_golpe`) REFERENCES `golpe` (`id_golpe`) ON UPDATE CASCADE,
  CONSTRAINT `fk_peg_pokemon` FOREIGN KEY (`id_pokemon_especie`) REFERENCES `pokemon_especie` (`id_pokemon_especie`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chk_pokemon_slot` CHECK (`slot` between 1 and 2)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pokemon_especie_golpe`
--

LOCK TABLES `pokemon_especie_golpe` WRITE;
/*!40000 ALTER TABLE `pokemon_especie_golpe` DISABLE KEYS */;
/*!40000 ALTER TABLE `pokemon_especie_golpe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pokemon_especie_tipo`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = utf8mb4 */;
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
INSERT INTO `status_pokemon` VALUES
(3,'Congelamento'),
(1,'Envenenamento'),
(5,'Paralisia'),
(2,'Queimadura'),
(4,'Sono');
/*!40000 ALTER TABLE `status_pokemon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo` (
  `id_tipo` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(30) NOT NULL,
  PRIMARY KEY (`id_tipo`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo`
--

LOCK TABLES `tipo` WRITE;
/*!40000 ALTER TABLE `tipo` DISABLE KEYS */;
INSERT INTO `tipo` VALUES
(7,'Aco'),
(4,'Agua'),
(10,'Dragao'),
(3,'Eletrico'),
(18,'Fada'),
(13,'Fantasma'),
(2,'Fogo'),
(11,'Gelo'),
(5,'Grama'),
(14,'Inseto'),
(6,'Lutador'),
(1,'Normal'),
(16,'Pedra'),
(8,'Psiquico'),
(9,'Sombrio'),
(17,'Terra'),
(12,'Veneno'),
(15,'Voador');
/*!40000 ALTER TABLE `tipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
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
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-10-02 14:50:54
