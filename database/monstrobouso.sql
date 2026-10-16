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
  `id_golpe_status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_desafio_pokemon`),
  UNIQUE KEY `uq_desafio_ordem` (`id_desafio`,`ordem`),
  KEY `fk_desafio_pokemon_especie` (`id_pokemon_especie`),
  KEY `fk_desafio_pokemon_held_item` (`id_held_item`),
  KEY `fk_desafio_pokemon_golpe_status` (`id_golpe_status`),
  CONSTRAINT `fk_desafio_pokemon_desafio` FOREIGN KEY (`id_desafio`) REFERENCES `desafio` (`id_desafio`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_desafio_pokemon_especie` FOREIGN KEY (`id_pokemon_especie`) REFERENCES `pokemon_especie` (`id_pokemon_especie`) ON UPDATE CASCADE,
  CONSTRAINT `fk_desafio_pokemon_golpe_status` FOREIGN KEY (`id_golpe_status`) REFERENCES `golpe` (`id_golpe`) ON DELETE SET NULL ON UPDATE CASCADE,
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
  `id_item` int(11) DEFAULT NULL,
  `metodo_evolucao` varchar(10) NOT NULL DEFAULT 'ITEM',
  `nivel_requisito` int(11) DEFAULT NULL,
  `api_trigger` varchar(30) DEFAULT NULL,
  `id_pokemon_origem` int(11) NOT NULL,
  `id_pokemon_destino` int(11) NOT NULL,
  PRIMARY KEY (`id_evolucao`),
  UNIQUE KEY `uq_evolucao_origem_destino` (`id_pokemon_origem`,`id_pokemon_destino`),
  KEY `fk_evolucao_origem` (`id_pokemon_origem`),
  KEY `fk_evolucao_destino` (`id_pokemon_destino`),
  KEY `idx_evolucao_item` (`id_item`),
  CONSTRAINT `fk_evolucao_destino` FOREIGN KEY (`id_pokemon_destino`) REFERENCES `pokemon_especie` (`id_pokemon_especie`) ON UPDATE CASCADE,
  CONSTRAINT `fk_evolucao_item` FOREIGN KEY (`id_item`) REFERENCES `item` (`id_item`) ON UPDATE CASCADE,
  CONSTRAINT `fk_evolucao_origem` FOREIGN KEY (`id_pokemon_origem`) REFERENCES `pokemon_especie` (`id_pokemon_especie`) ON UPDATE CASCADE,
  CONSTRAINT `chk_evolucao_metodo` CHECK (`metodo_evolucao` in ('NIVEL','ITEM')),
  CONSTRAINT `chk_evolucao_requisito` CHECK (`metodo_evolucao` = 'NIVEL' and `nivel_requisito` between 1 and 100 and `id_item` is null or `metodo_evolucao` = 'ITEM' and `nivel_requisito` is null and `id_item` is not null)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evolucao`
--

LOCK TABLES `evolucao` WRITE;
/*!40000 ALTER TABLE `evolucao` DISABLE KEYS */;
INSERT INTO `evolucao` VALUES
(1,NULL,'NIVEL',34,'level-up',82,83),
(2,NULL,'NIVEL',17,'level-up',16,17),
(3,NULL,'NIVEL',36,'level-up',17,18),
(6,NULL,'NIVEL',17,'level-up',19,20),
(7,NULL,'NIVEL',36,'level-up',20,21),
(8,NULL,'NIVEL',17,'level-up',22,23),
(9,NULL,'NIVEL',36,'level-up',23,24),
(12,NULL,'NIVEL',20,'level-up',25,26),
(13,NULL,'NIVEL',16,'level-up',27,28),
(14,NULL,'NIVEL',32,'level-up',28,29),
(15,NULL,'NIVEL',20,'level-up',30,31),
(16,13,'ITEM',NULL,'use-item',32,33),
(17,13,'ITEM',NULL,'use-item',34,35),
(18,13,'ITEM',NULL,'use-item',36,37),
(19,13,'ITEM',NULL,'use-item',38,39),
(20,NULL,'NIVEL',21,'level-up',40,41),
(21,NULL,'NIVEL',32,'level-up',41,42),
(24,NULL,'NIVEL',27,'level-up',43,44),
(25,NULL,'NIVEL',25,'level-up',45,46),
(26,13,'ITEM',NULL,'trade',46,47),
(29,13,'ITEM',NULL,'level-up',48,49),
(33,NULL,'NIVEL',31,'level-up',50,51),
(34,NULL,'NIVEL',25,'level-up',53,54),
(35,13,'ITEM',NULL,'trade',54,55),
(36,NULL,'NIVEL',25,'level-up',56,57),
(37,NULL,'NIVEL',36,'level-up',57,58),
(38,NULL,'NIVEL',20,'level-up',61,62),
(39,13,'ITEM',NULL,'level-up',62,63),
(40,NULL,'NIVEL',22,'level-up',64,65),
(41,NULL,'NIVEL',30,'level-up',65,66),
(42,13,'ITEM',NULL,'use-item',67,68),
(43,13,'ITEM',NULL,'use-item',69,70),
(46,NULL,'NIVEL',30,'level-up',84,73),
(50,NULL,'NIVEL',39,'level-up',85,86),
(52,NULL,'NIVEL',34,'level-up',88,89),
(56,NULL,'NIVEL',35,'take-damage',88,91),
(59,NULL,'NIVEL',37,'level-up',92,93),
(60,NULL,'NIVEL',52,'level-up',94,95),
(62,NULL,'NIVEL',60,'three-defeated-bisharp',95,96);
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
  `classe_dano` varchar(20) DEFAULT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_golpe`),
  UNIQUE KEY `api_id` (`api_id`),
  UNIQUE KEY `nome` (`nome`),
  KEY `fk_golpe_tipo` (`id_tipo`),
  CONSTRAINT `fk_golpe_tipo` FOREIGN KEY (`id_tipo`) REFERENCES `tipo` (`id_tipo`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `golpe`
--

LOCK TABLES `golpe` WRITE;
/*!40000 ALTER TABLE `golpe` DISABLE KEYS */;
INSERT INTO `golpe` VALUES
(1,34,'body-slam',1,'DANO',65,100,15,0,'PHYSICAL','Causa dano e tem 30% de chance de paralisar o oponente.'),
(2,351,'shock-wave',3,'DANO',65,NULL,20,0,'SPECIAL','Golpe especial do tipo Elétrico que causa dano.'),
(3,424,'fire-fang',2,'DANO',65,95,15,0,'PHYSICAL','Causa dano e tem 10% de chance de causar queimadura.'),
(4,352,'water-pulse',4,'DANO',65,100,20,0,'SPECIAL','Golpe especial do tipo Água que causa dano.'),
(5,72,'mega-drain',5,'DANO',65,100,15,0,'SPECIAL','Causa dano e recupera HP equivalente a 50% do dano causado.'),
(6,409,'drain-punch',6,'DANO',65,100,10,0,'PHYSICAL','Causa dano e recupera HP equivalente a 50% do dano causado.'),
(7,389,'sucker-punch',9,'DANO',65,100,5,1,'PHYSICAL','Golpe físico do tipo Sombrio com prioridade de execução 1.'),
(8,418,'bullet-punch',7,'DANO',65,100,30,1,'PHYSICAL','Golpe físico do tipo Aço com prioridade de execução 1.'),
(9,425,'shadow-sneak',13,'DANO',65,100,30,1,'PHYSICAL','Golpe físico do tipo Fantasma com prioridade de execução 1.'),
(10,450,'bug-bite',14,'DANO',65,100,20,0,'PHYSICAL','Golpe físico do tipo Inseto que causa dano.'),
(11,414,'earth-power',17,'DANO',65,100,10,0,'SPECIAL','Golpe especial do tipo Terra que causa dano.'),
(12,317,'rock-tomb',16,'DANO',65,95,15,0,'PHYSICAL','Golpe físico do tipo Pedra que causa dano.'),
(13,337,'dragon-claw',10,'DANO',65,100,15,0,'PHYSICAL','Golpe físico do tipo Dragão que causa dano.'),
(14,605,'dazzling-gleam',18,'DANO',65,100,10,0,'SPECIAL','Golpe especial do tipo Fada que causa dano.'),
(15,512,'acrobatics',15,'DANO',65,100,15,0,'PHYSICAL','Golpe físico do tipo Voador que causa dano.'),
(16,94,'psychic',8,'DANO',65,100,10,0,'SPECIAL','Golpe especial do tipo Psíquico que causa dano.'),
(17,188,'sludge-bomb',12,'DANO',65,100,10,0,'SPECIAL','Causa dano e tem 30% de chance de envenenar o oponente.'),
(18,58,'ice-beam',11,'DANO',65,100,10,0,'SPECIAL','Causa dano e tem 10% de chance de congelar o oponente.'),
(28,14,'Dança das Espadas',1,'STATUS',NULL,NULL,20,0,'status','Raises the user’s Attack by two stages.'),
(29,417,'Maquinação Maliciosa',9,'STATUS',NULL,NULL,20,0,'status','Raises the user’s Special Attack by two stages.'),
(30,86,'Onda Trovão',3,'STATUS',NULL,90,20,0,'status','Paralyzes the target.'),
(31,92,'Tóxico',12,'STATUS',NULL,90,10,0,'status','Badly poisons the target.  Never misses when used by a Poison-type Pokémon.'),
(32,347,'Paz Mental',8,'STATUS',NULL,NULL,20,0,'status','Raises the user’s Special Attack and Special Defense by one stage each.'),
(33,339,'Corpulência',6,'STATUS',NULL,NULL,20,0,'status','Raises the user’s Attack and Defense by one stage each.'),
(34,147,'Esporo',5,'STATUS',NULL,100,15,0,'status','Puts the target to sleep.'),
(35,261,'Fogo Fátuo',2,'STATUS',NULL,85,15,0,'status','Burns the target.'),
(37,496,'round',1,'DANO',65,100,15,0,'SPECIAL','Golpe especial do tipo Normal que causa dano.'),
(39,209,'spark',3,'DANO',65,100,20,0,'PHYSICAL','Golpe físico do tipo Elétrico que causa dano.'),
(41,510,'incinerate',2,'DANO',65,100,15,0,'SPECIAL','Golpe especial do tipo Fogo que causa dano.'),
(43,453,'aqua-jet',4,'DANO',65,100,20,1,'PHYSICAL','Golpe físico do tipo Água com prioridade de execução 1.'),
(45,348,'leaf-blade',5,'DANO',65,100,15,0,'PHYSICAL','Golpe físico do tipo Grama que causa dano.'),
(47,396,'aura-sphere',6,'DANO',65,NULL,20,0,'SPECIAL','Golpe especial do tipo Lutador que causa dano.'),
(49,399,'dark-pulse',9,'DANO',65,100,15,0,'SPECIAL','Golpe especial do tipo Sombrio que causa dano.'),
(51,430,'flash-cannon',7,'DANO',65,100,10,0,'SPECIAL','Golpe especial do tipo Aço que causa dano.'),
(53,247,'shadow-ball',13,'DANO',65,100,15,0,'SPECIAL','Golpe especial do tipo Fantasma que causa dano.'),
(55,324,'signal-beam',14,'DANO',65,100,15,0,'SPECIAL','Golpe especial do tipo Inseto que causa dano.'),
(57,523,'bulldoze',17,'DANO',65,100,20,0,'PHYSICAL','Golpe físico do tipo Terra que causa dano.'),
(59,408,'power-gem',16,'DANO',65,100,20,0,'SPECIAL','Golpe especial do tipo Pedra que causa dano.'),
(61,225,'dragon-breath',10,'DANO',65,100,20,0,'SPECIAL','Causa dano e tem 30% de chance de paralisar o oponente.'),
(63,583,'play-rough',18,'DANO',65,90,10,0,'PHYSICAL','Golpe físico do tipo Fada que causa dano.'),
(65,403,'air-slash',15,'DANO',65,95,15,0,'SPECIAL','Golpe especial do tipo Voador que causa dano.'),
(67,428,'zen-headbutt',8,'DANO',65,90,15,0,'PHYSICAL','Golpe físico do tipo Psíquico que causa dano.'),
(69,398,'poison-jab',12,'DANO',65,100,20,0,'PHYSICAL','Causa dano e tem 30% de chance de envenenar o oponente.'),
(71,420,'ice-shard',11,'DANO',65,100,30,1,'PHYSICAL','Golpe físico do tipo Gelo com prioridade de execução 1.');
/*!40000 ALTER TABLE `golpe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `golpe_efeito`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `golpe_efeito` (
  `id_golpe_efeito` int(11) NOT NULL AUTO_INCREMENT,
  `id_golpe` int(11) NOT NULL,
  `tipo_efeito` varchar(30) NOT NULL,
  `alvo` varchar(10) NOT NULL DEFAULT 'OPONENTE',
  `id_status` int(11) DEFAULT NULL,
  `atributo` varchar(30) DEFAULT NULL,
  `alteracao` int(11) DEFAULT NULL,
  `percentual` tinyint(3) unsigned DEFAULT NULL,
  `chance` int(11) NOT NULL DEFAULT 100,
  PRIMARY KEY (`id_golpe_efeito`),
  KEY `fk_golpe_efeito_golpe` (`id_golpe`),
  KEY `fk_golpe_efeito_status` (`id_status`),
  CONSTRAINT `fk_golpe_efeito_golpe` FOREIGN KEY (`id_golpe`) REFERENCES `golpe` (`id_golpe`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_golpe_efeito_status` FOREIGN KEY (`id_status`) REFERENCES `status_pokemon` (`id_status`) ON UPDATE CASCADE,
  CONSTRAINT `chk_golpe_efeito_chance` CHECK (`chance` between 0 and 100),
  CONSTRAINT `chk_golpe_efeito_tipo` CHECK (`tipo_efeito` in ('APLICAR_STATUS','ALTERAR_ATRIBUTO','DRENAR_DANO')),
  CONSTRAINT `chk_golpe_efeito_alvo` CHECK (`alvo` in ('USUARIO','OPONENTE')),
  CONSTRAINT `chk_golpe_efeito_percentual` CHECK (`percentual` is null or `percentual` between 1 and 100),
  CONSTRAINT `chk_golpe_efeito_campos` CHECK (`tipo_efeito` = 'APLICAR_STATUS' and `id_status` is not null and `atributo` is null and `alteracao` is null and `percentual` is null or `tipo_efeito` = 'ALTERAR_ATRIBUTO' and `id_status` is null and `atributo` is not null and `atributo` in ('ATAQUE','DEFESA','ATAQUE_ESPECIAL','DEFESA_ESPECIAL','VELOCIDADE') and `alteracao` is not null and `alteracao` <> 0 and `percentual` is null or `tipo_efeito` = 'DRENAR_DANO' and `id_status` is null and `atributo` is null and `alteracao` is null and `percentual` is not null and `percentual` between 1 and 100 and `alvo` = 'USUARIO')
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `golpe_efeito`
--

LOCK TABLES `golpe_efeito` WRITE;
/*!40000 ALTER TABLE `golpe_efeito` DISABLE KEYS */;
INSERT INTO `golpe_efeito` VALUES
(1,28,'ALTERAR_ATRIBUTO','USUARIO',NULL,'ATAQUE',2,NULL,100),
(2,29,'ALTERAR_ATRIBUTO','USUARIO',NULL,'ATAQUE_ESPECIAL',2,NULL,100),
(3,32,'ALTERAR_ATRIBUTO','USUARIO',NULL,'ATAQUE_ESPECIAL',1,NULL,100),
(4,32,'ALTERAR_ATRIBUTO','USUARIO',NULL,'DEFESA_ESPECIAL',1,NULL,100),
(5,33,'ALTERAR_ATRIBUTO','USUARIO',NULL,'ATAQUE',1,NULL,100),
(6,33,'ALTERAR_ATRIBUTO','USUARIO',NULL,'DEFESA',1,NULL,100),
(7,30,'APLICAR_STATUS','OPONENTE',5,NULL,NULL,NULL,100),
(8,31,'APLICAR_STATUS','OPONENTE',1,NULL,NULL,NULL,100),
(9,34,'APLICAR_STATUS','OPONENTE',4,NULL,NULL,NULL,100),
(10,35,'APLICAR_STATUS','OPONENTE',2,NULL,NULL,NULL,100),
(16,1,'APLICAR_STATUS','OPONENTE',5,NULL,NULL,NULL,30),
(17,3,'APLICAR_STATUS','OPONENTE',2,NULL,NULL,NULL,10),
(18,5,'DRENAR_DANO','USUARIO',NULL,NULL,NULL,50,100),
(19,6,'DRENAR_DANO','USUARIO',NULL,NULL,NULL,50,100),
(22,17,'APLICAR_STATUS','OPONENTE',1,NULL,NULL,NULL,30),
(23,18,'APLICAR_STATUS','OPONENTE',3,NULL,NULL,NULL,10),
(24,61,'APLICAR_STATUS','OPONENTE',5,NULL,NULL,NULL,30),
(25,69,'APLICAR_STATUS','OPONENTE',1,NULL,NULL,NULL,30);
/*!40000 ALTER TABLE `golpe_efeito` ENABLE KEYS */;
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
  CONSTRAINT `chk_item_tipo_efeito` CHECK (`tipo_efeito` in ('ABSOLUTO','PERCENTUAL','STATUS','EVOLUCAO')),
  CONSTRAINT `chk_item_categoria` CHECK (`categoria` in ('HP','HP_STATUS','STATUS','REVIVE','EVOLUCAO'))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
(12,'Revive','REVIVE',2000,50,'Revive um Pokémon desmaiado com 50% do HP máximo.','PERCENTUAL'),
(13,'Moon Stone','EVOLUCAO',1500,NULL,'Permite evoluir um Pokémon que possua uma evolução cadastrada, independentemente do nível.','EVOLUCAO');
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
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pokemon_especie`
--

LOCK TABLES `pokemon_especie` WRITE;
/*!40000 ALTER TABLE `pokemon_especie` DISABLE KEYS */;
INSERT INTO `pokemon_especie` VALUES
(16,495,'snivy',45,45,55,45,55,63,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/495.png'),
(17,496,'servine',60,60,75,60,75,83,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/496.png'),
(18,497,'serperior',75,75,95,75,95,113,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/497.png'),
(19,498,'tepig',65,63,45,45,45,45,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/498.png'),
(20,499,'pignite',90,93,55,70,55,55,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/499.png'),
(21,500,'emboar',110,123,65,100,65,65,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/500.png'),
(22,501,'oshawott',55,55,45,63,45,45,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/501.png'),
(23,502,'dewott',75,75,60,83,60,60,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/502.png'),
(24,503,'samurott',95,100,85,108,70,70,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/503.png'),
(25,504,'patrat',45,55,39,35,39,42,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/504.png'),
(26,505,'watchog',60,85,69,60,69,77,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/505.png'),
(27,506,'lillipup',45,60,45,25,45,55,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/506.png'),
(28,507,'herdier',65,80,65,35,65,60,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/507.png'),
(29,508,'stoutland',85,110,90,45,90,80,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/508.png'),
(30,509,'purrloin',41,50,37,50,37,66,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/509.png'),
(31,510,'liepard',64,88,50,88,50,106,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/510.png'),
(32,511,'pansage',50,53,48,53,48,64,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/511.png'),
(33,512,'simisage',75,98,63,98,63,101,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/512.png'),
(34,513,'pansear',50,53,48,53,48,64,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/513.png'),
(35,514,'simisear',75,98,63,98,63,101,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/514.png'),
(36,515,'panpour',50,53,48,53,48,64,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/515.png'),
(37,516,'simipour',75,98,63,98,63,101,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/516.png'),
(38,517,'munna',76,25,45,67,55,24,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/517.png'),
(39,518,'musharna',116,55,85,107,95,29,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/518.png'),
(40,519,'pidove',50,55,50,36,30,43,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/519.png'),
(41,520,'tranquill',62,77,62,50,42,65,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/520.png'),
(42,521,'unfezant',80,115,80,65,55,93,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/521.png'),
(43,522,'blitzle',45,60,32,50,32,76,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/522.png'),
(44,523,'zebstrika',75,100,63,80,63,116,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/523.png'),
(45,524,'roggenrola',55,75,85,25,25,15,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/524.png'),
(46,525,'boldore',70,105,105,50,40,20,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/525.png'),
(47,526,'gigalith',85,135,130,60,80,25,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/526.png'),
(48,527,'woobat',65,45,43,55,43,72,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/527.png'),
(49,528,'swoobat',67,57,55,77,55,114,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/528.png'),
(50,529,'drilbur',60,85,40,30,45,68,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/529.png'),
(51,530,'excadrill',110,135,60,50,65,88,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/530.png'),
(52,531,'audino',103,60,86,60,86,50,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/531.png'),
(53,532,'timburr',75,80,55,25,35,35,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/532.png'),
(54,533,'gurdurr',85,105,85,40,50,40,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/533.png'),
(55,534,'conkeldurr',105,140,95,55,65,45,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/534.png'),
(56,535,'tympole',50,50,40,50,40,64,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/535.png'),
(57,536,'palpitoad',75,65,55,65,55,69,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/536.png'),
(58,537,'seismitoad',105,95,75,85,75,74,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/537.png'),
(59,538,'throh',120,100,85,30,85,45,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/538.png'),
(60,539,'sawk',75,125,75,30,75,85,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/539.png'),
(61,540,'sewaddle',45,53,70,40,60,42,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/540.png'),
(62,541,'swadloon',55,63,90,50,80,42,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/541.png'),
(63,542,'leavanny',75,103,80,70,80,92,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/542.png'),
(64,543,'venipede',30,45,59,30,39,57,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/543.png'),
(65,544,'whirlipede',40,55,99,40,79,47,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/544.png'),
(66,545,'scolipede',60,100,89,55,69,112,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/545.png'),
(67,546,'cottonee',40,27,60,37,50,66,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/546.png'),
(68,547,'whimsicott',60,67,85,77,75,116,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/547.png'),
(69,548,'petilil',45,35,50,70,50,30,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/548.png'),
(70,549,'lilligant',70,60,75,110,75,90,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/549.png'),
(71,10237,'lilligant-hisui',70,105,75,50,75,105,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10237.png'),
(72,550,'basculin-red-striped',70,92,65,80,55,98,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/550.png'),
(73,902,'basculegion-male',120,112,65,80,75,78,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/902.png'),
(74,551,'sandile',50,72,35,35,35,65,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/551.png'),
(75,552,'krokorok',60,82,45,45,45,74,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/552.png'),
(76,553,'krookodile',95,117,80,65,70,92,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/553.png'),
(77,554,'darumaka',70,90,45,15,45,50,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/554.png'),
(78,10176,'darumaka-galar',70,90,45,15,45,50,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10176.png'),
(79,555,'darmanitan-standard',105,140,55,30,55,95,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/555.png'),
(80,10177,'darmanitan-galar-standard',105,140,55,30,55,95,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10177.png'),
(81,556,'maractus',75,86,67,106,67,60,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/556.png'),
(82,557,'dwebble',50,65,85,35,35,55,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/557.png'),
(83,558,'crustle',70,105,125,65,75,45,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/558.png'),
(84,10247,'basculin-white-striped',70,92,65,80,55,98,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10247.png'),
(85,559,'scraggy',50,75,70,35,70,48,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/559.png'),
(86,560,'scrafty',65,90,115,45,115,58,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/560.png'),
(87,561,'sigilyph',72,58,80,103,80,97,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/561.png'),
(88,562,'yamask',38,30,85,55,65,30,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/562.png'),
(89,563,'cofagrigus',58,50,145,95,105,30,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/563.png'),
(90,10179,'yamask-galar',38,55,85,30,65,30,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10179.png'),
(91,867,'runerigus',58,95,145,50,105,30,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/867.png'),
(92,564,'tirtouga',54,78,103,53,45,22,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/564.png'),
(93,565,'carracosta',74,108,133,83,65,32,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/565.png'),
(94,624,'pawniard',45,85,70,40,40,60,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/624.png'),
(95,625,'bisharp',65,125,100,60,70,70,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/625.png'),
(96,983,'kingambit',100,135,120,60,85,50,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/983.png');
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
INSERT INTO `pokemon_especie_golpe` VALUES
(16,45,1),
(17,45,1),
(18,45,1),
(19,3,1),
(20,3,1),
(20,6,2),
(21,3,1),
(21,6,2),
(22,4,1),
(23,4,1),
(24,4,1),
(25,1,1),
(26,1,1),
(27,1,1),
(28,1,1),
(29,1,1),
(30,7,1),
(31,7,1),
(32,45,1),
(33,45,1),
(34,3,1),
(35,3,1),
(36,43,1),
(37,43,1),
(38,16,1),
(39,16,1),
(40,1,1),
(40,15,2),
(41,1,1),
(41,15,2),
(42,1,1),
(42,15,2),
(43,39,1),
(44,39,1),
(45,12,1),
(46,12,1),
(47,12,1),
(48,16,1),
(48,65,2),
(49,16,1),
(49,65,2),
(50,57,1),
(51,57,1),
(51,8,2),
(52,1,1),
(53,6,1),
(54,6,1),
(55,6,1),
(56,43,1),
(57,43,1),
(57,57,2),
(58,43,1),
(58,57,2),
(59,6,1),
(60,6,1),
(61,10,1),
(61,45,2),
(62,10,1),
(62,45,2),
(63,10,1),
(63,45,2),
(64,10,1),
(64,69,2),
(65,10,1),
(65,69,2),
(66,10,1),
(66,69,2),
(67,5,1),
(67,14,2),
(68,5,1),
(68,14,2),
(69,5,1),
(70,5,1),
(71,45,1),
(71,6,2),
(72,43,1),
(73,43,1),
(73,9,2),
(74,57,1),
(74,7,2),
(75,57,1),
(75,7,2),
(76,57,1),
(76,7,2),
(77,3,1),
(78,71,1),
(79,3,1),
(80,71,1),
(81,5,1),
(82,10,1),
(82,12,2),
(83,10,1),
(83,12,2),
(84,43,1),
(85,7,1),
(85,6,2),
(86,7,1),
(86,6,2),
(87,16,1),
(87,65,2),
(88,53,1),
(89,53,1),
(90,57,1),
(90,9,2),
(91,57,1),
(91,9,2),
(92,43,1),
(92,12,2),
(93,43,1),
(93,12,2),
(94,7,1),
(94,8,2),
(95,7,1),
(95,8,2),
(96,7,1),
(96,8,2);
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_validar_golpe_dano_insert

BEFORE INSERT ON pokemon_especie_golpe

FOR EACH ROW

BEGIN

    DECLARE v_categoria VARCHAR(20);


    SELECT categoria

    INTO v_categoria

    FROM golpe

    WHERE id_golpe = NEW.id_golpe;


    IF v_categoria <> 'DANO' THEN

        SIGNAL SQLSTATE '45000'

        SET MESSAGE_TEXT =

            'Os slots do Pokemon devem conter apenas golpes de dano.';

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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_validar_golpe_dano_update

BEFORE UPDATE ON pokemon_especie_golpe

FOR EACH ROW

BEGIN

    DECLARE v_categoria VARCHAR(20);


    SELECT categoria

    INTO v_categoria

    FROM golpe

    WHERE id_golpe = NEW.id_golpe;


    IF v_categoria <> 'DANO' THEN

        SIGNAL SQLSTATE '45000'

        SET MESSAGE_TEXT =

            'Os slots do Pokemon devem conter apenas golpes de dano.';

    END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pokemon_especie_status_opcao`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pokemon_especie_status_opcao` (
  `id_pokemon_especie` int(11) NOT NULL,
  `id_golpe` int(11) NOT NULL,
  `criterio` varchar(40) NOT NULL DEFAULT 'TIPO',
  PRIMARY KEY (`id_pokemon_especie`,`id_golpe`),
  KEY `fk_status_opcao_golpe` (`id_golpe`),
  CONSTRAINT `fk_status_opcao_golpe` FOREIGN KEY (`id_golpe`) REFERENCES `golpe` (`id_golpe`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_status_opcao_pokemon` FOREIGN KEY (`id_pokemon_especie`) REFERENCES `pokemon_especie` (`id_pokemon_especie`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pokemon_especie_status_opcao`
--

LOCK TABLES `pokemon_especie_status_opcao` WRITE;
/*!40000 ALTER TABLE `pokemon_especie_status_opcao` DISABLE KEYS */;
INSERT INTO `pokemon_especie_status_opcao` VALUES
(16,28,'TEM_FISICO'),
(16,34,'TIPO_GRASS'),
(17,28,'TEM_FISICO'),
(17,34,'TIPO_GRASS'),
(18,28,'TEM_FISICO'),
(18,34,'TIPO_GRASS'),
(19,28,'TEM_FISICO'),
(19,35,'TIPO_FIRE_GHOST'),
(20,33,'TIPO_FIGHTING'),
(20,35,'TIPO_FIRE_GHOST'),
(21,33,'TIPO_FIGHTING'),
(21,35,'TIPO_FIRE_GHOST'),
(22,29,'TEM_ESPECIAL'),
(23,29,'TEM_ESPECIAL'),
(24,29,'TEM_ESPECIAL'),
(25,28,'TEM_FISICO'),
(26,28,'TEM_FISICO'),
(27,28,'TEM_FISICO'),
(28,28,'TEM_FISICO'),
(29,28,'TEM_FISICO'),
(30,28,'TEM_FISICO'),
(31,28,'TEM_FISICO'),
(32,28,'TEM_FISICO'),
(32,34,'TIPO_GRASS'),
(33,28,'TEM_FISICO'),
(33,34,'TIPO_GRASS'),
(34,28,'TEM_FISICO'),
(34,35,'TIPO_FIRE_GHOST'),
(35,28,'TEM_FISICO'),
(35,35,'TIPO_FIRE_GHOST'),
(36,28,'TEM_FISICO'),
(37,28,'TEM_FISICO'),
(38,32,'TIPO_PSYCHIC'),
(39,32,'TIPO_PSYCHIC'),
(40,28,'TEM_FISICO'),
(41,28,'TEM_FISICO'),
(42,28,'TEM_FISICO'),
(43,28,'TEM_FISICO'),
(43,30,'TIPO_ELETRICO'),
(44,28,'TEM_FISICO'),
(44,30,'TIPO_ELETRICO'),
(45,28,'TEM_FISICO'),
(46,28,'TEM_FISICO'),
(47,28,'TEM_FISICO'),
(48,32,'TIPO_PSYCHIC'),
(49,32,'TIPO_PSYCHIC'),
(50,28,'TEM_FISICO'),
(51,28,'TEM_FISICO'),
(52,28,'TEM_FISICO'),
(53,33,'TIPO_FIGHTING'),
(54,33,'TIPO_FIGHTING'),
(55,33,'TIPO_FIGHTING'),
(56,28,'TEM_FISICO'),
(57,28,'TEM_FISICO'),
(58,28,'TEM_FISICO'),
(59,33,'TIPO_FIGHTING'),
(60,33,'TIPO_FIGHTING'),
(61,28,'TEM_FISICO'),
(61,34,'TIPO_GRASS'),
(62,28,'TEM_FISICO'),
(62,34,'TIPO_GRASS'),
(63,28,'TEM_FISICO'),
(63,34,'TIPO_GRASS'),
(64,28,'TEM_FISICO'),
(64,31,'TIPO_POISON'),
(65,28,'TEM_FISICO'),
(65,31,'TIPO_POISON'),
(66,28,'TEM_FISICO'),
(66,31,'TIPO_POISON'),
(67,29,'TEM_ESPECIAL'),
(67,34,'TIPO_GRASS'),
(68,29,'TEM_ESPECIAL'),
(68,34,'TIPO_GRASS'),
(69,29,'TEM_ESPECIAL'),
(69,34,'TIPO_GRASS'),
(70,29,'TEM_ESPECIAL'),
(70,34,'TIPO_GRASS'),
(71,33,'TIPO_FIGHTING'),
(71,34,'TIPO_GRASS'),
(72,28,'TEM_FISICO'),
(73,28,'TEM_FISICO'),
(73,35,'TIPO_FIRE_GHOST'),
(74,28,'TEM_FISICO'),
(75,28,'TEM_FISICO'),
(76,28,'TEM_FISICO'),
(77,28,'TEM_FISICO'),
(77,35,'TIPO_FIRE_GHOST'),
(78,28,'TEM_FISICO'),
(79,28,'TEM_FISICO'),
(79,35,'TIPO_FIRE_GHOST'),
(80,28,'TEM_FISICO'),
(81,29,'TEM_ESPECIAL'),
(81,34,'TIPO_GRASS'),
(82,28,'TEM_FISICO'),
(83,28,'TEM_FISICO'),
(84,28,'TEM_FISICO'),
(85,33,'TIPO_FIGHTING'),
(86,33,'TIPO_FIGHTING'),
(87,32,'TIPO_PSYCHIC'),
(88,29,'TEM_ESPECIAL'),
(88,35,'TIPO_FIRE_GHOST'),
(89,29,'TEM_ESPECIAL'),
(89,35,'TIPO_FIRE_GHOST'),
(90,28,'TEM_FISICO'),
(90,35,'TIPO_FIRE_GHOST'),
(91,28,'TEM_FISICO'),
(91,35,'TIPO_FIRE_GHOST'),
(92,28,'TEM_FISICO'),
(93,28,'TEM_FISICO'),
(94,28,'TEM_FISICO'),
(95,28,'TEM_FISICO'),
(96,28,'TEM_FISICO');
/*!40000 ALTER TABLE `pokemon_especie_status_opcao` ENABLE KEYS */;
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
INSERT INTO `pokemon_especie_tipo` VALUES
(16,5),
(17,5),
(18,5),
(19,2),
(20,2),
(20,6),
(21,2),
(21,6),
(22,4),
(23,4),
(24,4),
(25,1),
(26,1),
(27,1),
(28,1),
(29,1),
(30,9),
(31,9),
(32,5),
(33,5),
(34,2),
(35,2),
(36,4),
(37,4),
(38,8),
(39,8),
(40,1),
(40,15),
(41,1),
(41,15),
(42,1),
(42,15),
(43,3),
(44,3),
(45,16),
(46,16),
(47,16),
(48,8),
(48,15),
(49,8),
(49,15),
(50,17),
(51,7),
(51,17),
(52,1),
(53,6),
(54,6),
(55,6),
(56,4),
(57,4),
(57,17),
(58,4),
(58,17),
(59,6),
(60,6),
(61,5),
(61,14),
(62,5),
(62,14),
(63,5),
(63,14),
(64,12),
(64,14),
(65,12),
(65,14),
(66,12),
(66,14),
(67,5),
(67,18),
(68,5),
(68,18),
(69,5),
(70,5),
(71,5),
(71,6),
(72,4),
(73,4),
(73,13),
(74,9),
(74,17),
(75,9),
(75,17),
(76,9),
(76,17),
(77,2),
(78,11),
(79,2),
(80,11),
(81,5),
(82,14),
(82,16),
(83,14),
(83,16),
(84,4),
(85,6),
(85,9),
(86,6),
(86,9),
(87,8),
(87,15),
(88,13),
(89,13),
(90,13),
(90,17),
(91,13),
(91,17),
(92,4),
(92,16),
(93,4),
(93,16),
(94,7),
(94,9),
(95,7),
(95,9),
(96,7),
(96,9);
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
  `id_golpe_status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_pokemon_time`),
  UNIQUE KEY `uq_perfil_posicao` (`id_perfil`,`posicao`),
  KEY `fk_time_especie` (`id_pokemon_especie`),
  KEY `fk_pokemon_time_held_item` (`id_held_item`),
  KEY `fk_pokemon_time_golpe_status` (`id_golpe_status`),
  CONSTRAINT `fk_pokemon_time_golpe_status` FOREIGN KEY (`id_golpe_status`) REFERENCES `golpe` (`id_golpe`) ON DELETE SET NULL ON UPDATE CASCADE,
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
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_validar_status_pokemon_time_insert

BEFORE INSERT ON pokemon_time

FOR EACH ROW

BEGIN

    DECLARE v_existe INT DEFAULT 0;


    IF NEW.id_golpe_status IS NOT NULL THEN


        SELECT COUNT(*)

        INTO v_existe

        FROM pokemon_especie_status_opcao

        WHERE id_pokemon_especie = NEW.id_pokemon_especie

          AND id_golpe = NEW.id_golpe_status;


        IF v_existe = 0 THEN

            SIGNAL SQLSTATE '45000'

            SET MESSAGE_TEXT =

                'O golpe de status escolhido nao e uma opcao valida para este Pokemon.';

        END IF;


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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_validar_status_pokemon_time_update

BEFORE UPDATE ON pokemon_time

FOR EACH ROW

BEGIN

    DECLARE v_existe INT DEFAULT 0;


    IF NEW.id_golpe_status IS NOT NULL THEN


        SELECT COUNT(*)

        INTO v_existe

        FROM pokemon_especie_status_opcao

        WHERE id_pokemon_especie = NEW.id_pokemon_especie

          AND id_golpe = NEW.id_golpe_status;


        IF v_existe = 0 THEN

            SIGNAL SQLSTATE '45000'

            SET MESSAGE_TEXT =

                'O golpe de status escolhido nao e uma opcao valida para este Pokemon.';

        END IF;


    END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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
INSERT INTO `tipo` VALUES
(1,'Normal','normal'),
(2,'Fogo','fire'),
(3,'Eletrico','electric'),
(4,'Agua','water'),
(5,'Grama','grass'),
(6,'Lutador','fighting'),
(7,'Aco','steel'),
(8,'Psiquico','psychic'),
(9,'Sombrio','dark'),
(10,'Dragao','dragon'),
(11,'Gelo','ice'),
(12,'Veneno','poison'),
(13,'Fantasma','ghost'),
(14,'Inseto','bug'),
(15,'Voador','flying'),
(16,'Pedra','rock'),
(17,'Terra','ground'),
(18,'Fada','fairy');
/*!40000 ALTER TABLE `tipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_efetividade`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
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
INSERT INTO `tipo_efetividade` VALUES
(1,1,1.00),
(1,2,1.00),
(1,3,1.00),
(1,4,1.00),
(1,5,1.00),
(1,6,1.00),
(1,7,0.50),
(1,8,1.00),
(1,9,1.00),
(1,10,1.00),
(1,11,1.00),
(1,12,1.00),
(1,13,0.00),
(1,14,1.00),
(1,15,1.00),
(1,16,0.50),
(1,17,1.00),
(1,18,1.00),
(2,1,1.00),
(2,2,0.50),
(2,3,1.00),
(2,4,0.50),
(2,5,2.00),
(2,6,1.00),
(2,7,2.00),
(2,8,1.00),
(2,9,1.00),
(2,10,0.50),
(2,11,2.00),
(2,12,1.00),
(2,13,1.00),
(2,14,2.00),
(2,15,1.00),
(2,16,0.50),
(2,17,1.00),
(2,18,1.00),
(3,1,1.00),
(3,2,1.00),
(3,3,0.50),
(3,4,2.00),
(3,5,0.50),
(3,6,1.00),
(3,7,1.00),
(3,8,1.00),
(3,9,1.00),
(3,10,0.50),
(3,11,1.00),
(3,12,1.00),
(3,13,1.00),
(3,14,1.00),
(3,15,2.00),
(3,16,1.00),
(3,17,0.00),
(3,18,1.00),
(4,1,1.00),
(4,2,2.00),
(4,3,1.00),
(4,4,0.50),
(4,5,0.50),
(4,6,1.00),
(4,7,1.00),
(4,8,1.00),
(4,9,1.00),
(4,10,0.50),
(4,11,1.00),
(4,12,1.00),
(4,13,1.00),
(4,14,1.00),
(4,15,1.00),
(4,16,2.00),
(4,17,2.00),
(4,18,1.00),
(5,1,1.00),
(5,2,0.50),
(5,3,1.00),
(5,4,2.00),
(5,5,0.50),
(5,6,1.00),
(5,7,0.50),
(5,8,1.00),
(5,9,1.00),
(5,10,0.50),
(5,11,1.00),
(5,12,0.50),
(5,13,1.00),
(5,14,0.50),
(5,15,0.50),
(5,16,2.00),
(5,17,2.00),
(5,18,1.00),
(6,1,2.00),
(6,2,1.00),
(6,3,1.00),
(6,4,1.00),
(6,5,1.00),
(6,6,1.00),
(6,7,2.00),
(6,8,0.50),
(6,9,2.00),
(6,10,1.00),
(6,11,2.00),
(6,12,0.50),
(6,13,0.00),
(6,14,0.50),
(6,15,0.50),
(6,16,2.00),
(6,17,1.00),
(6,18,0.50),
(7,1,1.00),
(7,2,0.50),
(7,3,0.50),
(7,4,0.50),
(7,5,1.00),
(7,6,1.00),
(7,7,0.50),
(7,8,1.00),
(7,9,1.00),
(7,10,1.00),
(7,11,2.00),
(7,12,1.00),
(7,13,1.00),
(7,14,1.00),
(7,15,1.00),
(7,16,2.00),
(7,17,1.00),
(7,18,2.00),
(8,1,1.00),
(8,2,1.00),
(8,3,1.00),
(8,4,1.00),
(8,5,1.00),
(8,6,2.00),
(8,7,0.50),
(8,8,0.50),
(8,9,0.00),
(8,10,1.00),
(8,11,1.00),
(8,12,2.00),
(8,13,1.00),
(8,14,1.00),
(8,15,1.00),
(8,16,1.00),
(8,17,1.00),
(8,18,1.00),
(9,1,1.00),
(9,2,1.00),
(9,3,1.00),
(9,4,1.00),
(9,5,1.00),
(9,6,0.50),
(9,7,1.00),
(9,8,2.00),
(9,9,0.50),
(9,10,1.00),
(9,11,1.00),
(9,12,1.00),
(9,13,2.00),
(9,14,1.00),
(9,15,1.00),
(9,16,1.00),
(9,17,1.00),
(9,18,0.50),
(10,1,1.00),
(10,2,1.00),
(10,3,1.00),
(10,4,1.00),
(10,5,1.00),
(10,6,1.00),
(10,7,0.50),
(10,8,1.00),
(10,9,1.00),
(10,10,2.00),
(10,11,1.00),
(10,12,1.00),
(10,13,1.00),
(10,14,1.00),
(10,15,1.00),
(10,16,1.00),
(10,17,1.00),
(10,18,0.00),
(11,1,1.00),
(11,2,0.50),
(11,3,1.00),
(11,4,0.50),
(11,5,2.00),
(11,6,1.00),
(11,7,0.50),
(11,8,1.00),
(11,9,1.00),
(11,10,2.00),
(11,11,0.50),
(11,12,1.00),
(11,13,1.00),
(11,14,1.00),
(11,15,2.00),
(11,16,1.00),
(11,17,2.00),
(11,18,1.00),
(12,1,1.00),
(12,2,1.00),
(12,3,1.00),
(12,4,1.00),
(12,5,2.00),
(12,6,1.00),
(12,7,0.00),
(12,8,1.00),
(12,9,1.00),
(12,10,1.00),
(12,11,1.00),
(12,12,0.50),
(12,13,0.50),
(12,14,1.00),
(12,15,1.00),
(12,16,0.50),
(12,17,0.50),
(12,18,2.00),
(13,1,0.00),
(13,2,1.00),
(13,3,1.00),
(13,4,1.00),
(13,5,1.00),
(13,6,1.00),
(13,7,1.00),
(13,8,2.00),
(13,9,0.50),
(13,10,1.00),
(13,11,1.00),
(13,12,1.00),
(13,13,2.00),
(13,14,1.00),
(13,15,1.00),
(13,16,1.00),
(13,17,1.00),
(13,18,1.00),
(14,1,1.00),
(14,2,0.50),
(14,3,1.00),
(14,4,1.00),
(14,5,2.00),
(14,6,0.50),
(14,7,0.50),
(14,8,2.00),
(14,9,2.00),
(14,10,1.00),
(14,11,1.00),
(14,12,0.50),
(14,13,0.50),
(14,14,1.00),
(14,15,0.50),
(14,16,1.00),
(14,17,1.00),
(14,18,0.50),
(15,1,1.00),
(15,2,1.00),
(15,3,0.50),
(15,4,1.00),
(15,5,2.00),
(15,6,2.00),
(15,7,0.50),
(15,8,1.00),
(15,9,1.00),
(15,10,1.00),
(15,11,1.00),
(15,12,1.00),
(15,13,1.00),
(15,14,2.00),
(15,15,1.00),
(15,16,0.50),
(15,17,1.00),
(15,18,1.00),
(16,1,1.00),
(16,2,2.00),
(16,3,1.00),
(16,4,1.00),
(16,5,1.00),
(16,6,0.50),
(16,7,0.50),
(16,8,1.00),
(16,9,1.00),
(16,10,1.00),
(16,11,2.00),
(16,12,1.00),
(16,13,1.00),
(16,14,2.00),
(16,15,2.00),
(16,16,1.00),
(16,17,0.50),
(16,18,1.00),
(17,1,1.00),
(17,2,2.00),
(17,3,2.00),
(17,4,1.00),
(17,5,0.50),
(17,6,1.00),
(17,7,2.00),
(17,8,1.00),
(17,9,1.00),
(17,10,1.00),
(17,11,1.00),
(17,12,2.00),
(17,13,1.00),
(17,14,0.50),
(17,15,0.00),
(17,16,2.00),
(17,17,1.00),
(17,18,1.00),
(18,1,1.00),
(18,2,0.50),
(18,3,1.00),
(18,4,1.00),
(18,5,1.00),
(18,6,2.00),
(18,7,0.50),
(18,8,1.00),
(18,9,2.00),
(18,10,2.00),
(18,11,1.00),
(18,12,0.50),
(18,13,1.00),
(18,14,1.00),
(18,15,1.00),
(18,16,1.00),
(18,17,1.00),
(18,18,1.00);
/*!40000 ALTER TABLE `tipo_efetividade` ENABLE KEYS */;
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

-- Dump completed on 2026-10-16 14:43:48
