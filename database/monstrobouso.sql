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
  `id_perfil` int(11) DEFAULT NULL,
  `id_perfil_original` int(11) DEFAULT NULL,
  `nome_jornada` varchar(50) DEFAULT NULL,
  `id_desafio` int(11) DEFAULT NULL,
  `resultado` varchar(20) NOT NULL,
  `dinheiro_ganho` int(11) NOT NULL DEFAULT 0,
  `detalhes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`detalhes`)),
  `iniciada_em` datetime NOT NULL DEFAULT current_timestamp(),
  `finalizada_em` datetime DEFAULT NULL,
  PRIMARY KEY (`id_batalha`),
  KEY `fk_batalha_log_perfil` (`id_perfil`),
  KEY `idx_batalha_perfil_original` (`id_perfil_original`),
  KEY `fk_batalha_log_desafio` (`id_desafio`),
  CONSTRAINT `fk_batalha_log_desafio` FOREIGN KEY (`id_desafio`) REFERENCES `desafio` (`id_desafio`) ON UPDATE CASCADE,
  CONSTRAINT `fk_batalha_log_perfil` FOREIGN KEY (`id_perfil`) REFERENCES `perfil` (`id_perfil`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `chk_batalha_resultado` CHECK (`resultado` in ('VITORIA','DERROTA')),
  CONSTRAINT `chk_batalha_dinheiro` CHECK (`dinheiro_ganho` >= 0)
) ENGINE=InnoDB AUTO_INCREMENT=297 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batalha_log`
--

LOCK TABLES `batalha_log` WRITE;
/*!40000 ALTER TABLE `batalha_log` DISABLE KEYS */;
INSERT INTO `batalha_log` VALUES (61,NULL,33,'red',NULL,'VITORIA',100,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":427,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Dwebble!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Snivy!\"},{\"tipo\":\"golpe\",\"texto\":\"Snivy usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Dwebble perdeu 56 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Dwebble desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Snivy subiu para o Nv. 51!\"},{\"tipo\":\"evolucao\",\"texto\":\"Snivy evoluiu para Servine!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 100!\"}]}','2026-11-18 15:53:48','2026-11-18 11:53:50'),(62,NULL,33,'red',NULL,'VITORIA',300,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":142,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Normal quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Lillipup!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Servine!\"},{\"tipo\":\"golpe\",\"texto\":\"Servine usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Lillipup perdeu 60 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Lillipup desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Patrat!\"},{\"tipo\":\"golpe\",\"texto\":\"Servine usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Patrat perdeu 60 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Patrat desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Servine subiu para o Nv. 53!\"},{\"tipo\":\"evolucao\",\"texto\":\"Servine evoluiu para Serperior!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 300!\"}]}','2026-11-18 15:53:56','2026-11-18 11:54:00'),(63,NULL,33,'red',NULL,'VITORIA',100,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":435,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Patrat!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Serperior!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Patrat perdeu 72 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Patrat desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 54!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 100!\"}]}','2026-11-18 15:54:04','2026-11-18 11:54:08'),(78,NULL,33,'red',NULL,'VITORIA',100,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":438,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Timburr!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Serperior!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Timburr perdeu 42 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Timburr desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 55!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 100!\"}]}','2026-11-23 18:43:24','2026-11-23 14:43:26'),(79,NULL,33,'red',1,'VITORIA',0,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":1,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 1 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Axew!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Serperior!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Axew perdeu 33 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Axew desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Druddigon!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Druddigon perdeu 48 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Druddigon desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 57!\"}]}','2026-11-23 18:43:32','2026-11-23 14:43:36'),(80,NULL,33,'red',NULL,'VITORIA',300,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":170,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Agua quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Alomomola!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Serperior!\"},{\"tipo\":\"golpe\",\"texto\":\"Alomomola usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 3 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Alomomola perdeu 96 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Alomomola desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Jellicent Male!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Jellicent Male perdeu 70 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Jellicent Male desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Simipour!\"},{\"tipo\":\"golpe\",\"texto\":\"Simipour usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 4 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Simipour perdeu 60 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Simipour desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 59!\"},{\"tipo\":\"nivel\",\"texto\":\"Zorua subiu para o Nv. 59!\"},{\"tipo\":\"evolucao\",\"texto\":\"Zorua evoluiu para Zoroark!\"},{\"tipo\":\"nivel\",\"texto\":\"Venipede subiu para o Nv. 59!\"},{\"tipo\":\"evolucao\",\"texto\":\"Venipede evoluiu para Whirlipede!\"},{\"tipo\":\"evolucao\",\"texto\":\"Whirlipede evoluiu para Scolipede!\"},{\"tipo\":\"nivel\",\"texto\":\"Sewaddle subiu para o Nv. 59!\"},{\"tipo\":\"evolucao\",\"texto\":\"Sewaddle evoluiu para Swadloon!\"},{\"tipo\":\"evolucao\",\"texto\":\"Swadloon evoluiu para Leavanny!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 300!\"}]}','2026-11-23 18:43:54','2026-11-23 14:44:02'),(81,NULL,33,'red',2,'VITORIA',0,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":2,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 2 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Gothorita!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Serperior!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Gothorita perdeu 49 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Gothorita desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Swoobat!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Swoobat perdeu 56 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Swoobat desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Musharna!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Musharna perdeu 83 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Musharna desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 61!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 61!\"},{\"tipo\":\"nivel\",\"texto\":\"Scolipede subiu para o Nv. 61!\"},{\"tipo\":\"nivel\",\"texto\":\"Leavanny subiu para o Nv. 61!\"}]}','2026-11-23 18:44:14','2026-11-23 14:44:21'),(82,NULL,33,'red',NULL,'VITORIA',300,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":175,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Agua quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Alomomola!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Serperior!\"},{\"tipo\":\"golpe\",\"texto\":\"Alomomola usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 4 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Alomomola perdeu 126 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Alomomola desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 63!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 63!\"},{\"tipo\":\"nivel\",\"texto\":\"Scolipede subiu para o Nv. 63!\"},{\"tipo\":\"nivel\",\"texto\":\"Leavanny subiu para o Nv. 63!\"},{\"tipo\":\"nivel\",\"texto\":\"Basculin White Striped subiu para o Nv. 63!\"},{\"tipo\":\"evolucao\",\"texto\":\"Basculin White Striped evoluiu para Basculegion Male!\"},{\"tipo\":\"nivel\",\"texto\":\"Joltik subiu para o Nv. 63!\"},{\"tipo\":\"evolucao\",\"texto\":\"Joltik evoluiu para Galvantula!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 300!\"}]}','2026-11-23 18:45:46','2026-11-23 14:45:48'),(83,NULL,33,'red',3,'VITORIA',0,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":3,\"turnos\":4,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 3 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Emolga!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Serperior!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Emolga perdeu 58 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Emolga desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Tranquill!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tranquill perdeu 66 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tranquill desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Swanna!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Swanna perdeu 77 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Swanna desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Archeops!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Archeops perdeu 82 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Archeops desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 65!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 65!\"},{\"tipo\":\"nivel\",\"texto\":\"Scolipede subiu para o Nv. 65!\"},{\"tipo\":\"nivel\",\"texto\":\"Leavanny subiu para o Nv. 65!\"},{\"tipo\":\"nivel\",\"texto\":\"Basculegion Male subiu para o Nv. 65!\"},{\"tipo\":\"nivel\",\"texto\":\"Galvantula subiu para o Nv. 65!\"}]}','2026-11-23 18:46:35','2026-11-23 14:46:45'),(84,NULL,33,'red',NULL,'VITORIA',300,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":180,\"turnos\":12,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Grama quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Leavanny!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Serperior!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Leavanny perdeu 23 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Leavanny usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 8 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Leavanny perdeu 23 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Leavanny usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Leavanny aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Leavanny perdeu 20 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Leavanny usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 17 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Leavanny perdeu 22 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Leavanny usou Bug Bite!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 64 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Leavanny perdeu 7 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Leavanny desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Maractus!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Maractus perdeu 50 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Maractus usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Maractus aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Maractus perdeu 45 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Maractus desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Ferrothorn!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Ferrothorn perdeu 13 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Ferrothorn usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 7 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Serperior aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Ferrothorn usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 8 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Serperior aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Ferrothorn usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Ferrothorn aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Ferrothorn usou Bullet Punch!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 64 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Ferrothorn perdeu 41 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Ferrothorn perdeu 40 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Ferrothorn desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 67!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 67!\"},{\"tipo\":\"nivel\",\"texto\":\"Scolipede subiu para o Nv. 67!\"},{\"tipo\":\"nivel\",\"texto\":\"Yamask Galar subiu para o Nv. 67!\"},{\"tipo\":\"evolucao\",\"texto\":\"Yamask Galar evoluiu para Runerigus!\"},{\"tipo\":\"nivel\",\"texto\":\"Basculegion Male subiu para o Nv. 67!\"},{\"tipo\":\"nivel\",\"texto\":\"Galvantula subiu para o Nv. 67!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 300!\"}]}','2026-11-23 18:48:09','2026-11-23 14:48:49'),(85,NULL,33,'red',4,'VITORIA',0,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":4,\"turnos\":9,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 4 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Heatmor!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Serperior!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Serperior aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Heatmor usou Incinerate!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 26 HP.\"},{\"tipo\":\"status\",\"texto\":\"Serperior recebeu Queimadura!\"},{\"tipo\":\"status\",\"texto\":\"Serperior perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Serperior aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Heatmor usou Incinerate!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 27 HP.\"},{\"tipo\":\"status\",\"texto\":\"Serperior perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Serperior aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Heatmor usou Incinerate!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 51 HP.\"},{\"tipo\":\"status\",\"texto\":\"Serperior perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Heatmor perdeu 85 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Heatmor desmaiou!\"},{\"tipo\":\"status\",\"texto\":\"Serperior perdeu HP por Queimadura!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Simisear!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Simisear perdeu 85 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Simisear desmaiou!\"},{\"tipo\":\"status\",\"texto\":\"Serperior perdeu HP por Queimadura!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Darmanitan Standard!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Darmanitan Standard perdeu 109 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Darmanitan Standard desmaiou!\"},{\"tipo\":\"status\",\"texto\":\"Serperior perdeu HP por Queimadura!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Chandelure!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Chandelure perdeu 84 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Chandelure desmaiou!\"},{\"tipo\":\"status\",\"texto\":\"Serperior perdeu HP por Queimadura!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Volcarona!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Volcarona perdeu 103 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Volcarona usou Signal Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 38 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Serperior desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Zoroark!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"dano\",\"texto\":\"Volcarona perdeu 4 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Volcarona desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 69!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 69!\"},{\"tipo\":\"nivel\",\"texto\":\"Scolipede subiu para o Nv. 69!\"},{\"tipo\":\"nivel\",\"texto\":\"Runerigus subiu para o Nv. 69!\"},{\"tipo\":\"nivel\",\"texto\":\"Basculegion Male subiu para o Nv. 69!\"},{\"tipo\":\"nivel\",\"texto\":\"Galvantula subiu para o Nv. 69!\"}]}','2026-11-23 18:50:16','2026-11-23 14:52:36'),(86,NULL,33,'red',NULL,'VITORIA',300,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":183,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Pedra quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Dwebble!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Throh!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Dwebble perdeu 74 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Dwebble desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Tirtouga!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Tirtouga perdeu 76 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tirtouga desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Throh subiu para o Nv. 71!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 71!\"},{\"tipo\":\"nivel\",\"texto\":\"Runerigus subiu para o Nv. 71!\"},{\"tipo\":\"nivel\",\"texto\":\"Basculegion Male subiu para o Nv. 71!\"},{\"tipo\":\"nivel\",\"texto\":\"Galvantula subiu para o Nv. 71!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 300!\"}]}','2026-11-23 18:55:40','2026-11-23 14:55:44'),(87,NULL,33,'red',NULL,'VITORIA',300,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":184,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Pedra quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Tirtouga!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Throh!\"},{\"tipo\":\"golpe\",\"texto\":\"Tirtouga usou Aqua Jet!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 17 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Tirtouga perdeu 86 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tirtouga desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Throh subiu para o Nv. 73!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 73!\"},{\"tipo\":\"nivel\",\"texto\":\"Runerigus subiu para o Nv. 73!\"},{\"tipo\":\"nivel\",\"texto\":\"Basculegion Male subiu para o Nv. 73!\"},{\"tipo\":\"nivel\",\"texto\":\"Galvantula subiu para o Nv. 73!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 300!\"}]}','2026-11-23 18:56:14','2026-11-23 14:56:17'),(88,NULL,33,'red',NULL,'VITORIA',300,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":185,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Agua quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Alomomola!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Throh!\"},{\"tipo\":\"golpe\",\"texto\":\"Alomomola usou Aqua Jet!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 17 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Alomomola perdeu 112 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Alomomola perdeu 74 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Alomomola desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Throh subiu para o Nv. 75!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 75!\"},{\"tipo\":\"nivel\",\"texto\":\"Runerigus subiu para o Nv. 75!\"},{\"tipo\":\"nivel\",\"texto\":\"Basculegion Male subiu para o Nv. 75!\"},{\"tipo\":\"nivel\",\"texto\":\"Galvantula subiu para o Nv. 75!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 300!\"}]}','2026-11-23 18:56:26','2026-11-23 14:56:29'),(89,NULL,33,'red',5,'VITORIA',0,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":5,\"turnos\":10,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ex-Campeão quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Scrafty!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Throh!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Scrafty perdeu 85 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Scrafty desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Braviary!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Braviary perdeu 115 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Braviary desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Amoonguss!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Amoonguss perdeu 85 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Amoonguss usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 16 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Amoonguss perdeu 46 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Amoonguss desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Seismitoad!\"},{\"tipo\":\"golpe\",\"texto\":\"Seismitoad usou Aqua Jet!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 19 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Seismitoad perdeu 130 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Seismitoad desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Beartic!\"},{\"tipo\":\"golpe\",\"texto\":\"Beartic usou Ice Shard!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 29 HP.\"},{\"tipo\":\"status\",\"texto\":\"Throh recebeu Congelamento!\"},{\"tipo\":\"status\",\"texto\":\"Throh está congelado!\"},{\"tipo\":\"golpe\",\"texto\":\"Beartic usou Ice Shard!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 28 HP.\"},{\"tipo\":\"status\",\"texto\":\"Throh está congelado!\"},{\"tipo\":\"golpe\",\"texto\":\"Beartic usou Ice Shard!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 30 HP.\"},{\"tipo\":\"status\",\"texto\":\"Throh descongelou!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Beartic perdeu 128 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Beartic desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Eelektross!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Eelektross perdeu 122 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Eelektross usou Spark!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 26 HP.\"},{\"tipo\":\"status\",\"texto\":\"Throh recebeu Paralisia!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Eelektross perdeu 4 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Eelektross desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Throh subiu para o Nv. 77!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 77!\"},{\"tipo\":\"nivel\",\"texto\":\"Runerigus subiu para o Nv. 77!\"},{\"tipo\":\"nivel\",\"texto\":\"Basculegion Male subiu para o Nv. 77!\"},{\"tipo\":\"nivel\",\"texto\":\"Galvantula subiu para o Nv. 77!\"}]}','2026-11-23 18:56:53','2026-11-23 14:59:41'),(90,NULL,33,'red',NULL,'VITORIA',100,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":563,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Ferrothorn!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Zoroark!\"},{\"tipo\":\"golpe\",\"texto\":\"Ferrothorn usou Bullet Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark perdeu 19 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Zoroark aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Ferrothorn usou Bullet Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark perdeu 21 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"dano\",\"texto\":\"Ferrothorn perdeu 91 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Ferrothorn desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 78!\"},{\"tipo\":\"nivel\",\"texto\":\"Runerigus subiu para o Nv. 78!\"},{\"tipo\":\"nivel\",\"texto\":\"Throh subiu para o Nv. 78!\"},{\"tipo\":\"nivel\",\"texto\":\"Basculegion Male subiu para o Nv. 78!\"},{\"tipo\":\"nivel\",\"texto\":\"Galvantula subiu para o Nv. 78!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 100!\"}]}','2026-11-23 19:00:05','2026-11-23 15:00:13'),(91,NULL,33,'red',NULL,'VITORIA',300,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":189,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Normal quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Herdier!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Zoroark!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"dano\",\"texto\":\"Herdier perdeu 111 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Herdier desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Sawsbuck!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"dano\",\"texto\":\"Sawsbuck perdeu 124 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Sawsbuck desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 80!\"},{\"tipo\":\"nivel\",\"texto\":\"Runerigus subiu para o Nv. 80!\"},{\"tipo\":\"nivel\",\"texto\":\"Litwick subiu para o Nv. 80!\"},{\"tipo\":\"evolucao\",\"texto\":\"Litwick evoluiu para Lampent!\"},{\"tipo\":\"evolucao\",\"texto\":\"Lampent evoluiu para Chandelure!\"},{\"tipo\":\"nivel\",\"texto\":\"Basculegion Male subiu para o Nv. 80!\"},{\"tipo\":\"nivel\",\"texto\":\"Galvantula subiu para o Nv. 80!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 300!\"}]}','2026-11-23 19:00:32','2026-11-23 15:00:36'),(92,NULL,33,'red',NULL,'VITORIA',100,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":573,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Boldore!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Zoroark!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"dano\",\"texto\":\"Boldore perdeu 125 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Boldore desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 81!\"},{\"tipo\":\"nivel\",\"texto\":\"Runerigus subiu para o Nv. 81!\"},{\"tipo\":\"nivel\",\"texto\":\"Chandelure subiu para o Nv. 81!\"},{\"tipo\":\"nivel\",\"texto\":\"Basculegion Male subiu para o Nv. 81!\"},{\"tipo\":\"nivel\",\"texto\":\"Galvantula subiu para o Nv. 81!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 100!\"}]}','2026-11-23 19:00:44','2026-11-23 15:00:47'),(93,NULL,33,'red',6,'VITORIA',0,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":6,\"turnos\":11,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Rival quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Scolipede!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Zoroark!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"dano\",\"texto\":\"Scolipede perdeu 98 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Scolipede desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Serperior!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 115 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Serperior desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Samurott!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"dano\",\"texto\":\"Samurott perdeu 137 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Samurott desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Hydreigon!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Hydreigon perdeu 70 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Hydreigon usou Dark Pulse!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark perdeu 20 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Hydreigon perdeu 70 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Hydreigon desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Emboar!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Emboar perdeu 99 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Emboar usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark perdeu 89 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Emboar perdeu 64 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Emboar desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Kingambit!\"},{\"tipo\":\"golpe\",\"texto\":\"Kingambit usou Bullet Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark perdeu 51 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Kingambit perdeu 69 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Kingambit usou Sucker Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark perdeu 27 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Kingambit perdeu 63 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Kingambit usou Sucker Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark perdeu 1 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Zoroark desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Runerigus!\"},{\"tipo\":\"golpe\",\"texto\":\"Kingambit usou Sucker Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Runerigus perdeu 46 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Runerigus usou Bulldoze!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Kingambit perdeu 28 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Kingambit desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 83!\"},{\"tipo\":\"nivel\",\"texto\":\"Runerigus subiu para o Nv. 83!\"},{\"tipo\":\"nivel\",\"texto\":\"Chandelure subiu para o Nv. 83!\"},{\"tipo\":\"nivel\",\"texto\":\"Basculegion Male subiu para o Nv. 83!\"},{\"tipo\":\"nivel\",\"texto\":\"Galvantula subiu para o Nv. 83!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 71!\"}]}','2026-11-23 19:01:11','2026-11-23 15:01:53'),(94,NULL,36,'leaf',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":593,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Timburr!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Timburr perdeu 13 HP.\"},{\"tipo\":\"status\",\"texto\":\"Timburr recebeu Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Timburr usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 5 HP.\"},{\"tipo\":\"status\",\"texto\":\"Timburr perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Timburr perdeu 1 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Timburr desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 6!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-23 21:34:59','2026-11-23 17:35:12'),(95,NULL,36,'leaf',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":597,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Throh!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 10 HP.\"},{\"tipo\":\"status\",\"texto\":\"Throh recebeu Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Throh aumentou!\"},{\"tipo\":\"status\",\"texto\":\"Throh perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 9 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Throh desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 7!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-23 21:35:25','2026-11-23 17:35:34'),(96,NULL,36,'leaf',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":200,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Grama quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Sewaddle!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Sewaddle perdeu 17 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Sewaddle desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Ferroseed!\"},{\"tipo\":\"golpe\",\"texto\":\"Ferroseed usou Bullet Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 2 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Ferroseed perdeu 17 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Ferroseed desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 9!\"},{\"tipo\":\"nivel\",\"texto\":\"Stunfisk subiu para o Nv. 9!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-23 21:39:25','2026-11-23 17:39:33'),(97,NULL,36,'leaf',1,'DERROTA',0,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":1,\"turnos\":5,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 1 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Axew!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Stunfisk!\"},{\"tipo\":\"golpe\",\"texto\":\"Axew usou Dragon Claw!\"},{\"tipo\":\"dano\",\"texto\":\"Stunfisk perdeu 14 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Stunfisk usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Stunfisk aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Axew usou Dragon Claw!\"},{\"tipo\":\"dano\",\"texto\":\"Stunfisk perdeu 15 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Stunfisk usou Earth Power!\"},{\"tipo\":\"dano\",\"texto\":\"Axew perdeu 24 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Axew usou Dragon Claw!\"},{\"tipo\":\"dano\",\"texto\":\"Stunfisk perdeu 9 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Stunfisk desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Axew usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Axew aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Tepig aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Axew usou Dragon Claw!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 30 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-23 21:39:51','2026-11-23 17:41:35'),(98,NULL,37,'leaf',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":205,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Lutador quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Timburr!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Emolga!\"},{\"tipo\":\"golpe\",\"texto\":\"Emolga usou Acrobatics!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Timburr perdeu 15 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Timburr desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Sawk!\"},{\"tipo\":\"golpe\",\"texto\":\"Emolga usou Acrobatics!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Sawk perdeu 15 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Sawk desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Emolga subiu para o Nv. 7!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 7!\"},{\"tipo\":\"nivel\",\"texto\":\"Sandile subiu para o Nv. 7!\"},{\"tipo\":\"nivel\",\"texto\":\"Cubchoo subiu para o Nv. 7!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-23 21:55:01','2026-11-23 17:55:57'),(99,NULL,37,'leaf',1,'DERROTA',0,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":1,\"turnos\":6,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 1 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Druddigon!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Emolga!\"},{\"tipo\":\"golpe\",\"texto\":\"Emolga usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Emolga aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Druddigon usou Dragon Claw!\"},{\"tipo\":\"dano\",\"texto\":\"Emolga perdeu 24 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Emolga desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Druddigon usou Dragon Claw!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 26 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Sandile!\"},{\"tipo\":\"golpe\",\"texto\":\"Sandile usou Sucker Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Druddigon perdeu 6 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Druddigon usou Dragon Claw!\"},{\"tipo\":\"dano\",\"texto\":\"Sandile perdeu 24 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Sandile desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Cubchoo!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Druddigon perdeu 11 HP.\"},{\"tipo\":\"status\",\"texto\":\"Druddigon recebeu Congelamento!\"},{\"tipo\":\"status\",\"texto\":\"Druddigon está congelado!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Druddigon perdeu 10 HP.\"},{\"tipo\":\"status\",\"texto\":\"Druddigon está congelado!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Druddigon perdeu 11 HP.\"},{\"tipo\":\"status\",\"texto\":\"Druddigon descongelou!\"},{\"tipo\":\"golpe\",\"texto\":\"Druddigon usou Dragon Claw!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 24 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Cubchoo desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-23 21:56:17','2026-11-23 17:58:45'),(100,NULL,38,'leaf',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":623,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Panpour!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Snivy!\"},{\"tipo\":\"golpe\",\"texto\":\"Panpour usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Snivy perdeu 1 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Snivy usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Panpour perdeu 14 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Panpour desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Snivy subiu para o Nv. 6!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-23 22:00:20','2026-11-23 18:00:24'),(101,NULL,38,'leaf',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":627,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Roggenrola!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Snivy!\"},{\"tipo\":\"golpe\",\"texto\":\"Snivy usou Leaf Blade!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Roggenrola perdeu 16 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Roggenrola desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Snivy subiu para o Nv. 7!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-23 22:00:31','2026-11-23 18:00:35'),(102,NULL,38,'leaf',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":209,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Pedra quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Tirtouga!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Snivy!\"},{\"tipo\":\"golpe\",\"texto\":\"Tirtouga usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Snivy perdeu 2 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Snivy usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Tirtouga perdeu 18 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tirtouga desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Snivy subiu para o Nv. 9!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-23 22:01:24','2026-11-23 18:01:29'),(103,NULL,38,'leaf',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":633,\"turnos\":4,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Deerling!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Snivy!\"},{\"tipo\":\"golpe\",\"texto\":\"Snivy usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Snivy aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Deerling usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Deerling aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Snivy usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Snivy aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Deerling usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Snivy perdeu 6 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Snivy usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Deerling perdeu 16 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Deerling usou Leaf Blade!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Snivy perdeu 13 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Snivy usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Deerling perdeu 7 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Deerling desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Snivy subiu para o Nv. 10!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-23 22:01:36','2026-11-23 18:01:50'),(104,NULL,38,'leaf',1,'DERROTA',0,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":1,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 1 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Druddigon!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Snivy!\"},{\"tipo\":\"golpe\",\"texto\":\"Snivy usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Druddigon perdeu 4 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Druddigon usou Dragon Claw!\"},{\"tipo\":\"dano\",\"texto\":\"Snivy perdeu 23 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Snivy usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Druddigon perdeu 3 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Druddigon usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Druddigon aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Snivy usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Druddigon perdeu 3 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Druddigon usou Dragon Claw!\"},{\"tipo\":\"dano\",\"texto\":\"Snivy perdeu 6 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Snivy desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-23 22:01:56','2026-11-23 18:02:08'),(105,NULL,39,'leaf',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":211,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Lutador quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Timburr!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Timburr perdeu 14 HP.\"},{\"tipo\":\"status\",\"texto\":\"Timburr recebeu Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Timburr usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Timburr aumentou!\"},{\"tipo\":\"status\",\"texto\":\"Timburr perdeu HP por Queimadura!\"},{\"tipo\":\"desmaio\",\"texto\":\"Timburr desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Sawk!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Sawk perdeu 11 HP.\"},{\"tipo\":\"status\",\"texto\":\"Sawk recebeu Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Sawk usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 5 HP.\"},{\"tipo\":\"status\",\"texto\":\"Sawk perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Sawk perdeu 3 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Sawk desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 7!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-23 22:05:44','2026-11-23 18:05:58'),(106,NULL,39,'leaf',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":213,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Inseto quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Durant!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Durant aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Durant perdeu 18 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Durant desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 9!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-23 22:06:07','2026-11-23 18:06:11'),(107,NULL,39,'leaf',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":646,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Ferroseed!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Ferroseed perdeu 21 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Ferroseed desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 10!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-23 22:08:12','2026-11-23 18:08:16'),(108,NULL,39,'leaf',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":215,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Grama quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Ferroseed!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Ferroseed perdeu 23 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Ferroseed desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 12!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-23 22:08:21','2026-11-23 18:08:25'),(109,NULL,39,'leaf',1,'DERROTA',0,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":1,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 1 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Druddigon!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Druddigon usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Druddigon aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Druddigon perdeu 5 HP.\"},{\"tipo\":\"status\",\"texto\":\"Druddigon recebeu Queimadura!\"},{\"tipo\":\"status\",\"texto\":\"Druddigon perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Druddigon usou Dragon Claw!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 37 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"status\",\"texto\":\"Druddigon perdeu HP por Queimadura!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-23 22:08:36','2026-11-23 18:09:08'),(110,NULL,40,'leaf',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":653,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Maractus!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Maractus perdeu 15 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Maractus desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 6!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-23 22:40:49','2026-11-23 18:40:55'),(111,NULL,40,'leaf',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":657,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Deerling!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Deerling perdeu 16 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Deerling desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 7!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-23 22:41:00','2026-11-23 18:41:04'),(112,NULL,40,'leaf',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":661,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Sewaddle!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Sewaddle perdeu 17 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Sewaddle desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 8!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-23 22:41:09','2026-11-23 18:41:13'),(113,NULL,40,'leaf',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":663,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Throh!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 11 HP.\"},{\"tipo\":\"status\",\"texto\":\"Throh recebeu Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 10 HP.\"},{\"tipo\":\"status\",\"texto\":\"Throh perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 11 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 10 HP.\"},{\"tipo\":\"status\",\"texto\":\"Throh perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 3 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Throh desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 9!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-23 22:41:21','2026-11-23 18:41:29'),(114,NULL,40,'leaf',1,'DERROTA',0,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":1,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 1 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Cubchoo!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Cubchoo aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 22 HP.\"},{\"tipo\":\"status\",\"texto\":\"Cubchoo recebeu Queimadura!\"},{\"tipo\":\"status\",\"texto\":\"Cubchoo perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 18 HP.\"},{\"tipo\":\"status\",\"texto\":\"Tepig recebeu Congelamento!\"},{\"tipo\":\"status\",\"texto\":\"Tepig descongelou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 12 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Cubchoo desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Vanillish!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 12 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-23 22:41:51','2026-11-23 18:42:05'),(115,NULL,41,'leaf',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":221,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Normal quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Deerling!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Deerling perdeu 14 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Deerling desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 7!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-24 17:27:04','2026-11-24 13:27:07'),(116,NULL,41,'leaf',NULL,'DERROTA',0,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":222,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Normal quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Lillipup!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Tepig aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Lillipup usou Body Slam!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 14 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Tepig aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Lillipup usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Lillipup aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Tepig aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Lillipup usou Body Slam!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 12 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-24 17:27:14','2026-11-24 13:27:22'),(117,NULL,43,'leaf',NULL,'DERROTA',0,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":231,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Lutador quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Sawk!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Oshawott!\"},{\"tipo\":\"golpe\",\"texto\":\"Sawk usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Oshawott perdeu 11 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Oshawott usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Oshawott aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Sawk usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Oshawott perdeu 9 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Oshawott desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-25 12:22:54','2026-11-25 08:23:00'),(118,NULL,44,'leaf',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":236,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Inseto quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Shelmet!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Oshawott!\"},{\"tipo\":\"golpe\",\"texto\":\"Oshawott usou Water Pulse!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Shelmet perdeu 18 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Shelmet desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Oshawott subiu para o Nv. 8!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 12:23:05','2026-11-25 08:23:19'),(119,NULL,44,'leaf',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":237,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Pedra quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Dwebble!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Oshawott!\"},{\"tipo\":\"golpe\",\"texto\":\"Oshawott usou Water Pulse!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Dwebble perdeu 24 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Dwebble desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Oshawott subiu para o Nv. 11!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 12:23:25','2026-11-25 08:23:26'),(120,NULL,44,'leaf',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":240,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Terra quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Sandile!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Oshawott!\"},{\"tipo\":\"golpe\",\"texto\":\"Sandile usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Sandile aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Oshawott usou Water Pulse!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Sandile perdeu 28 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Sandile desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Oshawott subiu para o Nv. 14!\"},{\"tipo\":\"nivel\",\"texto\":\"Zorua subiu para o Nv. 14!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 12:23:35','2026-11-25 08:23:37'),(121,NULL,44,'leaf',1,'VITORIA',900,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":1,\"turnos\":5,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 1 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Cubchoo!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Zorua!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"dano\",\"texto\":\"Zorua perdeu 16 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zorua usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Zorua aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"dano\",\"texto\":\"Zorua perdeu 16 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zorua usou Dark Pulse!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 35 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Cubchoo desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Vanillish!\"},{\"tipo\":\"golpe\",\"texto\":\"Zorua usou Dark Pulse!\"},{\"tipo\":\"dano\",\"texto\":\"Vanillish perdeu 27 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"dano\",\"texto\":\"Zorua perdeu 3 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Zorua desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Oshawott!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Oshawott perdeu 12 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Oshawott usou Water Pulse!\"},{\"tipo\":\"dano\",\"texto\":\"Vanillish perdeu 11 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Oshawott perdeu 12 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Oshawott usou Water Pulse!\"},{\"tipo\":\"dano\",\"texto\":\"Vanillish perdeu 2 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Vanillish desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Zorua subiu para o Nv. 18!\"},{\"tipo\":\"nivel\",\"texto\":\"Oshawott subiu para o Nv. 18!\"},{\"tipo\":\"evolucao\",\"texto\":\"Oshawott evoluiu para Dewott!\"},{\"tipo\":\"recuperacao\",\"texto\":\"Desafio vencido! Todo o time recuperou 100% do HP, os desmaiados reviveram e as condicoes foram curadas!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 900!\"}]}','2026-11-25 12:23:46','2026-11-25 08:24:00'),(122,NULL,44,'leaf',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":729,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Gothorita!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Dewott!\"},{\"tipo\":\"golpe\",\"texto\":\"Dewott usou Water Pulse!\"},{\"tipo\":\"dano\",\"texto\":\"Gothorita perdeu 21 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Gothorita usou Psychic!\"},{\"tipo\":\"dano\",\"texto\":\"Dewott perdeu 15 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Dewott usou Water Pulse!\"},{\"tipo\":\"dano\",\"texto\":\"Gothorita perdeu 21 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Gothorita usou Psychic!\"},{\"tipo\":\"dano\",\"texto\":\"Dewott perdeu 15 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Dewott usou Water Pulse!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Gothorita perdeu 1 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Gothorita desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Dewott subiu para o Nv. 20!\"},{\"tipo\":\"nivel\",\"texto\":\"Zorua subiu para o Nv. 20!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 12:24:36','2026-11-25 08:24:42'),(123,NULL,44,'leaf',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":245,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Psiquico quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Swoobat!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Zorua!\"},{\"tipo\":\"golpe\",\"texto\":\"Swoobat usou Air Slash!\"},{\"tipo\":\"dano\",\"texto\":\"Zorua perdeu 26 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zorua usou Dark Pulse!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Swoobat perdeu 52 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Swoobat desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Musharna!\"},{\"tipo\":\"golpe\",\"texto\":\"Zorua usou Dark Pulse!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Musharna perdeu 36 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Musharna usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Musharna aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Zorua usou Dark Pulse!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Musharna perdeu 33 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Musharna desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Zorua subiu para o Nv. 23!\"},{\"tipo\":\"nivel\",\"texto\":\"Lillipup subiu para o Nv. 23!\"},{\"tipo\":\"evolucao\",\"texto\":\"Lillipup evoluiu para Herdier!\"},{\"tipo\":\"nivel\",\"texto\":\"Tirtouga subiu para o Nv. 23!\"},{\"tipo\":\"nivel\",\"texto\":\"Dewott subiu para o Nv. 23!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 12:25:00','2026-11-25 08:25:08'),(124,NULL,44,'leaf',2,'VITORIA',900,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":2,\"turnos\":4,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 2 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Frillish Female!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Zoroark!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Zoroark aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Frillish Female usou Shadow Ball!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark perdeu 8 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Frillish Female perdeu 47 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Frillish Female desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Alomomola!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"dano\",\"texto\":\"Alomomola perdeu 96 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Alomomola desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Simipour!\"},{\"tipo\":\"golpe\",\"texto\":\"Simipour usou Aqua Jet!\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark perdeu 29 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"dano\",\"texto\":\"Simipour perdeu 65 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Simipour desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 27!\"},{\"tipo\":\"nivel\",\"texto\":\"Herdier subiu para o Nv. 27!\"},{\"tipo\":\"nivel\",\"texto\":\"Tirtouga subiu para o Nv. 27!\"},{\"tipo\":\"nivel\",\"texto\":\"Dewott subiu para o Nv. 27!\"},{\"tipo\":\"recuperacao\",\"texto\":\"Desafio vencido! Todo o time recuperou 100% do HP, os desmaiados reviveram e as condicoes foram curadas!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 900!\"}]}','2026-11-25 12:25:56','2026-11-25 08:26:12'),(125,NULL,44,'leaf',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":247,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Psiquico quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Woobat!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Zoroark!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Woobat perdeu 65 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Woobat desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Munna!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Munna perdeu 70 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Munna desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 30!\"},{\"tipo\":\"nivel\",\"texto\":\"Herdier subiu para o Nv. 30!\"},{\"tipo\":\"nivel\",\"texto\":\"Tirtouga subiu para o Nv. 30!\"},{\"tipo\":\"nivel\",\"texto\":\"Dewott subiu para o Nv. 30!\"},{\"tipo\":\"nivel\",\"texto\":\"Durant subiu para o Nv. 30!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 12:26:29','2026-11-25 08:26:33'),(126,NULL,44,'leaf',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":250,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Inseto quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Joltik!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Darumaka!\"},{\"tipo\":\"golpe\",\"texto\":\"Joltik usou Signal Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Darumaka perdeu 11 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Darumaka usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Joltik perdeu 64 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Joltik desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Durant!\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Bullet Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Darumaka perdeu 20 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Darumaka usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Durant perdeu 68 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Durant desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Darumaka subiu para o Nv. 33!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 33!\"},{\"tipo\":\"nivel\",\"texto\":\"Herdier subiu para o Nv. 33!\"},{\"tipo\":\"evolucao\",\"texto\":\"Herdier evoluiu para Stoutland!\"},{\"tipo\":\"nivel\",\"texto\":\"Tirtouga subiu para o Nv. 33!\"},{\"tipo\":\"nivel\",\"texto\":\"Dewott subiu para o Nv. 33!\"},{\"tipo\":\"nivel\",\"texto\":\"Durant subiu para o Nv. 33!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 12:26:48','2026-11-25 08:26:54'),(127,NULL,44,'leaf',3,'VITORIA',900,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":3,\"turnos\":5,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 3 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Emolga!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Zoroark!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Zoroark aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Emolga usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Emolga aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"dano\",\"texto\":\"Emolga perdeu 58 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Emolga desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Tranquill!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"dano\",\"texto\":\"Tranquill perdeu 66 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tranquill desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Swanna!\"},{\"tipo\":\"golpe\",\"texto\":\"Swanna usou Aqua Jet!\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark perdeu 29 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"dano\",\"texto\":\"Swanna perdeu 77 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Swanna desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Archeops!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"dano\",\"texto\":\"Archeops perdeu 82 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Archeops desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 37!\"},{\"tipo\":\"nivel\",\"texto\":\"Stoutland subiu para o Nv. 37!\"},{\"tipo\":\"nivel\",\"texto\":\"Tirtouga subiu para o Nv. 37!\"},{\"tipo\":\"evolucao\",\"texto\":\"Tirtouga evoluiu para Carracosta!\"},{\"tipo\":\"nivel\",\"texto\":\"Dewott subiu para o Nv. 37!\"},{\"tipo\":\"evolucao\",\"texto\":\"Dewott evoluiu para Samurott!\"},{\"tipo\":\"nivel\",\"texto\":\"Durant subiu para o Nv. 37!\"},{\"tipo\":\"nivel\",\"texto\":\"Darumaka subiu para o Nv. 37!\"},{\"tipo\":\"evolucao\",\"texto\":\"Darumaka evoluiu para Darmanitan Standard!\"},{\"tipo\":\"recuperacao\",\"texto\":\"Desafio vencido! Todo o time recuperou 100% do HP, os desmaiados reviveram e as condicoes foram curadas!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 900!\"}]}','2026-11-25 12:27:51','2026-11-25 08:28:09'),(128,NULL,44,'leaf',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":252,\"turnos\":4,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Pedra quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Crustle!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Carracosta!\"},{\"tipo\":\"golpe\",\"texto\":\"Crustle usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Crustle aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Carracosta aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Crustle perdeu 89 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Crustle desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Boldore!\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Boldore perdeu 89 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Boldore desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Carracosta!\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Aqua Jet!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Carracosta perdeu 91 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Carracosta desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Carracosta subiu para o Nv. 40!\"},{\"tipo\":\"nivel\",\"texto\":\"Samurott subiu para o Nv. 40!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 40!\"},{\"tipo\":\"nivel\",\"texto\":\"Stoutland subiu para o Nv. 40!\"},{\"tipo\":\"nivel\",\"texto\":\"Durant subiu para o Nv. 40!\"},{\"tipo\":\"nivel\",\"texto\":\"Darmanitan Standard subiu para o Nv. 40!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 12:28:40','2026-11-25 08:28:59'),(129,NULL,44,'leaf',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":255,\"turnos\":4,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Inseto quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Galvantula!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Carracosta!\"},{\"tipo\":\"golpe\",\"texto\":\"Galvantula usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Galvantula aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Rock Tomb!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Galvantula perdeu 91 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Galvantula desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Durant!\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Bullet Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Carracosta perdeu 22 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Rock Tomb!\"},{\"tipo\":\"dano\",\"texto\":\"Durant perdeu 40 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Bullet Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Carracosta perdeu 20 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Rock Tomb!\"},{\"tipo\":\"dano\",\"texto\":\"Durant perdeu 38 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Aqua Jet!\"},{\"tipo\":\"dano\",\"texto\":\"Durant perdeu 5 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Durant desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Carracosta subiu para o Nv. 43!\"},{\"tipo\":\"nivel\",\"texto\":\"Samurott subiu para o Nv. 43!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 43!\"},{\"tipo\":\"nivel\",\"texto\":\"Stoutland subiu para o Nv. 43!\"},{\"tipo\":\"nivel\",\"texto\":\"Darmanitan Standard subiu para o Nv. 43!\"},{\"tipo\":\"nivel\",\"texto\":\"Durant subiu para o Nv. 43!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 12:29:32','2026-11-25 08:29:43'),(130,NULL,44,'leaf',4,'VITORIA',900,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":4,\"turnos\":5,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 4 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Heatmor!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Carracosta!\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Heatmor perdeu 85 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Heatmor desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Simisear!\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Simisear perdeu 85 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Simisear desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Darmanitan Standard!\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Darmanitan Standard perdeu 109 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Darmanitan Standard desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Chandelure!\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Chandelure perdeu 84 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Chandelure desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Volcarona!\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Volcarona perdeu 107 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Volcarona desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Carracosta subiu para o Nv. 47!\"},{\"tipo\":\"nivel\",\"texto\":\"Samurott subiu para o Nv. 47!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 47!\"},{\"tipo\":\"nivel\",\"texto\":\"Stoutland subiu para o Nv. 47!\"},{\"tipo\":\"nivel\",\"texto\":\"Darmanitan Standard subiu para o Nv. 47!\"},{\"tipo\":\"nivel\",\"texto\":\"Durant subiu para o Nv. 47!\"},{\"tipo\":\"recuperacao\",\"texto\":\"Desafio vencido! Todo o time recuperou 100% do HP, os desmaiados reviveram e as condicoes foram curadas!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 900!\"}]}','2026-11-25 12:30:14','2026-11-25 08:30:26'),(131,NULL,44,'leaf',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":776,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Crustle!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Carracosta!\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Crustle perdeu 79 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Crustle usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Crustle aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Crustle perdeu 24 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Crustle desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Carracosta subiu para o Nv. 49!\"},{\"tipo\":\"nivel\",\"texto\":\"Samurott subiu para o Nv. 49!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 49!\"},{\"tipo\":\"nivel\",\"texto\":\"Stoutland subiu para o Nv. 49!\"},{\"tipo\":\"nivel\",\"texto\":\"Darmanitan Standard subiu para o Nv. 49!\"},{\"tipo\":\"nivel\",\"texto\":\"Durant subiu para o Nv. 49!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 12:30:42','2026-11-25 08:30:46'),(132,NULL,44,'leaf',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":260,\"turnos\":5,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Normal quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Stoutland!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Carracosta!\"},{\"tipo\":\"golpe\",\"texto\":\"Stoutland usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Stoutland aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Carracosta aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Aqua Jet!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Stoutland perdeu 120 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Stoutland desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Watchog!\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Aqua Jet!\"},{\"tipo\":\"dano\",\"texto\":\"Watchog perdeu 100 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Watchog desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Sawsbuck!\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Sawsbuck perdeu 67 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Sawsbuck usou Body Slam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Carracosta perdeu 11 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Sawsbuck perdeu 49 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Sawsbuck desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Carracosta subiu para o Nv. 52!\"},{\"tipo\":\"nivel\",\"texto\":\"Samurott subiu para o Nv. 52!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 52!\"},{\"tipo\":\"nivel\",\"texto\":\"Stoutland subiu para o Nv. 52!\"},{\"tipo\":\"nivel\",\"texto\":\"Darmanitan Standard subiu para o Nv. 52!\"},{\"tipo\":\"nivel\",\"texto\":\"Joltik subiu para o Nv. 52!\"},{\"tipo\":\"evolucao\",\"texto\":\"Joltik evoluiu para Galvantula!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 12:31:05','2026-11-25 08:31:18'),(133,NULL,44,'leaf',5,'VITORIA',900,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":5,\"turnos\":8,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ex-Campeão quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Scrafty!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Carracosta!\"},{\"tipo\":\"golpe\",\"texto\":\"Scrafty usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Carracosta perdeu 28 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Carracosta aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Scrafty usou Sucker Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Carracosta perdeu 13 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Carracosta aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Scrafty usou Sucker Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Carracosta perdeu 14 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Aqua Jet!\"},{\"tipo\":\"dano\",\"texto\":\"Scrafty perdeu 85 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Scrafty desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Braviary!\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Aqua Jet!\"},{\"tipo\":\"dano\",\"texto\":\"Braviary perdeu 115 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Braviary desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Amoonguss!\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Rock Tomb!\"},{\"tipo\":\"dano\",\"texto\":\"Amoonguss perdeu 131 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Amoonguss desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Seismitoad!\"},{\"tipo\":\"golpe\",\"texto\":\"Seismitoad usou Aqua Jet!\"},{\"tipo\":\"dano\",\"texto\":\"Carracosta perdeu 21 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Aqua Jet!\"},{\"tipo\":\"dano\",\"texto\":\"Seismitoad perdeu 130 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Seismitoad desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Beartic!\"},{\"tipo\":\"golpe\",\"texto\":\"Beartic usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Carracosta perdeu 13 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Aqua Jet!\"},{\"tipo\":\"dano\",\"texto\":\"Beartic perdeu 128 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Beartic desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Eelektross!\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Aqua Jet!\"},{\"tipo\":\"dano\",\"texto\":\"Eelektross perdeu 126 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Eelektross desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Carracosta subiu para o Nv. 56!\"},{\"tipo\":\"nivel\",\"texto\":\"Samurott subiu para o Nv. 56!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 56!\"},{\"tipo\":\"nivel\",\"texto\":\"Stoutland subiu para o Nv. 56!\"},{\"tipo\":\"nivel\",\"texto\":\"Darmanitan Standard subiu para o Nv. 56!\"},{\"tipo\":\"nivel\",\"texto\":\"Galvantula subiu para o Nv. 56!\"},{\"tipo\":\"recuperacao\",\"texto\":\"Desafio vencido! Todo o time recuperou 100% do HP, os desmaiados reviveram e as condicoes foram curadas!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 900!\"}]}','2026-11-25 12:31:28','2026-11-25 08:31:52'),(134,NULL,44,'leaf',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":796,\"turnos\":6,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Sawsbuck!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Carracosta!\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Sawsbuck perdeu 39 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Sawsbuck usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Carracosta perdeu 92 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Sawsbuck usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Carracosta perdeu 56 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Carracosta desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Samurott!\"},{\"tipo\":\"golpe\",\"texto\":\"Sawsbuck usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Samurott perdeu 68 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Samurott usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Samurott aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Sawsbuck usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Samurott perdeu 76 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Samurott usou Water Pulse!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Sawsbuck perdeu 79 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Sawsbuck usou Body Slam!\"},{\"tipo\":\"dano\",\"texto\":\"Samurott perdeu 28 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Samurott desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Zoroark!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"dano\",\"texto\":\"Sawsbuck perdeu 14 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Sawsbuck desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Carracosta subiu para o Nv. 58!\"},{\"tipo\":\"nivel\",\"texto\":\"Samurott subiu para o Nv. 58!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 58!\"},{\"tipo\":\"nivel\",\"texto\":\"Stoutland subiu para o Nv. 58!\"},{\"tipo\":\"nivel\",\"texto\":\"Darmanitan Standard subiu para o Nv. 58!\"},{\"tipo\":\"nivel\",\"texto\":\"Galvantula subiu para o Nv. 58!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 12:35:36','2026-11-25 08:35:51'),(135,NULL,44,'leaf',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":265,\"turnos\":4,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Inseto quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Galvantula!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Darmanitan Standard!\"},{\"tipo\":\"golpe\",\"texto\":\"Darmanitan Standard usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Darmanitan Standard aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Galvantula usou Signal Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Darmanitan Standard perdeu 30 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Darmanitan Standard usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Galvantula perdeu 125 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Galvantula desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Accelgor!\"},{\"tipo\":\"golpe\",\"texto\":\"Accelgor usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Accelgor aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Darmanitan Standard usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Accelgor perdeu 134 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Accelgor desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Durant!\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Bullet Punch!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Darmanitan Standard perdeu 60 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Darmanitan Standard usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Durant perdeu 113 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Durant desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Darmanitan Standard subiu para o Nv. 61!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 61!\"},{\"tipo\":\"nivel\",\"texto\":\"Stoutland subiu para o Nv. 61!\"},{\"tipo\":\"nivel\",\"texto\":\"Galvantula subiu para o Nv. 61!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 12:36:01','2026-11-25 08:36:11'),(136,NULL,44,'leaf',6,'VITORIA',900,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":6,\"turnos\":14,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Rival quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Golurk!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Darmanitan Standard!\"},{\"tipo\":\"golpe\",\"texto\":\"Darmanitan Standard usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Darmanitan Standard aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Golurk usou Bulldoze!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Darmanitan Standard perdeu 93 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Golurk usou Shadow Sneak!\"},{\"tipo\":\"dano\",\"texto\":\"Darmanitan Standard perdeu 44 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Darmanitan Standard usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Darmanitan Standard aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Golurk usou Shadow Sneak!\"},{\"tipo\":\"dano\",\"texto\":\"Darmanitan Standard perdeu 50 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Darmanitan Standard usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Golurk perdeu 121 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Golurk desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Serperior!\"},{\"tipo\":\"golpe\",\"texto\":\"Darmanitan Standard usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 115 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Serperior desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Samurott!\"},{\"tipo\":\"golpe\",\"texto\":\"Darmanitan Standard usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Samurott perdeu 137 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Samurott desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Hydreigon!\"},{\"tipo\":\"golpe\",\"texto\":\"Darmanitan Standard usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Hydreigon perdeu 137 HP.\"},{\"tipo\":\"status\",\"texto\":\"Hydreigon recebeu Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Hydreigon usou Dark Pulse!\"},{\"tipo\":\"dano\",\"texto\":\"Darmanitan Standard perdeu 12 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Darmanitan Standard desmaiou!\"},{\"tipo\":\"status\",\"texto\":\"Hydreigon perdeu HP por Queimadura!\"},{\"tipo\":\"desmaio\",\"texto\":\"Hydreigon desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Zoroark!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Emboar!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Emboar perdeu 107 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Emboar usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark perdeu 128 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Emboar perdeu 56 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Emboar desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Kingambit!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Kingambit perdeu 39 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Kingambit usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Kingambit aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Kingambit perdeu 74 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Kingambit usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Kingambit aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Kingambit usou Bullet Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark perdeu 16 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Zoroark desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Stoutland!\"},{\"tipo\":\"golpe\",\"texto\":\"Stoutland usou Body Slam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Kingambit perdeu 29 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Kingambit usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Kingambit aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Kingambit usou Bullet Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Stoutland perdeu 174 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Stoutland desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Galvantula!\"},{\"tipo\":\"golpe\",\"texto\":\"Kingambit usou Bullet Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Galvantula perdeu 136 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Galvantula usou Signal Beam!\"},{\"tipo\":\"dano\",\"texto\":\"Kingambit perdeu 18 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Kingambit desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Darmanitan Standard subiu para o Nv. 65!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 65!\"},{\"tipo\":\"nivel\",\"texto\":\"Stoutland subiu para o Nv. 65!\"},{\"tipo\":\"nivel\",\"texto\":\"Galvantula subiu para o Nv. 65!\"},{\"tipo\":\"nivel\",\"texto\":\"Samurott subiu para o Nv. 62!\"},{\"tipo\":\"nivel\",\"texto\":\"Sawsbuck subiu para o Nv. 51!\"},{\"tipo\":\"recuperacao\",\"texto\":\"Desafio vencido! Todo o time recuperou 100% do HP, os desmaiados reviveram e as condicoes foram curadas!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 900!\"}]}','2026-11-25 12:37:40','2026-11-25 08:38:36'),(137,NULL,45,'blue',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":802,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Munna!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Munna perdeu 14 HP.\"},{\"tipo\":\"status\",\"texto\":\"Munna recebeu Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Munna usou Psychic!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 6 HP.\"},{\"tipo\":\"status\",\"texto\":\"Munna perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Munna perdeu 2 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Munna desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 7!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 12:40:32','2026-11-25 08:40:37'),(138,NULL,45,'blue',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":809,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Joltik!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Joltik usou Shock Wave!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 7 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Joltik perdeu 20 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Joltik desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 9!\"},{\"tipo\":\"nivel\",\"texto\":\"Venipede subiu para o Nv. 9!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 12:40:46','2026-11-25 08:40:47'),(139,NULL,45,'blue',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":270,\"turnos\":4,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Lutador quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Sawk!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Venipede!\"},{\"tipo\":\"golpe\",\"texto\":\"Sawk usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Venipede perdeu 3 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Venipede usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Venipede aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Sawk usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Venipede perdeu 3 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Venipede usou Poison Jab!\"},{\"tipo\":\"dano\",\"texto\":\"Sawk perdeu 14 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Sawk usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Venipede perdeu 3 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Venipede usou Poison Jab!\"},{\"tipo\":\"dano\",\"texto\":\"Sawk perdeu 15 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Sawk usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Sawk aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Venipede usou Poison Jab!\"},{\"tipo\":\"dano\",\"texto\":\"Sawk perdeu 1 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Sawk desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Venipede subiu para o Nv. 12!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 12!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 12:40:56','2026-11-25 08:41:07'),(140,NULL,45,'blue',1,'VITORIA',900,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":1,\"turnos\":4,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 1 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Cubchoo!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Tepig aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Cubchoo aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 16 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Tepig aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 15 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 35 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Cubchoo desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Vanillish!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Vanillish aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Vanillish perdeu 40 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Vanillish desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 16!\"},{\"tipo\":\"nivel\",\"texto\":\"Venipede subiu para o Nv. 16!\"},{\"tipo\":\"recuperacao\",\"texto\":\"Desafio vencido! Todo o time recuperou 100% do HP, os desmaiados reviveram e as condicoes foram curadas!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 900!\"}]}','2026-11-25 12:41:15','2026-11-25 08:41:29'),(141,NULL,45,'blue',NULL,'DERROTA',0,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":818,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Stunfisk!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Stunfisk perdeu 17 HP.\"},{\"tipo\":\"status\",\"texto\":\"Stunfisk recebeu Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Stunfisk usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Stunfisk aumentou!\"},{\"tipo\":\"status\",\"texto\":\"Stunfisk perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Stunfisk perdeu 16 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Stunfisk usou Earth Power!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 46 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"status\",\"texto\":\"Stunfisk perdeu HP por Queimadura!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Venipede!\"},{\"tipo\":\"golpe\",\"texto\":\"Venipede usou Bug Bite!\"},{\"tipo\":\"dano\",\"texto\":\"Stunfisk perdeu 11 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Stunfisk usou Shock Wave!\"},{\"tipo\":\"dano\",\"texto\":\"Venipede perdeu 35 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Venipede desmaiou!\"},{\"tipo\":\"status\",\"texto\":\"Stunfisk perdeu HP por Queimadura!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-25 12:42:20','2026-11-25 08:42:31'),(142,NULL,46,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":842,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Patrat!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Patrat perdeu 13 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Patrat usou Body Slam!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 6 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Patrat perdeu 2 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Patrat desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 7!\"},{\"tipo\":\"nivel\",\"texto\":\"Durant subiu para o Nv. 7!\"},{\"tipo\":\"nivel\",\"texto\":\"Basculin Red Striped subiu para o Nv. 7!\"},{\"tipo\":\"nivel\",\"texto\":\"Cubchoo subiu para o Nv. 7!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 12:53:09','2026-11-25 09:03:59'),(143,NULL,46,'red',1,'VITORIA',900,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":1,\"turnos\":8,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 1 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Cubchoo!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 11 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 15 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 10 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 18 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 5 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Durant!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Durant perdeu 6 HP.\"},{\"tipo\":\"status\",\"texto\":\"Durant recebeu Congelamento!\"},{\"tipo\":\"status\",\"texto\":\"Durant está congelado!\"},{\"tipo\":\"status\",\"texto\":\"Durant descongelou!\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Bullet Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 2 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Cubchoo desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Vanillish!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Durant perdeu 17 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Durant aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Bullet Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Vanillish perdeu 26 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Vanillish aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Bullet Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Vanillish perdeu 14 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Vanillish desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 11!\"},{\"tipo\":\"nivel\",\"texto\":\"Durant subiu para o Nv. 11!\"},{\"tipo\":\"nivel\",\"texto\":\"Basculin Red Striped subiu para o Nv. 11!\"},{\"tipo\":\"nivel\",\"texto\":\"Cubchoo subiu para o Nv. 11!\"},{\"tipo\":\"recuperacao\",\"texto\":\"Desafio vencido! Todo o time recuperou 100% do HP, os desmaiados reviveram e as condicoes foram curadas!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 900!\"}]}','2026-11-25 13:04:07','2026-11-25 09:05:26'),(144,NULL,46,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":851,\"turnos\":5,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Carracosta!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 34 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Carracosta perdeu 1 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Carracosta perdeu 1 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Rock Tomb!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 1 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Durant!\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Durant aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Carracosta aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Bullet Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Carracosta perdeu 24 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Rock Tomb!\"},{\"tipo\":\"dano\",\"texto\":\"Durant perdeu 15 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Bullet Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Carracosta perdeu 6 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Carracosta desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 13!\"},{\"tipo\":\"nivel\",\"texto\":\"Durant subiu para o Nv. 13!\"},{\"tipo\":\"nivel\",\"texto\":\"Basculin Red Striped subiu para o Nv. 13!\"},{\"tipo\":\"nivel\",\"texto\":\"Cubchoo subiu para o Nv. 13!\"},{\"tipo\":\"nivel\",\"texto\":\"Cryogonal subiu para o Nv. 13!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 13:05:35','2026-11-25 09:05:50'),(145,NULL,46,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":284,\"turnos\":5,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Normal quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Stoutland!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Durant!\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Durant aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Stoutland usou Body Slam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Durant perdeu 5 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Durant aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Stoutland usou Body Slam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Durant perdeu 5 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Bullet Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Stoutland perdeu 39 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Stoutland desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Watchog!\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Bullet Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Watchog perdeu 34 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Watchog desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Sawsbuck!\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Bullet Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Sawsbuck perdeu 38 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Sawsbuck desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Durant subiu para o Nv. 16!\"},{\"tipo\":\"nivel\",\"texto\":\"Basculin Red Striped subiu para o Nv. 16!\"},{\"tipo\":\"nivel\",\"texto\":\"Cubchoo subiu para o Nv. 16!\"},{\"tipo\":\"nivel\",\"texto\":\"Cryogonal subiu para o Nv. 16!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 13:06:51','2026-11-25 09:07:04'),(146,NULL,46,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":285,\"turnos\":5,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Pedra quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Crustle!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Basculin Red Striped!\"},{\"tipo\":\"golpe\",\"texto\":\"Basculin Red Striped usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Basculin Red Striped aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Crustle usou Rock Tomb!\"},{\"tipo\":\"dano\",\"texto\":\"Basculin Red Striped perdeu 20 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Basculin Red Striped usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Crustle perdeu 43 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Crustle desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Gigalith!\"},{\"tipo\":\"golpe\",\"texto\":\"Basculin Red Striped usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Gigalith perdeu 47 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Gigalith desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Carracosta!\"},{\"tipo\":\"golpe\",\"texto\":\"Basculin Red Striped usou Aqua Jet!\"},{\"tipo\":\"dano\",\"texto\":\"Carracosta perdeu 24 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Basculin Red Striped perdeu 9 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Basculin Red Striped usou Aqua Jet!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Carracosta perdeu 20 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Carracosta desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Basculin Red Striped subiu para o Nv. 19!\"},{\"tipo\":\"nivel\",\"texto\":\"Durant subiu para o Nv. 19!\"},{\"tipo\":\"nivel\",\"texto\":\"Cubchoo subiu para o Nv. 19!\"},{\"tipo\":\"nivel\",\"texto\":\"Cryogonal subiu para o Nv. 19!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 13:07:09','2026-11-25 09:07:17'),(147,NULL,46,'red',2,'DERROTA',0,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":2,\"turnos\":16,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 2 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Frillish Female!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Durant!\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Durant aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Frillish Female usou Water Pulse!\"},{\"tipo\":\"dano\",\"texto\":\"Durant perdeu 20 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Durant aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Frillish Female usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Durant perdeu 22 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Bullet Punch!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Frillish Female perdeu 47 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Frillish Female desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Alomomola!\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Bullet Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Alomomola perdeu 32 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Alomomola usou Aqua Jet!\"},{\"tipo\":\"dano\",\"texto\":\"Durant perdeu 9 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Durant desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Cubchoo!\"},{\"tipo\":\"golpe\",\"texto\":\"Alomomola usou Aqua Jet!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 49 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Cubchoo desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Cryogonal!\"},{\"tipo\":\"golpe\",\"texto\":\"Alomomola usou Aqua Jet!\"},{\"tipo\":\"dano\",\"texto\":\"Cryogonal perdeu 26 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Cryogonal usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Cryogonal aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Alomomola usou Aqua Jet!\"},{\"tipo\":\"dano\",\"texto\":\"Cryogonal perdeu 30 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Cryogonal usou Ice Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Alomomola perdeu 28 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Cryogonal usou Ice Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Alomomola perdeu 27 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Alomomola usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Alomomola aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Alomomola usou Aqua Jet!\"},{\"tipo\":\"dano\",\"texto\":\"Cryogonal perdeu 3 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Cryogonal desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Basculin Red Striped!\"},{\"tipo\":\"golpe\",\"texto\":\"Basculin Red Striped usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Alomomola perdeu 8 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Alomomola usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Basculin Red Striped perdeu 23 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Basculin Red Striped usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Alomomola perdeu 1 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Alomomola desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Simipour!\"},{\"tipo\":\"golpe\",\"texto\":\"Simipour usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Basculin Red Striped perdeu 15 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Basculin Red Striped usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Basculin Red Striped aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Basculin Red Striped usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Simipour perdeu 22 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Simipour usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Simipour aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Basculin Red Striped usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Simipour perdeu 20 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Simipour usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Simipour aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Simipour usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Basculin Red Striped perdeu 17 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Basculin Red Striped desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Simipour usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 39 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-25 13:07:28','2026-11-25 09:07:51'),(148,NULL,47,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":865,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Shelmet!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Shelmet perdeu 16 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Shelmet desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 7!\"},{\"tipo\":\"nivel\",\"texto\":\"Pidove subiu para o Nv. 7!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 13:08:29','2026-11-25 09:08:31'),(149,NULL,47,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":289,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Normal quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Deerling!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Deerling usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Deerling aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Deerling perdeu 23 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Deerling desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 10!\"},{\"tipo\":\"nivel\",\"texto\":\"Pidove subiu para o Nv. 10!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 13:08:33','2026-11-25 09:08:34'),(150,NULL,47,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":290,\"turnos\":5,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Terra quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Drilbur!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Pidove!\"},{\"tipo\":\"golpe\",\"texto\":\"Drilbur usou Bulldoze!\"},{\"tipo\":\"imunidade\",\"texto\":\"Não afetou Pidove...\"},{\"tipo\":\"golpe\",\"texto\":\"Pidove usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Pidove aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Drilbur usou Bulldoze!\"},{\"tipo\":\"imunidade\",\"texto\":\"Não afetou Pidove...\"},{\"tipo\":\"golpe\",\"texto\":\"Pidove usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Pidove aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Drilbur usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Drilbur aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Pidove usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Pidove aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Drilbur usou Bulldoze!\"},{\"tipo\":\"imunidade\",\"texto\":\"Não afetou Pidove...\"},{\"tipo\":\"golpe\",\"texto\":\"Pidove usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque já está no máximo!\"},{\"tipo\":\"golpe\",\"texto\":\"Drilbur usou Bulldoze!\"},{\"tipo\":\"imunidade\",\"texto\":\"Não afetou Pidove...\"},{\"tipo\":\"golpe\",\"texto\":\"Pidove usou Body Slam!\"},{\"tipo\":\"dano\",\"texto\":\"Drilbur perdeu 29 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Drilbur desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Pidove subiu para o Nv. 13!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 13!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 13:08:39','2026-11-25 09:08:51'),(151,NULL,47,'red',1,'VITORIA',900,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":1,\"turnos\":5,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 1 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Cubchoo!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Pidove!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Pidove perdeu 31 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Pidove usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Pidove aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Pidove perdeu 5 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Pidove desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 7 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Tepig aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 8 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 35 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Cubchoo desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Vanillish!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 13 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Vanillish perdeu 40 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Vanillish desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Pidove subiu para o Nv. 17!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 17!\"},{\"tipo\":\"evolucao\",\"texto\":\"Tepig evoluiu para Pignite!\"},{\"tipo\":\"recuperacao\",\"texto\":\"Desafio vencido! Todo o time recuperou 100% do HP, os desmaiados reviveram e as condicoes foram curadas!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 900!\"}]}','2026-11-25 13:08:55','2026-11-25 09:09:02'),(152,NULL,47,'red',NULL,'DERROTA',0,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":291,\"turnos\":9,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Pedra quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Crustle!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Pidove!\"},{\"tipo\":\"golpe\",\"texto\":\"Pidove usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Pidove aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Crustle usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Crustle aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Pidove usou Body Slam!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Crustle perdeu 16 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Crustle usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Crustle aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Pidove usou Body Slam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Crustle perdeu 8 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Crustle usou Rock Tomb!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Pidove perdeu 44 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Pidove desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Pignite!\"},{\"tipo\":\"golpe\",\"texto\":\"Pignite usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Crustle perdeu 15 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Crustle usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Crustle aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Pignite usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Crustle perdeu 7 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Crustle desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Boldore!\"},{\"tipo\":\"golpe\",\"texto\":\"Pignite usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Boldore perdeu 34 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Boldore usou Rock Tomb!\"},{\"tipo\":\"dano\",\"texto\":\"Pignite perdeu 24 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Pignite usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Boldore perdeu 12 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Boldore desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Carracosta!\"},{\"tipo\":\"golpe\",\"texto\":\"Pignite usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Carracosta perdeu 29 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Carracosta aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Pignite perdeu 33 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Pignite desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-25 13:09:11','2026-11-25 09:09:20'),(153,NULL,48,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":892,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Joltik!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Tepig aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Joltik usou Shock Wave!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 6 HP.\"},{\"tipo\":\"status\",\"texto\":\"Tepig recebeu Paralisia!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Joltik perdeu 16 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Joltik desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 7!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 13:15:12','2026-11-25 09:15:16'),(154,NULL,48,'red',NULL,'DERROTA',0,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":297,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Psiquico quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Woobat!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Woobat usou Air Slash!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 8 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Tepig aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Woobat usou Psychic!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 9 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Woobat perdeu 21 HP.\"},{\"tipo\":\"status\",\"texto\":\"Woobat recebeu Queimadura!\"},{\"tipo\":\"status\",\"texto\":\"Woobat perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Woobat usou Psychic!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 9 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"status\",\"texto\":\"Woobat perdeu HP por Queimadura!\"},{\"tipo\":\"desmaio\",\"texto\":\"Woobat desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-25 13:15:20','2026-11-25 09:15:23'),(155,NULL,49,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":908,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Woobat!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Woobat usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Woobat aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Woobat perdeu 16 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Woobat desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 7!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 13:15:29','2026-11-25 09:15:29'),(156,NULL,49,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":911,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Timburr!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Timburr perdeu 10 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Timburr usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 11 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Timburr perdeu 12 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Timburr desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 9!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 13:15:33','2026-11-25 09:15:34'),(157,NULL,49,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":305,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Normal quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Lillipup!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Lillipup perdeu 12 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Lillipup usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Lillipup aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Lillipup perdeu 13 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Lillipup desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 12!\"},{\"tipo\":\"nivel\",\"texto\":\"Rufflet subiu para o Nv. 12!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 13:15:39','2026-11-25 09:15:41'),(158,NULL,49,'red',1,'DERROTA',0,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":1,\"turnos\":5,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 1 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Cubchoo!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 7 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 35 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Cubchoo desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Vanillish!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 13 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Vanillish perdeu 20 HP.\"},{\"tipo\":\"status\",\"texto\":\"Vanillish recebeu Queimadura!\"},{\"tipo\":\"status\",\"texto\":\"Vanillish perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 15 HP.\"},{\"tipo\":\"status\",\"texto\":\"Tepig recebeu Congelamento!\"},{\"tipo\":\"status\",\"texto\":\"Tepig está congelado!\"},{\"tipo\":\"status\",\"texto\":\"Vanillish perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 2 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"status\",\"texto\":\"Vanillish perdeu HP por Queimadura!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Rufflet!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Rufflet perdeu 38 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Rufflet desmaiou!\"},{\"tipo\":\"status\",\"texto\":\"Vanillish perdeu HP por Queimadura!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-25 13:15:46','2026-11-25 09:15:53'),(159,NULL,50,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":306,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Normal quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Lillipup!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Tepig aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Lillipup usou Body Slam!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 6 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Lillipup usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Lillipup aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Lillipup perdeu 17 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Lillipup desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 8!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 13:15:59','2026-11-25 09:16:01'),(160,NULL,50,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":308,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Normal quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Deerling!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Deerling usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Deerling aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Deerling perdeu 25 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Deerling desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 11!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 13:16:04','2026-11-25 09:16:05'),(161,NULL,50,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":310,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Pedra quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Dwebble!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tympole!\"},{\"tipo\":\"golpe\",\"texto\":\"Tympole usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Dwebble perdeu 20 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Dwebble usou Bug Bite!\"},{\"tipo\":\"dano\",\"texto\":\"Tympole perdeu 12 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tympole usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Dwebble perdeu 8 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Dwebble desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tympole subiu para o Nv. 14!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 14!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 13:16:12','2026-11-25 09:16:14'),(162,NULL,50,'red',1,'VITORIA',900,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":1,\"turnos\":4,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 1 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Cubchoo!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Palpitoad!\"},{\"tipo\":\"golpe\",\"texto\":\"Palpitoad usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Palpitoad aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Cubchoo aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"dano\",\"texto\":\"Palpitoad perdeu 26 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Palpitoad usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Palpitoad aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Palpitoad usou Aqua Jet!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 35 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Cubchoo desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Vanillish!\"},{\"tipo\":\"golpe\",\"texto\":\"Palpitoad usou Aqua Jet!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Vanillish perdeu 40 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Vanillish desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Palpitoad subiu para o Nv. 18!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 18!\"},{\"tipo\":\"evolucao\",\"texto\":\"Tepig evoluiu para Pignite!\"},{\"tipo\":\"recuperacao\",\"texto\":\"Desafio vencido! Todo o time recuperou 100% do HP, os desmaiados reviveram e as condicoes foram curadas!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 900!\"}]}','2026-11-25 13:16:34','2026-11-25 09:16:40'),(163,NULL,50,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":313,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Terra quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Stunfisk!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Palpitoad!\"},{\"tipo\":\"golpe\",\"texto\":\"Palpitoad usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Stunfisk perdeu 33 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Stunfisk usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Stunfisk aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Palpitoad usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Stunfisk perdeu 27 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Stunfisk desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Krokorok!\"},{\"tipo\":\"golpe\",\"texto\":\"Palpitoad usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Krokorok perdeu 45 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Krokorok desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Palpitoad subiu para o Nv. 21!\"},{\"tipo\":\"nivel\",\"texto\":\"Venipede subiu para o Nv. 21!\"},{\"tipo\":\"nivel\",\"texto\":\"Pignite subiu para o Nv. 21!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 13:17:29','2026-11-25 09:17:33'),(164,NULL,50,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":315,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Inseto quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Galvantula!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Pignite!\"},{\"tipo\":\"golpe\",\"texto\":\"Galvantula usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Galvantula aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Pignite usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Galvantula perdeu 53 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Galvantula desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Durant!\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Durant aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Pignite usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Durant perdeu 48 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Durant desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Pignite subiu para o Nv. 24!\"},{\"tipo\":\"nivel\",\"texto\":\"Venipede subiu para o Nv. 24!\"},{\"tipo\":\"evolucao\",\"texto\":\"Venipede evoluiu para Whirlipede!\"},{\"tipo\":\"nivel\",\"texto\":\"Palpitoad subiu para o Nv. 24!\"},{\"tipo\":\"nivel\",\"texto\":\"Yamask subiu para o Nv. 24!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 13:17:44','2026-11-25 09:17:46'),(165,NULL,50,'red',2,'VITORIA',900,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":2,\"turnos\":5,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 2 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Frillish Female!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Cofagrigus!\"},{\"tipo\":\"golpe\",\"texto\":\"Cofagrigus usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Cofagrigus aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Frillish Female usou Shadow Ball!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Cofagrigus perdeu 17 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Cofagrigus usou Shadow Ball!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Frillish Female perdeu 47 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Frillish Female desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Alomomola!\"},{\"tipo\":\"golpe\",\"texto\":\"Alomomola usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Alomomola aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Cofagrigus usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Alomomola perdeu 86 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Alomomola usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Alomomola aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Cofagrigus usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Alomomola perdeu 10 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Alomomola desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Simipour!\"},{\"tipo\":\"golpe\",\"texto\":\"Simipour usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Simipour aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Cofagrigus usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Simipour perdeu 65 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Simipour desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Cofagrigus subiu para o Nv. 28!\"},{\"tipo\":\"nivel\",\"texto\":\"Whirlipede subiu para o Nv. 28!\"},{\"tipo\":\"nivel\",\"texto\":\"Palpitoad subiu para o Nv. 28!\"},{\"tipo\":\"nivel\",\"texto\":\"Pignite subiu para o Nv. 28!\"},{\"tipo\":\"recuperacao\",\"texto\":\"Desafio vencido! Todo o time recuperou 100% do HP, os desmaiados reviveram e as condicoes foram curadas!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 900!\"}]}','2026-11-25 13:22:10','2026-11-25 09:22:17'),(166,NULL,50,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":316,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Inseto quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Galvantula!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Pignite!\"},{\"tipo\":\"golpe\",\"texto\":\"Galvantula usou Shock Wave!\"},{\"tipo\":\"dano\",\"texto\":\"Pignite perdeu 34 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Pignite usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Galvantula perdeu 70 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Galvantula desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Accelgor!\"},{\"tipo\":\"golpe\",\"texto\":\"Accelgor usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Accelgor aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Pignite usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Accelgor perdeu 75 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Accelgor desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Durant!\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Durant aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Pignite usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Durant perdeu 64 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Durant desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Pignite subiu para o Nv. 31!\"},{\"tipo\":\"nivel\",\"texto\":\"Whirlipede subiu para o Nv. 31!\"},{\"tipo\":\"evolucao\",\"texto\":\"Whirlipede evoluiu para Scolipede!\"},{\"tipo\":\"nivel\",\"texto\":\"Palpitoad subiu para o Nv. 31!\"},{\"tipo\":\"nivel\",\"texto\":\"Cofagrigus subiu para o Nv. 31!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 13:23:19','2026-11-25 09:23:22'),(167,NULL,50,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":963,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Galvantula!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Pignite!\"},{\"tipo\":\"golpe\",\"texto\":\"Galvantula usou Signal Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Pignite perdeu 8 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Pignite usou Fire Fang!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Galvantula perdeu 72 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Galvantula desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Pignite subiu para o Nv. 33!\"},{\"tipo\":\"nivel\",\"texto\":\"Scolipede subiu para o Nv. 33!\"},{\"tipo\":\"nivel\",\"texto\":\"Palpitoad subiu para o Nv. 33!\"},{\"tipo\":\"nivel\",\"texto\":\"Cofagrigus subiu para o Nv. 33!\"},{\"tipo\":\"nivel\",\"texto\":\"Klink subiu para o Nv. 33!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 13:23:49','2026-11-25 09:23:50'),(168,NULL,50,'red',3,'VITORIA',900,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":3,\"turnos\":10,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 3 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Emolga!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Palpitoad!\"},{\"tipo\":\"golpe\",\"texto\":\"Emolga usou Acrobatics!\"},{\"tipo\":\"dano\",\"texto\":\"Palpitoad perdeu 18 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Palpitoad usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Palpitoad aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Palpitoad usou Aqua Jet!\"},{\"tipo\":\"dano\",\"texto\":\"Emolga perdeu 58 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Emolga desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Tranquill!\"},{\"tipo\":\"golpe\",\"texto\":\"Palpitoad usou Aqua Jet!\"},{\"tipo\":\"dano\",\"texto\":\"Tranquill perdeu 66 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tranquill desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Swanna!\"},{\"tipo\":\"golpe\",\"texto\":\"Palpitoad usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Swanna perdeu 32 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Swanna usou Acrobatics!\"},{\"tipo\":\"dano\",\"texto\":\"Palpitoad perdeu 31 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Palpitoad usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Swanna perdeu 33 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Swanna usou Acrobatics!\"},{\"tipo\":\"dano\",\"texto\":\"Palpitoad perdeu 29 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Swanna usou Aqua Jet!\"},{\"tipo\":\"dano\",\"texto\":\"Palpitoad perdeu 14 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Palpitoad desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Scolipede!\"},{\"tipo\":\"golpe\",\"texto\":\"Scolipede usou Bug Bite!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Swanna perdeu 12 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Swanna desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Archeops!\"},{\"tipo\":\"golpe\",\"texto\":\"Scolipede usou Bug Bite!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Archeops perdeu 22 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Archeops usou Acrobatics!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Scolipede perdeu 68 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Scolipede usou Bug Bite!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Archeops perdeu 24 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Archeops usou Acrobatics!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Scolipede perdeu 14 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Scolipede desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Pignite!\"},{\"tipo\":\"golpe\",\"texto\":\"Archeops usou Rock Tomb!\"},{\"tipo\":\"dano\",\"texto\":\"Pignite perdeu 46 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Pignite usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Archeops perdeu 36 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Archeops desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Palpitoad subiu para o Nv. 37!\"},{\"tipo\":\"evolucao\",\"texto\":\"Palpitoad evoluiu para Seismitoad!\"},{\"tipo\":\"nivel\",\"texto\":\"Scolipede subiu para o Nv. 37!\"},{\"tipo\":\"nivel\",\"texto\":\"Pignite subiu para o Nv. 37!\"},{\"tipo\":\"evolucao\",\"texto\":\"Pignite evoluiu para Emboar!\"},{\"tipo\":\"nivel\",\"texto\":\"Cofagrigus subiu para o Nv. 37!\"},{\"tipo\":\"nivel\",\"texto\":\"Klink subiu para o Nv. 37!\"},{\"tipo\":\"recuperacao\",\"texto\":\"Desafio vencido! Todo o time recuperou 100% do HP, os desmaiados reviveram e as condicoes foram curadas!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 900!\"}]}','2026-11-25 13:24:02','2026-11-25 09:24:17'),(169,NULL,50,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":321,\"turnos\":5,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Terra quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Stunfisk!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Seismitoad!\"},{\"tipo\":\"golpe\",\"texto\":\"Seismitoad usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Stunfisk perdeu 78 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Stunfisk usou Earth Power!\"},{\"tipo\":\"dano\",\"texto\":\"Seismitoad perdeu 28 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Seismitoad usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Stunfisk perdeu 36 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Stunfisk desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Krokorok!\"},{\"tipo\":\"golpe\",\"texto\":\"Seismitoad usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Krokorok perdeu 82 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Krokorok desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Excadrill!\"},{\"tipo\":\"golpe\",\"texto\":\"Seismitoad usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Excadrill perdeu 93 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Excadrill usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Excadrill aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Excadrill usou Bullet Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Seismitoad perdeu 44 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Seismitoad usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Excadrill perdeu 22 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Excadrill desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Seismitoad subiu para o Nv. 40!\"},{\"tipo\":\"nivel\",\"texto\":\"Scolipede subiu para o Nv. 40!\"},{\"tipo\":\"nivel\",\"texto\":\"Emboar subiu para o Nv. 40!\"},{\"tipo\":\"nivel\",\"texto\":\"Cofagrigus subiu para o Nv. 40!\"},{\"tipo\":\"nivel\",\"texto\":\"Klink subiu para o Nv. 40!\"},{\"tipo\":\"evolucao\",\"texto\":\"Klink evoluiu para Klang!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 13:24:53','2026-11-25 09:24:59'),(170,NULL,50,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":322,\"turnos\":4,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Lutador quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Gurdurr!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Cofagrigus!\"},{\"tipo\":\"golpe\",\"texto\":\"Gurdurr usou Drain Punch!\"},{\"tipo\":\"imunidade\",\"texto\":\"Não afetou Cofagrigus...\"},{\"tipo\":\"golpe\",\"texto\":\"Cofagrigus usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Cofagrigus aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Gurdurr usou Drain Punch!\"},{\"tipo\":\"imunidade\",\"texto\":\"Não afetou Cofagrigus...\"},{\"tipo\":\"golpe\",\"texto\":\"Cofagrigus usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Cofagrigus aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Gurdurr usou Drain Punch!\"},{\"tipo\":\"imunidade\",\"texto\":\"Não afetou Cofagrigus...\"},{\"tipo\":\"golpe\",\"texto\":\"Cofagrigus usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Gurdurr perdeu 101 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Gurdurr desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Throh!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"imunidade\",\"texto\":\"Não afetou Cofagrigus...\"},{\"tipo\":\"golpe\",\"texto\":\"Cofagrigus usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 125 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Throh desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Cofagrigus subiu para o Nv. 43!\"},{\"tipo\":\"nivel\",\"texto\":\"Scolipede subiu para o Nv. 43!\"},{\"tipo\":\"nivel\",\"texto\":\"Emboar subiu para o Nv. 43!\"},{\"tipo\":\"nivel\",\"texto\":\"Seismitoad subiu para o Nv. 43!\"},{\"tipo\":\"nivel\",\"texto\":\"Klang subiu para o Nv. 43!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 13:25:07','2026-11-25 09:25:11'),(171,NULL,50,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":324,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Terra quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Krokorok!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Seismitoad!\"},{\"tipo\":\"golpe\",\"texto\":\"Seismitoad usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Krokorok perdeu 84 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Krokorok desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Excadrill!\"},{\"tipo\":\"golpe\",\"texto\":\"Seismitoad usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Excadrill perdeu 118 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Excadrill desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Seismitoad subiu para o Nv. 46!\"},{\"tipo\":\"nivel\",\"texto\":\"Scolipede subiu para o Nv. 46!\"},{\"tipo\":\"nivel\",\"texto\":\"Emboar subiu para o Nv. 46!\"},{\"tipo\":\"nivel\",\"texto\":\"Cofagrigus subiu para o Nv. 46!\"},{\"tipo\":\"nivel\",\"texto\":\"Klang subiu para o Nv. 46!\"},{\"tipo\":\"evolucao\",\"texto\":\"Klang evoluiu para Klinklang!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 13:25:17','2026-11-25 09:25:19'),(172,NULL,50,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":977,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Carracosta!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Seismitoad!\"},{\"tipo\":\"golpe\",\"texto\":\"Seismitoad usou Aqua Jet!\"},{\"tipo\":\"dano\",\"texto\":\"Carracosta perdeu 35 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Aqua Jet!\"},{\"tipo\":\"dano\",\"texto\":\"Seismitoad perdeu 33 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Seismitoad usou Aqua Jet!\"},{\"tipo\":\"dano\",\"texto\":\"Carracosta perdeu 40 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Aqua Jet!\"},{\"tipo\":\"dano\",\"texto\":\"Seismitoad perdeu 31 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Seismitoad usou Aqua Jet!\"},{\"tipo\":\"dano\",\"texto\":\"Carracosta perdeu 16 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Carracosta desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Seismitoad subiu para o Nv. 48!\"},{\"tipo\":\"nivel\",\"texto\":\"Scolipede subiu para o Nv. 48!\"},{\"tipo\":\"nivel\",\"texto\":\"Emboar subiu para o Nv. 48!\"},{\"tipo\":\"nivel\",\"texto\":\"Cofagrigus subiu para o Nv. 48!\"},{\"tipo\":\"nivel\",\"texto\":\"Klinklang subiu para o Nv. 48!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 13:26:04','2026-11-25 09:26:07'),(173,NULL,50,'red',4,'VITORIA',900,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":4,\"turnos\":7,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 4 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Heatmor!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Seismitoad!\"},{\"tipo\":\"golpe\",\"texto\":\"Seismitoad usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Heatmor perdeu 85 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Heatmor desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Simisear!\"},{\"tipo\":\"golpe\",\"texto\":\"Seismitoad usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Simisear perdeu 85 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Simisear desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Darmanitan Standard!\"},{\"tipo\":\"golpe\",\"texto\":\"Seismitoad usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Darmanitan Standard perdeu 109 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Darmanitan Standard desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Chandelure!\"},{\"tipo\":\"golpe\",\"texto\":\"Seismitoad usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Seismitoad aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Chandelure usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Chandelure aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Seismitoad usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Seismitoad aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Chandelure usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Seismitoad perdeu 79 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Seismitoad usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Chandelure perdeu 84 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Chandelure desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Volcarona!\"},{\"tipo\":\"golpe\",\"texto\":\"Seismitoad usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Volcarona perdeu 107 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Volcarona desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Seismitoad subiu para o Nv. 52!\"},{\"tipo\":\"nivel\",\"texto\":\"Scolipede subiu para o Nv. 52!\"},{\"tipo\":\"nivel\",\"texto\":\"Emboar subiu para o Nv. 52!\"},{\"tipo\":\"nivel\",\"texto\":\"Cofagrigus subiu para o Nv. 52!\"},{\"tipo\":\"nivel\",\"texto\":\"Klinklang subiu para o Nv. 52!\"},{\"tipo\":\"recuperacao\",\"texto\":\"Desafio vencido! Todo o time recuperou 100% do HP, os desmaiados reviveram e as condicoes foram curadas!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 900!\"}]}','2026-11-25 13:26:22','2026-11-25 09:26:30'),(174,NULL,50,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":326,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Normal quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Lillipup!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Emboar!\"},{\"tipo\":\"golpe\",\"texto\":\"Emboar usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Lillipup perdeu 87 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Lillipup desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Emboar subiu para o Nv. 55!\"},{\"tipo\":\"nivel\",\"texto\":\"Scolipede subiu para o Nv. 55!\"},{\"tipo\":\"nivel\",\"texto\":\"Seismitoad subiu para o Nv. 55!\"},{\"tipo\":\"nivel\",\"texto\":\"Cofagrigus subiu para o Nv. 55!\"},{\"tipo\":\"nivel\",\"texto\":\"Klinklang subiu para o Nv. 55!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 13:30:33','2026-11-25 09:30:34'),(175,NULL,50,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":328,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Psiquico quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Gothita!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Cofagrigus!\"},{\"tipo\":\"golpe\",\"texto\":\"Gothita usou Psychic!\"},{\"tipo\":\"dano\",\"texto\":\"Cofagrigus perdeu 14 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Cofagrigus usou Shadow Ball!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Gothita perdeu 87 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Gothita desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Munna!\"},{\"tipo\":\"golpe\",\"texto\":\"Cofagrigus usou Shadow Ball!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Munna perdeu 113 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Munna desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Cofagrigus subiu para o Nv. 58!\"},{\"tipo\":\"nivel\",\"texto\":\"Scolipede subiu para o Nv. 58!\"},{\"tipo\":\"nivel\",\"texto\":\"Seismitoad subiu para o Nv. 58!\"},{\"tipo\":\"nivel\",\"texto\":\"Emboar subiu para o Nv. 58!\"},{\"tipo\":\"nivel\",\"texto\":\"Klinklang subiu para o Nv. 58!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 13:31:12','2026-11-25 09:31:13'),(176,NULL,50,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":329,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Psiquico quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Woobat!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Cofagrigus!\"},{\"tipo\":\"golpe\",\"texto\":\"Woobat usou Air Slash!\"},{\"tipo\":\"dano\",\"texto\":\"Cofagrigus perdeu 15 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Cofagrigus usou Shadow Ball!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Woobat perdeu 104 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Woobat desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Cofagrigus subiu para o Nv. 61!\"},{\"tipo\":\"nivel\",\"texto\":\"Scolipede subiu para o Nv. 61!\"},{\"tipo\":\"nivel\",\"texto\":\"Seismitoad subiu para o Nv. 61!\"},{\"tipo\":\"nivel\",\"texto\":\"Emboar subiu para o Nv. 61!\"},{\"tipo\":\"nivel\",\"texto\":\"Klinklang subiu para o Nv. 61!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 13:31:19','2026-11-25 09:31:20'),(177,NULL,50,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":330,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Normal quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Patrat!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Emboar!\"},{\"tipo\":\"golpe\",\"texto\":\"Emboar usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Patrat perdeu 87 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Patrat desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Emboar subiu para o Nv. 64!\"},{\"tipo\":\"nivel\",\"texto\":\"Scolipede subiu para o Nv. 64!\"},{\"tipo\":\"nivel\",\"texto\":\"Seismitoad subiu para o Nv. 64!\"},{\"tipo\":\"nivel\",\"texto\":\"Cofagrigus subiu para o Nv. 64!\"},{\"tipo\":\"nivel\",\"texto\":\"Klinklang subiu para o Nv. 64!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 13:31:28','2026-11-25 09:31:43'),(178,NULL,50,'red',5,'VITORIA',900,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":5,\"turnos\":9,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ex-Campeão quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Scrafty!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Emboar!\"},{\"tipo\":\"golpe\",\"texto\":\"Emboar usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Emboar aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Scrafty usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Scrafty aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Emboar usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Emboar aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Scrafty usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Emboar perdeu 44 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Emboar usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Scrafty perdeu 85 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Scrafty desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Braviary!\"},{\"tipo\":\"golpe\",\"texto\":\"Emboar usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Braviary perdeu 115 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Braviary desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Amoonguss!\"},{\"tipo\":\"golpe\",\"texto\":\"Emboar usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Amoonguss perdeu 131 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Amoonguss desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Seismitoad!\"},{\"tipo\":\"golpe\",\"texto\":\"Emboar usou Drain Punch!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Seismitoad perdeu 130 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Seismitoad desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Beartic!\"},{\"tipo\":\"golpe\",\"texto\":\"Emboar usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Beartic perdeu 128 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Beartic desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Eelektross!\"},{\"tipo\":\"golpe\",\"texto\":\"Emboar usou Fire Fang!\"},{\"tipo\":\"erro\",\"texto\":\"O ataque de Emboar errou!\"},{\"tipo\":\"golpe\",\"texto\":\"Eelektross usou Spark!\"},{\"tipo\":\"dano\",\"texto\":\"Emboar perdeu 42 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Emboar usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Eelektross perdeu 126 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Eelektross desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Emboar subiu para o Nv. 68!\"},{\"tipo\":\"nivel\",\"texto\":\"Scolipede subiu para o Nv. 68!\"},{\"tipo\":\"nivel\",\"texto\":\"Seismitoad subiu para o Nv. 68!\"},{\"tipo\":\"nivel\",\"texto\":\"Cofagrigus subiu para o Nv. 68!\"},{\"tipo\":\"nivel\",\"texto\":\"Klinklang subiu para o Nv. 68!\"},{\"tipo\":\"recuperacao\",\"texto\":\"Desafio vencido! Todo o time recuperou 100% do HP, os desmaiados reviveram e as condicoes foram curadas!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 900!\"}]}','2026-11-25 13:31:47','2026-11-25 09:32:03'),(179,NULL,50,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":998,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Throh!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Emboar!\"},{\"tipo\":\"golpe\",\"texto\":\"Emboar usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Emboar aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Throh aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Emboar usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Emboar aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Throh aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Emboar usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 169 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Throh desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Emboar subiu para o Nv. 70!\"},{\"tipo\":\"nivel\",\"texto\":\"Scolipede subiu para o Nv. 70!\"},{\"tipo\":\"nivel\",\"texto\":\"Seismitoad subiu para o Nv. 70!\"},{\"tipo\":\"nivel\",\"texto\":\"Cofagrigus subiu para o Nv. 70!\"},{\"tipo\":\"nivel\",\"texto\":\"Klinklang subiu para o Nv. 70!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 13:32:36','2026-11-25 09:32:55'),(180,NULL,50,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":335,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Normal quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Watchog!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Emboar!\"},{\"tipo\":\"golpe\",\"texto\":\"Emboar usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Watchog perdeu 115 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Watchog desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Sawsbuck!\"},{\"tipo\":\"golpe\",\"texto\":\"Emboar usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Sawsbuck perdeu 134 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Sawsbuck desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Emboar subiu para o Nv. 73!\"},{\"tipo\":\"nivel\",\"texto\":\"Scolipede subiu para o Nv. 73!\"},{\"tipo\":\"nivel\",\"texto\":\"Seismitoad subiu para o Nv. 73!\"},{\"tipo\":\"nivel\",\"texto\":\"Cofagrigus subiu para o Nv. 73!\"},{\"tipo\":\"nivel\",\"texto\":\"Klinklang subiu para o Nv. 73!\"},{\"tipo\":\"nivel\",\"texto\":\"Vanillite subiu para o Nv. 73!\"},{\"tipo\":\"evolucao\",\"texto\":\"Vanillite evoluiu para Vanillish!\"},{\"tipo\":\"evolucao\",\"texto\":\"Vanillish evoluiu para Vanilluxe!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 13:35:22','2026-11-25 09:35:23'),(181,NULL,50,'red',6,'VITORIA',900,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":6,\"turnos\":12,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Rival quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Golurk!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Emboar!\"},{\"tipo\":\"golpe\",\"texto\":\"Golurk usou Shadow Sneak!\"},{\"tipo\":\"dano\",\"texto\":\"Emboar perdeu 38 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Emboar usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Emboar aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Golurk usou Shadow Sneak!\"},{\"tipo\":\"dano\",\"texto\":\"Emboar perdeu 39 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Emboar usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Emboar aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Golurk usou Shadow Sneak!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Emboar perdeu 67 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Emboar usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Emboar aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Golurk usou Shadow Sneak!\"},{\"tipo\":\"dano\",\"texto\":\"Emboar perdeu 37 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Emboar usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Golurk perdeu 121 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Golurk desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Serperior!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Emboar perdeu 13 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Emboar usou Fire Fang!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 115 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Serperior desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Samurott!\"},{\"tipo\":\"golpe\",\"texto\":\"Emboar usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Samurott perdeu 137 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Samurott desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Hydreigon!\"},{\"tipo\":\"golpe\",\"texto\":\"Emboar usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Hydreigon perdeu 140 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Hydreigon desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Emboar!\"},{\"tipo\":\"golpe\",\"texto\":\"Emboar usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Emboar perdeu 163 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Emboar desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Kingambit!\"},{\"tipo\":\"golpe\",\"texto\":\"Kingambit usou Sucker Punch!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Emboar perdeu 49 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Emboar desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Scolipede!\"},{\"tipo\":\"golpe\",\"texto\":\"Kingambit usou Bullet Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Scolipede perdeu 41 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Scolipede usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Scolipede aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Scolipede usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Scolipede aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Kingambit usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Kingambit aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Scolipede usou Bug Bite!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Kingambit perdeu 160 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Kingambit desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Emboar subiu para o Nv. 77!\"},{\"tipo\":\"nivel\",\"texto\":\"Scolipede subiu para o Nv. 77!\"},{\"tipo\":\"nivel\",\"texto\":\"Seismitoad subiu para o Nv. 77!\"},{\"tipo\":\"nivel\",\"texto\":\"Cofagrigus subiu para o Nv. 77!\"},{\"tipo\":\"nivel\",\"texto\":\"Klinklang subiu para o Nv. 77!\"},{\"tipo\":\"nivel\",\"texto\":\"Vanilluxe subiu para o Nv. 77!\"},{\"tipo\":\"recuperacao\",\"texto\":\"Desafio vencido! Todo o time recuperou 100% do HP, os desmaiados reviveram e as condicoes foram curadas!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 900!\"}]}','2026-11-25 13:35:46','2026-11-25 09:35:59'),(182,NULL,51,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1013,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Dwebble!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"erro\",\"texto\":\"O ataque de Tepig errou!\"},{\"tipo\":\"golpe\",\"texto\":\"Dwebble usou Bug Bite!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 2 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Dwebble perdeu 9 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Dwebble usou Bug Bite!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 2 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Dwebble perdeu 7 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Dwebble desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 6!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 13:41:14','2026-11-25 09:41:17'),(183,NULL,51,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":338,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Inseto quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Shelmet!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"erro\",\"texto\":\"O ataque de Tepig errou!\"},{\"tipo\":\"golpe\",\"texto\":\"Shelmet usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Shelmet aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Shelmet perdeu 16 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Shelmet usou Bug Bite!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 6 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Shelmet perdeu 4 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Shelmet desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 8!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 13:41:20','2026-11-25 09:41:22'),(184,NULL,51,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":340,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Pedra quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Dwebble!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Snivy!\"},{\"tipo\":\"golpe\",\"texto\":\"Snivy usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Dwebble perdeu 8 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Dwebble usou Bug Bite!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Snivy perdeu 17 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Snivy usou Leaf Blade!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Dwebble perdeu 15 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Dwebble usou Rock Tomb!\"},{\"tipo\":\"dano\",\"texto\":\"Snivy perdeu 8 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Snivy desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Dwebble usou Bug Bite!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 5 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Dwebble perdeu 1 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Dwebble desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Snivy subiu para o Nv. 10!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 10!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 13:41:42','2026-11-25 09:41:44'),(185,NULL,51,'red',1,'VITORIA',900,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":1,\"turnos\":5,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 1 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Cubchoo!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 8 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 31 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 4 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Cubchoo desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Vanillish!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 15 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Vanillish perdeu 19 HP.\"},{\"tipo\":\"status\",\"texto\":\"Vanillish recebeu Queimadura!\"},{\"tipo\":\"status\",\"texto\":\"Vanillish perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Vanillish aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Vanillish perdeu 18 HP.\"},{\"tipo\":\"status\",\"texto\":\"Vanillish perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 10 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"status\",\"texto\":\"Vanillish perdeu HP por Queimadura!\"},{\"tipo\":\"desmaio\",\"texto\":\"Vanillish desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Snivy!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 13!\"},{\"tipo\":\"nivel\",\"texto\":\"Snivy subiu para o Nv. 13!\"},{\"tipo\":\"recuperacao\",\"texto\":\"Desafio vencido! Todo o time recuperou 100% do HP, os desmaiados reviveram e as condicoes foram curadas!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 900!\"}]}','2026-11-25 13:41:49','2026-11-25 09:41:52'),(186,NULL,51,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":341,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Inseto quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Galvantula!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Galvantula usou Signal Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 10 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Galvantula perdeu 36 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Galvantula desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Accelgor!\"},{\"tipo\":\"golpe\",\"texto\":\"Accelgor usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Accelgor aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Accelgor perdeu 38 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Accelgor desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Durant!\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Bullet Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 9 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Durant perdeu 33 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Durant desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 15!\"},{\"tipo\":\"nivel\",\"texto\":\"Snivy subiu para o Nv. 15!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 13:44:02','2026-11-25 09:44:05'),(187,NULL,51,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":345,\"turnos\":9,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Terra quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Stunfisk!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Panpour!\"},{\"tipo\":\"golpe\",\"texto\":\"Panpour usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Stunfisk perdeu 26 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Stunfisk usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Stunfisk aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Panpour usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Stunfisk perdeu 25 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Stunfisk desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Krookodile!\"},{\"tipo\":\"golpe\",\"texto\":\"Krookodile usou Sucker Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Panpour perdeu 24 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Panpour usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Krookodile perdeu 26 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Krookodile usou Sucker Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Panpour perdeu 16 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Panpour desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Snivy!\"},{\"tipo\":\"golpe\",\"texto\":\"Krookodile usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Krookodile aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Snivy usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Krookodile perdeu 21 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Krookodile desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Excadrill!\"},{\"tipo\":\"golpe\",\"texto\":\"Excadrill usou Bulldoze!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Snivy perdeu 11 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Snivy usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Excadrill perdeu 15 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Excadrill usou Bullet Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Snivy perdeu 24 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Snivy usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Excadrill perdeu 14 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Excadrill usou Bulldoze!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Snivy perdeu 3 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Snivy desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Excadrill usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Excadrill aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Excadrill perdeu 22 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Excadrill desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Panpour subiu para o Nv. 17!\"},{\"tipo\":\"nivel\",\"texto\":\"Snivy subiu para o Nv. 17!\"},{\"tipo\":\"evolucao\",\"texto\":\"Snivy evoluiu para Servine!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 17!\"},{\"tipo\":\"evolucao\",\"texto\":\"Tepig evoluiu para Pignite!\"},{\"tipo\":\"nivel\",\"texto\":\"Pansear subiu para o Nv. 17!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 13:44:18','2026-11-25 09:44:25'),(188,NULL,51,'red',2,'DERROTA',0,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":2,\"turnos\":11,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 2 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Frillish Female!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Servine!\"},{\"tipo\":\"golpe\",\"texto\":\"Servine usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Servine aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Frillish Female usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Servine perdeu 16 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Servine usou Leaf Blade!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Frillish Female perdeu 47 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Frillish Female desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Alomomola!\"},{\"tipo\":\"golpe\",\"texto\":\"Servine usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Alomomola perdeu 48 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Alomomola usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Alomomola aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Alomomola usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Servine perdeu 20 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Servine usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Alomomola perdeu 43 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Alomomola usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Servine perdeu 11 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Servine desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Panpour!\"},{\"tipo\":\"golpe\",\"texto\":\"Alomomola usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Panpour perdeu 30 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Panpour usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Alomomola perdeu 5 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Alomomola desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Simipour!\"},{\"tipo\":\"golpe\",\"texto\":\"Simipour usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Panpour perdeu 14 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Panpour desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Pansear!\"},{\"tipo\":\"golpe\",\"texto\":\"Simipour usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Simipour aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Pansear usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Simipour perdeu 5 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Simipour usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Simipour aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Pansear usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Simipour perdeu 5 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Simipour usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Pansear perdeu 44 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Pansear desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Pignite!\"},{\"tipo\":\"golpe\",\"texto\":\"Simipour usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Pignite perdeu 57 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Pignite desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-25 13:45:02','2026-11-25 09:45:12'),(189,NULL,52,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1043,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Roggenrola!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Roggenrola perdeu 9 HP.\"},{\"tipo\":\"status\",\"texto\":\"Roggenrola recebeu Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Roggenrola usou Rock Tomb!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 13 HP.\"},{\"tipo\":\"status\",\"texto\":\"Roggenrola perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Roggenrola perdeu 4 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Roggenrola usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Roggenrola aumentou!\"},{\"tipo\":\"status\",\"texto\":\"Roggenrola perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Roggenrola perdeu 1 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Roggenrola desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 6!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 13:46:38','2026-11-25 09:46:41'),(190,NULL,52,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1047,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Deerling!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Deerling usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Deerling aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Deerling perdeu 18 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Deerling desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 7!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 13:46:44','2026-11-25 09:46:44'),(191,NULL,52,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1053,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Drilbur!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Drilbur usou Bulldoze!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 21 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Darumaka Galar!\"},{\"tipo\":\"golpe\",\"texto\":\"Darumaka Galar usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Drilbur perdeu 21 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Drilbur desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 8!\"},{\"tipo\":\"nivel\",\"texto\":\"Darumaka Galar subiu para o Nv. 8!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 13:46:54','2026-11-25 09:46:57'),(192,NULL,52,'red',1,'DERROTA',0,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":1,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 1 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Cubchoo!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Darumaka Galar!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Darumaka Galar perdeu 10 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Darumaka Galar usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Darumaka Galar aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Darumaka Galar perdeu 10 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Darumaka Galar usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 12 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Darumaka Galar perdeu 9 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Darumaka Galar desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-25 13:47:11','2026-11-25 09:47:13'),(193,NULL,53,'red',NULL,'DERROTA',0,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1058,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Roggenrola!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Roggenrola perdeu 4 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Roggenrola usou Rock Tomb!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 12 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Roggenrola perdeu 4 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Roggenrola usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Roggenrola aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"erro\",\"texto\":\"O ataque de Tepig errou!\"},{\"tipo\":\"golpe\",\"texto\":\"Roggenrola usou Rock Tomb!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 9 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-25 13:47:22','2026-11-25 09:47:24'),(194,NULL,54,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":356,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Normal quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Deerling!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Deerling usou Body Slam!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 14 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Deerling perdeu 18 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Deerling desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 7!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 13:47:31','2026-11-25 09:47:32'),(195,NULL,54,'red',NULL,'DERROTA',0,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":357,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Psiquico quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Munna!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"erro\",\"texto\":\"O ataque de Tepig errou!\"},{\"tipo\":\"golpe\",\"texto\":\"Munna usou Psychic!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 11 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Munna perdeu 10 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Munna usou Psychic!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 7 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-25 13:47:35','2026-11-25 09:47:37'),(196,NULL,55,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1087,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Timburr!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Timburr perdeu 12 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Timburr usou Drain Punch!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 12 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Timburr perdeu 5 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Timburr desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 6!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 13:48:18','2026-11-25 09:48:20'),(197,NULL,55,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1091,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Dwebble!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Dwebble perdeu 8 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Dwebble usou Rock Tomb!\"},{\"tipo\":\"erro\",\"texto\":\"O ataque de Dwebble errou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Dwebble perdeu 9 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Dwebble usou Bug Bite!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 2 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Dwebble perdeu 1 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Dwebble desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 7!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 13:48:23','2026-11-25 09:48:25'),(198,NULL,55,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":365,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Normal quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Patrat!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Patrat perdeu 13 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Patrat usou Body Slam!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 8 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Patrat perdeu 8 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Patrat desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 9!\"},{\"tipo\":\"nivel\",\"texto\":\"Heatmor subiu para o Nv. 9!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 13:48:30','2026-11-25 09:48:31'),(199,NULL,55,'red',1,'VITORIA',900,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":1,\"turnos\":6,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 1 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Cubchoo!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 9 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 22 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 10 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 13 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Cubchoo desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Vanillish!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 11 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Heatmor!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Heatmor perdeu 13 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Heatmor usou Incinerate!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Vanillish perdeu 18 HP.\"},{\"tipo\":\"status\",\"texto\":\"Vanillish recebeu Queimadura!\"},{\"tipo\":\"status\",\"texto\":\"Vanillish perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Vanillish aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Heatmor usou Incinerate!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Vanillish perdeu 17 HP.\"},{\"tipo\":\"status\",\"texto\":\"Vanillish perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Vanillish aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Heatmor usou Incinerate!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Vanillish perdeu 3 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Vanillish desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 12!\"},{\"tipo\":\"nivel\",\"texto\":\"Heatmor subiu para o Nv. 12!\"},{\"tipo\":\"recuperacao\",\"texto\":\"Desafio vencido! Todo o time recuperou 100% do HP, os desmaiados reviveram e as condicoes foram curadas!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 900!\"}]}','2026-11-25 13:48:37','2026-11-25 09:48:41'),(200,NULL,55,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":366,\"turnos\":5,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Normal quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Herdier!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Herdier usou Body Slam!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 17 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Herdier perdeu 13 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Herdier usou Body Slam!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 15 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Herdier perdeu 14 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Herdier usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Herdier aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Herdier perdeu 6 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Herdier desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Sawsbuck!\"},{\"tipo\":\"golpe\",\"texto\":\"Sawsbuck usou Body Slam!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 5 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Heatmor!\"},{\"tipo\":\"golpe\",\"texto\":\"Sawsbuck usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Heatmor perdeu 7 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Heatmor usou Incinerate!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Sawsbuck perdeu 36 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Sawsbuck desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 14!\"},{\"tipo\":\"nivel\",\"texto\":\"Heatmor subiu para o Nv. 14!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 13:48:58','2026-11-25 09:49:03'),(201,NULL,55,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1108,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Crustle!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Heatmor!\"},{\"tipo\":\"golpe\",\"texto\":\"Heatmor usou Incinerate!\"},{\"tipo\":\"dano\",\"texto\":\"Crustle perdeu 20 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Crustle usou Rock Tomb!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Heatmor perdeu 30 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Heatmor usou Incinerate!\"},{\"tipo\":\"dano\",\"texto\":\"Crustle perdeu 16 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Crustle desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Heatmor subiu para o Nv. 15!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 13:49:06','2026-11-25 09:49:07'),(202,NULL,55,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1111,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Stunfisk!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Heatmor!\"},{\"tipo\":\"golpe\",\"texto\":\"Heatmor usou Incinerate!\"},{\"tipo\":\"dano\",\"texto\":\"Stunfisk perdeu 18 HP.\"},{\"tipo\":\"status\",\"texto\":\"Stunfisk recebeu Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Stunfisk usou Shock Wave!\"},{\"tipo\":\"dano\",\"texto\":\"Heatmor perdeu 11 HP.\"},{\"tipo\":\"status\",\"texto\":\"Stunfisk perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Heatmor usou Incinerate!\"},{\"tipo\":\"dano\",\"texto\":\"Stunfisk perdeu 20 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Stunfisk usou Shock Wave!\"},{\"tipo\":\"dano\",\"texto\":\"Heatmor perdeu 12 HP.\"},{\"tipo\":\"status\",\"texto\":\"Stunfisk perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Heatmor usou Incinerate!\"},{\"tipo\":\"dano\",\"texto\":\"Stunfisk perdeu 8 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Stunfisk desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Heatmor subiu para o Nv. 16!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 13:49:09','2026-11-25 09:49:12'),(203,NULL,55,'red',NULL,'DERROTA',0,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":370,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Inseto quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Galvantula!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Heatmor!\"},{\"tipo\":\"golpe\",\"texto\":\"Galvantula usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Galvantula aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Heatmor usou Incinerate!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Galvantula perdeu 43 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Galvantula desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Accelgor!\"},{\"tipo\":\"golpe\",\"texto\":\"Accelgor usou Signal Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Heatmor perdeu 8 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Heatmor usou Incinerate!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Accelgor perdeu 46 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Accelgor desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Durant!\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Bullet Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Heatmor perdeu 8 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Heatmor desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-25 13:49:14','2026-11-25 09:49:18'),(204,NULL,56,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":371,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Inseto quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Shelmet!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Shelmet perdeu 17 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Shelmet usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Shelmet aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Shelmet perdeu 1 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Shelmet desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 7!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 13:50:06','2026-11-25 09:50:07'),(205,NULL,56,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":375,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Inseto quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Durant!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Bug Bite!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 6 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"erro\",\"texto\":\"O ataque de Tepig errou!\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Bug Bite!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 6 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Durant perdeu 22 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Durant desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 9!\"},{\"tipo\":\"nivel\",\"texto\":\"Axew subiu para o Nv. 9!\"},{\"tipo\":\"nivel\",\"texto\":\"Gothita subiu para o Nv. 9!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 13:50:19','2026-11-25 09:50:20'),(206,NULL,56,'red',1,'DERROTA',0,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":1,\"turnos\":6,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 1 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Cubchoo!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 8 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 23 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 8 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 12 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Cubchoo desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Vanillish!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 14 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Axew!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Axew perdeu 27 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Axew desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Gothita!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Vanillish aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Gothita usou Psychic!\"},{\"tipo\":\"dano\",\"texto\":\"Vanillish perdeu 6 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"dano\",\"texto\":\"Gothita perdeu 27 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Gothita desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-25 13:50:24','2026-11-25 09:50:27'),(207,NULL,57,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":376,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Lutador quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Throh!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 9 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 9 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 9 HP.\"},{\"tipo\":\"status\",\"texto\":\"Throh recebeu Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 10 HP.\"},{\"tipo\":\"status\",\"texto\":\"Throh perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 4 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Throh desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 7!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 14:05:54','2026-11-25 10:05:56'),(208,NULL,57,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1142,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Throh!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 8 HP.\"},{\"tipo\":\"status\",\"texto\":\"Throh recebeu Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 11 HP.\"},{\"tipo\":\"status\",\"texto\":\"Throh perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 8 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 2 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"status\",\"texto\":\"Throh perdeu HP por Queimadura!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Foongus!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Foongus perdeu 5 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Foongus usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 8 HP.\"},{\"tipo\":\"status\",\"texto\":\"Throh perdeu HP por Queimadura!\"},{\"tipo\":\"desmaio\",\"texto\":\"Throh desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 8!\"},{\"tipo\":\"nivel\",\"texto\":\"Foongus subiu para o Nv. 8!\"},{\"tipo\":\"nivel\",\"texto\":\"Pidove subiu para o Nv. 8!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 14:06:05','2026-11-25 10:06:08'),(209,NULL,58,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1154,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Patrat!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Patrat perdeu 13 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Patrat usou Body Slam!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 6 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Patrat perdeu 2 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Patrat desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 6!\"},{\"tipo\":\"nivel\",\"texto\":\"Sawk subiu para o Nv. 6!\"},{\"tipo\":\"nivel\",\"texto\":\"Axew subiu para o Nv. 6!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 14:06:32','2026-11-25 10:06:34'),(210,NULL,58,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":385,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Normal quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Deerling!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Sawk!\"},{\"tipo\":\"golpe\",\"texto\":\"Sawk usou Drain Punch!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Deerling perdeu 21 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Deerling desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Sawk subiu para o Nv. 8!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 8!\"},{\"tipo\":\"nivel\",\"texto\":\"Axew subiu para o Nv. 8!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 14:06:37','2026-11-25 10:06:38'),(211,NULL,58,'red',1,'DERROTA',0,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":1,\"turnos\":5,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 1 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Cubchoo!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Sawk!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"dano\",\"texto\":\"Sawk perdeu 15 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Sawk usou Drain Punch!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 35 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Cubchoo desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Vanillish!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"dano\",\"texto\":\"Sawk perdeu 15 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Sawk desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 20 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Vanillish perdeu 17 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 8 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Axew!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Axew perdeu 25 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Axew desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-25 14:06:42','2026-11-25 10:06:46'),(212,NULL,59,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1166,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Durant!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Bullet Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 3 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Durant perdeu 16 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Durant desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 6!\"},{\"tipo\":\"nivel\",\"texto\":\"Bouffalant subiu para o Nv. 6!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 14:06:59','2026-11-25 10:07:00'),(213,NULL,59,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1172,\"turnos\":4,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Tirtouga!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tirtouga perdeu 3 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tirtouga usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Tirtouga aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tirtouga usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 23 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Bouffalant!\"},{\"tipo\":\"golpe\",\"texto\":\"Tirtouga usou Aqua Jet!\"},{\"tipo\":\"dano\",\"texto\":\"Bouffalant perdeu 8 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Bouffalant usou Body Slam!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tirtouga perdeu 11 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Bouffalant usou Body Slam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tirtouga perdeu 4 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tirtouga desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 7!\"},{\"tipo\":\"nivel\",\"texto\":\"Bouffalant subiu para o Nv. 7!\"},{\"tipo\":\"nivel\",\"texto\":\"Ferroseed subiu para o Nv. 7!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 14:07:06','2026-11-25 10:07:09'),(214,NULL,59,'red',1,'DERROTA',0,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":1,\"turnos\":5,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 1 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Cubchoo!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Cubchoo aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 18 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 19 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 17 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Cubchoo desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Vanillish!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 7 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Bouffalant!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Bouffalant perdeu 30 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Bouffalant desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Ferroseed!\"},{\"tipo\":\"golpe\",\"texto\":\"Ferroseed usou Bullet Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Vanillish perdeu 11 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"dano\",\"texto\":\"Ferroseed perdeu 23 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Ferroseed desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-25 14:07:13','2026-11-25 10:07:18'),(215,NULL,60,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":391,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Normal quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Deerling!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Deerling usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 2 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Deerling perdeu 18 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Deerling desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 7!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 14:07:27','2026-11-25 10:07:27'),(216,NULL,60,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":393,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Inseto quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Durant!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Bullet Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 6 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Durant perdeu 22 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Durant desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 9!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 14:07:29','2026-11-25 10:07:30'),(217,NULL,60,'red',NULL,'DERROTA',0,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":394,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Lutador quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Sawk!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Sawk usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 18 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Sawk perdeu 10 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Sawk usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 12 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-25 14:07:37','2026-11-25 10:07:38'),(218,NULL,61,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":396,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Normal quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Deerling!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Deerling usou Leaf Blade!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 6 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Deerling perdeu 18 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Deerling desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 8!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 14:20:40','2026-11-25 10:20:41'),(219,NULL,61,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":399,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Inseto quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Shelmet!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Shelmet perdeu 23 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Shelmet usou Bug Bite!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 8 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Shelmet perdeu 1 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Shelmet desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 11!\"},{\"tipo\":\"nivel\",\"texto\":\"Larvesta subiu para o Nv. 11!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 14:20:48','2026-11-25 10:20:50'),(220,NULL,61,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1203,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Timburr!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Timburr perdeu 17 HP.\"},{\"tipo\":\"status\",\"texto\":\"Timburr recebeu Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Timburr usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Timburr aumentou!\"},{\"tipo\":\"status\",\"texto\":\"Timburr perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Timburr perdeu 14 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Timburr desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 13!\"},{\"tipo\":\"nivel\",\"texto\":\"Larvesta subiu para o Nv. 13!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 14:20:52','2026-11-25 10:20:53'),(221,NULL,61,'red',1,'VITORIA',900,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":1,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 1 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Cubchoo!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 35 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Cubchoo desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Vanillish!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 14 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Vanillish perdeu 22 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 14 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Vanillish perdeu 18 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Vanillish desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 16!\"},{\"tipo\":\"nivel\",\"texto\":\"Larvesta subiu para o Nv. 16!\"},{\"tipo\":\"recuperacao\",\"texto\":\"Desafio vencido! Todo o time recuperou 100% do HP, os desmaiados reviveram e as condicoes foram curadas!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 900!\"}]}','2026-11-25 14:20:57','2026-11-25 10:20:59'),(222,NULL,61,'red',NULL,'DERROTA',0,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":401,\"turnos\":6,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Normal quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Stoutland!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Stoutland usou Body Slam!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 23 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Stoutland perdeu 14 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Stoutland usou Body Slam!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 23 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Larvesta!\"},{\"tipo\":\"golpe\",\"texto\":\"Stoutland usou Body Slam!\"},{\"tipo\":\"dano\",\"texto\":\"Larvesta perdeu 21 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Larvesta usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Stoutland perdeu 16 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Stoutland usou Body Slam!\"},{\"tipo\":\"dano\",\"texto\":\"Larvesta perdeu 21 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Larvesta usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Stoutland perdeu 17 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Stoutland desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Watchog!\"},{\"tipo\":\"golpe\",\"texto\":\"Watchog usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Watchog aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Larvesta usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Watchog perdeu 18 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Watchog usou Body Slam!\"},{\"tipo\":\"dano\",\"texto\":\"Larvesta perdeu 1 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Larvesta desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-25 14:22:41','2026-11-25 10:22:48'),(223,NULL,62,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1222,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Joltik!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Joltik perdeu 16 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Joltik desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 7!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 14:26:16','2026-11-25 10:26:18'),(224,NULL,62,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":410,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Normal quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Lillipup!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Lillipup perdeu 21 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Lillipup desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 10!\"},{\"tipo\":\"nivel\",\"texto\":\"Sigilyph subiu para o Nv. 10!\"},{\"tipo\":\"nivel\",\"texto\":\"Deino subiu para o Nv. 10!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 14:26:26','2026-11-25 10:26:27'),(225,NULL,62,'red',1,'VITORIA',900,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":1,\"turnos\":9,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 1 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Cubchoo!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 8 HP.\"},{\"tipo\":\"status\",\"texto\":\"Tepig recebeu Congelamento!\"},{\"tipo\":\"status\",\"texto\":\"Tepig está congelado!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 8 HP.\"},{\"tipo\":\"status\",\"texto\":\"Tepig está congelado!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Cubchoo aumentou!\"},{\"tipo\":\"status\",\"texto\":\"Tepig descongelou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 29 HP.\"},{\"tipo\":\"status\",\"texto\":\"Cubchoo recebeu Queimadura!\"},{\"tipo\":\"status\",\"texto\":\"Cubchoo perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 16 HP.\"},{\"tipo\":\"status\",\"texto\":\"Tepig recebeu Congelamento!\"},{\"tipo\":\"status\",\"texto\":\"Tepig está congelado!\"},{\"tipo\":\"status\",\"texto\":\"Cubchoo perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 1 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"status\",\"texto\":\"Cubchoo perdeu HP por Queimadura!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Sigilyph!\"},{\"tipo\":\"golpe\",\"texto\":\"Sigilyph usou Psychic!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 3 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Cubchoo desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Vanillish!\"},{\"tipo\":\"golpe\",\"texto\":\"Sigilyph usou Psychic!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Vanillish perdeu 27 HP.\"},{\"tipo\":\"status\",\"texto\":\"Vanillish recebeu Sono!\"},{\"tipo\":\"status\",\"texto\":\"Vanillish está dormindo!\"},{\"tipo\":\"golpe\",\"texto\":\"Sigilyph usou Psychic!\"},{\"tipo\":\"dano\",\"texto\":\"Vanillish perdeu 12 HP.\"},{\"tipo\":\"status\",\"texto\":\"Vanillish está dormindo!\"},{\"tipo\":\"golpe\",\"texto\":\"Sigilyph usou Psychic!\"},{\"tipo\":\"dano\",\"texto\":\"Vanillish perdeu 1 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Vanillish desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 13!\"},{\"tipo\":\"nivel\",\"texto\":\"Sigilyph subiu para o Nv. 13!\"},{\"tipo\":\"nivel\",\"texto\":\"Deino subiu para o Nv. 13!\"},{\"tipo\":\"recuperacao\",\"texto\":\"Desafio vencido! Todo o time recuperou 100% do HP, os desmaiados reviveram e as condicoes foram curadas!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 900!\"}]}','2026-11-25 14:26:31','2026-11-25 10:26:39'),(226,NULL,62,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":411,\"turnos\":9,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Terra quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Stunfisk!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Deino!\"},{\"tipo\":\"golpe\",\"texto\":\"Deino usou Dragon Claw!\"},{\"tipo\":\"dano\",\"texto\":\"Stunfisk perdeu 12 HP.\"},{\"tipo\":\"status\",\"texto\":\"Stunfisk recebeu Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Stunfisk usou Earth Power!\"},{\"tipo\":\"dano\",\"texto\":\"Deino perdeu 14 HP.\"},{\"tipo\":\"status\",\"texto\":\"Stunfisk perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Deino usou Dragon Claw!\"},{\"tipo\":\"dano\",\"texto\":\"Stunfisk perdeu 13 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Stunfisk usou Earth Power!\"},{\"tipo\":\"dano\",\"texto\":\"Deino perdeu 13 HP.\"},{\"tipo\":\"status\",\"texto\":\"Stunfisk perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Deino usou Sucker Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Stunfisk perdeu 12 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Stunfisk usou Earth Power!\"},{\"tipo\":\"dano\",\"texto\":\"Deino perdeu 9 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Deino desmaiou!\"},{\"tipo\":\"status\",\"texto\":\"Stunfisk perdeu HP por Queimadura!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Sigilyph!\"},{\"tipo\":\"golpe\",\"texto\":\"Sigilyph usou Psychic!\"},{\"tipo\":\"dano\",\"texto\":\"Stunfisk perdeu 4 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Stunfisk desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Excadrill!\"},{\"tipo\":\"golpe\",\"texto\":\"Sigilyph usou Psychic!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Excadrill perdeu 10 HP.\"},{\"tipo\":\"status\",\"texto\":\"Excadrill recebeu Sono!\"},{\"tipo\":\"status\",\"texto\":\"Excadrill está dormindo!\"},{\"tipo\":\"golpe\",\"texto\":\"Sigilyph usou Psychic!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Excadrill perdeu 11 HP.\"},{\"tipo\":\"status\",\"texto\":\"Excadrill acordou!\"},{\"tipo\":\"golpe\",\"texto\":\"Excadrill usou Bulldoze!\"},{\"tipo\":\"imunidade\",\"texto\":\"Não afetou Sigilyph...\"},{\"tipo\":\"golpe\",\"texto\":\"Sigilyph usou Psychic!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Excadrill perdeu 10 HP.\"},{\"tipo\":\"status\",\"texto\":\"Excadrill recebeu Sono!\"},{\"tipo\":\"status\",\"texto\":\"Excadrill está dormindo!\"},{\"tipo\":\"golpe\",\"texto\":\"Sigilyph usou Psychic!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Excadrill perdeu 11 HP.\"},{\"tipo\":\"status\",\"texto\":\"Excadrill está dormindo!\"},{\"tipo\":\"golpe\",\"texto\":\"Sigilyph usou Psychic!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Excadrill perdeu 3 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Excadrill desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Deino subiu para o Nv. 16!\"},{\"tipo\":\"nivel\",\"texto\":\"Sigilyph subiu para o Nv. 16!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 16!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 14:26:49','2026-11-25 10:26:59'),(227,NULL,62,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1241,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Watchog!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Sigilyph!\"},{\"tipo\":\"golpe\",\"texto\":\"Sigilyph usou Psychic!\"},{\"tipo\":\"dano\",\"texto\":\"Watchog perdeu 24 HP.\"},{\"tipo\":\"status\",\"texto\":\"Watchog recebeu Sono!\"},{\"tipo\":\"status\",\"texto\":\"Watchog está dormindo!\"},{\"tipo\":\"golpe\",\"texto\":\"Sigilyph usou Psychic!\"},{\"tipo\":\"dano\",\"texto\":\"Watchog perdeu 14 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Watchog desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Sigilyph subiu para o Nv. 18!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 18!\"},{\"tipo\":\"evolucao\",\"texto\":\"Tepig evoluiu para Pignite!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 14:27:03','2026-11-25 10:27:04'),(228,NULL,62,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1247,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Carracosta!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Sigilyph!\"},{\"tipo\":\"golpe\",\"texto\":\"Carracosta usou Aqua Jet!\"},{\"tipo\":\"dano\",\"texto\":\"Sigilyph perdeu 18 HP.\"},{\"tipo\":\"status\",\"texto\":\"Sigilyph recebeu Congelamento!\"},{\"tipo\":\"status\",\"texto\":\"Sigilyph está congelado!\"},{\"tipo\":\"status\",\"texto\":\"Sigilyph descongelou!\"},{\"tipo\":\"golpe\",\"texto\":\"Sigilyph usou Psychic!\"},{\"tipo\":\"dano\",\"texto\":\"Carracosta perdeu 29 HP.\"},{\"tipo\":\"status\",\"texto\":\"Carracosta recebeu Sono!\"},{\"tipo\":\"status\",\"texto\":\"Carracosta está dormindo!\"},{\"tipo\":\"golpe\",\"texto\":\"Sigilyph usou Psychic!\"},{\"tipo\":\"dano\",\"texto\":\"Carracosta perdeu 18 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Carracosta desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Sigilyph subiu para o Nv. 20!\"},{\"tipo\":\"nivel\",\"texto\":\"Pignite subiu para o Nv. 20!\"},{\"tipo\":\"nivel\",\"texto\":\"Oshawott subiu para o Nv. 20!\"},{\"tipo\":\"evolucao\",\"texto\":\"Oshawott evoluiu para Dewott!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 14:27:12','2026-11-25 10:27:14'),(229,NULL,62,'red',2,'DERROTA',0,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":2,\"turnos\":11,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 2 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Frillish Female!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Sigilyph!\"},{\"tipo\":\"golpe\",\"texto\":\"Sigilyph usou Psychic!\"},{\"tipo\":\"dano\",\"texto\":\"Frillish Female perdeu 25 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Frillish Female usou Shadow Ball!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Sigilyph perdeu 26 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Sigilyph usou Psychic!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Frillish Female perdeu 22 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Frillish Female desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Alomomola!\"},{\"tipo\":\"golpe\",\"texto\":\"Alomomola usou Aqua Jet!\"},{\"tipo\":\"dano\",\"texto\":\"Sigilyph perdeu 18 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Sigilyph usou Psychic!\"},{\"tipo\":\"dano\",\"texto\":\"Alomomola perdeu 41 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Alomomola usou Aqua Jet!\"},{\"tipo\":\"dano\",\"texto\":\"Sigilyph perdeu 14 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Sigilyph desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Pignite!\"},{\"tipo\":\"golpe\",\"texto\":\"Alomomola usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Alomomola aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Pignite usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Alomomola perdeu 22 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Alomomola usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Pignite perdeu 66 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Pignite desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Dewott!\"},{\"tipo\":\"golpe\",\"texto\":\"Alomomola usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Alomomola aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Dewott usou Water Pulse!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Alomomola perdeu 16 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Alomomola usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Dewott perdeu 34 HP.\"},{\"tipo\":\"status\",\"texto\":\"Dewott recebeu Congelamento!\"},{\"tipo\":\"status\",\"texto\":\"Dewott está congelado!\"},{\"tipo\":\"golpe\",\"texto\":\"Alomomola usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Dewott perdeu 26 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Dewott desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Deino!\"},{\"tipo\":\"golpe\",\"texto\":\"Deino usou Sucker Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Alomomola perdeu 12 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Alomomola usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Alomomola aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Alomomola usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Deino perdeu 42 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Deino desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-25 14:27:40','2026-11-25 10:27:50'),(230,NULL,63,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1253,\"turnos\":4,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Gothita!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Gothita perdeu 12 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Gothita usou Psychic!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 6 HP.\"},{\"tipo\":\"status\",\"texto\":\"Tepig recebeu Sono!\"},{\"tipo\":\"status\",\"texto\":\"Tepig está dormindo!\"},{\"tipo\":\"golpe\",\"texto\":\"Gothita usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Gothita aumentou!\"},{\"tipo\":\"status\",\"texto\":\"Tepig está dormindo!\"},{\"tipo\":\"golpe\",\"texto\":\"Gothita usou Psychic!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 10 HP.\"},{\"tipo\":\"status\",\"texto\":\"Tepig acordou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Gothita perdeu 3 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Gothita desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 7!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 14:28:03','2026-11-25 10:28:06'),(231,NULL,63,'red',NULL,'DERROTA',0,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":417,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Normal quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Deerling!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Deerling usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Deerling aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Deerling perdeu 22 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Deerling usou Body Slam!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 14 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-25 14:28:08','2026-11-25 10:28:10'),(232,NULL,64,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":422,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Normal quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Lillipup!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Lillipup perdeu 11 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Lillipup usou Body Slam!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 6 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Lillipup usou Body Slam!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 6 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Lillipup perdeu 6 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Lillipup desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 8!\"},{\"tipo\":\"nivel\",\"texto\":\"Deerling subiu para o Nv. 8!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 14:30:38','2026-11-25 10:30:39'),(233,NULL,64,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1274,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Dwebble!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Dwebble perdeu 22 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Dwebble desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 10!\"},{\"tipo\":\"nivel\",\"texto\":\"Deerling subiu para o Nv. 10!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 14:30:45','2026-11-25 10:30:46'),(234,NULL,64,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1277,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Gothita!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Gothita perdeu 16 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Gothita usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Gothita aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Gothita perdeu 9 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Gothita desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 12!\"},{\"tipo\":\"nivel\",\"texto\":\"Deerling subiu para o Nv. 12!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 14:30:48','2026-11-25 10:30:49'),(235,NULL,64,'red',1,'DERROTA',0,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":1,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 1 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Cubchoo!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 8 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 35 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Cubchoo desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Vanillish!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 29 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Deerling!\"},{\"tipo\":\"golpe\",\"texto\":\"Deerling usou Body Slam!\"},{\"tipo\":\"dano\",\"texto\":\"Vanillish perdeu 11 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Deerling perdeu 36 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Deerling desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-25 14:30:57','2026-11-25 10:31:02'),(236,NULL,65,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1283,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Gothita!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Gothita perdeu 11 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Gothita usou Psychic!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 6 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Gothita perdeu 4 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Gothita desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 7!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 14:35:15','2026-11-25 10:35:16'),(237,NULL,65,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":428,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Lutador quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Timburr!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Timburr perdeu 11 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Timburr usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 10 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Timburr perdeu 11 HP.\"},{\"tipo\":\"status\",\"texto\":\"Timburr recebeu Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Timburr usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Timburr aumentou!\"},{\"tipo\":\"status\",\"texto\":\"Timburr perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Timburr perdeu 2 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Timburr desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 10!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 14:35:21','2026-11-25 10:35:22'),(238,NULL,65,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":430,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Inseto quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Joltik!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Joltik usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Joltik aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Joltik perdeu 28 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Joltik desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 13!\"},{\"tipo\":\"nivel\",\"texto\":\"Oshawott subiu para o Nv. 13!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 14:35:29','2026-11-25 10:35:30'),(239,NULL,65,'red',1,'DERROTA',0,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":1,\"turnos\":6,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 1 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Cubchoo!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Pignite!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Pignite perdeu 6 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Pignite usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 35 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Cubchoo desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Vanillish!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Vanillish aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Pignite usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Vanillish perdeu 35 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Pignite perdeu 21 HP.\"},{\"tipo\":\"status\",\"texto\":\"Pignite recebeu Congelamento!\"},{\"tipo\":\"status\",\"texto\":\"Pignite está congelado!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Pignite perdeu 19 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Pignite desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Oshawott!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Oshawott perdeu 25 HP.\"},{\"tipo\":\"status\",\"texto\":\"Oshawott recebeu Congelamento!\"},{\"tipo\":\"status\",\"texto\":\"Oshawott está congelado!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Oshawott perdeu 12 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Oshawott desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-25 14:36:29','2026-11-25 10:36:37'),(240,NULL,66,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":433,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Normal quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Patrat!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Patrat perdeu 12 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Patrat usou Body Slam!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 6 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Patrat perdeu 5 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Patrat desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 8!\"},{\"tipo\":\"nivel\",\"texto\":\"Patrat subiu para o Nv. 8!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 14:37:03','2026-11-25 10:37:04'),(241,NULL,66,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1304,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Throh!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 11 HP.\"},{\"tipo\":\"status\",\"texto\":\"Throh recebeu Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Throh aumentou!\"},{\"tipo\":\"status\",\"texto\":\"Throh perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 11 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Throh aumentou!\"},{\"tipo\":\"status\",\"texto\":\"Throh perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 6 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Throh desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 10!\"},{\"tipo\":\"nivel\",\"texto\":\"Patrat subiu para o Nv. 10!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 14:37:06','2026-11-25 10:37:10'),(242,NULL,66,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":435,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Inseto quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Shelmet!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Shelmet perdeu 21 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Shelmet usou Bug Bite!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 4 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Shelmet perdeu 7 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Shelmet desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 13!\"},{\"tipo\":\"nivel\",\"texto\":\"Patrat subiu para o Nv. 13!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 14:37:13','2026-11-25 10:37:14'),(243,NULL,66,'red',1,'VITORIA',900,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":1,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 1 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Cubchoo!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Pignite!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Pignite perdeu 6 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Pignite usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Pignite aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Pignite perdeu 6 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Pignite usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 35 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Cubchoo desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Vanillish!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Pignite perdeu 11 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Pignite usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Vanillish perdeu 40 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Vanillish desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Pignite subiu para o Nv. 16!\"},{\"tipo\":\"nivel\",\"texto\":\"Patrat subiu para o Nv. 16!\"},{\"tipo\":\"recuperacao\",\"texto\":\"Desafio vencido! Todo o time recuperou 100% do HP, os desmaiados reviveram e as condicoes foram curadas!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 900!\"}]}','2026-11-25 14:37:44','2026-11-25 10:37:48'),(244,NULL,66,'red',NULL,'DERROTA',0,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":438,\"turnos\":6,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Psiquico quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Gothitelle!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Patrat!\"},{\"tipo\":\"golpe\",\"texto\":\"Gothitelle usou Psychic!\"},{\"tipo\":\"dano\",\"texto\":\"Patrat perdeu 26 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Patrat usou Body Slam!\"},{\"tipo\":\"dano\",\"texto\":\"Gothitelle perdeu 12 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Gothitelle usou Psychic!\"},{\"tipo\":\"dano\",\"texto\":\"Patrat perdeu 14 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Patrat desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Petilil!\"},{\"tipo\":\"golpe\",\"texto\":\"Gothitelle usou Psychic!\"},{\"tipo\":\"dano\",\"texto\":\"Petilil perdeu 21 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Petilil usou Mega Drain!\"},{\"tipo\":\"dano\",\"texto\":\"Gothitelle perdeu 12 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Gothitelle usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Gothitelle aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Petilil usou Mega Drain!\"},{\"tipo\":\"dano\",\"texto\":\"Gothitelle perdeu 14 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Gothitelle usou Psychic!\"},{\"tipo\":\"dano\",\"texto\":\"Petilil perdeu 19 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Petilil desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Pignite!\"},{\"tipo\":\"golpe\",\"texto\":\"Gothitelle usou Psychic!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Pignite perdeu 54 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Pignite desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-25 14:39:08','2026-11-25 10:40:02'),(245,NULL,67,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1328,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Stunfisk!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Stunfisk perdeu 9 HP.\"},{\"tipo\":\"status\",\"texto\":\"Stunfisk recebeu Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Stunfisk usou Shock Wave!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 6 HP.\"},{\"tipo\":\"status\",\"texto\":\"Tepig recebeu Paralisia!\"},{\"tipo\":\"status\",\"texto\":\"Stunfisk perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Stunfisk perdeu 9 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Stunfisk desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 7!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 14:40:39','2026-11-25 10:40:41'),(246,NULL,67,'red',NULL,'DERROTA',0,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1331,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Throh!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 8 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 12 HP.\"},{\"tipo\":\"status\",\"texto\":\"Tepig travou de paralisia!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 11 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 9 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 1 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-25 14:40:43','2026-11-25 10:40:48'),(247,NULL,68,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":446,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Inseto quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Durant!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Bullet Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 4 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Durant perdeu 18 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Durant desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 8!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 14:40:57','2026-11-25 10:40:58'),(248,NULL,68,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1347,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Shelmet!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Shelmet perdeu 20 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Shelmet usou Bug Bite!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 2 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Shelmet perdeu 2 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Shelmet desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 10!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 14:41:01','2026-11-25 10:41:21'),(249,NULL,68,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1351,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Joltik!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Joltik usou Shock Wave!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 10 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Joltik perdeu 26 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Joltik desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 11!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 14:42:31','2026-11-25 10:42:32'),(250,NULL,68,'red',NULL,'DERROTA',0,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1353,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Tirtouga!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tirtouga perdeu 2 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tirtouga usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Tirtouga aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tirtouga usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 31 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-25 14:42:36','2026-11-25 10:43:56'),(251,NULL,69,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":451,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Inseto quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Durant!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Bullet Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 4 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Durant perdeu 18 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Durant desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 8!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 14:48:06','2026-11-25 10:48:08'),(252,NULL,69,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":454,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Pedra quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Roggenrola!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Drilbur!\"},{\"tipo\":\"golpe\",\"texto\":\"Drilbur usou Bulldoze!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Roggenrola perdeu 24 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Roggenrola desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Drilbur subiu para o Nv. 11!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 11!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 14:48:15','2026-11-25 10:48:17'),(253,NULL,69,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":455,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Terra quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Stunfisk!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Drilbur!\"},{\"tipo\":\"golpe\",\"texto\":\"Drilbur usou Bulldoze!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Stunfisk perdeu 27 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Stunfisk usou Earth Power!\"},{\"tipo\":\"dano\",\"texto\":\"Drilbur perdeu 13 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Drilbur usou Bulldoze!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Stunfisk perdeu 11 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Stunfisk desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Drilbur subiu para o Nv. 14!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 14!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 14:48:20','2026-11-25 10:48:23'),(254,NULL,69,'red',1,'VITORIA',900,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":1,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 1 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Cubchoo!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Tepig aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Cubchoo aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 13 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 35 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Cubchoo desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Vanillish!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 12 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Vanillish perdeu 40 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Vanillish desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 17!\"},{\"tipo\":\"evolucao\",\"texto\":\"Tepig evoluiu para Pignite!\"},{\"tipo\":\"nivel\",\"texto\":\"Drilbur subiu para o Nv. 17!\"},{\"tipo\":\"recuperacao\",\"texto\":\"Desafio vencido! Todo o time recuperou 100% do HP, os desmaiados reviveram e as condicoes foram curadas!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 900!\"}]}','2026-11-25 14:48:28','2026-11-25 10:48:35'),(255,NULL,69,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":456,\"turnos\":8,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Terra quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Stunfisk!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Drilbur!\"},{\"tipo\":\"golpe\",\"texto\":\"Drilbur usou Bulldoze!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Stunfisk perdeu 36 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Stunfisk usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Stunfisk aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Drilbur usou Bulldoze!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Stunfisk perdeu 21 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Stunfisk desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Krookodile!\"},{\"tipo\":\"golpe\",\"texto\":\"Krookodile usou Bulldoze!\"},{\"tipo\":\"dano\",\"texto\":\"Drilbur perdeu 32 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Drilbur usou Bulldoze!\"},{\"tipo\":\"dano\",\"texto\":\"Krookodile perdeu 16 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Krookodile usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Krookodile aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Drilbur usou Bulldoze!\"},{\"tipo\":\"dano\",\"texto\":\"Krookodile perdeu 17 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Krookodile usou Sucker Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Drilbur perdeu 15 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Drilbur desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Pignite!\"},{\"tipo\":\"golpe\",\"texto\":\"Krookodile usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Krookodile aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Pignite usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Krookodile perdeu 20 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Krookodile desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Excadrill!\"},{\"tipo\":\"golpe\",\"texto\":\"Excadrill usou Bullet Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Pignite perdeu 14 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Pignite usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Excadrill perdeu 46 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Excadrill usou Bullet Punch!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Pignite perdeu 18 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Pignite usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Excadrill perdeu 12 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Excadrill desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Drilbur subiu para o Nv. 20!\"},{\"tipo\":\"nivel\",\"texto\":\"Pignite subiu para o Nv. 20!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 14:49:23','2026-11-25 10:49:32'),(256,NULL,69,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":457,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Inseto quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Galvantula!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Pignite!\"},{\"tipo\":\"golpe\",\"texto\":\"Galvantula usou Shock Wave!\"},{\"tipo\":\"dano\",\"texto\":\"Pignite perdeu 27 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Pignite usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Galvantula perdeu 53 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Galvantula desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Accelgor!\"},{\"tipo\":\"golpe\",\"texto\":\"Accelgor usou Signal Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Pignite perdeu 6 HP.\"},{\"tipo\":\"status\",\"texto\":\"Pignite recebeu Envenenamento!\"},{\"tipo\":\"golpe\",\"texto\":\"Pignite usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Accelgor perdeu 56 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Accelgor desmaiou!\"},{\"tipo\":\"status\",\"texto\":\"Pignite perdeu HP por Envenenamento!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Durant!\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Durant aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Pignite usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Durant perdeu 48 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Durant desmaiou!\"},{\"tipo\":\"status\",\"texto\":\"Pignite perdeu HP por Envenenamento!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Pignite subiu para o Nv. 23!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 14:49:35','2026-11-25 10:49:38'),(257,NULL,69,'red',NULL,'DERROTA',0,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1382,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Krookodile!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Pignite!\"},{\"tipo\":\"golpe\",\"texto\":\"Krookodile usou Bulldoze!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Pignite perdeu 32 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Pignite desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Venipede!\"},{\"tipo\":\"golpe\",\"texto\":\"Krookodile usou Bulldoze!\"},{\"tipo\":\"dano\",\"texto\":\"Venipede perdeu 26 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Venipede usou Bug Bite!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Krookodile perdeu 33 HP.\"},{\"tipo\":\"status\",\"texto\":\"Krookodile recebeu Envenenamento!\"},{\"tipo\":\"status\",\"texto\":\"Krookodile perdeu HP por Envenenamento!\"},{\"tipo\":\"golpe\",\"texto\":\"Krookodile usou Bulldoze!\"},{\"tipo\":\"dano\",\"texto\":\"Venipede perdeu 20 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Venipede desmaiou!\"},{\"tipo\":\"status\",\"texto\":\"Krookodile perdeu HP por Envenenamento!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-25 14:49:45','2026-11-25 10:49:49'),(258,NULL,70,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1388,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Dwebble!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Dwebble perdeu 9 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Dwebble usou Bug Bite!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 2 HP.\"},{\"tipo\":\"status\",\"texto\":\"Tepig recebeu Envenenamento!\"},{\"tipo\":\"status\",\"texto\":\"Tepig perdeu HP por Envenenamento!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Dwebble perdeu 7 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Dwebble desmaiou!\"},{\"tipo\":\"status\",\"texto\":\"Tepig perdeu HP por Envenenamento!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 7!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 14:50:02','2026-11-25 10:50:04'),(259,NULL,70,'red',NULL,'DERROTA',0,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1392,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Sawk!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Sawk usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 14 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Sawk perdeu 8 HP.\"},{\"tipo\":\"status\",\"texto\":\"Tepig perdeu HP por Envenenamento!\"},{\"tipo\":\"golpe\",\"texto\":\"Sawk usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 11 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-25 14:50:09','2026-11-25 10:50:10'),(260,NULL,71,'red',NULL,'DERROTA',0,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1403,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Roggenrola!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Roggenrola perdeu 4 HP.\"},{\"tipo\":\"status\",\"texto\":\"Roggenrola recebeu Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Roggenrola usou Rock Tomb!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 13 HP.\"},{\"tipo\":\"status\",\"texto\":\"Roggenrola perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Roggenrola perdeu 4 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Roggenrola usou Rock Tomb!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 8 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"status\",\"texto\":\"Roggenrola perdeu HP por Queimadura!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-25 14:50:16','2026-11-25 10:50:36'),(261,NULL,72,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1422,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Woobat!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Woobat perdeu 16 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Woobat desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 7!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 7!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 14:50:49','2026-11-25 10:50:50'),(262,NULL,72,'red',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1427,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Sandile!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Sandile usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Sandile aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Sandile perdeu 13 HP.\"},{\"tipo\":\"status\",\"texto\":\"Sandile recebeu Queimadura!\"},{\"tipo\":\"status\",\"texto\":\"Sandile perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Sandile perdeu 6 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Sandile desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 9!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 9!\"},{\"tipo\":\"nivel\",\"texto\":\"Bouffalant subiu para o Nv. 9!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 14:50:55','2026-11-25 10:50:56'),(263,NULL,72,'red',1,'DERROTA',0,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":1,\"turnos\":6,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 1 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Cubchoo!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 11 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 23 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 8 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 12 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Cubchoo desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Vanillish!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 11 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Vanillish aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Vanillish perdeu 16 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 30 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Bouffalant!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"dano\",\"texto\":\"Bouffalant perdeu 36 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Bouffalant desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-25 14:50:59','2026-11-25 10:51:03'),(264,NULL,73,'red',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":476,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Psiquico quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Woobat!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Woobat usou Air Slash!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 5 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Woobat perdeu 12 HP.\"},{\"tipo\":\"status\",\"texto\":\"Woobat recebeu Queimadura!\"},{\"tipo\":\"status\",\"texto\":\"Woobat perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Woobat usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Woobat aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Woobat perdeu 6 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Woobat desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 8!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 14:52:26','2026-11-25 10:52:27'),(265,NULL,73,'red',NULL,'DERROTA',0,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1436,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Drilbur!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Drilbur usou Bulldoze!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 23 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Drilbur perdeu 17 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Drilbur usou Bulldoze!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 5 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-25 14:52:33','2026-11-25 10:52:37'),(266,NULL,74,'red',NULL,'DERROTA',0,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":481,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Terra quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Sandile!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Sandile usou Bulldoze!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 16 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Sandile perdeu 13 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Sandile usou Sucker Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 5 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-25 14:52:42','2026-11-25 10:52:45'),(267,75,NULL,NULL,NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":488,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Normal quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Deerling!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Deerling usou Body Slam!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 6 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Deerling perdeu 18 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Deerling desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 8!\"},{\"tipo\":\"nivel\",\"texto\":\"Zorua Hisui subiu para o Nv. 8!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 14:52:57','2026-11-25 10:52:58'),(268,75,NULL,NULL,NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":489,\"turnos\":4,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Lutador quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Throh!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Zorua Hisui!\"},{\"tipo\":\"golpe\",\"texto\":\"Zorua Hisui usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Zorua Hisui aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"imunidade\",\"texto\":\"Não afetou Zorua Hisui...\"},{\"tipo\":\"golpe\",\"texto\":\"Zorua Hisui usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Zorua Hisui aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"imunidade\",\"texto\":\"Não afetou Zorua Hisui...\"},{\"tipo\":\"golpe\",\"texto\":\"Zorua Hisui usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Zorua Hisui aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"imunidade\",\"texto\":\"Não afetou Zorua Hisui...\"},{\"tipo\":\"golpe\",\"texto\":\"Zorua Hisui usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 33 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Throh desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Zorua Hisui subiu para o Nv. 11!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 11!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 14:53:03','2026-11-25 10:53:12'),(269,75,NULL,NULL,NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":490,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Inseto quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Joltik!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Joltik usou Shock Wave!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 10 HP.\"},{\"tipo\":\"status\",\"texto\":\"Tepig recebeu Paralisia!\"},{\"tipo\":\"status\",\"texto\":\"Tepig travou de paralisia!\"},{\"tipo\":\"golpe\",\"texto\":\"Joltik usou Signal Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 5 HP.\"},{\"tipo\":\"status\",\"texto\":\"Tepig travou de paralisia!\"},{\"tipo\":\"golpe\",\"texto\":\"Joltik usou Signal Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 5 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Joltik perdeu 28 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Joltik desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 14!\"},{\"tipo\":\"nivel\",\"texto\":\"Zorua Hisui subiu para o Nv. 14!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 14:53:17','2026-11-25 10:53:24'),(270,75,NULL,NULL,1,'VITORIA',900,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":1,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 1 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Cubchoo!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Zoroark Hisui!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Zoroark Hisui aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Cubchoo aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark Hisui perdeu 21 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 35 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Cubchoo desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Vanillish!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Vanillish perdeu 40 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Vanillish desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark Hisui subiu para o Nv. 17!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 17!\"},{\"tipo\":\"evolucao\",\"texto\":\"Tepig evoluiu para Pignite!\"},{\"tipo\":\"recuperacao\",\"texto\":\"Desafio vencido! Todo o time recuperou 100% do HP, os desmaiados reviveram e as condicoes foram curadas!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 900!\"}]}','2026-11-25 14:53:54','2026-11-25 10:53:59'),(271,75,NULL,NULL,NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":491,\"turnos\":6,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Pedra quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Crustle!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Pignite!\"},{\"tipo\":\"golpe\",\"texto\":\"Pignite usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Crustle perdeu 14 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Crustle usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Crustle aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Pignite usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Crustle perdeu 14 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Crustle usou Bug Bite!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Pignite perdeu 10 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Pignite usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Crustle perdeu 14 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Crustle usou Rock Tomb!\"},{\"tipo\":\"dano\",\"texto\":\"Pignite perdeu 47 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Pignite desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Zoroark Hisui!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Crustle perdeu 4 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Crustle desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Boldore!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Zoroark Hisui aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Boldore usou Rock Tomb!\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark Hisui perdeu 22 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Boldore perdeu 46 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Boldore desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Pignite subiu para o Nv. 20!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark Hisui subiu para o Nv. 20!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 14:55:08','2026-11-25 10:55:16'),(272,75,NULL,NULL,NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":492,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Psiquico quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Swoobat!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Zoroark Hisui!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Swoobat perdeu 52 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Swoobat desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Musharna!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Musharna perdeu 59 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Musharna usou Psychic!\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark Hisui perdeu 26 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Musharna perdeu 10 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Musharna desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark Hisui subiu para o Nv. 23!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 14:55:20','2026-11-25 10:55:22'),(273,75,NULL,NULL,NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1487,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Galvantula!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Zoroark Hisui!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Galvantula perdeu 50 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Galvantula usou Signal Beam!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark Hisui perdeu 13 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Galvantula perdeu 5 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Galvantula desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark Hisui subiu para o Nv. 25!\"},{\"tipo\":\"nivel\",\"texto\":\"Snivy subiu para o Nv. 25!\"},{\"tipo\":\"evolucao\",\"texto\":\"Snivy evoluiu para Servine!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 14:55:30','2026-11-25 10:55:32'),(274,75,NULL,NULL,2,'VITORIA',900,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":2,\"turnos\":5,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 2 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Frillish Female!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Serperior!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Serperior aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Frillish Female usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 10 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Serperior aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Frillish Female usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 10 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Frillish Female perdeu 47 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Frillish Female desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Alomomola!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Alomomola perdeu 96 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Alomomola desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Simipour!\"},{\"tipo\":\"golpe\",\"texto\":\"Simipour usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 9 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Simipour perdeu 65 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Simipour desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 28!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark Hisui subiu para o Nv. 28!\"},{\"tipo\":\"recuperacao\",\"texto\":\"Desafio vencido! Todo o time recuperou 100% do HP, os desmaiados reviveram e as condicoes foram curadas!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 900!\"}]}','2026-11-25 14:56:10','2026-11-25 10:56:18'),(275,75,NULL,NULL,NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":497,\"turnos\":7,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Inseto quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Galvantula!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Pignite!\"},{\"tipo\":\"golpe\",\"texto\":\"Galvantula usou Signal Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Pignite perdeu 11 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Pignite usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Galvantula perdeu 48 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Galvantula usou Signal Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Pignite perdeu 10 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Pignite usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Galvantula perdeu 22 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Galvantula desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Accelgor!\"},{\"tipo\":\"golpe\",\"texto\":\"Accelgor usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Accelgor aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Pignite usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Accelgor perdeu 66 HP.\"},{\"tipo\":\"status\",\"texto\":\"Accelgor recebeu Queimadura!\"},{\"tipo\":\"status\",\"texto\":\"Accelgor perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Accelgor usou Signal Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Pignite perdeu 20 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Pignite usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Accelgor perdeu 7 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Accelgor desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Durant!\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Durant aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Pignite usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Durant perdeu 59 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Bullet Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Pignite perdeu 25 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Pignite desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Zoroark Hisui!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Durant perdeu 5 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Durant desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Pignite subiu para o Nv. 23!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark Hisui subiu para o Nv. 31!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 31!\"},{\"tipo\":\"nivel\",\"texto\":\"Throh subiu para o Nv. 31!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 14:56:47','2026-11-25 10:56:55'),(276,75,NULL,NULL,NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":499,\"turnos\":8,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Lutador quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Conkeldurr!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Zoroark Hisui!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Zoroark Hisui aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Conkeldurr usou Drain Punch!\"},{\"tipo\":\"imunidade\",\"texto\":\"Não afetou Zoroark Hisui...\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Zoroark Hisui aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Conkeldurr usou Drain Punch!\"},{\"tipo\":\"imunidade\",\"texto\":\"Não afetou Zoroark Hisui...\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Zoroark Hisui aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Conkeldurr usou Drain Punch!\"},{\"tipo\":\"imunidade\",\"texto\":\"Não afetou Zoroark Hisui...\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial já está no máximo!\"},{\"tipo\":\"golpe\",\"texto\":\"Conkeldurr usou Drain Punch!\"},{\"tipo\":\"imunidade\",\"texto\":\"Não afetou Zoroark Hisui...\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial já está no máximo!\"},{\"tipo\":\"golpe\",\"texto\":\"Conkeldurr usou Drain Punch!\"},{\"tipo\":\"imunidade\",\"texto\":\"Não afetou Zoroark Hisui...\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Round!\"},{\"tipo\":\"dano\",\"texto\":\"Conkeldurr perdeu 93 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Conkeldurr desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Sawk!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Round!\"},{\"tipo\":\"dano\",\"texto\":\"Sawk perdeu 77 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Sawk desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Throh!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Round!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 101 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Throh desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark Hisui subiu para o Nv. 34!\"},{\"tipo\":\"nivel\",\"texto\":\"Throh subiu para o Nv. 34!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 34!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 14:57:02','2026-11-25 10:57:12'),(277,75,NULL,NULL,NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1502,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Galvantula!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Zoroark Hisui!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Galvantula perdeu 72 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Galvantula desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark Hisui subiu para o Nv. 36!\"},{\"tipo\":\"nivel\",\"texto\":\"Throh subiu para o Nv. 36!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 36!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 14:57:15','2026-11-25 10:57:16'),(278,75,NULL,NULL,3,'VITORIA',900,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":3,\"turnos\":7,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 3 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Emolga!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Zoroark Hisui!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Zoroark Hisui aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Emolga usou Spark!\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark Hisui perdeu 17 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Zoroark Hisui aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Emolga usou Spark!\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark Hisui perdeu 16 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Emolga perdeu 58 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Emolga desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Tranquill!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"imunidade\",\"texto\":\"Não afetou Tranquill...\"},{\"tipo\":\"golpe\",\"texto\":\"Tranquill usou Body Slam!\"},{\"tipo\":\"imunidade\",\"texto\":\"Não afetou Zoroark Hisui...\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Round!\"},{\"tipo\":\"dano\",\"texto\":\"Tranquill perdeu 66 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tranquill desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Swanna!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Round!\"},{\"tipo\":\"dano\",\"texto\":\"Swanna perdeu 77 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Swanna desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Archeops!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Archeops perdeu 82 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Archeops desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark Hisui subiu para o Nv. 39!\"},{\"tipo\":\"nivel\",\"texto\":\"Throh subiu para o Nv. 39!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 39!\"},{\"tipo\":\"nivel\",\"texto\":\"Pignite subiu para o Nv. 26!\"},{\"tipo\":\"recuperacao\",\"texto\":\"Desafio vencido! Todo o time recuperou 100% do HP, os desmaiados reviveram e as condicoes foram curadas!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 900!\"}]}','2026-11-25 14:57:24','2026-11-25 10:57:32'),(279,75,NULL,NULL,NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1508,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Stunfisk!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Zoroark Hisui!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Stunfisk perdeu 54 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Stunfisk usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Stunfisk aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Stunfisk perdeu 45 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Stunfisk usou Earth Power!\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark Hisui perdeu 66 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Stunfisk perdeu 15 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Stunfisk desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark Hisui subiu para o Nv. 41!\"},{\"tipo\":\"nivel\",\"texto\":\"Throh subiu para o Nv. 41!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 41!\"},{\"tipo\":\"nivel\",\"texto\":\"Pignite subiu para o Nv. 28!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 14:57:38','2026-11-25 10:57:41'),(280,75,NULL,NULL,NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1511,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Boldore!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Throh!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Boldore perdeu 77 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Boldore usou Rock Tomb!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 14 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Boldore perdeu 12 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Boldore desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Throh subiu para o Nv. 43!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 43!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark Hisui subiu para o Nv. 43!\"},{\"tipo\":\"nivel\",\"texto\":\"Pignite subiu para o Nv. 30!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 14:57:51','2026-11-25 10:57:53'),(281,75,NULL,NULL,NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1514,\"turnos\":5,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Swoobat!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Throh!\"},{\"tipo\":\"golpe\",\"texto\":\"Swoobat usou Psychic!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 39 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Throh aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Swoobat usou Psychic!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 39 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Swoobat perdeu 37 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Swoobat usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Swoobat aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Swoobat perdeu 37 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Swoobat usou Psychic!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 78 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Throh desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Serperior!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Swoobat perdeu 13 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Swoobat desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Throh subiu para o Nv. 45!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 45!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark Hisui subiu para o Nv. 45!\"},{\"tipo\":\"nivel\",\"texto\":\"Pignite subiu para o Nv. 32!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 14:58:02','2026-11-25 10:58:09'),(282,75,NULL,NULL,NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1517,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Throh!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Serperior!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 45 HP.\"},{\"tipo\":\"status\",\"texto\":\"Throh recebeu Sono!\"},{\"tipo\":\"status\",\"texto\":\"Throh está dormindo!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 43 HP.\"},{\"tipo\":\"status\",\"texto\":\"Throh está dormindo!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 34 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Throh desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 47!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark Hisui subiu para o Nv. 47!\"},{\"tipo\":\"nivel\",\"texto\":\"Pignite subiu para o Nv. 34!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 14:58:15','2026-11-25 10:58:17'),(283,75,NULL,NULL,4,'VITORIA',900,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":4,\"turnos\":12,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 4 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Heatmor!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Serperior!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Serperior aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Heatmor usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Heatmor aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Heatmor perdeu 61 HP.\"},{\"tipo\":\"status\",\"texto\":\"Heatmor recebeu Sono!\"},{\"tipo\":\"status\",\"texto\":\"Heatmor está dormindo!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Heatmor perdeu 24 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Heatmor desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Simisear!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Serperior aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Simisear usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 37 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Simisear perdeu 85 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Simisear desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Darmanitan Standard!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Darmanitan Standard perdeu 103 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Darmanitan Standard usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 51 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Darmanitan Standard perdeu 6 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Darmanitan Standard desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Chandelure!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Chandelure perdeu 60 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Chandelure usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Chandelure aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Chandelure perdeu 24 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Chandelure desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Volcarona!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Volcarona perdeu 41 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Volcarona usou Signal Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 39 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Serperior desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Zoroark Hisui!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Zoroark Hisui aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Volcarona usou Incinerate!\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark Hisui perdeu 52 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Volcarona perdeu 66 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Volcarona desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 50!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark Hisui subiu para o Nv. 50!\"},{\"tipo\":\"nivel\",\"texto\":\"Pignite subiu para o Nv. 37!\"},{\"tipo\":\"evolucao\",\"texto\":\"Pignite evoluiu para Emboar!\"},{\"tipo\":\"recuperacao\",\"texto\":\"Desafio vencido! Todo o time recuperou 100% do HP, os desmaiados reviveram e as condicoes foram curadas!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 900!\"}]}','2026-11-25 14:58:36','2026-11-25 10:58:51'),(284,75,NULL,NULL,NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":506,\"turnos\":7,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Terra quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Stunfisk!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Serperior!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Serperior aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Stunfisk usou Shock Wave!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 11 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Serperior aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Stunfisk usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Stunfisk aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque já está no máximo!\"},{\"tipo\":\"golpe\",\"texto\":\"Stunfisk usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Stunfisk aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Stunfisk perdeu 140 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Stunfisk desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Krookodile!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Krookodile perdeu 128 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Krookodile desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Excadrill!\"},{\"tipo\":\"golpe\",\"texto\":\"Excadrill usou Bullet Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 39 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Excadrill perdeu 123 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Excadrill perdeu 18 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Excadrill desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 53!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark Hisui subiu para o Nv. 53!\"},{\"tipo\":\"nivel\",\"texto\":\"Throh subiu para o Nv. 48!\"},{\"tipo\":\"nivel\",\"texto\":\"Emboar subiu para o Nv. 40!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 15:00:00','2026-11-25 11:00:10'),(285,75,NULL,NULL,NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":508,\"turnos\":8,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Pedra quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Crustle!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Serperior!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Crustle perdeu 32 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Crustle usou Bug Bite!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 58 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Crustle perdeu 35 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Crustle usou Bug Bite!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 61 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Crustle perdeu 37 HP.\"},{\"tipo\":\"status\",\"texto\":\"Crustle recebeu Sono!\"},{\"tipo\":\"status\",\"texto\":\"Crustle está dormindo!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Crustle perdeu 4 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Crustle desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Gigalith!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Gigalith perdeu 65 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Gigalith usou Rock Tomb!\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 2 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Serperior desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Zoroark Hisui!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Zoroark Hisui aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Gigalith usou Rock Tomb!\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark Hisui perdeu 54 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Gigalith perdeu 55 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Gigalith desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Carracosta!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Carracosta perdeu 111 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Carracosta desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 56!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark Hisui subiu para o Nv. 56!\"},{\"tipo\":\"nivel\",\"texto\":\"Throh subiu para o Nv. 51!\"},{\"tipo\":\"nivel\",\"texto\":\"Emboar subiu para o Nv. 43!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 15:00:13','2026-11-25 11:00:22'),(286,75,NULL,NULL,NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1531,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Gothitelle!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Zoroark Hisui!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Gothitelle perdeu 106 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Gothitelle desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark Hisui subiu para o Nv. 58!\"},{\"tipo\":\"nivel\",\"texto\":\"Throh subiu para o Nv. 53!\"},{\"tipo\":\"nivel\",\"texto\":\"Emboar subiu para o Nv. 45!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 15:00:26','2026-11-25 11:00:27'),(287,75,NULL,NULL,NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1533,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Gigalith!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Zoroark Hisui!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Gigalith perdeu 93 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Gigalith usou Rock Tomb!\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark Hisui perdeu 51 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Gigalith perdeu 25 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Gigalith desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark Hisui subiu para o Nv. 60!\"},{\"tipo\":\"nivel\",\"texto\":\"Throh subiu para o Nv. 55!\"},{\"tipo\":\"nivel\",\"texto\":\"Emboar subiu para o Nv. 47!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 15:00:30','2026-11-25 11:00:32'),(288,75,NULL,NULL,5,'VITORIA',900,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":5,\"turnos\":13,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ex-Campeão quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Scrafty!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Zoroark Hisui!\"},{\"tipo\":\"golpe\",\"texto\":\"Scrafty usou Sucker Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark Hisui perdeu 45 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Zoroark Hisui aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Zoroark Hisui aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Scrafty usou Drain Punch!\"},{\"tipo\":\"imunidade\",\"texto\":\"Não afetou Zoroark Hisui...\"},{\"tipo\":\"golpe\",\"texto\":\"Scrafty usou Sucker Punch!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark Hisui perdeu 59 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Scrafty perdeu 85 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Scrafty desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Braviary!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Round!\"},{\"tipo\":\"dano\",\"texto\":\"Braviary perdeu 115 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Braviary desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Amoonguss!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Amoonguss perdeu 131 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Amoonguss desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Seismitoad!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Seismitoad perdeu 130 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Seismitoad desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Beartic!\"},{\"tipo\":\"golpe\",\"texto\":\"Beartic usou Ice Shard!\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark Hisui perdeu 32 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Zoroark Hisui desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Serperior!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Beartic perdeu 58 HP.\"},{\"tipo\":\"status\",\"texto\":\"Beartic recebeu Sono!\"},{\"tipo\":\"status\",\"texto\":\"Beartic está dormindo!\"},{\"tipo\":\"status\",\"texto\":\"Beartic está dormindo!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Beartic perdeu 53 HP.\"},{\"tipo\":\"status\",\"texto\":\"Beartic acordou!\"},{\"tipo\":\"golpe\",\"texto\":\"Beartic usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 71 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Beartic perdeu 17 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Beartic desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Eelektross!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Eelektross perdeu 60 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Eelektross usou Spark!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 16 HP.\"},{\"tipo\":\"status\",\"texto\":\"Serperior recebeu Paralisia!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Eelektross perdeu 60 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Eelektross usou Spark!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 16 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Eelektross perdeu 6 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Eelektross desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark Hisui subiu para o Nv. 63!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 59!\"},{\"tipo\":\"nivel\",\"texto\":\"Throh subiu para o Nv. 58!\"},{\"tipo\":\"nivel\",\"texto\":\"Emboar subiu para o Nv. 50!\"},{\"tipo\":\"recuperacao\",\"texto\":\"Desafio vencido! Todo o time recuperou 100% do HP, os desmaiados reviveram e as condicoes foram curadas!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 900!\"}]}','2026-11-25 15:00:39','2026-11-25 11:00:57'),(289,75,NULL,NULL,NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1538,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Boldore!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Zoroark Hisui!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Zoroark Hisui aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Boldore usou Rock Tomb!\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark Hisui perdeu 48 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Boldore perdeu 122 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Boldore desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark Hisui subiu para o Nv. 65!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 61!\"},{\"tipo\":\"nivel\",\"texto\":\"Throh subiu para o Nv. 60!\"},{\"tipo\":\"nivel\",\"texto\":\"Emboar subiu para o Nv. 52!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 15:02:54','2026-11-25 11:02:59'),(290,75,NULL,NULL,NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":513,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Inseto quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Accelgor!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Emboar!\"},{\"tipo\":\"golpe\",\"texto\":\"Accelgor usou Signal Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Emboar perdeu 13 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Emboar usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Accelgor perdeu 134 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Accelgor desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Durant!\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Bullet Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Emboar perdeu 31 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Emboar usou Fire Fang!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Durant perdeu 113 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Durant desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Emboar subiu para o Nv. 55!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 64!\"},{\"tipo\":\"nivel\",\"texto\":\"Throh subiu para o Nv. 63!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark Hisui subiu para o Nv. 68!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 15:03:03','2026-11-25 11:03:06'),(291,75,NULL,NULL,NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":514,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Psiquico quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Gothorita!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Zoroark Hisui!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Gothorita perdeu 115 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Gothorita desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Swoobat!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Swoobat perdeu 122 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Swoobat desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark Hisui subiu para o Nv. 71!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 67!\"},{\"tipo\":\"nivel\",\"texto\":\"Throh subiu para o Nv. 66!\"},{\"tipo\":\"nivel\",\"texto\":\"Emboar subiu para o Nv. 58!\"},{\"tipo\":\"recuperacao\",\"texto\":\"A equipe recuperou parte do HP após a vitória!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-25 15:03:20','2026-11-25 11:03:22'),(292,75,NULL,NULL,NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1548,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Accelgor!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Zoroark Hisui!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Accelgor perdeu 132 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Accelgor desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark Hisui subiu para o Nv. 73!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 69!\"},{\"tipo\":\"nivel\",\"texto\":\"Throh subiu para o Nv. 68!\"},{\"tipo\":\"nivel\",\"texto\":\"Emboar subiu para o Nv. 60!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-25 15:03:25','2026-11-25 11:03:26'),(293,75,NULL,NULL,6,'VITORIA',900,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":6,\"turnos\":15,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Rival quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Golurk!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Zoroark Hisui!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Zoroark Hisui aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Golurk usou Bulldoze!\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark Hisui perdeu 39 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Zoroark Hisui aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Golurk usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Golurk aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Golurk perdeu 121 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Golurk desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Serperior!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 115 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Serperior desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Samurott!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Samurott perdeu 137 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Samurott desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Hydreigon!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Hydreigon perdeu 131 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Hydreigon usou Dark Pulse!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark Hisui perdeu 101 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Round!\"},{\"tipo\":\"dano\",\"texto\":\"Hydreigon perdeu 9 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Hydreigon desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Emboar!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark Hisui usou Shadow Ball!\"},{\"tipo\":\"dano\",\"texto\":\"Emboar perdeu 163 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Emboar desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Kingambit!\"},{\"tipo\":\"golpe\",\"texto\":\"Kingambit usou Sucker Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark Hisui perdeu 23 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Zoroark Hisui desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Serperior!\"},{\"tipo\":\"golpe\",\"texto\":\"Kingambit usou Bullet Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 45 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Serperior aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Kingambit perdeu 31 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Kingambit usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Kingambit aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Kingambit usou Sucker Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 65 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Serperior aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Kingambit usou Bullet Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 66 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Kingambit perdeu 44 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Kingambit usou Bullet Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 6 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Serperior desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Throh!\"},{\"tipo\":\"golpe\",\"texto\":\"Kingambit usou Bullet Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 78 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Kingambit perdeu 85 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Kingambit desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark Hisui subiu para o Nv. 76!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 72!\"},{\"tipo\":\"nivel\",\"texto\":\"Throh subiu para o Nv. 71!\"},{\"tipo\":\"nivel\",\"texto\":\"Emboar subiu para o Nv. 63!\"},{\"tipo\":\"recuperacao\",\"texto\":\"Desafio vencido! Todo o time recuperou 100% do HP, os desmaiados reviveram e as condicoes foram curadas!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 900!\"}]}','2026-11-25 15:03:29','2026-11-25 11:03:49'),(294,NULL,76,'red2',NULL,'DERROTA',0,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":516,\"turnos\":6,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Normal quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Deerling!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Deerling usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 2 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Tepig aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Deerling usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Deerling aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Tepig aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Deerling usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Deerling aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque já está no máximo!\"},{\"tipo\":\"golpe\",\"texto\":\"Deerling usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 5 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque já está no máximo!\"},{\"tipo\":\"golpe\",\"texto\":\"Deerling usou Body Slam!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 11 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque já está no máximo!\"},{\"tipo\":\"golpe\",\"texto\":\"Deerling usou Body Slam!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 3 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-25 15:05:18','2026-11-25 11:05:20'),(295,NULL,77,'leaf',NULL,'DERROTA',0,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1569,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Tirtouga!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Tepig aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tirtouga usou Rock Tomb!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 13 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Tepig aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tirtouga usou Rock Tomb!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 8 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-25 15:10:04','2026-11-25 11:10:05'),(296,NULL,78,'leaf',NULL,'DERROTA',0,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":1587,\"turnos\":5,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Throh!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Tepig aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 7 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Tepig aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 9 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque já está no máximo!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Throh aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque já está no máximo!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 5 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Purrloin!\"},{\"tipo\":\"golpe\",\"texto\":\"Purrloin usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Purrloin aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Purrloin perdeu 19 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Purrloin desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-25 15:10:22','2026-11-25 11:10:23');
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
) ENGINE=InnoDB AUTO_INCREMENT=1231 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batalha_pokemon`
--

LOCK TABLES `batalha_pokemon` WRITE;
/*!40000 ALTER TABLE `batalha_pokemon` DISABLE KEYS */;
INSERT INTO `batalha_pokemon` VALUES (138,61,NULL,16,'JOGADOR',1,50,192,192,NULL,NULL),(139,61,NULL,82,'INIMIGO',1,3,56,0,NULL,NULL),(140,62,NULL,17,'JOGADOR',1,51,210,210,NULL,NULL),(141,62,NULL,27,'INIMIGO',1,6,60,0,NULL,NULL),(142,62,NULL,25,'INIMIGO',2,6,60,0,NULL,NULL),(143,63,NULL,18,'JOGADOR',1,53,231,231,NULL,NULL),(144,63,NULL,25,'INIMIGO',1,10,72,0,NULL,NULL),(230,78,NULL,18,'JOGADOR',1,54,145,145,NULL,NULL),(231,78,NULL,53,'INIMIGO',1,13,42,0,NULL,NULL),(232,79,NULL,18,'JOGADOR',1,55,147,147,NULL,NULL),(233,79,NULL,143,'INIMIGO',1,12,33,0,NULL,NULL),(234,79,NULL,154,'INIMIGO',2,15,48,0,NULL,NULL),(235,80,NULL,18,'JOGADOR',1,57,152,145,NULL,NULL),(236,80,NULL,102,'JOGADOR',2,57,112,112,NULL,NULL),(237,80,NULL,64,'JOGADOR',3,57,101,101,NULL,NULL),(238,80,NULL,61,'JOGADOR',4,57,118,118,NULL,NULL),(239,80,NULL,127,'INIMIGO',1,20,96,0,NULL,NULL),(240,80,NULL,126,'INIMIGO',2,20,70,0,NULL,NULL),(241,80,NULL,37,'INIMIGO',3,20,60,0,NULL,NULL),(242,81,NULL,18,'JOGADOR',1,59,150,150,NULL,NULL),(243,81,NULL,103,'JOGADOR',2,59,139,139,NULL,NULL),(244,81,NULL,66,'JOGADOR',3,59,139,139,NULL,NULL),(245,81,NULL,63,'JOGADOR',4,59,157,157,NULL,NULL),(246,81,NULL,109,'INIMIGO',1,18,49,0,NULL,NULL),(247,81,NULL,49,'INIMIGO',2,20,56,0,NULL,NULL),(248,81,NULL,39,'INIMIGO',3,22,83,0,NULL,NULL),(249,82,NULL,18,'JOGADOR',1,61,155,151,NULL,NULL),(250,82,NULL,103,'JOGADOR',2,61,144,144,NULL,NULL),(251,82,NULL,66,'JOGADOR',3,61,144,144,NULL,NULL),(252,82,NULL,63,'JOGADOR',4,61,162,162,NULL,NULL),(253,82,NULL,84,'JOGADOR',5,61,156,156,NULL,NULL),(254,82,NULL,128,'JOGADOR',6,61,132,132,NULL,NULL),(255,82,NULL,127,'INIMIGO',1,27,126,0,NULL,NULL),(256,83,NULL,18,'JOGADOR',1,63,167,167,NULL,NULL),(257,83,NULL,103,'JOGADOR',2,63,148,148,NULL,NULL),(258,83,NULL,66,'JOGADOR',3,63,148,148,NULL,NULL),(259,83,NULL,63,'JOGADOR',4,63,167,167,NULL,NULL),(260,83,NULL,73,'JOGADOR',5,63,224,224,NULL,NULL),(261,83,NULL,129,'JOGADOR',6,63,161,161,NULL,NULL),(262,83,NULL,97,'INIMIGO',1,23,58,0,NULL,NULL),(263,83,NULL,41,'INIMIGO',2,25,66,0,NULL,NULL),(264,83,NULL,115,'INIMIGO',3,27,77,0,NULL,NULL),(265,83,NULL,99,'INIMIGO',4,29,82,0,NULL,NULL),(266,84,NULL,18,'JOGADOR',1,65,172,4,NULL,NULL),(267,84,NULL,103,'JOGADOR',2,65,153,153,NULL,NULL),(268,84,NULL,66,'JOGADOR',3,65,153,153,NULL,NULL),(269,84,NULL,90,'JOGADOR',4,65,124,124,NULL,NULL),(270,84,NULL,73,'JOGADOR',5,65,231,231,NULL,NULL),(271,84,NULL,129,'JOGADOR',6,65,166,166,NULL,NULL),(272,84,NULL,63,'INIMIGO',1,34,95,0,NULL,NULL),(273,84,NULL,81,'INIMIGO',2,34,95,0,NULL,NULL),(274,84,NULL,131,'INIMIGO',3,34,94,0,NULL,NULL),(275,85,NULL,18,'JOGADOR',1,67,177,0,2,NULL),(276,85,NULL,103,'JOGADOR',2,67,157,157,NULL,NULL),(277,85,NULL,66,'JOGADOR',3,67,157,157,NULL,NULL),(278,85,NULL,91,'JOGADOR',4,67,154,154,NULL,NULL),(279,85,NULL,73,'JOGADOR',5,67,237,237,NULL,NULL),(280,85,NULL,129,'JOGADOR',6,67,170,170,NULL,NULL),(281,85,NULL,163,'INIMIGO',1,28,85,0,NULL,NULL),(282,85,NULL,35,'INIMIGO',2,30,85,0,NULL,NULL),(283,85,NULL,79,'INIMIGO',3,32,109,0,NULL,NULL),(284,85,NULL,142,'INIMIGO',4,34,84,0,NULL,NULL),(285,85,NULL,169,'INIMIGO',5,36,107,0,NULL,NULL),(286,86,NULL,18,'JOGADOR',1,69,0,0,2,NULL),(287,86,NULL,59,'JOGADOR',2,69,244,244,NULL,NULL),(288,86,NULL,103,'JOGADOR',3,69,161,161,NULL,NULL),(289,86,NULL,91,'JOGADOR',4,69,159,159,NULL,NULL),(290,86,NULL,73,'JOGADOR',5,69,244,244,NULL,NULL),(291,86,NULL,129,'JOGADOR',6,69,175,175,NULL,NULL),(292,86,NULL,82,'INIMIGO',1,32,74,0,NULL,NULL),(293,86,NULL,92,'INIMIGO',2,32,76,0,NULL,NULL),(294,87,NULL,18,'JOGADOR',1,69,0,0,2,NULL),(295,87,NULL,59,'JOGADOR',2,71,251,234,NULL,NULL),(296,87,NULL,103,'JOGADOR',3,71,166,166,NULL,NULL),(297,87,NULL,91,'JOGADOR',4,71,163,163,NULL,NULL),(298,87,NULL,73,'JOGADOR',5,71,251,251,NULL,NULL),(299,87,NULL,129,'JOGADOR',6,71,180,180,NULL,NULL),(300,87,NULL,92,'INIMIGO',1,37,86,0,NULL,NULL),(301,88,NULL,18,'JOGADOR',1,69,0,0,2,NULL),(302,88,NULL,59,'JOGADOR',2,73,241,224,NULL,NULL),(303,88,NULL,103,'JOGADOR',3,73,170,170,NULL,NULL),(304,88,NULL,91,'JOGADOR',4,73,167,167,NULL,NULL),(305,88,NULL,73,'JOGADOR',5,73,258,258,NULL,NULL),(306,88,NULL,129,'JOGADOR',6,73,185,185,NULL,NULL),(307,88,NULL,127,'INIMIGO',1,41,186,0,NULL,NULL),(308,89,NULL,18,'JOGADOR',1,69,0,0,2,NULL),(309,89,NULL,59,'JOGADOR',2,75,231,83,5,NULL),(310,89,NULL,103,'JOGADOR',3,75,175,175,NULL,NULL),(311,89,NULL,91,'JOGADOR',4,75,172,172,NULL,NULL),(312,89,NULL,73,'JOGADOR',5,75,265,265,NULL,NULL),(313,89,NULL,129,'JOGADOR',6,75,190,190,NULL,NULL),(314,89,NULL,86,'INIMIGO',1,33,85,0,NULL,NULL),(315,89,NULL,159,'INIMIGO',2,35,115,0,NULL,NULL),(316,89,NULL,124,'INIMIGO',3,37,131,0,NULL,NULL),(317,89,NULL,58,'INIMIGO',4,39,130,0,NULL,NULL),(318,89,NULL,147,'INIMIGO',5,41,128,0,NULL,NULL),(319,89,NULL,137,'INIMIGO',6,43,126,0,NULL,NULL),(320,90,NULL,18,'JOGADOR',1,69,0,0,2,NULL),(321,90,NULL,103,'JOGADOR',2,77,179,139,NULL,NULL),(322,90,NULL,91,'JOGADOR',3,77,176,176,NULL,NULL),(323,90,NULL,59,'JOGADOR',4,77,89,89,5,NULL),(324,90,NULL,73,'JOGADOR',5,77,271,271,NULL,NULL),(325,90,NULL,129,'JOGADOR',6,77,194,194,NULL,NULL),(326,90,NULL,131,'INIMIGO',1,33,91,0,NULL,NULL),(327,91,NULL,18,'JOGADOR',1,69,0,0,2,NULL),(328,91,NULL,103,'JOGADOR',2,78,141,141,NULL,NULL),(329,91,NULL,91,'JOGADOR',3,78,178,178,NULL,NULL),(330,91,NULL,140,'JOGADOR',4,78,166,166,NULL,NULL),(331,91,NULL,73,'JOGADOR',5,78,275,275,NULL,NULL),(332,91,NULL,129,'JOGADOR',6,78,197,197,NULL,NULL),(333,91,NULL,28,'INIMIGO',1,44,111,0,NULL,NULL),(334,91,NULL,120,'INIMIGO',2,44,124,0,NULL,NULL),(335,92,NULL,18,'JOGADOR',1,69,0,0,2,NULL),(336,92,NULL,103,'JOGADOR',2,80,146,146,NULL,NULL),(337,92,NULL,91,'JOGADOR',3,80,182,182,NULL,NULL),(338,92,NULL,142,'JOGADOR',4,80,186,186,NULL,NULL),(339,92,NULL,73,'JOGADOR',5,80,282,282,NULL,NULL),(340,92,NULL,129,'JOGADOR',6,80,202,202,NULL,NULL),(341,92,NULL,46,'INIMIGO',1,48,125,0,NULL,NULL),(342,93,NULL,103,'JOGADOR',1,81,188,0,NULL,NULL),(343,93,NULL,91,'JOGADOR',2,81,184,138,NULL,NULL),(344,93,NULL,142,'JOGADOR',3,81,188,188,NULL,NULL),(345,93,NULL,73,'JOGADOR',4,81,285,285,NULL,NULL),(346,93,NULL,129,'JOGADOR',5,81,204,204,NULL,NULL),(347,93,NULL,18,'JOGADOR',6,69,182,182,NULL,NULL),(348,93,NULL,66,'INIMIGO',1,40,98,0,NULL,NULL),(349,93,NULL,18,'INIMIGO',2,42,115,0,NULL,NULL),(350,93,NULL,24,'INIMIGO',3,44,137,0,NULL,NULL),(351,93,NULL,167,'INIMIGO',4,46,140,0,NULL,NULL),(352,93,NULL,21,'INIMIGO',5,48,163,0,NULL,NULL),(353,93,NULL,96,'INIMIGO',6,50,160,0,NULL,NULL),(354,94,NULL,19,'JOGADOR',1,5,21,16,NULL,NULL),(355,94,NULL,53,'INIMIGO',1,2,15,0,2,NULL),(356,95,NULL,19,'JOGADOR',1,6,18,18,NULL,NULL),(357,95,NULL,59,'INIMIGO',1,3,20,0,2,NULL),(358,96,NULL,19,'JOGADOR',1,7,21,19,NULL,NULL),(359,96,NULL,151,'JOGADOR',2,7,32,32,NULL,NULL),(360,96,NULL,61,'INIMIGO',1,4,17,0,NULL,NULL),(361,96,NULL,130,'INIMIGO',2,4,17,0,NULL,NULL),(362,97,NULL,151,'JOGADOR',1,9,38,0,NULL,NULL),(363,97,NULL,19,'JOGADOR',2,9,30,0,NULL,NULL),(364,97,NULL,143,'INIMIGO',1,12,33,9,NULL,NULL),(365,97,NULL,154,'INIMIGO',2,15,48,48,NULL,NULL),(366,98,NULL,97,'JOGADOR',1,5,20,20,NULL,NULL),(367,98,NULL,19,'JOGADOR',2,5,21,21,NULL,NULL),(368,98,NULL,74,'JOGADOR',3,5,20,20,NULL,NULL),(369,98,NULL,146,'JOGADOR',4,5,20,20,NULL,NULL),(370,98,NULL,53,'INIMIGO',1,2,15,0,NULL,NULL),(371,98,NULL,60,'INIMIGO',2,2,15,0,NULL,NULL),(372,99,NULL,97,'JOGADOR',1,7,24,0,NULL,NULL),(373,99,NULL,19,'JOGADOR',2,7,26,0,NULL,NULL),(374,99,NULL,74,'JOGADOR',3,7,24,0,NULL,NULL),(375,99,NULL,146,'JOGADOR',4,7,24,0,NULL,NULL),(376,99,NULL,154,'INIMIGO',1,12,40,2,NULL,NULL),(377,100,NULL,16,'JOGADOR',1,5,19,18,NULL,NULL),(378,100,NULL,36,'INIMIGO',1,2,14,0,NULL,NULL),(379,101,NULL,16,'JOGADOR',1,6,20,20,NULL,NULL),(380,101,NULL,45,'INIMIGO',1,3,16,0,NULL,NULL),(381,102,NULL,16,'JOGADOR',1,7,22,20,NULL,NULL),(382,102,NULL,92,'INIMIGO',1,4,18,0,NULL,NULL),(383,103,NULL,16,'JOGADOR',1,9,24,5,NULL,NULL),(384,103,NULL,119,'INIMIGO',1,6,23,0,NULL,NULL),(385,104,NULL,16,'JOGADOR',1,10,29,0,NULL,NULL),(386,104,NULL,154,'INIMIGO',1,12,40,30,NULL,NULL),(387,105,NULL,19,'JOGADOR',1,5,21,16,NULL,NULL),(388,105,NULL,53,'INIMIGO',1,2,15,0,2,NULL),(389,105,NULL,60,'INIMIGO',2,2,15,0,2,NULL),(390,106,NULL,19,'JOGADOR',1,7,21,21,NULL,NULL),(391,106,NULL,164,'INIMIGO',1,4,18,0,NULL,NULL),(392,107,NULL,19,'JOGADOR',1,9,25,25,NULL,NULL),(393,107,NULL,130,'INIMIGO',1,6,21,0,NULL,NULL),(394,108,NULL,19,'JOGADOR',1,10,28,28,NULL,NULL),(395,108,NULL,130,'INIMIGO',1,7,23,0,NULL,NULL),(396,109,NULL,19,'JOGADOR',1,12,37,0,NULL,NULL),(397,109,NULL,154,'INIMIGO',1,12,40,33,2,NULL),(398,110,NULL,19,'JOGADOR',1,5,21,21,NULL,NULL),(399,110,NULL,81,'INIMIGO',1,2,15,0,NULL,NULL),(400,111,NULL,19,'JOGADOR',1,6,23,23,NULL,NULL),(401,111,NULL,119,'INIMIGO',1,3,16,0,NULL,NULL),(402,112,NULL,19,'JOGADOR',1,7,26,26,NULL,NULL),(403,112,NULL,61,'INIMIGO',1,4,17,0,NULL,NULL),(404,113,NULL,19,'JOGADOR',1,8,28,8,NULL,NULL),(405,113,NULL,59,'INIMIGO',1,5,27,0,2,NULL),(406,114,NULL,19,'JOGADOR',1,9,30,0,NULL,NULL),(407,114,NULL,146,'INIMIGO',1,12,35,0,2,NULL),(408,114,NULL,117,'INIMIGO',2,15,40,40,NULL,NULL),(409,115,NULL,19,'JOGADOR',1,5,21,21,NULL,NULL),(410,115,NULL,119,'INIMIGO',1,2,14,0,NULL,NULL),(411,116,NULL,19,'JOGADOR',1,7,26,0,NULL,NULL),(412,116,NULL,27,'INIMIGO',1,4,17,17,NULL,NULL),(413,116,NULL,25,'INIMIGO',2,4,17,17,NULL,NULL),(414,117,NULL,22,'JOGADOR',1,5,20,0,NULL,NULL),(415,117,NULL,60,'INIMIGO',1,4,20,20,NULL,NULL),(416,118,NULL,22,'JOGADOR',1,5,20,20,NULL,NULL),(417,118,NULL,149,'INIMIGO',1,4,18,0,NULL,NULL),(418,119,NULL,22,'JOGADOR',1,8,26,26,NULL,NULL),(419,119,NULL,82,'INIMIGO',1,7,24,0,NULL,NULL),(420,120,NULL,22,'JOGADOR',1,11,33,33,NULL,NULL),(421,120,NULL,102,'JOGADOR',2,11,29,29,NULL,NULL),(422,120,NULL,74,'INIMIGO',1,9,28,0,NULL,NULL),(423,121,NULL,102,'JOGADOR',1,14,35,0,NULL,NULL),(424,121,NULL,22,'JOGADOR',2,14,39,15,NULL,NULL),(425,121,NULL,146,'INIMIGO',1,12,35,0,NULL,NULL),(426,121,NULL,117,'INIMIGO',2,15,40,0,NULL,NULL),(427,122,NULL,23,'JOGADOR',1,18,55,25,NULL,NULL),(428,122,NULL,102,'JOGADOR',2,18,42,42,NULL,NULL),(429,122,NULL,109,'INIMIGO',1,15,43,0,NULL,NULL),(430,123,NULL,102,'JOGADOR',1,20,46,20,NULL,NULL),(431,123,NULL,27,'JOGADOR',2,20,48,48,NULL,NULL),(432,123,NULL,92,'JOGADOR',3,20,51,51,NULL,NULL),(433,123,NULL,23,'JOGADOR',4,20,51,51,NULL,NULL),(434,123,NULL,49,'INIMIGO',1,18,52,0,NULL,NULL),(435,123,NULL,39,'INIMIGO',2,18,69,0,NULL,NULL),(436,124,NULL,103,'JOGADOR',1,23,57,20,NULL,NULL),(437,124,NULL,28,'JOGADOR',2,23,62,62,NULL,NULL),(438,124,NULL,92,'JOGADOR',3,23,57,57,NULL,NULL),(439,124,NULL,23,'JOGADOR',4,23,67,67,NULL,NULL),(440,124,NULL,171,'INIMIGO',1,18,47,0,NULL,NULL),(441,124,NULL,127,'INIMIGO',2,20,96,0,NULL,NULL),(442,124,NULL,37,'INIMIGO',3,22,65,0,NULL,NULL),(443,125,NULL,103,'JOGADOR',1,27,69,69,NULL,NULL),(444,125,NULL,28,'JOGADOR',2,27,72,72,NULL,NULL),(445,125,NULL,92,'JOGADOR',3,27,66,66,NULL,NULL),(446,125,NULL,23,'JOGADOR',4,27,77,77,NULL,NULL),(447,125,NULL,164,'JOGADOR',5,27,68,68,NULL,NULL),(448,125,NULL,48,'INIMIGO',1,24,65,0,NULL,NULL),(449,125,NULL,38,'INIMIGO',2,24,70,0,NULL,NULL),(450,126,NULL,77,'JOGADOR',1,30,82,51,NULL,NULL),(451,126,NULL,103,'JOGADOR',2,30,76,76,NULL,NULL),(452,126,NULL,28,'JOGADOR',3,30,79,79,NULL,NULL),(453,126,NULL,92,'JOGADOR',4,30,72,72,NULL,NULL),(454,126,NULL,23,'JOGADOR',5,30,85,85,NULL,NULL),(455,126,NULL,164,'JOGADOR',6,30,74,74,NULL,NULL),(456,126,NULL,128,'INIMIGO',1,27,64,0,NULL,NULL),(457,126,NULL,164,'INIMIGO',2,27,68,0,NULL,NULL),(458,127,NULL,103,'JOGADOR',1,33,82,53,NULL,NULL),(459,127,NULL,29,'JOGADOR',2,33,99,99,NULL,NULL),(460,127,NULL,92,'JOGADOR',3,33,78,78,NULL,NULL),(461,127,NULL,23,'JOGADOR',4,33,92,92,NULL,NULL),(462,127,NULL,164,'JOGADOR',5,33,81,81,NULL,NULL),(463,127,NULL,77,'JOGADOR',6,33,89,89,NULL,NULL),(464,127,NULL,97,'INIMIGO',1,23,58,0,NULL,NULL),(465,127,NULL,41,'INIMIGO',2,25,66,0,NULL,NULL),(466,127,NULL,115,'INIMIGO',3,27,77,0,NULL,NULL),(467,127,NULL,99,'INIMIGO',4,29,82,0,NULL,NULL),(468,128,NULL,93,'JOGADOR',1,37,101,101,NULL,NULL),(469,128,NULL,24,'JOGADOR',2,37,117,117,NULL,NULL),(470,128,NULL,103,'JOGADOR',3,37,91,91,NULL,NULL),(471,128,NULL,29,'JOGADOR',4,37,109,109,NULL,NULL),(472,128,NULL,164,'JOGADOR',5,37,89,89,NULL,NULL),(473,128,NULL,79,'JOGADOR',6,37,124,124,NULL,NULL),(474,128,NULL,83,'INIMIGO',1,33,89,0,NULL,NULL),(475,128,NULL,46,'INIMIGO',2,33,89,0,NULL,NULL),(476,128,NULL,93,'INIMIGO',3,33,91,0,NULL,NULL),(477,129,NULL,93,'JOGADOR',1,40,109,67,NULL,NULL),(478,129,NULL,24,'JOGADOR',2,40,126,126,NULL,NULL),(479,129,NULL,103,'JOGADOR',3,40,98,98,NULL,NULL),(480,129,NULL,29,'JOGADOR',4,40,118,118,NULL,NULL),(481,129,NULL,79,'JOGADOR',5,40,134,134,NULL,NULL),(482,129,NULL,164,'JOGADOR',6,40,96,96,NULL,NULL),(483,129,NULL,129,'INIMIGO',1,34,91,0,NULL,NULL),(484,129,NULL,164,'INIMIGO',2,34,83,0,NULL,NULL),(485,130,NULL,93,'JOGADOR',1,43,116,116,NULL,NULL),(486,130,NULL,24,'JOGADOR',2,43,134,134,NULL,NULL),(487,130,NULL,103,'JOGADOR',3,43,104,104,NULL,NULL),(488,130,NULL,29,'JOGADOR',4,43,126,126,NULL,NULL),(489,130,NULL,79,'JOGADOR',5,43,143,143,NULL,NULL),(490,130,NULL,164,'JOGADOR',6,43,102,102,NULL,NULL),(491,130,NULL,163,'INIMIGO',1,28,85,0,NULL,NULL),(492,130,NULL,35,'INIMIGO',2,30,85,0,NULL,NULL),(493,130,NULL,79,'INIMIGO',3,32,109,0,NULL,NULL),(494,130,NULL,142,'INIMIGO',4,34,84,0,NULL,NULL),(495,130,NULL,169,'INIMIGO',5,36,107,0,NULL,NULL),(496,131,NULL,93,'JOGADOR',1,47,126,126,NULL,NULL),(497,131,NULL,24,'JOGADOR',2,47,146,146,NULL,NULL),(498,131,NULL,103,'JOGADOR',3,47,113,113,NULL,NULL),(499,131,NULL,29,'JOGADOR',4,47,136,136,NULL,NULL),(500,131,NULL,79,'JOGADOR',5,47,155,155,NULL,NULL),(501,131,NULL,164,'JOGADOR',6,47,111,111,NULL,NULL),(502,131,NULL,83,'INIMIGO',1,39,103,0,NULL,NULL),(503,132,NULL,93,'JOGADOR',1,49,131,120,NULL,NULL),(504,132,NULL,24,'JOGADOR',2,49,152,152,NULL,NULL),(505,132,NULL,103,'JOGADOR',3,49,117,117,NULL,NULL),(506,132,NULL,29,'JOGADOR',4,49,142,142,NULL,NULL),(507,132,NULL,79,'JOGADOR',5,49,161,161,NULL,NULL),(508,132,NULL,128,'JOGADOR',6,49,108,108,NULL,NULL),(509,132,NULL,29,'INIMIGO',1,41,120,0,NULL,NULL),(510,132,NULL,26,'INIMIGO',2,41,100,0,NULL,NULL),(511,132,NULL,120,'INIMIGO',3,41,116,0,NULL,NULL),(512,133,NULL,93,'JOGADOR',1,52,138,49,NULL,NULL),(513,133,NULL,24,'JOGADOR',2,52,160,160,NULL,NULL),(514,133,NULL,103,'JOGADOR',3,52,124,124,NULL,NULL),(515,133,NULL,29,'JOGADOR',4,52,150,150,NULL,NULL),(516,133,NULL,79,'JOGADOR',5,52,171,171,NULL,NULL),(517,133,NULL,129,'JOGADOR',6,52,134,134,NULL,NULL),(518,133,NULL,86,'INIMIGO',1,33,85,0,NULL,NULL),(519,133,NULL,159,'INIMIGO',2,35,115,0,NULL,NULL),(520,133,NULL,124,'INIMIGO',3,37,131,0,NULL,NULL),(521,133,NULL,58,'INIMIGO',4,39,130,0,NULL,NULL),(522,133,NULL,147,'INIMIGO',5,41,128,0,NULL,NULL),(523,133,NULL,137,'INIMIGO',6,43,126,0,NULL,NULL),(524,134,NULL,93,'JOGADOR',1,56,148,0,NULL,NULL),(525,134,NULL,24,'JOGADOR',2,56,172,0,NULL,NULL),(526,134,NULL,103,'JOGADOR',3,56,133,133,NULL,NULL),(527,134,NULL,29,'JOGADOR',4,56,161,161,NULL,NULL),(528,134,NULL,79,'JOGADOR',5,56,183,183,NULL,NULL),(529,134,NULL,129,'JOGADOR',6,56,144,144,NULL,NULL),(530,134,NULL,120,'INIMIGO',1,47,132,0,NULL,NULL),(531,135,NULL,93,'JOGADOR',1,58,0,0,NULL,NULL),(532,135,NULL,24,'JOGADOR',2,58,0,0,NULL,NULL),(533,135,NULL,79,'JOGADOR',3,58,189,99,NULL,NULL),(534,135,NULL,103,'JOGADOR',4,58,137,137,NULL,NULL),(535,135,NULL,29,'JOGADOR',5,58,166,166,NULL,NULL),(536,135,NULL,129,'JOGADOR',6,58,149,149,NULL,NULL),(537,135,NULL,129,'INIMIGO',1,48,125,0,NULL,NULL),(538,135,NULL,150,'INIMIGO',2,48,134,0,NULL,NULL),(539,135,NULL,164,'INIMIGO',3,48,113,0,NULL,NULL),(540,136,NULL,79,'JOGADOR',1,61,199,0,NULL,NULL),(541,136,NULL,103,'JOGADOR',2,61,144,0,NULL,NULL),(542,136,NULL,29,'JOGADOR',3,61,174,0,NULL,NULL),(543,136,NULL,129,'JOGADOR',4,61,156,20,NULL,NULL),(544,136,NULL,24,'JOGADOR',5,58,178,178,NULL,NULL),(545,136,NULL,120,'JOGADOR',6,47,132,132,NULL,NULL),(546,136,NULL,156,'INIMIGO',1,40,121,0,NULL,NULL),(547,136,NULL,18,'INIMIGO',2,42,115,0,NULL,NULL),(548,136,NULL,24,'INIMIGO',3,44,137,0,NULL,NULL),(549,136,NULL,167,'INIMIGO',4,46,140,0,2,NULL),(550,136,NULL,21,'INIMIGO',5,48,163,0,NULL,NULL),(551,136,NULL,96,'INIMIGO',6,50,160,0,NULL,NULL),(552,137,NULL,19,'JOGADOR',1,5,21,15,NULL,NULL),(553,137,NULL,38,'INIMIGO',1,3,17,0,2,NULL),(554,138,NULL,19,'JOGADOR',1,7,26,19,NULL,NULL),(555,138,NULL,64,'JOGADOR',2,7,21,21,NULL,NULL),(556,138,NULL,128,'INIMIGO',1,5,20,0,NULL,NULL),(557,139,NULL,64,'JOGADOR',1,9,24,15,NULL,NULL),(558,139,NULL,19,'JOGADOR',2,9,30,30,NULL,NULL),(559,139,NULL,60,'INIMIGO',1,8,30,0,NULL,NULL),(560,140,NULL,19,'JOGADOR',1,12,37,6,NULL,NULL),(561,140,NULL,64,'JOGADOR',2,12,29,29,NULL,NULL),(562,140,NULL,146,'INIMIGO',1,12,35,0,NULL,NULL),(563,140,NULL,117,'INIMIGO',2,15,40,0,NULL,NULL),(564,141,NULL,19,'JOGADOR',1,16,46,0,NULL,NULL),(565,141,NULL,64,'JOGADOR',2,16,35,0,NULL,NULL),(566,141,NULL,151,'INIMIGO',1,13,51,4,2,NULL),(567,142,NULL,19,'JOGADOR',1,5,21,15,NULL,NULL),(568,142,NULL,164,'JOGADOR',2,5,20,20,NULL,NULL),(569,142,NULL,72,'JOGADOR',3,5,22,22,NULL,NULL),(570,142,NULL,146,'JOGADOR',4,5,20,20,NULL,NULL),(571,142,NULL,25,'INIMIGO',1,3,15,0,NULL,NULL),(572,143,NULL,19,'JOGADOR',1,7,26,0,NULL,NULL),(573,143,NULL,164,'JOGADOR',2,7,25,2,NULL,NULL),(574,143,NULL,72,'JOGADOR',3,7,26,26,NULL,NULL),(575,143,NULL,146,'JOGADOR',4,7,24,24,NULL,NULL),(576,143,NULL,146,'INIMIGO',1,12,35,0,NULL,NULL),(577,143,NULL,117,'INIMIGO',2,15,40,0,NULL,NULL),(578,144,NULL,19,'JOGADOR',1,11,35,0,NULL,NULL),(579,144,NULL,164,'JOGADOR',2,11,33,18,NULL,NULL),(580,144,NULL,72,'JOGADOR',3,11,36,36,NULL,NULL),(581,144,NULL,146,'JOGADOR',4,11,33,33,NULL,NULL),(582,144,NULL,148,'JOGADOR',5,11,38,38,NULL,NULL),(583,144,NULL,93,'INIMIGO',1,9,32,0,NULL,NULL),(584,145,NULL,164,'JOGADOR',1,13,37,27,NULL,NULL),(585,145,NULL,72,'JOGADOR',2,13,41,41,NULL,NULL),(586,145,NULL,146,'JOGADOR',3,13,37,37,NULL,NULL),(587,145,NULL,148,'JOGADOR',4,13,43,43,NULL,NULL),(588,145,NULL,19,'JOGADOR',5,13,0,0,NULL,NULL),(589,145,NULL,29,'INIMIGO',1,11,39,0,NULL,NULL),(590,145,NULL,26,'INIMIGO',2,11,34,0,NULL,NULL),(591,145,NULL,120,'INIMIGO',3,11,38,0,NULL,NULL),(592,146,NULL,72,'JOGADOR',1,16,48,19,NULL,NULL),(593,146,NULL,164,'JOGADOR',2,16,44,44,NULL,NULL),(594,146,NULL,146,'JOGADOR',3,16,43,43,NULL,NULL),(595,146,NULL,148,'JOGADOR',4,16,51,51,NULL,NULL),(596,146,NULL,19,'JOGADOR',5,13,0,0,NULL,NULL),(597,146,NULL,83,'INIMIGO',1,14,43,0,NULL,NULL),(598,146,NULL,47,'INIMIGO',2,14,47,0,NULL,NULL),(599,146,NULL,93,'INIMIGO',3,14,44,0,NULL,NULL),(600,147,NULL,164,'JOGADOR',1,19,51,0,NULL,NULL),(601,147,NULL,146,'JOGADOR',2,19,49,0,NULL,NULL),(602,147,NULL,148,'JOGADOR',3,19,59,0,NULL,NULL),(603,147,NULL,72,'JOGADOR',4,19,55,0,NULL,NULL),(604,147,NULL,19,'JOGADOR',5,13,39,0,NULL,NULL),(605,147,NULL,171,'INIMIGO',1,18,47,0,NULL,NULL),(606,147,NULL,127,'INIMIGO',2,20,96,0,NULL,NULL),(607,147,NULL,37,'INIMIGO',3,22,65,23,NULL,NULL),(608,148,NULL,19,'JOGADOR',1,5,21,21,NULL,NULL),(609,148,NULL,40,'JOGADOR',2,5,20,20,NULL,NULL),(610,148,NULL,149,'INIMIGO',1,3,16,0,NULL,NULL),(611,149,NULL,19,'JOGADOR',1,7,26,26,NULL,NULL),(612,149,NULL,40,'JOGADOR',2,7,24,24,NULL,NULL),(613,149,NULL,119,'INIMIGO',1,6,23,0,NULL,NULL),(614,150,NULL,40,'JOGADOR',1,10,30,30,NULL,NULL),(615,150,NULL,19,'JOGADOR',2,10,33,33,NULL,NULL),(616,150,NULL,50,'INIMIGO',1,9,29,0,NULL,NULL),(617,151,NULL,40,'JOGADOR',1,13,36,0,NULL,NULL),(618,151,NULL,19,'JOGADOR',2,13,39,11,NULL,NULL),(619,151,NULL,146,'INIMIGO',1,12,35,0,NULL,NULL),(620,151,NULL,117,'INIMIGO',2,15,40,0,NULL,NULL),(621,152,NULL,40,'JOGADOR',1,17,44,0,NULL,NULL),(622,152,NULL,20,'JOGADOR',2,17,57,0,NULL,NULL),(623,152,NULL,83,'INIMIGO',1,15,46,0,NULL,NULL),(624,152,NULL,46,'INIMIGO',2,15,46,0,NULL,NULL),(625,152,NULL,93,'INIMIGO',3,15,47,18,NULL,NULL),(626,153,NULL,19,'JOGADOR',1,5,21,15,5,NULL),(627,153,NULL,128,'INIMIGO',1,3,16,0,NULL,NULL),(628,154,NULL,19,'JOGADOR',1,7,26,0,5,NULL),(629,154,NULL,48,'INIMIGO',1,6,23,0,2,NULL),(630,155,NULL,19,'JOGADOR',1,5,21,21,NULL,NULL),(631,155,NULL,48,'INIMIGO',1,3,16,0,NULL,NULL),(632,156,NULL,19,'JOGADOR',1,7,26,15,NULL,NULL),(633,156,NULL,53,'INIMIGO',1,5,22,0,NULL,NULL),(634,157,NULL,19,'JOGADOR',1,9,30,30,NULL,NULL),(635,157,NULL,158,'JOGADOR',2,9,31,31,NULL,NULL),(636,157,NULL,27,'INIMIGO',1,8,25,0,NULL,NULL),(637,158,NULL,19,'JOGADOR',1,12,37,0,3,NULL),(638,158,NULL,158,'JOGADOR',2,12,38,0,NULL,NULL),(639,158,NULL,146,'INIMIGO',1,12,35,0,NULL,NULL),(640,158,NULL,117,'INIMIGO',2,15,40,16,2,NULL),(641,159,NULL,19,'JOGADOR',1,5,21,15,NULL,NULL),(642,159,NULL,27,'INIMIGO',1,4,17,0,NULL,NULL),(643,160,NULL,19,'JOGADOR',1,8,28,28,NULL,NULL),(644,160,NULL,119,'INIMIGO',1,7,25,0,NULL,NULL),(645,161,NULL,56,'JOGADOR',1,11,32,20,NULL,NULL),(646,161,NULL,19,'JOGADOR',2,11,35,35,NULL,NULL),(647,161,NULL,82,'INIMIGO',1,9,28,0,NULL,NULL),(648,162,NULL,57,'JOGADOR',1,14,45,19,NULL,NULL),(649,162,NULL,19,'JOGADOR',2,14,42,42,NULL,NULL),(650,162,NULL,146,'INIMIGO',1,12,35,0,NULL,NULL),(651,162,NULL,117,'INIMIGO',2,15,40,0,NULL,NULL),(652,163,NULL,57,'JOGADOR',1,18,55,55,NULL,NULL),(653,163,NULL,64,'JOGADOR',2,18,38,38,NULL,NULL),(654,163,NULL,20,'JOGADOR',3,18,60,60,NULL,NULL),(655,163,NULL,151,'INIMIGO',1,16,60,0,NULL,NULL),(656,163,NULL,75,'INIMIGO',2,16,45,0,NULL,NULL),(657,164,NULL,20,'JOGADOR',1,21,68,68,NULL,NULL),(658,164,NULL,64,'JOGADOR',2,21,43,43,NULL,NULL),(659,164,NULL,57,'JOGADOR',3,21,62,62,NULL,NULL),(660,164,NULL,88,'JOGADOR',4,21,46,46,NULL,NULL),(661,164,NULL,129,'INIMIGO',1,18,53,0,NULL,NULL),(662,164,NULL,164,'INIMIGO',2,18,48,0,NULL,NULL),(663,165,NULL,89,'JOGADOR',1,24,61,44,NULL,NULL),(664,165,NULL,65,'JOGADOR',2,24,53,53,NULL,NULL),(665,165,NULL,57,'JOGADOR',3,24,70,70,NULL,NULL),(666,165,NULL,20,'JOGADOR',4,24,77,77,NULL,NULL),(667,165,NULL,171,'INIMIGO',1,18,47,0,NULL,NULL),(668,165,NULL,127,'INIMIGO',2,20,96,0,NULL,NULL),(669,165,NULL,37,'INIMIGO',3,22,65,0,NULL,NULL),(670,166,NULL,20,'JOGADOR',1,28,88,54,NULL,NULL),(671,166,NULL,65,'JOGADOR',2,28,60,60,NULL,NULL),(672,166,NULL,57,'JOGADOR',3,28,80,80,NULL,NULL),(673,166,NULL,89,'JOGADOR',4,28,70,70,NULL,NULL),(674,166,NULL,129,'INIMIGO',1,25,70,0,NULL,NULL),(675,166,NULL,150,'INIMIGO',2,25,75,0,NULL,NULL),(676,166,NULL,164,'INIMIGO',3,25,64,0,NULL,NULL),(677,167,NULL,20,'JOGADOR',1,31,96,88,NULL,NULL),(678,167,NULL,66,'JOGADOR',2,31,78,78,NULL,NULL),(679,167,NULL,57,'JOGADOR',3,31,87,87,NULL,NULL),(680,167,NULL,89,'JOGADOR',4,31,76,76,NULL,NULL),(681,167,NULL,132,'JOGADOR',5,31,65,65,NULL,NULL),(682,167,NULL,129,'INIMIGO',1,26,72,0,NULL,NULL),(683,168,NULL,57,'JOGADOR',1,33,92,0,NULL,NULL),(684,168,NULL,66,'JOGADOR',2,33,82,0,NULL,NULL),(685,168,NULL,20,'JOGADOR',3,33,102,56,NULL,NULL),(686,168,NULL,89,'JOGADOR',4,33,81,81,NULL,NULL),(687,168,NULL,132,'JOGADOR',5,33,69,69,NULL,NULL),(688,168,NULL,97,'INIMIGO',1,23,58,0,NULL,NULL),(689,168,NULL,41,'INIMIGO',2,25,66,0,NULL,NULL),(690,168,NULL,115,'INIMIGO',3,27,77,0,NULL,NULL),(691,168,NULL,99,'INIMIGO',4,29,82,0,NULL,NULL),(692,169,NULL,58,'JOGADOR',1,37,124,52,NULL,NULL),(693,169,NULL,66,'JOGADOR',2,37,91,91,NULL,NULL),(694,169,NULL,21,'JOGADOR',3,37,128,128,NULL,NULL),(695,169,NULL,89,'JOGADOR',4,37,89,89,NULL,NULL),(696,169,NULL,132,'JOGADOR',5,37,76,76,NULL,NULL),(697,169,NULL,151,'INIMIGO',1,33,114,0,NULL,NULL),(698,169,NULL,75,'INIMIGO',2,33,82,0,NULL,NULL),(699,169,NULL,51,'INIMIGO',3,33,115,0,NULL,NULL),(700,170,NULL,89,'JOGADOR',1,40,96,96,NULL,NULL),(701,170,NULL,66,'JOGADOR',2,40,98,98,NULL,NULL),(702,170,NULL,21,'JOGADOR',3,40,138,138,NULL,NULL),(703,170,NULL,58,'JOGADOR',4,40,123,123,NULL,NULL),(704,170,NULL,133,'JOGADOR',5,40,98,98,NULL,NULL),(705,170,NULL,54,'INIMIGO',1,34,101,0,NULL,NULL),(706,170,NULL,59,'INIMIGO',2,34,125,0,NULL,NULL),(707,171,NULL,58,'JOGADOR',1,43,143,143,NULL,NULL),(708,171,NULL,66,'JOGADOR',2,43,104,104,NULL,NULL),(709,171,NULL,21,'JOGADOR',3,43,147,147,NULL,NULL),(710,171,NULL,89,'JOGADOR',4,43,102,102,NULL,NULL),(711,171,NULL,133,'JOGADOR',5,43,104,104,NULL,NULL),(712,171,NULL,75,'INIMIGO',1,34,84,0,NULL,NULL),(713,171,NULL,51,'INIMIGO',2,34,118,0,NULL,NULL),(714,172,NULL,58,'JOGADOR',1,46,152,88,NULL,NULL),(715,172,NULL,66,'JOGADOR',2,46,111,111,NULL,NULL),(716,172,NULL,21,'JOGADOR',3,46,157,157,NULL,NULL),(717,172,NULL,89,'JOGADOR',4,46,109,109,NULL,NULL),(718,172,NULL,134,'JOGADOR',5,46,111,111,NULL,NULL),(719,172,NULL,93,'INIMIGO',1,33,91,0,NULL,NULL),(720,173,NULL,58,'JOGADOR',1,48,150,71,NULL,NULL),(721,173,NULL,66,'JOGADOR',2,48,115,115,NULL,NULL),(722,173,NULL,21,'JOGADOR',3,48,163,163,NULL,NULL),(723,173,NULL,89,'JOGADOR',4,48,113,113,NULL,NULL),(724,173,NULL,134,'JOGADOR',5,48,115,115,NULL,NULL),(725,173,NULL,163,'INIMIGO',1,28,85,0,NULL,NULL),(726,173,NULL,35,'INIMIGO',2,30,85,0,NULL,NULL),(727,173,NULL,79,'INIMIGO',3,32,109,0,NULL,NULL),(728,173,NULL,142,'INIMIGO',4,34,84,0,NULL,NULL),(729,173,NULL,169,'INIMIGO',5,36,107,0,NULL,NULL),(730,174,NULL,21,'JOGADOR',1,52,176,176,NULL,NULL),(731,174,NULL,66,'JOGADOR',2,52,124,124,NULL,NULL),(732,174,NULL,58,'JOGADOR',3,52,171,171,NULL,NULL),(733,174,NULL,89,'JOGADOR',4,52,122,122,NULL,NULL),(734,174,NULL,134,'JOGADOR',5,52,124,124,NULL,NULL),(735,174,NULL,27,'INIMIGO',1,41,87,0,NULL,NULL),(736,175,NULL,89,'JOGADOR',1,55,128,114,NULL,NULL),(737,175,NULL,66,'JOGADOR',2,55,131,131,NULL,NULL),(738,175,NULL,58,'JOGADOR',3,55,180,180,NULL,NULL),(739,175,NULL,21,'JOGADOR',4,55,186,186,NULL,NULL),(740,175,NULL,134,'JOGADOR',5,55,131,131,NULL,NULL),(741,175,NULL,108,'INIMIGO',1,41,87,0,NULL,NULL),(742,175,NULL,38,'INIMIGO',2,41,113,0,NULL,NULL),(743,176,NULL,89,'JOGADOR',1,58,135,120,NULL,NULL),(744,176,NULL,66,'JOGADOR',2,58,137,137,NULL,NULL),(745,176,NULL,58,'JOGADOR',3,58,189,189,NULL,NULL),(746,176,NULL,21,'JOGADOR',4,58,195,195,NULL,NULL),(747,176,NULL,134,'JOGADOR',5,58,137,137,NULL,NULL),(748,176,NULL,48,'INIMIGO',1,41,104,0,NULL,NULL),(749,177,NULL,21,'JOGADOR',1,61,205,205,NULL,NULL),(750,177,NULL,66,'JOGADOR',2,61,144,144,NULL,NULL),(751,177,NULL,58,'JOGADOR',3,61,199,199,NULL,NULL),(752,177,NULL,89,'JOGADOR',4,61,141,141,NULL,NULL),(753,177,NULL,134,'JOGADOR',5,61,144,144,NULL,NULL),(754,177,NULL,25,'INIMIGO',1,41,87,0,NULL,NULL),(755,178,NULL,21,'JOGADOR',1,64,214,128,NULL,NULL),(756,178,NULL,66,'JOGADOR',2,64,150,150,NULL,NULL),(757,178,NULL,58,'JOGADOR',3,64,208,208,NULL,NULL),(758,178,NULL,89,'JOGADOR',4,64,148,148,NULL,NULL),(759,178,NULL,134,'JOGADOR',5,64,150,150,NULL,NULL),(760,178,NULL,86,'INIMIGO',1,33,85,0,NULL,NULL),(761,178,NULL,159,'INIMIGO',2,35,115,0,NULL,NULL),(762,178,NULL,124,'INIMIGO',3,37,131,0,NULL,NULL),(763,178,NULL,58,'INIMIGO',4,39,130,0,NULL,NULL),(764,178,NULL,147,'INIMIGO',5,41,128,0,NULL,NULL),(765,178,NULL,137,'INIMIGO',6,43,126,0,NULL,NULL),(766,179,NULL,21,'JOGADOR',1,68,227,227,NULL,NULL),(767,179,NULL,66,'JOGADOR',2,68,159,159,NULL,NULL),(768,179,NULL,58,'JOGADOR',3,68,220,220,NULL,NULL),(769,179,NULL,89,'JOGADOR',4,68,156,156,NULL,NULL),(770,179,NULL,134,'JOGADOR',5,68,159,159,NULL,NULL),(771,179,NULL,59,'INIMIGO',1,47,169,0,NULL,NULL),(772,180,NULL,21,'JOGADOR',1,70,234,234,NULL,NULL),(773,180,NULL,66,'JOGADOR',2,70,164,164,NULL,NULL),(774,180,NULL,58,'JOGADOR',3,70,227,227,NULL,NULL),(775,180,NULL,89,'JOGADOR',4,70,161,161,NULL,NULL),(776,180,NULL,134,'JOGADOR',5,70,164,164,NULL,NULL),(777,180,NULL,116,'JOGADOR',6,70,130,130,NULL,NULL),(778,180,NULL,26,'INIMIGO',1,48,115,0,NULL,NULL),(779,180,NULL,120,'INIMIGO',2,48,134,0,NULL,NULL),(780,181,NULL,21,'JOGADOR',1,73,243,0,NULL,NULL),(781,181,NULL,66,'JOGADOR',2,73,170,129,NULL,NULL),(782,181,NULL,58,'JOGADOR',3,73,236,236,NULL,NULL),(783,181,NULL,89,'JOGADOR',4,73,167,167,NULL,NULL),(784,181,NULL,134,'JOGADOR',5,73,170,170,NULL,NULL),(785,181,NULL,118,'JOGADOR',6,73,186,186,NULL,NULL),(786,181,NULL,156,'INIMIGO',1,40,121,0,NULL,NULL),(787,181,NULL,18,'INIMIGO',2,42,115,0,NULL,NULL),(788,181,NULL,24,'INIMIGO',3,44,137,0,NULL,NULL),(789,181,NULL,167,'INIMIGO',4,46,140,0,NULL,NULL),(790,181,NULL,21,'INIMIGO',5,48,163,0,NULL,NULL),(791,181,NULL,96,'INIMIGO',6,50,160,0,NULL,NULL),(792,182,NULL,19,'JOGADOR',1,5,21,17,NULL,NULL),(793,182,NULL,82,'INIMIGO',1,3,16,0,NULL,NULL),(794,183,NULL,19,'JOGADOR',1,6,23,17,NULL,NULL),(795,183,NULL,149,'INIMIGO',1,5,20,0,NULL,NULL),(796,184,NULL,16,'JOGADOR',1,8,25,0,NULL,NULL),(797,184,NULL,19,'JOGADOR',2,8,28,23,NULL,NULL),(798,184,NULL,82,'INIMIGO',1,7,24,0,NULL,NULL),(799,185,NULL,19,'JOGADOR',1,10,33,0,NULL,NULL),(800,185,NULL,16,'JOGADOR',2,10,29,29,NULL,NULL),(801,185,NULL,146,'INIMIGO',1,12,35,0,NULL,NULL),(802,185,NULL,117,'INIMIGO',2,15,40,0,2,NULL),(803,186,NULL,19,'JOGADOR',1,13,39,20,NULL,NULL),(804,186,NULL,16,'JOGADOR',2,13,34,34,NULL,NULL),(805,186,NULL,129,'INIMIGO',1,11,36,0,NULL,NULL),(806,186,NULL,150,'INIMIGO',2,11,38,0,NULL,NULL),(807,186,NULL,164,'INIMIGO',3,11,33,0,NULL,NULL),(808,187,NULL,36,'JOGADOR',1,15,40,0,NULL,NULL),(809,187,NULL,16,'JOGADOR',2,15,38,0,NULL,NULL),(810,187,NULL,19,'JOGADOR',3,15,34,34,NULL,NULL),(811,187,NULL,34,'JOGADOR',4,15,40,40,NULL,NULL),(812,187,NULL,151,'INIMIGO',1,13,51,0,NULL,NULL),(813,187,NULL,76,'INIMIGO',2,13,47,0,NULL,NULL),(814,187,NULL,51,'INIMIGO',3,13,51,0,NULL,NULL),(815,188,NULL,17,'JOGADOR',1,17,47,0,NULL,NULL),(816,188,NULL,36,'JOGADOR',2,17,44,0,NULL,NULL),(817,188,NULL,34,'JOGADOR',3,17,44,0,NULL,NULL),(818,188,NULL,20,'JOGADOR',4,17,57,0,NULL,NULL),(819,188,NULL,171,'INIMIGO',1,18,47,0,NULL,NULL),(820,188,NULL,127,'INIMIGO',2,20,96,0,NULL,NULL),(821,188,NULL,37,'INIMIGO',3,22,65,55,NULL,NULL),(822,189,NULL,19,'JOGADOR',1,5,21,8,NULL,NULL),(823,189,NULL,45,'INIMIGO',1,3,16,0,2,NULL),(824,190,NULL,19,'JOGADOR',1,6,14,14,NULL,NULL),(825,190,NULL,119,'INIMIGO',1,4,18,0,NULL,NULL),(826,191,NULL,19,'JOGADOR',1,7,21,0,NULL,NULL),(827,191,NULL,78,'JOGADOR',2,7,26,26,NULL,NULL),(828,191,NULL,50,'INIMIGO',1,5,21,0,NULL,NULL),(829,192,NULL,19,'JOGADOR',1,8,0,0,NULL,NULL),(830,192,NULL,78,'JOGADOR',2,8,29,0,NULL,NULL),(831,192,NULL,146,'INIMIGO',1,12,35,23,NULL,NULL),(832,192,NULL,117,'INIMIGO',2,15,40,40,NULL,NULL),(833,193,NULL,19,'JOGADOR',1,5,21,0,NULL,NULL),(834,193,NULL,45,'INIMIGO',1,3,16,8,NULL,NULL),(835,194,NULL,19,'JOGADOR',1,5,21,7,NULL,NULL),(836,194,NULL,119,'INIMIGO',1,4,18,0,NULL,NULL),(837,195,NULL,19,'JOGADOR',1,7,18,0,NULL,NULL),(838,195,NULL,38,'INIMIGO',1,6,25,15,NULL,NULL),(839,196,NULL,19,'JOGADOR',1,5,21,9,NULL,NULL),(840,196,NULL,53,'INIMIGO',1,3,17,0,NULL,NULL),(841,197,NULL,19,'JOGADOR',1,6,15,13,NULL,NULL),(842,197,NULL,82,'INIMIGO',1,4,18,0,NULL,NULL),(843,198,NULL,19,'JOGADOR',1,7,20,12,NULL,NULL),(844,198,NULL,163,'JOGADOR',2,7,28,28,NULL,NULL),(845,198,NULL,25,'INIMIGO',1,6,21,0,NULL,NULL),(846,199,NULL,19,'JOGADOR',1,9,30,0,NULL,NULL),(847,199,NULL,163,'JOGADOR',2,9,34,21,NULL,NULL),(848,199,NULL,146,'INIMIGO',1,12,35,0,NULL,NULL),(849,199,NULL,117,'INIMIGO',2,15,40,0,2,NULL),(850,200,NULL,19,'JOGADOR',1,12,37,0,NULL,NULL),(851,200,NULL,163,'JOGADOR',2,12,42,35,NULL,NULL),(852,200,NULL,28,'INIMIGO',1,10,33,0,NULL,NULL),(853,200,NULL,120,'INIMIGO',2,10,36,0,NULL,NULL),(854,201,NULL,19,'JOGADOR',1,14,0,0,NULL,NULL),(855,201,NULL,163,'JOGADOR',2,14,47,17,NULL,NULL),(856,201,NULL,83,'INIMIGO',1,11,36,0,NULL,NULL),(857,202,NULL,19,'JOGADOR',1,14,0,0,NULL,NULL),(858,202,NULL,163,'JOGADOR',2,15,28,5,NULL,NULL),(859,202,NULL,151,'INIMIGO',1,12,48,0,2,NULL),(860,203,NULL,19,'JOGADOR',1,14,0,0,NULL,NULL),(861,203,NULL,163,'JOGADOR',2,16,16,0,NULL,NULL),(862,203,NULL,129,'INIMIGO',1,14,43,0,NULL,NULL),(863,203,NULL,150,'INIMIGO',2,14,46,0,NULL,NULL),(864,203,NULL,164,'INIMIGO',3,14,40,40,NULL,NULL),(865,204,NULL,19,'JOGADOR',1,5,21,21,NULL,NULL),(866,204,NULL,149,'INIMIGO',1,4,18,0,NULL,NULL),(867,205,NULL,19,'JOGADOR',1,7,26,14,NULL,NULL),(868,205,NULL,143,'JOGADOR',2,7,23,23,NULL,NULL),(869,205,NULL,108,'JOGADOR',3,7,23,23,NULL,NULL),(870,205,NULL,164,'INIMIGO',1,6,22,0,NULL,NULL),(871,206,NULL,19,'JOGADOR',1,9,30,0,NULL,NULL),(872,206,NULL,143,'JOGADOR',2,9,27,0,NULL,NULL),(873,206,NULL,108,'JOGADOR',3,9,27,0,NULL,NULL),(874,206,NULL,146,'INIMIGO',1,12,35,0,NULL,NULL),(875,206,NULL,117,'INIMIGO',2,15,40,34,NULL,NULL),(876,207,NULL,19,'JOGADOR',1,5,21,2,NULL,NULL),(877,207,NULL,59,'INIMIGO',1,4,23,0,2,NULL),(878,208,NULL,19,'JOGADOR',1,7,13,0,NULL,NULL),(879,208,NULL,123,'JOGADOR',2,7,26,21,NULL,NULL),(880,208,NULL,40,'JOGADOR',3,7,24,24,NULL,NULL),(881,208,NULL,59,'INIMIGO',1,5,27,0,2,NULL),(882,209,NULL,19,'JOGADOR',1,5,21,15,NULL,NULL),(883,209,NULL,60,'JOGADOR',2,5,22,22,NULL,NULL),(884,209,NULL,143,'JOGADOR',3,5,19,19,NULL,NULL),(885,209,NULL,25,'INIMIGO',1,3,15,0,NULL,NULL),(886,210,NULL,60,'JOGADOR',1,6,25,25,NULL,NULL),(887,210,NULL,19,'JOGADOR',2,6,21,21,NULL,NULL),(888,210,NULL,143,'JOGADOR',3,6,21,21,NULL,NULL),(889,210,NULL,119,'INIMIGO',1,5,21,0,NULL,NULL),(890,211,NULL,60,'JOGADOR',1,8,30,0,NULL,NULL),(891,211,NULL,19,'JOGADOR',2,8,28,0,NULL,NULL),(892,211,NULL,143,'JOGADOR',3,8,25,0,NULL,NULL),(893,211,NULL,146,'INIMIGO',1,12,35,0,NULL,NULL),(894,211,NULL,117,'INIMIGO',2,15,40,23,NULL,NULL),(895,212,NULL,19,'JOGADOR',1,5,21,18,NULL,NULL),(896,212,NULL,157,'JOGADOR',2,5,24,24,NULL,NULL),(897,212,NULL,164,'INIMIGO',1,3,16,0,NULL,NULL),(898,213,NULL,19,'JOGADOR',1,6,23,0,NULL,NULL),(899,213,NULL,157,'JOGADOR',2,6,27,19,NULL,NULL),(900,213,NULL,130,'JOGADOR',3,6,21,21,NULL,NULL),(901,213,NULL,92,'INIMIGO',1,4,18,0,NULL,NULL),(902,214,NULL,19,'JOGADOR',1,7,26,0,NULL,NULL),(903,214,NULL,157,'JOGADOR',2,7,30,0,NULL,NULL),(904,214,NULL,130,'JOGADOR',3,7,23,0,NULL,NULL),(905,214,NULL,146,'INIMIGO',1,12,35,0,NULL,NULL),(906,214,NULL,117,'INIMIGO',2,15,40,29,NULL,NULL),(907,215,NULL,19,'JOGADOR',1,5,21,19,NULL,NULL),(908,215,NULL,119,'INIMIGO',1,4,18,0,NULL,NULL),(909,216,NULL,19,'JOGADOR',1,7,26,20,NULL,NULL),(910,216,NULL,164,'INIMIGO',1,6,22,0,NULL,NULL),(911,217,NULL,19,'JOGADOR',1,9,30,0,NULL,NULL),(912,217,NULL,60,'INIMIGO',1,8,30,20,NULL,NULL),(913,218,NULL,19,'JOGADOR',1,5,21,15,NULL,NULL),(914,218,NULL,119,'INIMIGO',1,4,18,0,NULL,NULL),(915,219,NULL,19,'JOGADOR',1,8,28,20,NULL,NULL),(916,219,NULL,168,'JOGADOR',2,8,26,26,NULL,NULL),(917,219,NULL,149,'INIMIGO',1,7,24,0,NULL,NULL),(918,220,NULL,19,'JOGADOR',1,11,34,34,NULL,NULL),(919,220,NULL,168,'JOGADOR',2,11,33,33,NULL,NULL),(920,220,NULL,53,'INIMIGO',1,9,32,0,2,NULL),(921,221,NULL,19,'JOGADOR',1,13,39,11,NULL,NULL),(922,221,NULL,168,'JOGADOR',2,13,37,37,NULL,NULL),(923,221,NULL,146,'INIMIGO',1,12,35,0,NULL,NULL),(924,221,NULL,117,'INIMIGO',2,15,40,0,NULL,NULL),(925,222,NULL,19,'JOGADOR',1,16,46,0,NULL,NULL),(926,222,NULL,168,'JOGADOR',2,16,43,0,NULL,NULL),(927,222,NULL,29,'INIMIGO',1,14,47,0,NULL,NULL),(928,222,NULL,26,'INIMIGO',2,14,40,22,NULL,NULL),(929,222,NULL,120,'INIMIGO',3,14,46,46,NULL,NULL),(930,223,NULL,19,'JOGADOR',1,5,21,21,NULL,NULL),(931,223,NULL,128,'INIMIGO',1,3,16,0,NULL,NULL),(932,224,NULL,19,'JOGADOR',1,7,26,26,NULL,NULL),(933,224,NULL,87,'JOGADOR',2,7,27,27,NULL,NULL),(934,224,NULL,165,'JOGADOR',3,7,24,24,NULL,NULL),(935,224,NULL,27,'INIMIGO',1,6,21,0,NULL,NULL),(936,225,NULL,19,'JOGADOR',1,10,33,0,3,NULL),(937,225,NULL,87,'JOGADOR',2,10,34,34,NULL,NULL),(938,225,NULL,165,'JOGADOR',3,10,30,30,NULL,NULL),(939,225,NULL,146,'INIMIGO',1,12,35,0,2,NULL),(940,225,NULL,117,'INIMIGO',2,15,40,0,4,NULL),(941,226,NULL,165,'JOGADOR',1,13,36,0,NULL,NULL),(942,226,NULL,87,'JOGADOR',2,13,41,41,NULL,NULL),(943,226,NULL,19,'JOGADOR',3,13,39,39,NULL,NULL),(944,226,NULL,151,'INIMIGO',1,11,44,0,2,NULL),(945,226,NULL,51,'INIMIGO',2,11,45,0,4,NULL),(946,227,NULL,165,'JOGADOR',1,16,0,0,NULL,NULL),(947,227,NULL,87,'JOGADOR',2,16,49,49,NULL,NULL),(948,227,NULL,19,'JOGADOR',3,16,46,46,NULL,NULL),(949,227,NULL,26,'INIMIGO',1,13,38,0,4,NULL),(950,228,NULL,165,'JOGADOR',1,16,0,0,NULL,NULL),(951,228,NULL,87,'JOGADOR',2,18,53,35,NULL,NULL),(952,228,NULL,20,'JOGADOR',3,18,60,60,NULL,NULL),(953,228,NULL,22,'JOGADOR',4,18,47,47,NULL,NULL),(954,228,NULL,93,'INIMIGO',1,15,47,0,4,NULL),(955,229,NULL,87,'JOGADOR',1,20,58,0,NULL,NULL),(956,229,NULL,20,'JOGADOR',2,20,66,0,NULL,NULL),(957,229,NULL,23,'JOGADOR',3,20,60,0,3,NULL),(958,229,NULL,165,'JOGADOR',4,16,42,0,NULL,NULL),(959,229,NULL,171,'INIMIGO',1,18,47,0,NULL,NULL),(960,229,NULL,127,'INIMIGO',2,20,96,5,NULL,NULL),(961,229,NULL,37,'INIMIGO',3,22,65,65,NULL,NULL),(962,230,NULL,19,'JOGADOR',1,5,21,5,NULL,NULL),(963,230,NULL,108,'INIMIGO',1,3,15,0,NULL,NULL),(964,231,NULL,19,'JOGADOR',1,7,14,0,NULL,NULL),(965,231,NULL,119,'INIMIGO',1,6,23,1,NULL,NULL),(966,232,NULL,19,'JOGADOR',1,5,21,9,NULL,NULL),(967,232,NULL,119,'JOGADOR',2,5,21,21,NULL,NULL),(968,232,NULL,27,'INIMIGO',1,4,17,0,NULL,NULL),(969,233,NULL,19,'JOGADOR',1,8,22,22,NULL,NULL),(970,233,NULL,119,'JOGADOR',2,8,27,27,NULL,NULL),(971,233,NULL,82,'INIMIGO',1,6,22,0,NULL,NULL),(972,234,NULL,19,'JOGADOR',1,10,32,32,NULL,NULL),(973,234,NULL,119,'JOGADOR',2,10,32,32,NULL,NULL),(974,234,NULL,108,'INIMIGO',1,8,25,0,NULL,NULL),(975,235,NULL,19,'JOGADOR',1,12,37,0,NULL,NULL),(976,235,NULL,119,'JOGADOR',2,12,36,0,NULL,NULL),(977,235,NULL,146,'INIMIGO',1,12,35,0,NULL,NULL),(978,235,NULL,117,'INIMIGO',2,15,40,29,NULL,NULL),(979,236,NULL,19,'JOGADOR',1,5,21,15,NULL,NULL),(980,236,NULL,108,'INIMIGO',1,3,15,0,NULL,NULL),(981,237,NULL,19,'JOGADOR',1,7,24,14,NULL,NULL),(982,237,NULL,53,'INIMIGO',1,6,25,0,2,NULL),(983,238,NULL,19,'JOGADOR',1,10,28,28,NULL,NULL),(984,238,NULL,22,'JOGADOR',2,10,31,31,NULL,NULL),(985,238,NULL,128,'INIMIGO',1,9,28,0,NULL,NULL),(986,239,NULL,20,'JOGADOR',1,13,46,0,3,NULL),(987,239,NULL,22,'JOGADOR',2,13,37,0,3,NULL),(988,239,NULL,146,'INIMIGO',1,12,35,0,NULL,NULL),(989,239,NULL,117,'INIMIGO',2,15,40,5,NULL,NULL),(990,240,NULL,19,'JOGADOR',1,5,21,15,NULL,NULL),(991,240,NULL,25,'JOGADOR',2,5,19,19,NULL,NULL),(992,240,NULL,25,'INIMIGO',1,4,17,0,NULL,NULL),(993,241,NULL,19,'JOGADOR',1,8,28,28,NULL,NULL),(994,241,NULL,25,'JOGADOR',2,8,25,25,NULL,NULL),(995,241,NULL,59,'INIMIGO',1,6,30,0,2,NULL),(996,242,NULL,19,'JOGADOR',1,10,33,29,NULL,NULL),(997,242,NULL,25,'JOGADOR',2,10,29,29,NULL,NULL),(998,242,NULL,149,'INIMIGO',1,9,28,0,NULL,NULL),(999,243,NULL,20,'JOGADOR',1,13,46,23,NULL,NULL),(1000,243,NULL,25,'JOGADOR',2,13,34,34,NULL,NULL),(1001,243,NULL,146,'INIMIGO',1,12,35,0,NULL,NULL),(1002,243,NULL,117,'INIMIGO',2,15,40,0,NULL,NULL),(1003,244,NULL,25,'JOGADOR',1,16,40,0,NULL,NULL),(1004,244,NULL,69,'JOGADOR',2,16,40,0,NULL,NULL),(1005,244,NULL,20,'JOGADOR',3,16,54,0,NULL,NULL),(1006,244,NULL,110,'INIMIGO',1,14,43,5,NULL,NULL),(1007,244,NULL,49,'INIMIGO',2,14,42,42,NULL,NULL),(1008,244,NULL,39,'INIMIGO',3,14,56,56,NULL,NULL),(1009,245,NULL,19,'JOGADOR',1,5,21,15,5,NULL),(1010,245,NULL,151,'INIMIGO',1,3,19,0,2,NULL),(1011,246,NULL,19,'JOGADOR',1,7,24,0,5,NULL),(1012,246,NULL,59,'INIMIGO',1,5,27,10,NULL,NULL),(1013,247,NULL,19,'JOGADOR',1,5,21,17,NULL,NULL),(1014,247,NULL,164,'INIMIGO',1,4,18,0,NULL,NULL),(1015,248,NULL,19,'JOGADOR',1,8,28,26,NULL,NULL),(1016,248,NULL,149,'INIMIGO',1,6,22,0,NULL,NULL),(1017,249,NULL,19,'JOGADOR',1,10,33,23,NULL,NULL),(1018,249,NULL,128,'INIMIGO',1,8,26,0,NULL,NULL),(1019,250,NULL,19,'JOGADOR',1,11,31,0,NULL,NULL),(1020,250,NULL,92,'INIMIGO',1,9,28,26,NULL,NULL),(1021,251,NULL,19,'JOGADOR',1,5,21,17,NULL,NULL),(1022,251,NULL,164,'INIMIGO',1,4,18,0,NULL,NULL),(1023,252,NULL,50,'JOGADOR',1,8,27,27,NULL,NULL),(1024,252,NULL,19,'JOGADOR',2,8,28,28,NULL,NULL),(1025,252,NULL,45,'INIMIGO',1,7,24,0,NULL,NULL),(1026,253,NULL,50,'JOGADOR',1,11,34,21,NULL,NULL),(1027,253,NULL,19,'JOGADOR',2,11,35,35,NULL,NULL),(1028,253,NULL,151,'INIMIGO',1,9,38,0,NULL,NULL),(1029,254,NULL,19,'JOGADOR',1,14,42,17,NULL,NULL),(1030,254,NULL,50,'JOGADOR',2,14,40,40,NULL,NULL),(1031,254,NULL,146,'INIMIGO',1,12,35,0,NULL,NULL),(1032,254,NULL,117,'INIMIGO',2,15,40,0,NULL,NULL),(1033,255,NULL,50,'JOGADOR',1,17,47,0,NULL,NULL),(1034,255,NULL,20,'JOGADOR',2,17,57,25,NULL,NULL),(1035,255,NULL,151,'INIMIGO',1,15,57,0,NULL,NULL),(1036,255,NULL,76,'INIMIGO',2,15,53,0,NULL,NULL),(1037,255,NULL,51,'INIMIGO',3,15,58,0,NULL,NULL),(1038,256,NULL,50,'JOGADOR',1,20,0,0,NULL,NULL),(1039,256,NULL,20,'JOGADOR',2,20,48,9,1,NULL),(1040,256,NULL,129,'INIMIGO',1,18,53,0,NULL,NULL),(1041,256,NULL,150,'INIMIGO',2,18,56,0,NULL,NULL),(1042,256,NULL,164,'INIMIGO',3,18,48,0,NULL,NULL),(1043,257,NULL,50,'JOGADOR',1,20,0,0,NULL,NULL),(1044,257,NULL,20,'JOGADOR',2,23,32,0,1,NULL),(1045,257,NULL,64,'JOGADOR',3,23,46,0,NULL,NULL),(1046,257,NULL,76,'INIMIGO',1,19,65,26,1,NULL),(1047,258,NULL,19,'JOGADOR',1,5,21,17,1,NULL),(1048,258,NULL,82,'INIMIGO',1,3,16,0,NULL,NULL),(1049,259,NULL,19,'JOGADOR',1,7,26,0,1,NULL),(1050,259,NULL,60,'INIMIGO',1,5,22,14,NULL,NULL),(1051,260,NULL,19,'JOGADOR',1,5,21,0,NULL,NULL),(1052,260,NULL,45,'INIMIGO',1,3,16,6,2,NULL),(1053,261,NULL,19,'JOGADOR',1,5,21,21,NULL,NULL),(1054,261,NULL,19,'JOGADOR',2,5,21,21,NULL,NULL),(1055,261,NULL,48,'INIMIGO',1,3,16,0,NULL,NULL),(1056,262,NULL,19,'JOGADOR',1,7,26,26,NULL,NULL),(1057,262,NULL,19,'JOGADOR',2,7,26,26,NULL,NULL),(1058,262,NULL,157,'JOGADOR',3,7,30,30,NULL,NULL),(1059,262,NULL,74,'INIMIGO',1,5,20,0,2,NULL),(1060,263,NULL,19,'JOGADOR',1,9,30,0,NULL,NULL),(1061,263,NULL,19,'JOGADOR',2,9,30,0,NULL,NULL),(1062,263,NULL,157,'JOGADOR',3,9,36,0,NULL,NULL),(1063,263,NULL,146,'INIMIGO',1,12,35,0,NULL,NULL),(1064,263,NULL,117,'INIMIGO',2,15,40,24,NULL,NULL),(1065,264,NULL,19,'JOGADOR',1,5,21,16,NULL,NULL),(1066,264,NULL,48,'INIMIGO',1,4,19,0,2,NULL),(1067,265,NULL,19,'JOGADOR',1,8,28,0,NULL,NULL),(1068,265,NULL,50,'INIMIGO',1,6,23,6,NULL,NULL),(1069,266,NULL,19,'JOGADOR',1,5,21,0,NULL,NULL),(1070,266,NULL,74,'INIMIGO',1,4,18,5,NULL,NULL),(1071,267,150,19,'JOGADOR',1,5,21,15,NULL,NULL),(1072,267,151,104,'JOGADOR',2,5,18,18,NULL,NULL),(1073,267,NULL,119,'INIMIGO',1,4,18,0,NULL,NULL),(1074,268,151,104,'JOGADOR',1,8,23,23,NULL,NULL),(1075,268,150,19,'JOGADOR',2,8,28,28,NULL,NULL),(1076,268,NULL,59,'INIMIGO',1,7,33,0,NULL,NULL),(1077,269,150,19,'JOGADOR',1,11,35,15,5,NULL),(1078,269,151,104,'JOGADOR',2,11,28,28,NULL,NULL),(1079,269,NULL,128,'INIMIGO',1,9,28,0,NULL,NULL),(1080,270,151,105,'JOGADOR',1,14,39,18,NULL,NULL),(1081,270,150,19,'JOGADOR',2,14,31,31,5,NULL),(1082,270,NULL,146,'INIMIGO',1,12,35,0,NULL,NULL),(1083,270,NULL,117,'INIMIGO',2,15,40,0,NULL,NULL),(1084,271,150,20,'JOGADOR',1,17,57,0,NULL,NULL),(1085,271,151,105,'JOGADOR',2,17,45,23,NULL,NULL),(1086,271,NULL,83,'INIMIGO',1,15,46,0,NULL,NULL),(1087,271,NULL,46,'INIMIGO',2,15,46,0,NULL,NULL),(1088,272,150,20,'JOGADOR',1,20,0,0,NULL,NULL),(1089,272,151,105,'JOGADOR',2,20,41,15,NULL,NULL),(1090,272,NULL,49,'INIMIGO',1,18,52,0,NULL,NULL),(1091,272,NULL,39,'INIMIGO',2,18,69,0,NULL,NULL),(1092,273,150,20,'JOGADOR',1,20,0,0,NULL,NULL),(1093,273,151,105,'JOGADOR',2,23,33,20,NULL,NULL),(1094,273,152,16,'JOGADOR',3,23,53,53,NULL,NULL),(1095,273,NULL,129,'INIMIGO',1,19,55,0,NULL,NULL),(1096,274,152,18,'JOGADOR',1,25,72,43,NULL,NULL),(1097,274,151,105,'JOGADOR',2,25,62,62,NULL,NULL),(1098,274,150,20,'JOGADOR',3,20,0,0,NULL,NULL),(1099,274,NULL,171,'INIMIGO',1,18,47,0,NULL,NULL),(1100,274,NULL,127,'INIMIGO',2,20,96,0,NULL,NULL),(1101,274,NULL,37,'INIMIGO',3,22,65,0,NULL,NULL),(1102,275,150,20,'JOGADOR',1,20,66,0,NULL,NULL),(1103,275,151,105,'JOGADOR',2,28,68,68,NULL,NULL),(1104,275,152,18,'JOGADOR',3,28,80,80,NULL,NULL),(1105,275,153,59,'JOGADOR',4,28,105,105,NULL,NULL),(1106,275,NULL,129,'INIMIGO',1,25,70,0,NULL,NULL),(1107,275,NULL,150,'INIMIGO',2,25,75,0,2,NULL),(1108,275,NULL,164,'INIMIGO',3,25,64,0,NULL,NULL),(1109,276,151,105,'JOGADOR',1,31,75,75,NULL,NULL),(1110,276,153,59,'JOGADOR',2,31,115,115,NULL,NULL),(1111,276,152,18,'JOGADOR',3,31,87,87,NULL,NULL),(1112,276,150,20,'JOGADOR',4,23,0,0,NULL,NULL),(1113,276,NULL,55,'INIMIGO',1,27,93,0,NULL,NULL),(1114,276,NULL,60,'INIMIGO',2,27,77,0,NULL,NULL),(1115,276,NULL,59,'INIMIGO',3,27,101,0,NULL,NULL),(1116,277,151,105,'JOGADOR',1,34,81,81,NULL,NULL),(1117,277,153,59,'JOGADOR',2,34,125,125,NULL,NULL),(1118,277,152,18,'JOGADOR',3,34,95,95,NULL,NULL),(1119,277,150,20,'JOGADOR',4,23,0,0,NULL,NULL),(1120,277,NULL,129,'INIMIGO',1,26,72,0,NULL,NULL),(1121,278,151,105,'JOGADOR',1,36,85,52,NULL,NULL),(1122,278,153,59,'JOGADOR',2,36,132,132,NULL,NULL),(1123,278,152,18,'JOGADOR',3,36,100,100,NULL,NULL),(1124,278,150,20,'JOGADOR',4,23,74,74,NULL,NULL),(1125,278,NULL,97,'INIMIGO',1,23,58,0,NULL,NULL),(1126,278,NULL,41,'INIMIGO',2,25,66,0,NULL,NULL),(1127,278,NULL,115,'INIMIGO',3,27,77,0,NULL,NULL),(1128,278,NULL,99,'INIMIGO',4,29,82,0,NULL,NULL),(1129,279,151,105,'JOGADOR',1,39,91,25,NULL,NULL),(1130,279,153,59,'JOGADOR',2,39,142,142,NULL,NULL),(1131,279,152,18,'JOGADOR',3,39,107,107,NULL,NULL),(1132,279,150,20,'JOGADOR',4,26,82,82,NULL,NULL),(1133,279,NULL,151,'INIMIGO',1,33,114,0,NULL,NULL),(1134,280,153,59,'JOGADOR',1,41,149,135,NULL,NULL),(1135,280,152,18,'JOGADOR',2,41,112,112,NULL,NULL),(1136,280,151,105,'JOGADOR',3,41,45,45,NULL,NULL),(1137,280,150,20,'JOGADOR',4,28,88,88,NULL,NULL),(1138,280,NULL,46,'INIMIGO',1,33,89,0,NULL,NULL),(1139,281,153,59,'JOGADOR',1,43,156,0,NULL,NULL),(1140,281,152,18,'JOGADOR',2,43,117,117,NULL,NULL),(1141,281,151,105,'JOGADOR',3,43,64,64,NULL,NULL),(1142,281,150,20,'JOGADOR',4,30,94,94,NULL,NULL),(1143,281,NULL,49,'INIMIGO',1,33,87,0,NULL,NULL),(1144,282,152,18,'JOGADOR',1,45,122,122,NULL,NULL),(1145,282,151,105,'JOGADOR',2,45,84,84,NULL,NULL),(1146,282,153,59,'JOGADOR',3,45,0,0,NULL,NULL),(1147,282,150,20,'JOGADOR',4,32,99,99,NULL,NULL),(1148,282,NULL,59,'INIMIGO',1,33,122,0,4,NULL),(1149,283,152,18,'JOGADOR',1,47,127,0,NULL,NULL),(1150,283,151,105,'JOGADOR',2,47,105,53,NULL,NULL),(1151,283,153,59,'JOGADOR',3,45,0,0,NULL,NULL),(1152,283,150,20,'JOGADOR',4,34,105,105,NULL,NULL),(1153,283,NULL,163,'INIMIGO',1,28,85,0,4,NULL),(1154,283,NULL,35,'INIMIGO',2,30,85,0,NULL,NULL),(1155,283,NULL,79,'INIMIGO',3,32,109,0,NULL,NULL),(1156,283,NULL,142,'INIMIGO',4,34,84,0,NULL,NULL),(1157,283,NULL,169,'INIMIGO',5,36,107,0,NULL,NULL),(1158,284,152,18,'JOGADOR',1,50,135,85,NULL,NULL),(1159,284,151,105,'JOGADOR',2,50,115,115,NULL,NULL),(1160,284,153,59,'JOGADOR',3,45,163,163,NULL,NULL),(1161,284,150,21,'JOGADOR',4,37,128,128,NULL,NULL),(1162,284,NULL,151,'INIMIGO',1,41,140,0,NULL,NULL),(1163,284,NULL,76,'INIMIGO',2,41,128,0,NULL,NULL),(1164,284,NULL,51,'INIMIGO',3,41,141,0,NULL,NULL),(1165,285,152,18,'JOGADOR',1,53,121,0,NULL,NULL),(1166,285,151,105,'JOGADOR',2,53,121,67,NULL,NULL),(1167,285,153,59,'JOGADOR',3,48,173,173,NULL,NULL),(1168,285,150,21,'JOGADOR',4,40,138,138,NULL,NULL),(1169,285,NULL,83,'INIMIGO',1,41,108,0,4,NULL),(1170,285,NULL,47,'INIMIGO',2,41,120,0,NULL,NULL),(1171,285,NULL,93,'INIMIGO',3,41,111,0,NULL,NULL),(1172,286,152,18,'JOGADOR',1,56,0,0,NULL,NULL),(1173,286,151,105,'JOGADOR',2,56,99,99,NULL,NULL),(1174,286,153,59,'JOGADOR',3,51,183,183,NULL,NULL),(1175,286,150,21,'JOGADOR',4,43,147,147,NULL,NULL),(1176,286,NULL,110,'INIMIGO',1,40,106,0,NULL,NULL),(1177,287,152,18,'JOGADOR',1,56,0,0,NULL,NULL),(1178,287,151,105,'JOGADOR',2,58,123,72,NULL,NULL),(1179,287,153,59,'JOGADOR',3,53,190,190,NULL,NULL),(1180,287,150,21,'JOGADOR',4,45,154,154,NULL,NULL),(1181,287,NULL,47,'INIMIGO',1,40,118,0,NULL,NULL),(1182,288,151,105,'JOGADOR',1,60,136,0,NULL,NULL),(1183,288,152,18,'JOGADOR',2,56,150,47,5,NULL),(1184,288,153,59,'JOGADOR',3,55,197,197,NULL,NULL),(1185,288,150,21,'JOGADOR',4,47,160,160,NULL,NULL),(1186,288,NULL,86,'INIMIGO',1,33,85,0,NULL,NULL),(1187,288,NULL,159,'INIMIGO',2,35,115,0,NULL,NULL),(1188,288,NULL,124,'INIMIGO',3,37,131,0,NULL,NULL),(1189,288,NULL,58,'INIMIGO',4,39,130,0,NULL,NULL),(1190,288,NULL,147,'INIMIGO',5,41,128,0,NULL,NULL),(1191,288,NULL,137,'INIMIGO',6,43,126,0,NULL,NULL),(1192,289,151,105,'JOGADOR',1,63,142,94,NULL,NULL),(1193,289,152,18,'JOGADOR',2,59,157,157,NULL,NULL),(1194,289,153,59,'JOGADOR',3,58,207,207,NULL,NULL),(1195,289,150,21,'JOGADOR',4,50,170,170,NULL,NULL),(1196,289,NULL,46,'INIMIGO',1,47,122,0,NULL,NULL),(1197,290,150,21,'JOGADOR',1,52,176,132,NULL,NULL),(1198,290,152,18,'JOGADOR',2,61,162,162,NULL,NULL),(1199,290,153,59,'JOGADOR',3,60,214,214,NULL,NULL),(1200,290,151,105,'JOGADOR',4,65,120,120,NULL,NULL),(1201,290,NULL,150,'INIMIGO',1,48,134,0,NULL,NULL),(1202,290,NULL,164,'INIMIGO',2,48,113,0,NULL,NULL),(1203,291,151,105,'JOGADOR',1,68,152,152,NULL,NULL),(1204,291,152,18,'JOGADOR',2,64,170,170,NULL,NULL),(1205,291,153,59,'JOGADOR',3,63,224,224,NULL,NULL),(1206,291,150,21,'JOGADOR',4,55,180,180,NULL,NULL),(1207,291,NULL,109,'INIMIGO',1,48,115,0,NULL,NULL),(1208,291,NULL,49,'INIMIGO',2,48,122,0,NULL,NULL),(1209,292,151,105,'JOGADOR',1,71,159,159,NULL,NULL),(1210,292,152,18,'JOGADOR',2,67,177,177,NULL,NULL),(1211,292,153,59,'JOGADOR',3,66,234,234,NULL,NULL),(1212,292,150,21,'JOGADOR',4,58,195,195,NULL,NULL),(1213,292,NULL,150,'INIMIGO',1,47,132,0,NULL,NULL),(1214,293,151,105,'JOGADOR',1,73,163,0,NULL,NULL),(1215,293,152,18,'JOGADOR',2,69,182,0,NULL,NULL),(1216,293,153,59,'JOGADOR',3,68,241,163,NULL,NULL),(1217,293,150,21,'JOGADOR',4,60,202,202,NULL,NULL),(1218,293,NULL,156,'INIMIGO',1,40,121,0,NULL,NULL),(1219,293,NULL,18,'INIMIGO',2,42,115,0,NULL,NULL),(1220,293,NULL,24,'INIMIGO',3,44,137,0,NULL,NULL),(1221,293,NULL,167,'INIMIGO',4,46,140,0,NULL,NULL),(1222,293,NULL,21,'INIMIGO',5,48,163,0,NULL,NULL),(1223,293,NULL,96,'INIMIGO',6,50,160,0,NULL,NULL),(1224,294,NULL,19,'JOGADOR',1,5,21,0,NULL,NULL),(1225,294,NULL,119,'INIMIGO',1,4,18,18,NULL,NULL),(1226,295,NULL,19,'JOGADOR',1,5,21,0,NULL,NULL),(1227,295,NULL,92,'INIMIGO',1,3,16,16,NULL,NULL),(1228,296,NULL,19,'JOGADOR',1,5,21,0,NULL,NULL),(1229,296,NULL,30,'JOGADOR',2,5,19,0,NULL,NULL),(1230,296,NULL,59,'INIMIGO',1,3,20,20,NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compra`
--

LOCK TABLES `compra` WRITE;
/*!40000 ALTER TABLE `compra` DISABLE KEYS */;
INSERT INTO `compra` VALUES (14,75,13,1,1500,1500,'2026-11-25 10:53:36'),(15,75,2,1,700,700,'2026-11-25 10:55:44'),(16,75,13,1,1500,1500,'2026-11-25 10:55:51'),(17,75,16,1,4000,4000,'2026-11-25 10:58:28'),(18,75,3,1,1200,1200,'2026-11-25 10:58:32');
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
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `desafio_pokemon`
--

LOCK TABLES `desafio_pokemon` WRITE;
/*!40000 ALTER TABLE `desafio_pokemon` DISABLE KEYS */;
INSERT INTO `desafio_pokemon` VALUES (6,3,97,NULL,23,1,NULL),(7,3,41,NULL,25,2,NULL),(8,3,115,NULL,27,3,NULL),(9,3,99,NULL,29,4,NULL),(10,4,163,NULL,28,1,NULL),(11,4,35,NULL,30,2,NULL),(12,4,79,NULL,32,3,NULL),(13,4,142,NULL,34,4,NULL),(14,4,169,NULL,36,5,NULL),(15,5,86,NULL,33,1,NULL),(16,5,159,NULL,35,2,NULL),(17,5,124,NULL,37,3,NULL),(18,5,58,NULL,39,4,NULL),(19,5,147,NULL,41,5,NULL),(20,5,137,NULL,43,6,NULL),(21,6,156,NULL,40,1,NULL),(22,6,18,NULL,42,2,NULL),(23,6,24,NULL,44,3,NULL),(24,6,167,NULL,46,4,NULL),(25,6,21,NULL,48,5,NULL),(26,6,96,NULL,50,6,NULL),(32,1,146,NULL,12,1,NULL),(33,1,117,NULL,15,2,NULL),(34,2,171,NULL,18,1,NULL),(35,2,127,NULL,20,2,NULL),(36,2,37,NULL,22,3,NULL);
/*!40000 ALTER TABLE `desafio_pokemon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evolucao`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evolucao`
--

LOCK TABLES `evolucao` WRITE;
/*!40000 ALTER TABLE `evolucao` DISABLE KEYS */;
INSERT INTO `evolucao` VALUES (1,NULL,'NIVEL',34,'level-up',82,83),(2,NULL,'NIVEL',17,'level-up',16,17),(3,NULL,'NIVEL',36,'level-up',17,18),(6,NULL,'NIVEL',17,'level-up',19,20),(7,NULL,'NIVEL',36,'level-up',20,21),(8,NULL,'NIVEL',17,'level-up',22,23),(9,NULL,'NIVEL',36,'level-up',23,24),(12,NULL,'NIVEL',20,'level-up',25,26),(13,NULL,'NIVEL',16,'level-up',27,28),(14,NULL,'NIVEL',32,'level-up',28,29),(15,NULL,'NIVEL',20,'level-up',30,31),(16,NULL,'NIVEL',20,'level-up',32,33),(17,NULL,'NIVEL',20,'level-up',34,35),(18,NULL,'NIVEL',20,'level-up',36,37),(19,NULL,'NIVEL',28,'level-up',38,39),(20,NULL,'NIVEL',21,'level-up',40,41),(21,NULL,'NIVEL',32,'level-up',41,42),(24,NULL,'NIVEL',27,'level-up',43,44),(25,NULL,'NIVEL',25,'level-up',45,46),(26,NULL,'NIVEL',40,'level-up',46,47),(29,NULL,'NIVEL',22,'level-up',48,49),(33,NULL,'NIVEL',31,'level-up',50,51),(34,NULL,'NIVEL',25,'level-up',53,54),(35,NULL,'NIVEL',30,'level-up',54,55),(36,NULL,'NIVEL',25,'level-up',56,57),(37,NULL,'NIVEL',36,'level-up',57,58),(38,NULL,'NIVEL',20,'level-up',61,62),(39,NULL,'NIVEL',28,'level-up',62,63),(40,NULL,'NIVEL',22,'level-up',64,65),(41,NULL,'NIVEL',30,'level-up',65,66),(42,NULL,'NIVEL',25,'level-up',67,68),(43,NULL,'NIVEL',25,'level-up',69,70),(46,NULL,'NIVEL',30,'level-up',84,73),(50,NULL,'NIVEL',39,'level-up',85,86),(52,NULL,'NIVEL',34,'level-up',88,89),(59,NULL,'NIVEL',37,'level-up',92,93),(60,NULL,'NIVEL',52,'level-up',94,95),(62,NULL,'NIVEL',45,'level-up',95,96),(63,NULL,'NIVEL',37,'level-up',98,99),(64,NULL,'NIVEL',36,'level-up',100,101),(65,NULL,'NIVEL',30,'level-up',102,103),(69,NULL,'NIVEL',20,'level-up',106,107),(70,NULL,'NIVEL',32,'level-up',108,109),(72,NULL,'NIVEL',41,'level-up',109,110),(73,NULL,'NIVEL',32,'level-up',111,112),(75,NULL,'NIVEL',41,'level-up',112,113),(76,NULL,'NIVEL',35,'level-up',114,115),(77,NULL,'NIVEL',35,'level-up',116,117),(79,NULL,'NIVEL',45,'level-up',117,118),(80,NULL,'NIVEL',34,'level-up',119,120),(81,NULL,'NIVEL',30,'level-up',121,122),(82,NULL,'NIVEL',39,'level-up',123,124),(83,NULL,'NIVEL',36,'level-up',128,129),(84,NULL,'NIVEL',40,'level-up',130,131),(85,NULL,'NIVEL',38,'level-up',132,133),(87,NULL,'NIVEL',45,'level-up',133,134),(88,NULL,'NIVEL',39,'level-up',135,136),(90,NULL,'NIVEL',45,'level-up',136,137),(91,NULL,'NIVEL',42,'level-up',138,139),(92,NULL,'NIVEL',41,'level-up',140,141),(94,NULL,'NIVEL',45,'level-up',141,142),(95,NULL,'NIVEL',38,'level-up',143,144),(97,NULL,'NIVEL',45,'level-up',144,145),(98,NULL,'NIVEL',37,'level-up',146,147),(99,NULL,'NIVEL',48,'level-up',149,150),(100,NULL,'NIVEL',40,'level-up',152,153),(101,NULL,'NIVEL',43,'level-up',155,156),(104,NULL,'NIVEL',44,'level-up',158,159),(106,NULL,'NIVEL',44,'level-up',161,162),(107,NULL,'NIVEL',36,'level-up',165,166),(109,NULL,'NIVEL',45,'level-up',166,167),(110,NULL,'NIVEL',45,'level-up',168,169),(115,NULL,'NIVEL',35,'level-up',90,91),(116,NULL,'NIVEL',35,'level-up',77,79),(117,NULL,'NIVEL',35,'level-up',78,80),(118,NULL,'NIVEL',25,'level-up',69,71),(119,NULL,'NIVEL',30,'level-up',104,105),(127,NULL,'NIVEL',40,'level-up',125,126),(131,NULL,'NIVEL',40,'level-up',171,172);
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
  `classe_dano` varchar(20) DEFAULT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_golpe`),
  UNIQUE KEY `api_id` (`api_id`),
  UNIQUE KEY `nome` (`nome`),
  KEY `fk_golpe_tipo` (`id_tipo`),
  CONSTRAINT `fk_golpe_tipo` FOREIGN KEY (`id_tipo`) REFERENCES `tipo` (`id_tipo`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `golpe`
--

LOCK TABLES `golpe` WRITE;
/*!40000 ALTER TABLE `golpe` DISABLE KEYS */;
INSERT INTO `golpe` VALUES (1,34,'body-slam',1,'DANO',65,100,15,0,'PHYSICAL','Causa dano e tem 25% de chance de paralisar o oponente.'),(2,351,'shock-wave',3,'DANO',65,100,20,0,'SPECIAL','Golpe especial do tipo Elétrico que causa dano. Efeito de tipo: 25% de chance de paralisar o oponente.'),(3,424,'fire-fang',2,'DANO',65,100,15,0,'PHYSICAL','Causa dano e tem 25% de chance de causar queimadura.'),(4,352,'water-pulse',4,'DANO',65,100,20,0,'SPECIAL','Golpe especial do tipo Água que causa dano. Efeito de tipo: 25% de chance de congelar o oponente.'),(5,72,'mega-drain',5,'DANO',65,100,15,0,'SPECIAL','Causa dano e recupera HP equivalente a 50% do dano causado. Efeito de tipo: 25% de chance de adormecer o oponente.'),(6,409,'drain-punch',6,'DANO',65,100,10,0,'PHYSICAL','Causa dano e recupera HP equivalente a 50% do dano causado.'),(7,389,'sucker-punch',9,'DANO',65,100,5,1,'PHYSICAL','Golpe físico do tipo Sombrio com prioridade de execução 1.'),(8,418,'bullet-punch',7,'DANO',65,100,30,1,'PHYSICAL','Golpe físico do tipo Aço com prioridade de execução 1.'),(9,425,'shadow-sneak',13,'DANO',65,100,30,1,'PHYSICAL','Golpe físico do tipo Fantasma com prioridade de execução 1.'),(10,450,'bug-bite',14,'DANO',65,100,20,0,'PHYSICAL','Golpe físico do tipo Inseto que causa dano. Efeito de tipo: 25% de chance de envenenar o oponente.'),(11,414,'earth-power',17,'DANO',65,100,10,0,'SPECIAL','Golpe especial do tipo Terra que causa dano.'),(12,317,'rock-tomb',16,'DANO',65,100,15,0,'PHYSICAL','Golpe físico do tipo Pedra que causa dano.'),(13,337,'dragon-claw',10,'DANO',65,100,15,0,'PHYSICAL','Golpe físico do tipo Dragão que causa dano. Efeito de tipo: 25% de chance de queimar o oponente.'),(14,605,'dazzling-gleam',18,'DANO',65,100,10,0,'SPECIAL','Golpe especial do tipo Fada que causa dano.'),(15,512,'acrobatics',15,'DANO',65,100,15,0,'PHYSICAL','Golpe físico do tipo Voador que causa dano.'),(16,94,'psychic',8,'DANO',65,100,10,0,'SPECIAL','Golpe especial do tipo Psíquico que causa dano. Efeito de tipo: 25% de chance de adormecer o oponente.'),(17,188,'sludge-bomb',12,'DANO',65,100,10,0,'SPECIAL','Causa dano e tem 25% de chance de envenenar o oponente.'),(18,58,'ice-beam',11,'DANO',65,100,10,0,'SPECIAL','Causa dano e tem 25% de chance de congelar o oponente.'),(28,14,'Dança das Espadas',1,'STATUS',NULL,100,20,0,'status','Raises the user’s Attack by two stages.'),(29,417,'Maquinação Maliciosa',9,'STATUS',NULL,100,20,0,'status','Raises the user’s Special Attack by two stages.'),(30,86,'Onda Trovão',3,'STATUS',NULL,100,20,0,'status','Paralyzes the target.'),(31,92,'Tóxico',12,'STATUS',NULL,100,10,0,'status','Badly poisons the target.  Never misses when used by a Poison-type Pokémon.'),(32,347,'Paz Mental',8,'STATUS',NULL,100,20,0,'status','Raises the user’s Special Attack and Special Defense by one stage each.'),(33,339,'Corpulência',6,'STATUS',NULL,100,20,0,'status','Raises the user’s Attack and Defense by one stage each.'),(34,147,'Esporo',5,'STATUS',NULL,100,15,0,'status','Puts the target to sleep.'),(35,261,'Fogo Fátuo',2,'STATUS',NULL,100,15,0,'status','Burns the target.'),(37,496,'round',1,'DANO',65,100,15,0,'SPECIAL','Golpe especial do tipo Normal que causa dano.'),(39,209,'spark',3,'DANO',65,100,20,0,'PHYSICAL','Golpe físico do tipo Elétrico que causa dano. Efeito de tipo: 25% de chance de paralisar o oponente.'),(41,510,'incinerate',2,'DANO',65,100,15,0,'SPECIAL','Golpe especial do tipo Fogo que causa dano. Efeito de tipo: 25% de chance de queimar o oponente.'),(43,453,'aqua-jet',4,'DANO',65,100,20,1,'PHYSICAL','Golpe físico do tipo Água com prioridade de execução 1. Efeito de tipo: 25% de chance de congelar o oponente.'),(45,348,'leaf-blade',5,'DANO',65,100,15,0,'PHYSICAL','Golpe físico do tipo Grama que causa dano. Efeito de tipo: 25% de chance de adormecer o oponente.'),(47,396,'aura-sphere',6,'DANO',65,100,20,0,'SPECIAL','Golpe especial do tipo Lutador que causa dano.'),(49,399,'dark-pulse',9,'DANO',65,100,15,0,'SPECIAL','Golpe especial do tipo Sombrio que causa dano.'),(51,430,'flash-cannon',7,'DANO',65,100,10,0,'SPECIAL','Golpe especial do tipo Aço que causa dano.'),(53,247,'shadow-ball',13,'DANO',65,100,15,0,'SPECIAL','Golpe especial do tipo Fantasma que causa dano.'),(55,324,'signal-beam',14,'DANO',65,100,15,0,'SPECIAL','Golpe especial do tipo Inseto que causa dano. Efeito de tipo: 25% de chance de envenenar o oponente.'),(57,523,'bulldoze',17,'DANO',65,100,20,0,'PHYSICAL','Golpe físico do tipo Terra que causa dano.'),(59,408,'power-gem',16,'DANO',65,100,20,0,'SPECIAL','Golpe especial do tipo Pedra que causa dano.'),(61,225,'dragon-breath',10,'DANO',65,100,20,0,'SPECIAL','Causa dano e tem 25% de chance de paralisar o oponente. Efeito de tipo: 25% de chance de queimar o oponente.'),(63,583,'play-rough',18,'DANO',65,100,10,0,'PHYSICAL','Golpe físico do tipo Fada que causa dano.'),(65,403,'air-slash',15,'DANO',65,100,15,0,'SPECIAL','Golpe especial do tipo Voador que causa dano.'),(67,428,'zen-headbutt',8,'DANO',65,100,15,0,'PHYSICAL','Golpe físico do tipo Psíquico que causa dano. Efeito de tipo: 25% de chance de adormecer o oponente.'),(69,398,'poison-jab',12,'DANO',65,100,20,0,'PHYSICAL','Causa dano e tem 25% de chance de envenenar o oponente.'),(71,420,'ice-shard',11,'DANO',65,100,30,1,'PHYSICAL','Golpe físico do tipo Gelo com prioridade de execução 1. Efeito de tipo: 25% de chance de congelar o oponente.');
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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `golpe_efeito`
--

LOCK TABLES `golpe_efeito` WRITE;
/*!40000 ALTER TABLE `golpe_efeito` DISABLE KEYS */;
INSERT INTO `golpe_efeito` VALUES (1,28,'ALTERAR_ATRIBUTO','USUARIO',NULL,'ATAQUE',2,NULL,100),(2,29,'ALTERAR_ATRIBUTO','USUARIO',NULL,'ATAQUE_ESPECIAL',2,NULL,100),(3,32,'ALTERAR_ATRIBUTO','USUARIO',NULL,'ATAQUE_ESPECIAL',1,NULL,100),(4,32,'ALTERAR_ATRIBUTO','USUARIO',NULL,'DEFESA_ESPECIAL',1,NULL,100),(5,33,'ALTERAR_ATRIBUTO','USUARIO',NULL,'ATAQUE',1,NULL,100),(6,33,'ALTERAR_ATRIBUTO','USUARIO',NULL,'DEFESA',1,NULL,100),(7,30,'APLICAR_STATUS','OPONENTE',5,NULL,NULL,NULL,100),(8,31,'APLICAR_STATUS','OPONENTE',1,NULL,NULL,NULL,100),(9,34,'APLICAR_STATUS','OPONENTE',4,NULL,NULL,NULL,100),(10,35,'APLICAR_STATUS','OPONENTE',2,NULL,NULL,NULL,100),(16,1,'APLICAR_STATUS','OPONENTE',5,NULL,NULL,NULL,25),(17,3,'APLICAR_STATUS','OPONENTE',2,NULL,NULL,NULL,25),(18,5,'DRENAR_DANO','USUARIO',NULL,NULL,NULL,50,100),(19,6,'DRENAR_DANO','USUARIO',NULL,NULL,NULL,50,100),(22,17,'APLICAR_STATUS','OPONENTE',1,NULL,NULL,NULL,25),(23,18,'APLICAR_STATUS','OPONENTE',3,NULL,NULL,NULL,25),(24,61,'APLICAR_STATUS','OPONENTE',5,NULL,NULL,NULL,25),(25,69,'APLICAR_STATUS','OPONENTE',1,NULL,NULL,NULL,25),(26,10,'APLICAR_STATUS','OPONENTE',1,NULL,NULL,NULL,25),(27,55,'APLICAR_STATUS','OPONENTE',1,NULL,NULL,NULL,25),(28,13,'APLICAR_STATUS','OPONENTE',2,NULL,NULL,NULL,25),(29,61,'APLICAR_STATUS','OPONENTE',2,NULL,NULL,NULL,25),(30,2,'APLICAR_STATUS','OPONENTE',5,NULL,NULL,NULL,25),(31,39,'APLICAR_STATUS','OPONENTE',5,NULL,NULL,NULL,25),(32,41,'APLICAR_STATUS','OPONENTE',2,NULL,NULL,NULL,25),(33,5,'APLICAR_STATUS','OPONENTE',4,NULL,NULL,NULL,25),(34,45,'APLICAR_STATUS','OPONENTE',4,NULL,NULL,NULL,25),(35,71,'APLICAR_STATUS','OPONENTE',3,NULL,NULL,NULL,25),(36,16,'APLICAR_STATUS','OPONENTE',4,NULL,NULL,NULL,25),(37,67,'APLICAR_STATUS','OPONENTE',4,NULL,NULL,NULL,25),(38,4,'APLICAR_STATUS','OPONENTE',3,NULL,NULL,NULL,25),(39,43,'APLICAR_STATUS','OPONENTE',3,NULL,NULL,NULL,25);
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
INSERT INTO `inventario` VALUES (75,2,0),(75,3,1),(75,13,0),(75,16,1);
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
  CONSTRAINT `chk_item_tipo_efeito` CHECK (`tipo_efeito` in ('ABSOLUTO','PERCENTUAL','STATUS','EVOLUCAO')),
  CONSTRAINT `chk_item_categoria` CHECK (`categoria` in ('HP','HP_STATUS','STATUS','REVIVE','EVOLUCAO'))
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (1,'Potion','HP',300,20,'Recupera 20 HP.','ABSOLUTO'),(2,'Super Potion','HP',700,50,'Recupera 50 HP.','ABSOLUTO'),(3,'Hyper Potion','HP',1200,200,'Recupera 200 HP.','ABSOLUTO'),(4,'Max Potion','HP',2500,100,'Recupera 100% do HP.','PERCENTUAL'),(5,'Full Restore','HP_STATUS',3000,100,'Recupera 100% do HP e cura todas as condições de status.','PERCENTUAL'),(6,'Antidote','STATUS',100,NULL,'Cura envenenamento.','STATUS'),(7,'Burn Heal','STATUS',100,NULL,'Cura queimadura.','STATUS'),(8,'Ice Heal','STATUS',100,NULL,'Cura congelamento.','STATUS'),(9,'Awakening','STATUS',100,NULL,'Cura sono.','STATUS'),(10,'Paralyze Heal','STATUS',100,NULL,'Cura paralisia.','STATUS'),(11,'Full Heal','STATUS',300,NULL,'Cura todas as condições de status.','STATUS'),(12,'Revive','REVIVE',2000,50,'Revive um Pokémon desmaiado com 50% do HP máximo.','PERCENTUAL'),(13,'Moon Stone','EVOLUCAO',1500,NULL,'Permite evoluir um Pokémon que possua uma evolução cadastrada, independentemente do nível.','EVOLUCAO'),(16,'Max Revive','REVIVE',4000,100,'Revive um Pokémon desmaiado com 100% do HP máximo.','PERCENTUAL');
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
-- Table structure for table `mapa_conexao`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mapa_conexao` (
  `id_mapa_conexao` int(11) NOT NULL AUTO_INCREMENT,
  `id_mapa_no_origem` int(11) NOT NULL,
  `id_mapa_no_destino` int(11) NOT NULL,
  PRIMARY KEY (`id_mapa_conexao`),
  UNIQUE KEY `uq_mapa_conexao` (`id_mapa_no_origem`,`id_mapa_no_destino`),
  KEY `idx_mapa_conexao_destino` (`id_mapa_no_destino`),
  CONSTRAINT `fk_mapa_conexao_destino` FOREIGN KEY (`id_mapa_no_destino`) REFERENCES `mapa_no` (`id_mapa_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_mapa_conexao_origem` FOREIGN KEY (`id_mapa_no_origem`) REFERENCES `mapa_no` (`id_mapa_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chk_mapa_conexao_direcao` CHECK (`id_mapa_no_origem` <> `id_mapa_no_destino`)
) ENGINE=InnoDB AUTO_INCREMENT=2125 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mapa_conexao`
--

LOCK TABLES `mapa_conexao` WRITE;
/*!40000 ALTER TABLE `mapa_conexao` DISABLE KEYS */;
INSERT INTO `mapa_conexao` VALUES (2045,1537,1540),(2046,1537,1541),(2047,1538,1541),(2048,1538,1542),(2049,1539,1542),(2050,1539,1543),(2051,1540,1544),(2052,1541,1544),(2053,1541,1545),(2054,1542,1545),(2055,1542,1546),(2056,1543,1546),(2057,1544,1547),(2058,1545,1547),(2059,1545,1548),(2060,1546,1548),(2061,1547,1549),(2062,1548,1550),(2063,1549,1551),(2064,1550,1551);
/*!40000 ALTER TABLE `mapa_conexao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mapa_no`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mapa_no` (
  `id_mapa_no` int(11) NOT NULL AUTO_INCREMENT,
  `id_perfil` int(11) NOT NULL,
  `tipo_local` varchar(25) NOT NULL,
  `id_npc_tipo` int(11) DEFAULT NULL,
  `id_npc_mapa` int(11) DEFAULT NULL,
  `posicao_x` tinyint(3) unsigned NOT NULL,
  `posicao_y` tinyint(3) unsigned NOT NULL,
  `etapa` tinyint(3) unsigned NOT NULL,
  `ordem_no` tinyint(3) unsigned NOT NULL,
  `status` varchar(15) NOT NULL DEFAULT 'BLOQUEADO',
  `criado_em` datetime NOT NULL DEFAULT current_timestamp(),
  `concluido_em` datetime DEFAULT NULL,
  PRIMARY KEY (`id_mapa_no`),
  UNIQUE KEY `uq_mapa_no_etapa` (`id_perfil`,`etapa`,`ordem_no`),
  UNIQUE KEY `uq_mapa_no_posicao` (`id_perfil`,`posicao_x`,`posicao_y`),
  UNIQUE KEY `uq_mapa_no_npc_mapa` (`id_npc_mapa`),
  KEY `idx_mapa_no_npc_tipo` (`id_npc_tipo`),
  CONSTRAINT `fk_mapa_no_npc_mapa` FOREIGN KEY (`id_npc_mapa`) REFERENCES `npc_mapa` (`id_npc_mapa`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_mapa_no_npc_tipo` FOREIGN KEY (`id_npc_tipo`) REFERENCES `npc_tipo` (`id_npc_tipo`) ON UPDATE CASCADE,
  CONSTRAINT `fk_mapa_no_perfil` FOREIGN KEY (`id_perfil`) REFERENCES `perfil` (`id_perfil`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chk_mapa_no_tipo` CHECK (`tipo_local` in ('TREINADOR','SELVAGEM','POKEBOLA','CENTRO_POKEMON','POKEMART','DESAFIO')),
  CONSTRAINT `chk_mapa_no_status` CHECK (`status` in ('BLOQUEADO','DISPONIVEL','CONCLUIDO','IGNORADO')),
  CONSTRAINT `chk_mapa_no_coordenadas` CHECK (`posicao_x` <= 100 and `posicao_y` <= 100),
  CONSTRAINT `chk_mapa_no_treinador` CHECK (`tipo_local` = 'TREINADOR' and `id_npc_tipo` is not null and `id_npc_mapa` is not null or `tipo_local` <> 'TREINADOR' and `id_npc_tipo` is null and `id_npc_mapa` is null),
  CONSTRAINT `chk_mapa_no_etapa` CHECK (`etapa` between 1 and 6)
) ENGINE=InnoDB AUTO_INCREMENT=1597 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mapa_no`
--

LOCK TABLES `mapa_no` WRITE;
/*!40000 ALTER TABLE `mapa_no` DISABLE KEYS */;
INSERT INTO `mapa_no` VALUES (1537,75,'POKEBOLA',NULL,NULL,14,79,1,1,'IGNORADO','2026-11-25 11:00:59',NULL),(1538,75,'SELVAGEM',NULL,NULL,50,79,1,2,'CONCLUIDO','2026-11-25 11:00:59','2026-11-25 11:02:59'),(1539,75,'TREINADOR',4,511,86,79,1,3,'IGNORADO','2026-11-25 11:00:59',NULL),(1540,75,'TREINADOR',3,512,10,61,2,1,'BLOQUEADO','2026-11-25 11:00:59',NULL),(1541,75,'SELVAGEM',NULL,NULL,36,61,2,2,'IGNORADO','2026-11-25 11:00:59',NULL),(1542,75,'TREINADOR',1,513,64,61,2,3,'CONCLUIDO','2026-11-25 11:00:59','2026-11-25 11:03:08'),(1543,75,'POKEBOLA',NULL,NULL,90,61,2,4,'BLOQUEADO','2026-11-25 11:00:59',NULL),(1544,75,'SELVAGEM',NULL,NULL,25,43,3,1,'BLOQUEADO','2026-11-25 11:00:59',NULL),(1545,75,'POKEBOLA',NULL,NULL,50,43,3,2,'IGNORADO','2026-11-25 11:00:59',NULL),(1546,75,'TREINADOR',6,514,75,43,3,3,'CONCLUIDO','2026-11-25 11:00:59','2026-11-25 11:03:24'),(1547,75,'TREINADOR',5,515,36,30,4,1,'BLOQUEADO','2026-11-25 11:00:59',NULL),(1548,75,'SELVAGEM',NULL,NULL,64,30,4,2,'CONCLUIDO','2026-11-25 11:00:59','2026-11-25 11:03:26'),(1549,75,'POKEMART',NULL,NULL,36,17,5,1,'BLOQUEADO','2026-11-25 11:00:59',NULL),(1550,75,'CENTRO_POKEMON',NULL,NULL,64,17,5,2,'CONCLUIDO','2026-11-25 11:00:59','2026-11-25 11:03:29'),(1551,75,'DESAFIO',NULL,NULL,50,7,6,1,'DISPONIVEL','2026-11-25 11:00:59',NULL);
/*!40000 ALTER TABLE `mapa_no` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `npc_mapa`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `npc_mapa` (
  `id_npc_mapa` int(11) NOT NULL AUTO_INCREMENT,
  `id_perfil` int(11) NOT NULL,
  `id_npc_tipo` int(11) NOT NULL,
  `posicao_x` smallint(5) unsigned NOT NULL,
  `posicao_y` smallint(5) unsigned NOT NULL,
  `ordem` smallint(5) unsigned NOT NULL,
  `derrotado` tinyint(1) NOT NULL DEFAULT 0,
  `criado_em` datetime NOT NULL DEFAULT current_timestamp(),
  `derrotado_em` datetime DEFAULT NULL,
  PRIMARY KEY (`id_npc_mapa`),
  UNIQUE KEY `uq_npc_mapa_coordenada` (`id_perfil`,`posicao_x`,`posicao_y`),
  UNIQUE KEY `uq_npc_mapa_ordem` (`id_perfil`,`ordem`),
  KEY `idx_npc_mapa_tipo` (`id_npc_tipo`),
  CONSTRAINT `fk_npc_mapa_perfil` FOREIGN KEY (`id_perfil`) REFERENCES `perfil` (`id_perfil`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_npc_mapa_tipo` FOREIGN KEY (`id_npc_tipo`) REFERENCES `npc_tipo` (`id_npc_tipo`) ON UPDATE CASCADE,
  CONSTRAINT `chk_npc_mapa_derrotado` CHECK (`derrotado` in (0,1))
) ENGINE=InnoDB AUTO_INCREMENT=531 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `npc_mapa`
--

LOCK TABLES `npc_mapa` WRITE;
/*!40000 ALTER TABLE `npc_mapa` DISABLE KEYS */;
INSERT INTO `npc_mapa` VALUES (511,75,4,860,790,1,0,'2026-11-25 11:00:59',NULL),(512,75,3,100,610,2,0,'2026-11-25 11:00:59',NULL),(513,75,1,640,610,3,1,'2026-11-25 11:00:59','2026-11-25 11:03:06'),(514,75,6,750,430,4,1,'2026-11-25 11:00:59','2026-11-25 11:03:22'),(515,75,5,360,300,5,0,'2026-11-25 11:00:59',NULL);
/*!40000 ALTER TABLE `npc_mapa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `npc_tipo`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `npc_tipo` (
  `id_npc_tipo` int(11) NOT NULL AUTO_INCREMENT,
  `id_tipo` int(11) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_npc_tipo`),
  UNIQUE KEY `uq_npc_tipo_id_tipo` (`id_tipo`),
  CONSTRAINT `fk_npc_tipo_tipo` FOREIGN KEY (`id_tipo`) REFERENCES `tipo` (`id_tipo`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `npc_tipo`
--

LOCK TABLES `npc_tipo` WRITE;
/*!40000 ALTER TABLE `npc_tipo` DISABLE KEYS */;
INSERT INTO `npc_tipo` VALUES (1,14,'Treinador especializado em Pokemon do tipo Inseto.'),(2,6,'Treinador especializado em Pokemon do tipo Lutador.'),(3,17,'Treinador especializado em Pokemon do tipo Terra.'),(4,1,'Treinador especializado em Pokemon do tipo Normal.'),(5,16,'Treinador especializado em Pokemon do tipo Rocha.'),(6,8,'Treinador especializado em Pokemon do tipo Psiquico.');
/*!40000 ALTER TABLE `npc_tipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `npc_tipo_pokemon`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `npc_tipo_pokemon` (
  `id_npc_tipo_pokemon` int(11) NOT NULL AUTO_INCREMENT,
  `id_npc_tipo` int(11) NOT NULL,
  `posicao` tinyint(3) unsigned NOT NULL,
  `id_pokemon_0_1` int(11) NOT NULL,
  `id_pokemon_2_3` int(11) NOT NULL,
  `id_pokemon_4_6` int(11) NOT NULL,
  PRIMARY KEY (`id_npc_tipo_pokemon`),
  UNIQUE KEY `uq_npc_tipo_posicao` (`id_npc_tipo`,`posicao`),
  KEY `idx_npc_pokemon_0_1` (`id_pokemon_0_1`),
  KEY `idx_npc_pokemon_2_3` (`id_pokemon_2_3`),
  KEY `idx_npc_pokemon_4_6` (`id_pokemon_4_6`),
  CONSTRAINT `fk_npc_tipo_pokemon_0_1` FOREIGN KEY (`id_pokemon_0_1`) REFERENCES `pokemon_especie` (`id_pokemon_especie`) ON UPDATE CASCADE,
  CONSTRAINT `fk_npc_tipo_pokemon_2_3` FOREIGN KEY (`id_pokemon_2_3`) REFERENCES `pokemon_especie` (`id_pokemon_especie`) ON UPDATE CASCADE,
  CONSTRAINT `fk_npc_tipo_pokemon_4_6` FOREIGN KEY (`id_pokemon_4_6`) REFERENCES `pokemon_especie` (`id_pokemon_especie`) ON UPDATE CASCADE,
  CONSTRAINT `fk_npc_tipo_pokemon_tipo` FOREIGN KEY (`id_npc_tipo`) REFERENCES `npc_tipo` (`id_npc_tipo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chk_npc_tipo_pokemon_posicao` CHECK (`posicao` between 1 and 3)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `npc_tipo_pokemon`
--

LOCK TABLES `npc_tipo_pokemon` WRITE;
/*!40000 ALTER TABLE `npc_tipo_pokemon` DISABLE KEYS */;
INSERT INTO `npc_tipo_pokemon` VALUES (1,3,1,151,151,151),(2,3,2,74,75,76),(3,3,3,50,51,51),(4,6,1,108,109,110),(5,6,2,48,49,49),(6,6,3,38,39,39),(7,4,1,27,28,29),(8,4,2,25,26,26),(9,4,3,119,120,120),(10,5,1,82,83,83),(11,5,2,45,46,47),(12,5,3,92,93,93),(13,2,1,53,54,55),(14,2,2,60,60,60),(15,2,3,59,59,59),(16,1,1,128,129,129),(17,1,2,149,150,150),(18,1,3,164,164,164);
/*!40000 ALTER TABLE `npc_tipo_pokemon` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perfil`
--

LOCK TABLES `perfil` WRITE;
/*!40000 ALTER TABLE `perfil` DISABLE KEYS */;
INSERT INTO `perfil` VALUES (75,1,'red',7100,'2026-11-25 10:52:46');
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
) ENGINE=InnoDB AUTO_INCREMENT=386 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perfil_log`
--

LOCK TABLES `perfil_log` WRITE;
/*!40000 ALTER TABLE `perfil_log` DISABLE KEYS */;
INSERT INTO `perfil_log` VALUES (360,75,'CRIACAO','Nova jornada criada após derrota.',NULL,'2026-11-25 10:52:46'),(361,75,'INICIAL_ESCOLHIDO','Pokémon inicial escolhido.','{\"pokemon\":\"tepig\"}','2026-11-25 10:52:47'),(362,75,'ROTA_GERADA',NULL,'{\"id_desafio\":1,\"area\":1}','2026-11-25 10:52:47'),(363,75,'POKEBOLA_OFERTA','Encontro com uma Pokébola do mapa.','{\"id_mapa_no\":1464,\"id_pokemon_especie\":104,\"nivel\":5}','2026-11-25 10:52:52'),(364,75,'POKEBOLA_CAPTURADA','Encontro com uma Pokébola do mapa.','{\"id_mapa_no\":1464,\"id_pokemon_especie\":104,\"nivel\":5}','2026-11-25 10:52:56'),(365,75,'ROTA_GERADA',NULL,'{\"id_desafio\":2,\"area\":2}','2026-11-25 10:55:03'),(366,75,'POKEBOLA_OFERTA','Encontro com uma Pokébola do mapa.','{\"id_mapa_no\":1485,\"id_pokemon_especie\":16,\"nivel\":23}','2026-11-25 10:55:27'),(367,75,'POKEBOLA_CAPTURADA','Encontro com uma Pokébola do mapa.','{\"id_mapa_no\":1485,\"id_pokemon_especie\":16,\"nivel\":23}','2026-11-25 10:55:28'),(368,75,'ROTA_GERADA',NULL,'{\"id_desafio\":3,\"area\":3}','2026-11-25 10:56:21'),(369,75,'POKEBOLA_OFERTA','Encontro com uma Pokébola do mapa.','{\"id_mapa_no\":1492,\"id_pokemon_especie\":59,\"nivel\":28}','2026-11-25 10:56:45'),(370,75,'POKEBOLA_CAPTURADA','Encontro com uma Pokébola do mapa.','{\"id_mapa_no\":1492,\"id_pokemon_especie\":59,\"nivel\":28}','2026-11-25 10:56:47'),(371,75,'ROTA_GERADA',NULL,'{\"id_desafio\":4,\"area\":2}','2026-11-25 10:57:33'),(372,75,'ROTA_GERADA',NULL,'{\"id_desafio\":5,\"area\":3}','2026-11-25 10:59:01'),(373,75,'ROTA_GERADA',NULL,'{\"id_desafio\":6,\"area\":2}','2026-11-25 11:00:59');
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
) ENGINE=InnoDB AUTO_INCREMENT=173 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pokemon_especie`
--

LOCK TABLES `pokemon_especie` WRITE;
/*!40000 ALTER TABLE `pokemon_especie` DISABLE KEYS */;
INSERT INTO `pokemon_especie` VALUES (16,495,'snivy',45,45,55,45,55,63,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/495.png'),(17,496,'servine',60,60,75,60,75,83,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/496.png'),(18,497,'serperior',75,75,95,75,95,113,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/497.png'),(19,498,'tepig',65,63,45,45,45,45,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/498.png'),(20,499,'pignite',90,93,55,70,55,55,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/499.png'),(21,500,'emboar',110,123,65,100,65,65,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/500.png'),(22,501,'oshawott',55,55,45,63,45,45,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/501.png'),(23,502,'dewott',75,75,60,83,60,60,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/502.png'),(24,503,'samurott',95,100,85,108,70,70,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/503.png'),(25,504,'patrat',45,55,39,35,39,42,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/504.png'),(26,505,'watchog',60,85,69,60,69,77,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/505.png'),(27,506,'lillipup',45,60,45,25,45,55,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/506.png'),(28,507,'herdier',65,80,65,35,65,60,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/507.png'),(29,508,'stoutland',85,110,90,45,90,80,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/508.png'),(30,509,'purrloin',41,50,37,50,37,66,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/509.png'),(31,510,'liepard',64,88,50,88,50,106,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/510.png'),(32,511,'pansage',50,53,48,53,48,64,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/511.png'),(33,512,'simisage',75,98,63,98,63,101,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/512.png'),(34,513,'pansear',50,53,48,53,48,64,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/513.png'),(35,514,'simisear',75,98,63,98,63,101,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/514.png'),(36,515,'panpour',50,53,48,53,48,64,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/515.png'),(37,516,'simipour',75,98,63,98,63,101,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/516.png'),(38,517,'munna',76,25,45,67,55,24,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/517.png'),(39,518,'musharna',116,55,85,107,95,29,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/518.png'),(40,519,'pidove',50,55,50,36,30,43,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/519.png'),(41,520,'tranquill',62,77,62,50,42,65,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/520.png'),(42,521,'unfezant',80,115,80,65,55,93,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/521.png'),(43,522,'blitzle',45,60,32,50,32,76,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/522.png'),(44,523,'zebstrika',75,100,63,80,63,116,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/523.png'),(45,524,'roggenrola',55,75,85,25,25,15,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/524.png'),(46,525,'boldore',70,105,105,50,40,20,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/525.png'),(47,526,'gigalith',85,135,130,60,80,25,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/526.png'),(48,527,'woobat',65,45,43,55,43,72,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/527.png'),(49,528,'swoobat',67,57,55,77,55,114,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/528.png'),(50,529,'drilbur',60,85,40,30,45,68,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/529.png'),(51,530,'excadrill',110,135,60,50,65,88,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/530.png'),(52,531,'audino',103,60,86,60,86,50,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/531.png'),(53,532,'timburr',75,80,55,25,35,35,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/532.png'),(54,533,'gurdurr',85,105,85,40,50,40,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/533.png'),(55,534,'conkeldurr',105,140,95,55,65,45,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/534.png'),(56,535,'tympole',50,50,40,50,40,64,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/535.png'),(57,536,'palpitoad',75,65,55,65,55,69,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/536.png'),(58,537,'seismitoad',105,95,75,85,75,74,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/537.png'),(59,538,'throh',120,100,85,30,85,45,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/538.png'),(60,539,'sawk',75,125,75,30,75,85,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/539.png'),(61,540,'sewaddle',45,53,70,40,60,42,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/540.png'),(62,541,'swadloon',55,63,90,50,80,42,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/541.png'),(63,542,'leavanny',75,103,80,70,80,92,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/542.png'),(64,543,'venipede',30,45,59,30,39,57,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/543.png'),(65,544,'whirlipede',40,55,99,40,79,47,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/544.png'),(66,545,'scolipede',60,100,89,55,69,112,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/545.png'),(67,546,'cottonee',40,27,60,37,50,66,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/546.png'),(68,547,'whimsicott',60,67,85,77,75,116,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/547.png'),(69,548,'petilil',45,35,50,70,50,30,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/548.png'),(70,549,'lilligant',70,60,75,110,75,90,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/549.png'),(71,10237,'lilligant-hisui',70,105,75,50,75,105,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10237.png'),(72,550,'basculin-red-striped',70,92,65,80,55,98,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/550.png'),(73,902,'basculegion-male',120,112,65,80,75,78,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/902.png'),(74,551,'sandile',50,72,35,35,35,65,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/551.png'),(75,552,'krokorok',60,82,45,45,45,74,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/552.png'),(76,553,'krookodile',95,117,80,65,70,92,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/553.png'),(77,554,'darumaka',70,90,45,15,45,50,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/554.png'),(78,10176,'darumaka-galar',70,90,45,15,45,50,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10176.png'),(79,555,'darmanitan-standard',105,140,55,30,55,95,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/555.png'),(80,10177,'darmanitan-galar-standard',105,140,55,30,55,95,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10177.png'),(81,556,'maractus',75,86,67,106,67,60,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/556.png'),(82,557,'dwebble',50,65,85,35,35,55,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/557.png'),(83,558,'crustle',70,105,125,65,75,45,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/558.png'),(84,10247,'basculin-white-striped',70,92,65,80,55,98,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10247.png'),(85,559,'scraggy',50,75,70,35,70,48,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/559.png'),(86,560,'scrafty',65,90,115,45,115,58,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/560.png'),(87,561,'sigilyph',72,58,80,103,80,97,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/561.png'),(88,562,'yamask',38,30,85,55,65,30,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/562.png'),(89,563,'cofagrigus',58,50,145,95,105,30,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/563.png'),(90,10179,'yamask-galar',38,55,85,30,65,30,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10179.png'),(91,867,'runerigus',58,95,145,50,105,30,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/867.png'),(92,564,'tirtouga',54,78,103,53,45,22,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/564.png'),(93,565,'carracosta',74,108,133,83,65,32,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/565.png'),(94,624,'pawniard',45,85,70,40,40,60,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/624.png'),(95,625,'bisharp',65,125,100,60,70,70,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/625.png'),(96,983,'kingambit',100,135,120,60,85,50,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/983.png'),(97,587,'emolga',55,75,60,75,60,103,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/587.png'),(98,566,'archen',55,112,45,74,45,70,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/566.png'),(99,567,'archeops',75,140,65,112,65,110,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/567.png'),(100,568,'trubbish',50,50,62,40,62,65,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/568.png'),(101,569,'garbodor',80,95,82,60,82,75,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/569.png'),(102,570,'zorua',40,65,40,80,40,65,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/570.png'),(103,571,'zoroark',60,105,60,120,60,105,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/571.png'),(104,10238,'zorua-hisui',35,60,40,85,40,70,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10238.png'),(105,10239,'zoroark-hisui',55,100,60,125,60,110,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10239.png'),(106,572,'minccino',55,50,40,40,40,75,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/572.png'),(107,573,'cinccino',75,95,60,65,60,115,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/573.png'),(108,574,'gothita',45,30,50,55,65,45,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/574.png'),(109,575,'gothorita',60,45,70,75,85,55,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/575.png'),(110,576,'gothitelle',70,55,95,95,110,65,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/576.png'),(111,577,'solosis',45,30,40,105,50,20,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/577.png'),(112,578,'duosion',65,40,50,125,60,30,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/578.png'),(113,579,'reuniclus',110,65,75,125,85,30,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/579.png'),(114,580,'ducklett',62,44,50,44,50,55,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/580.png'),(115,581,'swanna',75,87,63,87,63,98,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/581.png'),(116,582,'vanillite',36,50,50,65,60,44,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/582.png'),(117,583,'vanillish',51,65,65,80,75,59,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/583.png'),(118,584,'vanilluxe',71,95,85,110,95,79,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/584.png'),(119,585,'deerling',60,60,50,40,50,75,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/585.png'),(120,586,'sawsbuck',80,100,70,60,70,95,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/586.png'),(121,588,'karrablast',50,75,45,40,45,60,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/588.png'),(122,589,'escavalier',70,135,105,60,105,20,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/589.png'),(123,590,'foongus',69,55,45,55,55,15,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/590.png'),(124,591,'amoonguss',114,85,70,85,80,30,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/591.png'),(125,592,'frillish-male',55,40,50,65,85,40,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/592.png'),(126,593,'jellicent-male',100,60,70,85,105,60,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/593.png'),(127,594,'alomomola',165,75,80,40,45,65,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/594.png'),(128,595,'joltik',50,47,50,57,50,65,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/595.png'),(129,596,'galvantula',70,77,60,97,60,108,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/596.png'),(130,597,'ferroseed',44,50,91,24,86,10,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/597.png'),(131,598,'ferrothorn',74,94,131,54,116,20,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/598.png'),(132,599,'klink',40,55,70,45,60,30,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/599.png'),(133,600,'klang',60,80,95,70,85,50,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/600.png'),(134,601,'klinklang',60,100,115,70,85,90,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/601.png'),(135,602,'tynamo',35,55,40,45,40,60,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/602.png'),(136,603,'eelektrik',65,85,70,75,70,40,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/603.png'),(137,604,'eelektross',85,115,80,105,80,50,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/604.png'),(138,605,'elgyem',55,55,55,85,55,30,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/605.png'),(139,606,'beheeyem',75,75,75,125,95,40,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/606.png'),(140,607,'litwick',50,30,55,65,55,20,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/607.png'),(141,608,'lampent',60,40,60,95,60,55,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/608.png'),(142,609,'chandelure',60,55,90,145,90,80,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/609.png'),(143,610,'axew',46,87,60,30,40,57,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/610.png'),(144,611,'fraxure',66,117,70,40,50,67,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/611.png'),(145,612,'haxorus',76,147,90,60,70,97,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/612.png'),(146,613,'cubchoo',55,70,40,60,40,40,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/613.png'),(147,614,'beartic',95,130,80,70,80,50,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/614.png'),(148,615,'cryogonal',80,50,50,95,135,105,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/615.png'),(149,616,'shelmet',50,40,85,40,65,25,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/616.png'),(150,617,'accelgor',80,70,40,100,60,145,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/617.png'),(151,618,'stunfisk',109,66,84,81,99,32,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/618.png'),(152,619,'mienfoo',45,85,50,55,50,65,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/619.png'),(153,620,'mienshao',65,125,60,95,60,105,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/620.png'),(154,621,'druddigon',77,120,90,60,90,48,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/621.png'),(155,622,'golett',59,74,50,35,50,35,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/622.png'),(156,623,'golurk',89,124,80,55,80,55,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/623.png'),(157,626,'bouffalant',95,110,95,40,95,55,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/626.png'),(158,627,'rufflet',70,83,50,37,50,60,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/627.png'),(159,628,'braviary',100,123,75,57,75,80,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/628.png'),(160,10240,'braviary-hisui',110,83,70,112,70,65,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10240.png'),(161,629,'vullaby',70,55,75,45,65,60,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/629.png'),(162,630,'mandibuzz',110,65,105,55,95,80,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/630.png'),(163,631,'heatmor',85,97,66,105,66,65,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/631.png'),(164,632,'durant',58,109,112,48,48,109,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/632.png'),(165,633,'deino',52,65,50,45,50,38,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/633.png'),(166,634,'zweilous',72,85,70,65,70,58,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/634.png'),(167,635,'hydreigon',92,105,90,125,90,98,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/635.png'),(168,636,'larvesta',55,85,55,50,55,60,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/636.png'),(169,637,'volcarona',85,60,65,135,105,100,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/637.png'),(170,10180,'stunfisk-galar',109,81,99,66,84,32,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10180.png'),(171,-592,'frillish-female',55,40,50,65,85,40,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/female/592.png'),(172,-593,'jellicent-female',100,60,70,85,105,60,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/female/593.png');
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
  CONSTRAINT `chk_pokemon_slot` CHECK (`slot` between 1 and 2)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pokemon_especie_golpe`
--

LOCK TABLES `pokemon_especie_golpe` WRITE;
/*!40000 ALTER TABLE `pokemon_especie_golpe` DISABLE KEYS */;
INSERT INTO `pokemon_especie_golpe` VALUES (16,45,1),(17,45,1),(18,45,1),(19,3,1),(20,3,1),(20,6,2),(21,3,1),(21,6,2),(22,4,1),(23,4,1),(24,4,1),(25,1,1),(26,1,1),(27,1,1),(28,1,1),(29,1,1),(30,7,1),(31,7,1),(32,45,1),(33,45,1),(34,3,1),(35,3,1),(36,43,1),(37,43,1),(38,16,1),(39,16,1),(40,1,1),(40,15,2),(41,1,1),(41,15,2),(42,1,1),(42,15,2),(43,39,1),(44,39,1),(45,12,1),(46,12,1),(47,12,1),(48,16,1),(48,65,2),(49,16,1),(49,65,2),(50,57,1),(51,57,1),(51,8,2),(52,1,1),(53,6,1),(54,6,1),(55,6,1),(56,43,1),(57,43,1),(57,57,2),(58,43,1),(58,57,2),(59,6,1),(60,6,1),(61,10,1),(61,45,2),(62,10,1),(62,45,2),(63,10,1),(63,45,2),(64,10,1),(64,69,2),(65,10,1),(65,69,2),(66,10,1),(66,69,2),(67,5,1),(67,14,2),(68,5,1),(68,14,2),(69,5,1),(70,5,1),(71,45,1),(71,6,2),(72,43,1),(73,43,1),(73,9,2),(74,57,1),(74,7,2),(75,57,1),(75,7,2),(76,57,1),(76,7,2),(77,3,1),(78,71,1),(79,3,1),(80,71,1),(81,5,1),(82,10,1),(82,12,2),(83,10,1),(83,12,2),(84,43,1),(85,7,1),(85,6,2),(86,7,1),(86,6,2),(87,16,1),(87,65,2),(88,53,1),(89,53,1),(90,57,1),(90,9,2),(91,57,1),(91,9,2),(92,43,1),(92,12,2),(93,43,1),(93,12,2),(94,7,1),(94,8,2),(95,7,1),(95,8,2),(96,7,1),(96,8,2),(97,39,1),(97,15,2),(98,12,1),(98,15,2),(99,12,1),(99,15,2),(100,69,1),(101,69,1),(102,49,1),(103,49,1),(104,37,1),(104,53,2),(105,37,1),(105,53,2),(106,1,1),(107,1,1),(108,16,1),(109,16,1),(110,16,1),(111,16,1),(112,16,1),(113,16,1),(114,43,1),(114,15,2),(115,43,1),(115,15,2),(116,18,1),(117,18,1),(118,18,1),(119,1,1),(119,45,2),(120,1,1),(120,45,2),(121,10,1),(122,10,1),(122,8,2),(123,45,1),(123,69,2),(124,45,1),(124,69,2),(125,4,1),(125,53,2),(126,4,1),(126,53,2),(127,43,1),(128,55,1),(128,2,2),(129,55,1),(129,2,2),(130,45,1),(130,8,2),(131,45,1),(131,8,2),(132,8,1),(133,8,1),(134,8,1),(135,39,1),(136,39,1),(137,39,1),(138,16,1),(139,16,1),(140,53,1),(140,41,2),(141,53,1),(141,41,2),(142,53,1),(142,41,2),(143,13,1),(144,13,1),(145,13,1),(146,71,1),(147,71,1),(148,18,1),(149,10,1),(150,55,1),(151,11,1),(151,2,2),(152,6,1),(153,6,1),(154,13,1),(155,57,1),(155,9,2),(156,57,1),(156,9,2),(157,1,1),(158,1,1),(158,15,2),(159,1,1),(159,15,2),(160,16,1),(160,65,2),(161,7,1),(161,15,2),(162,7,1),(162,15,2),(163,41,1),(164,10,1),(164,8,2),(165,7,1),(165,13,2),(166,7,1),(166,13,2),(167,49,1),(167,61,2),(168,10,1),(168,3,2),(169,55,1),(169,41,2),(170,57,1),(170,8,2),(171,4,1),(171,53,2),(172,4,1),(172,53,2);
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
/*!50503 SET character_set_client = utf8mb4 */;
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
INSERT INTO `pokemon_especie_status_opcao` VALUES (16,28,'TEM_FISICO'),(16,34,'TIPO_GRASS'),(17,28,'TEM_FISICO'),(17,34,'TIPO_GRASS'),(18,28,'TEM_FISICO'),(18,34,'TIPO_GRASS'),(19,28,'TEM_FISICO'),(19,35,'TIPO_FIRE_GHOST'),(20,28,'TEM_FISICO'),(20,33,'TIPO_FIGHTING'),(20,35,'TIPO_FIRE_GHOST'),(21,28,'TEM_FISICO'),(21,33,'TIPO_FIGHTING'),(21,35,'TIPO_FIRE_GHOST'),(22,29,'TEM_ESPECIAL'),(23,29,'TEM_ESPECIAL'),(24,29,'TEM_ESPECIAL'),(25,28,'TEM_FISICO'),(26,28,'TEM_FISICO'),(27,28,'TEM_FISICO'),(28,28,'TEM_FISICO'),(29,28,'TEM_FISICO'),(30,28,'TEM_FISICO'),(31,28,'TEM_FISICO'),(32,28,'TEM_FISICO'),(32,34,'TIPO_GRASS'),(33,28,'TEM_FISICO'),(33,34,'TIPO_GRASS'),(34,28,'TEM_FISICO'),(34,35,'TIPO_FIRE_GHOST'),(35,28,'TEM_FISICO'),(35,35,'TIPO_FIRE_GHOST'),(36,28,'TEM_FISICO'),(37,28,'TEM_FISICO'),(38,29,'TEM_ESPECIAL'),(38,32,'TIPO_PSYCHIC'),(39,29,'TEM_ESPECIAL'),(39,32,'TIPO_PSYCHIC'),(40,28,'TEM_FISICO'),(41,28,'TEM_FISICO'),(42,28,'TEM_FISICO'),(43,28,'TEM_FISICO'),(43,30,'TIPO_ELETRICO'),(44,28,'TEM_FISICO'),(44,30,'TIPO_ELETRICO'),(45,28,'TEM_FISICO'),(46,28,'TEM_FISICO'),(47,28,'TEM_FISICO'),(48,29,'TEM_ESPECIAL'),(48,32,'TIPO_PSYCHIC'),(49,29,'TEM_ESPECIAL'),(49,32,'TIPO_PSYCHIC'),(50,28,'TEM_FISICO'),(51,28,'TEM_FISICO'),(52,28,'TEM_FISICO'),(53,28,'TEM_FISICO'),(53,33,'TIPO_FIGHTING'),(54,28,'TEM_FISICO'),(55,28,'TEM_FISICO'),(55,33,'TIPO_FIGHTING'),(56,28,'TEM_FISICO'),(57,28,'TEM_FISICO'),(58,28,'TEM_FISICO'),(59,28,'TEM_FISICO'),(59,33,'TIPO_FIGHTING'),(60,28,'TEM_FISICO'),(60,33,'TIPO_FIGHTING'),(61,28,'TEM_FISICO'),(61,34,'TIPO_GRASS'),(62,28,'TEM_FISICO'),(62,34,'TIPO_GRASS'),(63,28,'TEM_FISICO'),(63,34,'TIPO_GRASS'),(64,28,'TEM_FISICO'),(64,31,'TIPO_POISON'),(65,28,'TEM_FISICO'),(65,31,'TIPO_POISON'),(66,28,'TEM_FISICO'),(66,31,'TIPO_POISON'),(67,29,'TEM_ESPECIAL'),(67,34,'TIPO_GRASS'),(68,29,'TEM_ESPECIAL'),(68,34,'TIPO_GRASS'),(69,29,'TEM_ESPECIAL'),(69,34,'TIPO_GRASS'),(70,29,'TEM_ESPECIAL'),(70,34,'TIPO_GRASS'),(71,28,'TEM_FISICO'),(71,33,'TIPO_FIGHTING'),(71,34,'TIPO_GRASS'),(72,28,'TEM_FISICO'),(73,28,'TEM_FISICO'),(73,35,'TIPO_FIRE_GHOST'),(74,28,'TEM_FISICO'),(75,28,'TEM_FISICO'),(76,28,'TEM_FISICO'),(77,28,'TEM_FISICO'),(77,35,'TIPO_FIRE_GHOST'),(78,28,'TEM_FISICO'),(79,28,'TEM_FISICO'),(79,35,'TIPO_FIRE_GHOST'),(80,28,'TEM_FISICO'),(81,29,'TEM_ESPECIAL'),(81,34,'TIPO_GRASS'),(82,28,'TEM_FISICO'),(83,28,'TEM_FISICO'),(84,28,'TEM_FISICO'),(85,28,'TEM_FISICO'),(85,33,'TIPO_FIGHTING'),(86,28,'TEM_FISICO'),(86,33,'TIPO_FIGHTING'),(87,29,'TEM_ESPECIAL'),(87,32,'TIPO_PSYCHIC'),(88,29,'TEM_ESPECIAL'),(88,35,'TIPO_FIRE_GHOST'),(89,29,'TEM_ESPECIAL'),(89,35,'TIPO_FIRE_GHOST'),(90,28,'TEM_FISICO'),(90,35,'TIPO_FIRE_GHOST'),(91,28,'TEM_FISICO'),(91,35,'TIPO_FIRE_GHOST'),(92,28,'TEM_FISICO'),(93,28,'TEM_FISICO'),(94,28,'TEM_FISICO'),(95,28,'TEM_FISICO'),(96,28,'TEM_FISICO'),(97,28,'TEM_FISICO'),(97,30,'TIPO_ELETRICO'),(98,28,'TEM_FISICO'),(99,28,'TEM_FISICO'),(100,28,'TEM_FISICO'),(100,31,'TIPO_POISON'),(101,28,'TEM_FISICO'),(101,31,'TIPO_POISON'),(102,29,'TEM_ESPECIAL'),(103,29,'TEM_ESPECIAL'),(104,29,'TEM_ESPECIAL'),(104,35,'TIPO_FIRE_GHOST'),(105,29,'TEM_ESPECIAL'),(105,35,'TIPO_FIRE_GHOST'),(106,28,'TEM_FISICO'),(107,28,'TEM_FISICO'),(108,29,'TEM_ESPECIAL'),(108,32,'TIPO_PSYCHIC'),(109,29,'TEM_ESPECIAL'),(109,32,'TIPO_PSYCHIC'),(110,29,'TEM_ESPECIAL'),(110,32,'TIPO_PSYCHIC'),(111,29,'TEM_ESPECIAL'),(111,32,'TIPO_PSYCHIC'),(112,29,'TEM_ESPECIAL'),(112,32,'TIPO_PSYCHIC'),(113,29,'TEM_ESPECIAL'),(113,32,'TIPO_PSYCHIC'),(114,28,'TEM_FISICO'),(115,28,'TEM_FISICO'),(116,29,'TEM_ESPECIAL'),(117,29,'TEM_ESPECIAL'),(118,29,'TEM_ESPECIAL'),(119,28,'TEM_FISICO'),(119,34,'TIPO_GRASS'),(120,28,'TEM_FISICO'),(121,28,'TEM_FISICO'),(122,28,'TEM_FISICO'),(123,28,'TEM_FISICO'),(123,31,'TIPO_POISON'),(123,34,'TIPO_GRASS'),(124,28,'TEM_FISICO'),(124,31,'TIPO_POISON'),(124,34,'TIPO_GRASS'),(125,29,'TEM_ESPECIAL'),(126,29,'TEM_ESPECIAL'),(127,28,'TEM_FISICO'),(128,29,'TEM_ESPECIAL'),(128,30,'TIPO_ELETRICO'),(129,29,'TEM_ESPECIAL'),(129,30,'TIPO_ELETRICO'),(130,28,'TEM_FISICO'),(130,34,'TIPO_GRASS'),(131,28,'TEM_FISICO'),(131,34,'TIPO_GRASS'),(132,28,'TEM_FISICO'),(133,28,'TEM_FISICO'),(134,28,'TEM_FISICO'),(135,28,'TEM_FISICO'),(135,30,'TIPO_ELETRICO'),(136,28,'TEM_FISICO'),(136,30,'TIPO_ELETRICO'),(137,28,'TEM_FISICO'),(137,30,'TIPO_ELETRICO'),(138,29,'TEM_ESPECIAL'),(138,32,'TIPO_PSYCHIC'),(139,29,'TEM_ESPECIAL'),(139,32,'TIPO_PSYCHIC'),(140,29,'TEM_ESPECIAL'),(140,35,'TIPO_FIRE_GHOST'),(141,29,'TEM_ESPECIAL'),(141,35,'TIPO_FIRE_GHOST'),(142,29,'TEM_ESPECIAL'),(142,35,'TIPO_FIRE_GHOST'),(143,28,'TEM_FISICO'),(144,28,'TEM_FISICO'),(145,28,'TEM_FISICO'),(146,28,'TEM_FISICO'),(147,28,'TEM_FISICO'),(148,29,'TEM_ESPECIAL'),(149,28,'TEM_FISICO'),(150,29,'TEM_ESPECIAL'),(151,29,'TEM_ESPECIAL'),(151,30,'TIPO_ELETRICO'),(152,28,'TEM_FISICO'),(152,33,'TIPO_FIGHTING'),(153,28,'TEM_FISICO'),(153,33,'TIPO_FIGHTING'),(154,28,'TEM_FISICO'),(155,28,'TEM_FISICO'),(155,35,'TIPO_FIRE_GHOST'),(156,28,'TEM_FISICO'),(156,35,'TIPO_FIRE_GHOST'),(157,28,'TEM_FISICO'),(158,28,'TEM_FISICO'),(159,28,'TEM_FISICO'),(160,29,'TEM_ESPECIAL'),(160,32,'TIPO_PSYCHIC'),(161,28,'TEM_FISICO'),(162,28,'TEM_FISICO'),(163,29,'TEM_ESPECIAL'),(163,35,'TIPO_FIRE_GHOST'),(164,28,'TEM_FISICO'),(165,28,'TEM_FISICO'),(166,28,'TEM_FISICO'),(167,29,'TEM_ESPECIAL'),(168,28,'TEM_FISICO'),(168,35,'TIPO_FIRE_GHOST'),(169,29,'TEM_ESPECIAL'),(169,35,'TIPO_FIRE_GHOST'),(170,28,'TEM_FISICO'),(171,29,'TEM_ESPECIAL'),(172,29,'TEM_ESPECIAL');
/*!40000 ALTER TABLE `pokemon_especie_status_opcao` ENABLE KEYS */;
UNLOCK TABLES;

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
INSERT INTO `pokemon_especie_tipo` VALUES (16,5),(17,5),(18,5),(19,2),(20,2),(20,6),(21,2),(21,6),(22,4),(23,4),(24,4),(25,1),(26,1),(27,1),(28,1),(29,1),(30,9),(31,9),(32,5),(33,5),(34,2),(35,2),(36,4),(37,4),(38,8),(39,8),(40,1),(40,15),(41,1),(41,15),(42,1),(42,15),(43,3),(44,3),(45,16),(46,16),(47,16),(48,8),(48,15),(49,8),(49,15),(50,17),(51,7),(51,17),(52,1),(53,6),(54,6),(55,6),(56,4),(57,4),(57,17),(58,4),(58,17),(59,6),(60,6),(61,5),(61,14),(62,5),(62,14),(63,5),(63,14),(64,12),(64,14),(65,12),(65,14),(66,12),(66,14),(67,5),(67,18),(68,5),(68,18),(69,5),(70,5),(71,5),(71,6),(72,4),(73,4),(73,13),(74,9),(74,17),(75,9),(75,17),(76,9),(76,17),(77,2),(78,11),(79,2),(80,11),(81,5),(82,14),(82,16),(83,14),(83,16),(84,4),(85,6),(85,9),(86,6),(86,9),(87,8),(87,15),(88,13),(89,13),(90,13),(90,17),(91,13),(91,17),(92,4),(92,16),(93,4),(93,16),(94,7),(94,9),(95,7),(95,9),(96,7),(96,9),(97,3),(97,15),(98,15),(98,16),(99,15),(99,16),(100,12),(101,12),(102,9),(103,9),(104,1),(104,13),(105,1),(105,13),(106,1),(107,1),(108,8),(109,8),(110,8),(111,8),(112,8),(113,8),(114,4),(114,15),(115,4),(115,15),(116,11),(117,11),(118,11),(119,1),(119,5),(120,1),(120,5),(121,14),(122,7),(122,14),(123,5),(123,12),(124,5),(124,12),(125,4),(125,13),(126,4),(126,13),(127,4),(128,3),(128,14),(129,3),(129,14),(130,5),(130,7),(131,5),(131,7),(132,7),(133,7),(134,7),(135,3),(136,3),(137,3),(138,8),(139,8),(140,2),(140,13),(141,2),(141,13),(142,2),(142,13),(143,10),(144,10),(145,10),(146,11),(147,11),(148,11),(149,14),(150,14),(151,3),(151,17),(152,6),(153,6),(154,10),(155,13),(155,17),(156,13),(156,17),(157,1),(158,1),(158,15),(159,1),(159,15),(160,8),(160,15),(161,9),(161,15),(162,9),(162,15),(163,2),(164,7),(164,14),(165,9),(165,10),(166,9),(166,10),(167,9),(167,10),(168,2),(168,14),(169,2),(169,14),(170,7),(170,17),(171,4),(171,13),(172,4),(172,13);
/*!40000 ALTER TABLE `pokemon_especie_tipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pokemon_pc`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pokemon_pc` (
  `id_pokemon_pc` int(11) NOT NULL AUTO_INCREMENT,
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
  `id_golpe_status` int(11) DEFAULT NULL,
  `armazenado_em` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_pokemon_pc`),
  KEY `ix_pc_perfil` (`id_perfil`),
  KEY `fk_pc_especie` (`id_pokemon_especie`),
  KEY `fk_pc_item` (`id_held_item`),
  KEY `fk_pc_golpe` (`id_golpe_status`),
  CONSTRAINT `fk_pc_especie` FOREIGN KEY (`id_pokemon_especie`) REFERENCES `pokemon_especie` (`id_pokemon_especie`) ON UPDATE CASCADE,
  CONSTRAINT `fk_pc_golpe` FOREIGN KEY (`id_golpe_status`) REFERENCES `golpe` (`id_golpe`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_pc_item` FOREIGN KEY (`id_held_item`) REFERENCES `held_item` (`id_held_item`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_pc_perfil` FOREIGN KEY (`id_perfil`) REFERENCES `perfil` (`id_perfil`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chk_pc_nivel` CHECK (`nivel` between 1 and 100),
  CONSTRAINT `chk_pc_hp` CHECK (`hp_max` >= 0 and `hp_atual` between 0 and `hp_max`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pokemon_pc`
--

LOCK TABLES `pokemon_pc` WRITE;
/*!40000 ALTER TABLE `pokemon_pc` DISABLE KEYS */;
/*!40000 ALTER TABLE `pokemon_pc` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=158 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pokemon_time`
--

LOCK TABLES `pokemon_time` WRITE;
/*!40000 ALTER TABLE `pokemon_time` DISABLE KEYS */;
INSERT INTO `pokemon_time` VALUES (150,75,21,NULL,NULL,63,211,211,159,86,131,86,86,'normal',4,28),(151,75,105,NULL,NULL,76,169,169,157,96,195,96,172,'normal',1,29),(152,75,18,NULL,NULL,72,190,190,113,141,113,141,167,'normal',2,28),(153,75,59,NULL,NULL,71,251,251,147,125,47,125,68,'normal',3,28);
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
INSERT INTO `progresso_desafio` VALUES (75,1,1,'2026-11-25 10:53:59'),(75,2,1,'2026-11-25 10:56:18'),(75,3,1,'2026-11-25 10:57:32'),(75,4,1,'2026-11-25 10:58:51'),(75,5,1,'2026-11-25 11:00:57'),(75,6,1,'2026-11-25 11:03:49');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'artur','$2y$10$OvRXma7ZZdNq9DgWkpESb.FoMk.fb/4KyZW37jjPzFP6fW//qZNRe','2026-11-18 08:24:15');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_historico_batalhas`
--

SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_historico_batalhas` AS SELECT 
 1 AS `id_batalha`,
 1 AS `id_perfil`,
 1 AS `nome_perfil`,
 1 AS `id_desafio`,
 1 AS `adversario`,
 1 AS `resultado`,
 1 AS `dinheiro_ganho`,
 1 AS `iniciada_em`,
 1 AS `finalizada_em`,
 1 AS `duracao_segundos`,
 1 AS `qtd_pokemon_jogador`,
 1 AS `qtd_pokemon_inimigo`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_loja_itens`
--

SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_loja_itens` AS SELECT 
 1 AS `id_item`,
 1 AS `nome`,
 1 AS `categoria`,
 1 AS `preco`,
 1 AS `valor_efeito`,
 1 AS `descricao`,
 1 AS `tipo_efeito`,
 1 AS `status_curados`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_time_pokemon`
--

SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_time_pokemon` AS SELECT 
 1 AS `id_perfil`,
 1 AS `id_pokemon_time`,
 1 AS `posicao`,
 1 AS `id_pokemon_especie`,
 1 AS `nome_especie`,
 1 AS `nome_exibicao`,
 1 AS `imagem_url`,
 1 AS `nivel`,
 1 AS `hp_atual`,
 1 AS `hp_max`,
 1 AS `hp_percentual`,
 1 AS `status`,
 1 AS `item_equipado`,
 1 AS `golpe_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'monstrobouso'
--

--
-- Final view structure for view `vw_historico_batalhas`
--

/*!50001 DROP VIEW IF EXISTS `vw_historico_batalhas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_historico_batalhas` AS select `b`.`id_batalha` AS `id_batalha`,`b`.`id_perfil` AS `id_perfil`,coalesce(`p`.`nome`,`b`.`nome_jornada`) AS `nome_perfil`,`b`.`id_desafio` AS `id_desafio`,coalesce(`d`.`nome`,'Treinador aleatório') AS `adversario`,`b`.`resultado` AS `resultado`,`b`.`dinheiro_ganho` AS `dinheiro_ganho`,`b`.`iniciada_em` AS `iniciada_em`,`b`.`finalizada_em` AS `finalizada_em`,case when `b`.`finalizada_em` is null then NULL else timestampdiff(SECOND,`b`.`iniciada_em`,`b`.`finalizada_em`) end AS `duracao_segundos`,(select count(0) from `batalha_pokemon` `bp` where `bp`.`id_batalha` = `b`.`id_batalha` and `bp`.`lado` = 'JOGADOR') AS `qtd_pokemon_jogador`,(select count(0) from `batalha_pokemon` `bp` where `bp`.`id_batalha` = `b`.`id_batalha` and `bp`.`lado` = 'INIMIGO') AS `qtd_pokemon_inimigo` from ((`batalha_log` `b` left join `perfil` `p` on(`p`.`id_perfil` = `b`.`id_perfil`)) left join `desafio` `d` on(`d`.`id_desafio` = `b`.`id_desafio`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_loja_itens`
--

/*!50001 DROP VIEW IF EXISTS `vw_loja_itens`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_loja_itens` AS select `i`.`id_item` AS `id_item`,`i`.`nome` AS `nome`,`i`.`categoria` AS `categoria`,`i`.`preco` AS `preco`,`i`.`valor_efeito` AS `valor_efeito`,`i`.`descricao` AS `descricao`,`i`.`tipo_efeito` AS `tipo_efeito`,group_concat(distinct `sp`.`nome` order by `sp`.`nome` ASC separator ', ') AS `status_curados` from ((`item` `i` left join `item_status_cura` `isc` on(`isc`.`id_item` = `i`.`id_item`)) left join `status_pokemon` `sp` on(`sp`.`id_status` = `isc`.`id_status`)) group by `i`.`id_item`,`i`.`nome`,`i`.`categoria`,`i`.`preco`,`i`.`valor_efeito`,`i`.`descricao`,`i`.`tipo_efeito` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_time_pokemon`
--

/*!50001 DROP VIEW IF EXISTS `vw_time_pokemon`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_time_pokemon` AS select `pt`.`id_perfil` AS `id_perfil`,`pt`.`id_pokemon_time` AS `id_pokemon_time`,`pt`.`posicao` AS `posicao`,`pt`.`id_pokemon_especie` AS `id_pokemon_especie`,`pe`.`nome` AS `nome_especie`,coalesce(nullif(trim(`pt`.`apelido`),''),`pe`.`nome`) AS `nome_exibicao`,`pe`.`imagem_url` AS `imagem_url`,`pt`.`nivel` AS `nivel`,`pt`.`hp_atual` AS `hp_atual`,`pt`.`hp_max` AS `hp_max`,case when `pt`.`hp_max` > 0 then round(`pt`.`hp_atual` * 100.0 / `pt`.`hp_max`,0) else 0 end AS `hp_percentual`,`pt`.`status` AS `status`,`hi`.`nome` AS `item_equipado`,`gs`.`nome` AS `golpe_status` from (((`pokemon_time` `pt` join `pokemon_especie` `pe` on(`pe`.`id_pokemon_especie` = `pt`.`id_pokemon_especie`)) left join `held_item` `hi` on(`hi`.`id_held_item` = `pt`.`id_held_item`)) left join `golpe` `gs` on(`gs`.`id_golpe` = `pt`.`id_golpe_status`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-25 11:11:46
