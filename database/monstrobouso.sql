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
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batalha_log`
--

LOCK TABLES `batalha_log` WRITE;
/*!40000 ALTER TABLE `batalha_log` DISABLE KEYS */;
INSERT INTO `batalha_log` VALUES (61,33,NULL,NULL,NULL,'VITORIA',100,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":427,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Dwebble!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Snivy!\"},{\"tipo\":\"golpe\",\"texto\":\"Snivy usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Dwebble perdeu 56 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Dwebble desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Snivy subiu para o Nv. 51!\"},{\"tipo\":\"evolucao\",\"texto\":\"Snivy evoluiu para Servine!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 100!\"}]}','2026-11-18 15:53:48','2026-11-18 11:53:50'),(62,33,NULL,NULL,NULL,'VITORIA',300,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":142,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Normal quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Lillipup!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Servine!\"},{\"tipo\":\"golpe\",\"texto\":\"Servine usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Lillipup perdeu 60 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Lillipup desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Patrat!\"},{\"tipo\":\"golpe\",\"texto\":\"Servine usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Patrat perdeu 60 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Patrat desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Servine subiu para o Nv. 53!\"},{\"tipo\":\"evolucao\",\"texto\":\"Servine evoluiu para Serperior!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 300!\"}]}','2026-11-18 15:53:56','2026-11-18 11:54:00'),(63,33,NULL,NULL,NULL,'VITORIA',100,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":435,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Patrat!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Serperior!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Patrat perdeu 72 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Patrat desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 54!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 100!\"}]}','2026-11-18 15:54:04','2026-11-18 11:54:08'),(78,33,NULL,NULL,NULL,'VITORIA',100,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":438,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Timburr!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Serperior!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Timburr perdeu 42 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Timburr desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 55!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 100!\"}]}','2026-11-23 18:43:24','2026-11-23 14:43:26'),(79,33,NULL,NULL,1,'VITORIA',0,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":1,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 1 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Axew!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Serperior!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Axew perdeu 33 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Axew desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Druddigon!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Druddigon perdeu 48 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Druddigon desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 57!\"}]}','2026-11-23 18:43:32','2026-11-23 14:43:36'),(80,33,NULL,NULL,NULL,'VITORIA',300,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":170,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Agua quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Alomomola!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Serperior!\"},{\"tipo\":\"golpe\",\"texto\":\"Alomomola usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 3 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Alomomola perdeu 96 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Alomomola desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Jellicent Male!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Jellicent Male perdeu 70 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Jellicent Male desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Simipour!\"},{\"tipo\":\"golpe\",\"texto\":\"Simipour usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 4 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Simipour perdeu 60 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Simipour desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 59!\"},{\"tipo\":\"nivel\",\"texto\":\"Zorua subiu para o Nv. 59!\"},{\"tipo\":\"evolucao\",\"texto\":\"Zorua evoluiu para Zoroark!\"},{\"tipo\":\"nivel\",\"texto\":\"Venipede subiu para o Nv. 59!\"},{\"tipo\":\"evolucao\",\"texto\":\"Venipede evoluiu para Whirlipede!\"},{\"tipo\":\"evolucao\",\"texto\":\"Whirlipede evoluiu para Scolipede!\"},{\"tipo\":\"nivel\",\"texto\":\"Sewaddle subiu para o Nv. 59!\"},{\"tipo\":\"evolucao\",\"texto\":\"Sewaddle evoluiu para Swadloon!\"},{\"tipo\":\"evolucao\",\"texto\":\"Swadloon evoluiu para Leavanny!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 300!\"}]}','2026-11-23 18:43:54','2026-11-23 14:44:02'),(81,33,NULL,NULL,2,'VITORIA',0,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":2,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 2 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Gothorita!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Serperior!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Gothorita perdeu 49 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Gothorita desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Swoobat!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Swoobat perdeu 56 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Swoobat desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Musharna!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Musharna perdeu 83 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Musharna desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 61!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 61!\"},{\"tipo\":\"nivel\",\"texto\":\"Scolipede subiu para o Nv. 61!\"},{\"tipo\":\"nivel\",\"texto\":\"Leavanny subiu para o Nv. 61!\"}]}','2026-11-23 18:44:14','2026-11-23 14:44:21'),(82,33,NULL,NULL,NULL,'VITORIA',300,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":175,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Agua quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Alomomola!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Serperior!\"},{\"tipo\":\"golpe\",\"texto\":\"Alomomola usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 4 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Alomomola perdeu 126 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Alomomola desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 63!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 63!\"},{\"tipo\":\"nivel\",\"texto\":\"Scolipede subiu para o Nv. 63!\"},{\"tipo\":\"nivel\",\"texto\":\"Leavanny subiu para o Nv. 63!\"},{\"tipo\":\"nivel\",\"texto\":\"Basculin White Striped subiu para o Nv. 63!\"},{\"tipo\":\"evolucao\",\"texto\":\"Basculin White Striped evoluiu para Basculegion Male!\"},{\"tipo\":\"nivel\",\"texto\":\"Joltik subiu para o Nv. 63!\"},{\"tipo\":\"evolucao\",\"texto\":\"Joltik evoluiu para Galvantula!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 300!\"}]}','2026-11-23 18:45:46','2026-11-23 14:45:48'),(83,33,NULL,NULL,3,'VITORIA',0,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":3,\"turnos\":4,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 3 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Emolga!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Serperior!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Emolga perdeu 58 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Emolga desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Tranquill!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tranquill perdeu 66 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tranquill desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Swanna!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Swanna perdeu 77 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Swanna desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Archeops!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Archeops perdeu 82 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Archeops desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 65!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 65!\"},{\"tipo\":\"nivel\",\"texto\":\"Scolipede subiu para o Nv. 65!\"},{\"tipo\":\"nivel\",\"texto\":\"Leavanny subiu para o Nv. 65!\"},{\"tipo\":\"nivel\",\"texto\":\"Basculegion Male subiu para o Nv. 65!\"},{\"tipo\":\"nivel\",\"texto\":\"Galvantula subiu para o Nv. 65!\"}]}','2026-11-23 18:46:35','2026-11-23 14:46:45'),(84,33,NULL,NULL,NULL,'VITORIA',300,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":180,\"turnos\":12,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Grama quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Leavanny!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Serperior!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Leavanny perdeu 23 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Leavanny usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 8 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Leavanny perdeu 23 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Leavanny usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Leavanny aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Leavanny perdeu 20 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Leavanny usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 17 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Leavanny perdeu 22 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Leavanny usou Bug Bite!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 64 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Leavanny perdeu 7 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Leavanny desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Maractus!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Maractus perdeu 50 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Maractus usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Maractus aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Maractus perdeu 45 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Maractus desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Ferrothorn!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Ferrothorn perdeu 13 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Ferrothorn usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 7 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Serperior aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Ferrothorn usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 8 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Serperior aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Ferrothorn usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Ferrothorn aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Ferrothorn usou Bullet Punch!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 64 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Ferrothorn perdeu 41 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Ferrothorn perdeu 40 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Ferrothorn desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 67!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 67!\"},{\"tipo\":\"nivel\",\"texto\":\"Scolipede subiu para o Nv. 67!\"},{\"tipo\":\"nivel\",\"texto\":\"Yamask Galar subiu para o Nv. 67!\"},{\"tipo\":\"evolucao\",\"texto\":\"Yamask Galar evoluiu para Runerigus!\"},{\"tipo\":\"nivel\",\"texto\":\"Basculegion Male subiu para o Nv. 67!\"},{\"tipo\":\"nivel\",\"texto\":\"Galvantula subiu para o Nv. 67!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 300!\"}]}','2026-11-23 18:48:09','2026-11-23 14:48:49'),(85,33,NULL,NULL,4,'VITORIA',0,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":4,\"turnos\":9,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 4 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Heatmor!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Serperior!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Serperior aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Heatmor usou Incinerate!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 26 HP.\"},{\"tipo\":\"status\",\"texto\":\"Serperior recebeu Queimadura!\"},{\"tipo\":\"status\",\"texto\":\"Serperior perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Serperior aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Heatmor usou Incinerate!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 27 HP.\"},{\"tipo\":\"status\",\"texto\":\"Serperior perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Serperior aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Heatmor usou Incinerate!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 51 HP.\"},{\"tipo\":\"status\",\"texto\":\"Serperior perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Heatmor perdeu 85 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Heatmor desmaiou!\"},{\"tipo\":\"status\",\"texto\":\"Serperior perdeu HP por Queimadura!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Simisear!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Simisear perdeu 85 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Simisear desmaiou!\"},{\"tipo\":\"status\",\"texto\":\"Serperior perdeu HP por Queimadura!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Darmanitan Standard!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Darmanitan Standard perdeu 109 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Darmanitan Standard desmaiou!\"},{\"tipo\":\"status\",\"texto\":\"Serperior perdeu HP por Queimadura!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Chandelure!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Chandelure perdeu 84 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Chandelure desmaiou!\"},{\"tipo\":\"status\",\"texto\":\"Serperior perdeu HP por Queimadura!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Volcarona!\"},{\"tipo\":\"golpe\",\"texto\":\"Serperior usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Volcarona perdeu 103 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Volcarona usou Signal Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 38 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Serperior desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Zoroark!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"dano\",\"texto\":\"Volcarona perdeu 4 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Volcarona desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 69!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 69!\"},{\"tipo\":\"nivel\",\"texto\":\"Scolipede subiu para o Nv. 69!\"},{\"tipo\":\"nivel\",\"texto\":\"Runerigus subiu para o Nv. 69!\"},{\"tipo\":\"nivel\",\"texto\":\"Basculegion Male subiu para o Nv. 69!\"},{\"tipo\":\"nivel\",\"texto\":\"Galvantula subiu para o Nv. 69!\"}]}','2026-11-23 18:50:16','2026-11-23 14:52:36'),(86,33,NULL,NULL,NULL,'VITORIA',300,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":183,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Pedra quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Dwebble!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Throh!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Dwebble perdeu 74 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Dwebble desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Tirtouga!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Tirtouga perdeu 76 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tirtouga desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Throh subiu para o Nv. 71!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 71!\"},{\"tipo\":\"nivel\",\"texto\":\"Runerigus subiu para o Nv. 71!\"},{\"tipo\":\"nivel\",\"texto\":\"Basculegion Male subiu para o Nv. 71!\"},{\"tipo\":\"nivel\",\"texto\":\"Galvantula subiu para o Nv. 71!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 300!\"}]}','2026-11-23 18:55:40','2026-11-23 14:55:44'),(87,33,NULL,NULL,NULL,'VITORIA',300,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":184,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Pedra quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Tirtouga!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Throh!\"},{\"tipo\":\"golpe\",\"texto\":\"Tirtouga usou Aqua Jet!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 17 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Tirtouga perdeu 86 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tirtouga desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Throh subiu para o Nv. 73!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 73!\"},{\"tipo\":\"nivel\",\"texto\":\"Runerigus subiu para o Nv. 73!\"},{\"tipo\":\"nivel\",\"texto\":\"Basculegion Male subiu para o Nv. 73!\"},{\"tipo\":\"nivel\",\"texto\":\"Galvantula subiu para o Nv. 73!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 300!\"}]}','2026-11-23 18:56:14','2026-11-23 14:56:17'),(88,33,NULL,NULL,NULL,'VITORIA',300,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":185,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Agua quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Alomomola!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Throh!\"},{\"tipo\":\"golpe\",\"texto\":\"Alomomola usou Aqua Jet!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 17 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Alomomola perdeu 112 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Alomomola perdeu 74 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Alomomola desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Throh subiu para o Nv. 75!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 75!\"},{\"tipo\":\"nivel\",\"texto\":\"Runerigus subiu para o Nv. 75!\"},{\"tipo\":\"nivel\",\"texto\":\"Basculegion Male subiu para o Nv. 75!\"},{\"tipo\":\"nivel\",\"texto\":\"Galvantula subiu para o Nv. 75!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 300!\"}]}','2026-11-23 18:56:26','2026-11-23 14:56:29'),(89,33,NULL,NULL,5,'VITORIA',0,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":5,\"turnos\":10,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ex-Campeão quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Scrafty!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Throh!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Scrafty perdeu 85 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Scrafty desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Braviary!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Braviary perdeu 115 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Braviary desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Amoonguss!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Amoonguss perdeu 85 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Amoonguss usou Leaf Blade!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 16 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Amoonguss perdeu 46 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Amoonguss desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Seismitoad!\"},{\"tipo\":\"golpe\",\"texto\":\"Seismitoad usou Aqua Jet!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 19 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Seismitoad perdeu 130 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Seismitoad desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Beartic!\"},{\"tipo\":\"golpe\",\"texto\":\"Beartic usou Ice Shard!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 29 HP.\"},{\"tipo\":\"status\",\"texto\":\"Throh recebeu Congelamento!\"},{\"tipo\":\"status\",\"texto\":\"Throh está congelado!\"},{\"tipo\":\"golpe\",\"texto\":\"Beartic usou Ice Shard!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 28 HP.\"},{\"tipo\":\"status\",\"texto\":\"Throh está congelado!\"},{\"tipo\":\"golpe\",\"texto\":\"Beartic usou Ice Shard!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 30 HP.\"},{\"tipo\":\"status\",\"texto\":\"Throh descongelou!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Beartic perdeu 128 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Beartic desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Eelektross!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Eelektross perdeu 122 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Eelektross usou Spark!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 26 HP.\"},{\"tipo\":\"status\",\"texto\":\"Throh recebeu Paralisia!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Eelektross perdeu 4 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Eelektross desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Throh subiu para o Nv. 77!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 77!\"},{\"tipo\":\"nivel\",\"texto\":\"Runerigus subiu para o Nv. 77!\"},{\"tipo\":\"nivel\",\"texto\":\"Basculegion Male subiu para o Nv. 77!\"},{\"tipo\":\"nivel\",\"texto\":\"Galvantula subiu para o Nv. 77!\"}]}','2026-11-23 18:56:53','2026-11-23 14:59:41'),(90,33,NULL,NULL,NULL,'VITORIA',100,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":563,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Ferrothorn!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Zoroark!\"},{\"tipo\":\"golpe\",\"texto\":\"Ferrothorn usou Bullet Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark perdeu 19 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Zoroark aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Ferrothorn usou Bullet Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark perdeu 21 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"dano\",\"texto\":\"Ferrothorn perdeu 91 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Ferrothorn desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 78!\"},{\"tipo\":\"nivel\",\"texto\":\"Runerigus subiu para o Nv. 78!\"},{\"tipo\":\"nivel\",\"texto\":\"Throh subiu para o Nv. 78!\"},{\"tipo\":\"nivel\",\"texto\":\"Basculegion Male subiu para o Nv. 78!\"},{\"tipo\":\"nivel\",\"texto\":\"Galvantula subiu para o Nv. 78!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 100!\"}]}','2026-11-23 19:00:05','2026-11-23 15:00:13'),(91,33,NULL,NULL,NULL,'VITORIA',300,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":189,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Normal quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Herdier!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Zoroark!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"dano\",\"texto\":\"Herdier perdeu 111 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Herdier desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Sawsbuck!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"dano\",\"texto\":\"Sawsbuck perdeu 124 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Sawsbuck desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 80!\"},{\"tipo\":\"nivel\",\"texto\":\"Runerigus subiu para o Nv. 80!\"},{\"tipo\":\"nivel\",\"texto\":\"Litwick subiu para o Nv. 80!\"},{\"tipo\":\"evolucao\",\"texto\":\"Litwick evoluiu para Lampent!\"},{\"tipo\":\"evolucao\",\"texto\":\"Lampent evoluiu para Chandelure!\"},{\"tipo\":\"nivel\",\"texto\":\"Basculegion Male subiu para o Nv. 80!\"},{\"tipo\":\"nivel\",\"texto\":\"Galvantula subiu para o Nv. 80!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 300!\"}]}','2026-11-23 19:00:32','2026-11-23 15:00:36'),(92,33,NULL,NULL,NULL,'VITORIA',100,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":573,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Boldore!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Zoroark!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"dano\",\"texto\":\"Boldore perdeu 125 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Boldore desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 81!\"},{\"tipo\":\"nivel\",\"texto\":\"Runerigus subiu para o Nv. 81!\"},{\"tipo\":\"nivel\",\"texto\":\"Chandelure subiu para o Nv. 81!\"},{\"tipo\":\"nivel\",\"texto\":\"Basculegion Male subiu para o Nv. 81!\"},{\"tipo\":\"nivel\",\"texto\":\"Galvantula subiu para o Nv. 81!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 100!\"}]}','2026-11-23 19:00:44','2026-11-23 15:00:47'),(93,33,NULL,NULL,6,'VITORIA',0,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":6,\"turnos\":11,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Rival quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Scolipede!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Zoroark!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"dano\",\"texto\":\"Scolipede perdeu 98 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Scolipede desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Serperior!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"dano\",\"texto\":\"Serperior perdeu 115 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Serperior desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Samurott!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"dano\",\"texto\":\"Samurott perdeu 137 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Samurott desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Hydreigon!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Hydreigon perdeu 70 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Hydreigon usou Dark Pulse!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark perdeu 20 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Hydreigon perdeu 70 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Hydreigon desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Emboar!\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Emboar perdeu 99 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Emboar usou Drain Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark perdeu 89 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Emboar perdeu 64 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Emboar desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Kingambit!\"},{\"tipo\":\"golpe\",\"texto\":\"Kingambit usou Bullet Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark perdeu 51 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Kingambit perdeu 69 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Kingambit usou Sucker Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark perdeu 27 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Zoroark usou Dark Pulse!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Kingambit perdeu 63 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Kingambit usou Sucker Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Zoroark perdeu 1 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Zoroark desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Runerigus!\"},{\"tipo\":\"golpe\",\"texto\":\"Kingambit usou Sucker Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Runerigus perdeu 46 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Runerigus usou Bulldoze!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Kingambit perdeu 28 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Kingambit desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o desafio!\"},{\"tipo\":\"nivel\",\"texto\":\"Zoroark subiu para o Nv. 83!\"},{\"tipo\":\"nivel\",\"texto\":\"Runerigus subiu para o Nv. 83!\"},{\"tipo\":\"nivel\",\"texto\":\"Chandelure subiu para o Nv. 83!\"},{\"tipo\":\"nivel\",\"texto\":\"Basculegion Male subiu para o Nv. 83!\"},{\"tipo\":\"nivel\",\"texto\":\"Galvantula subiu para o Nv. 83!\"},{\"tipo\":\"nivel\",\"texto\":\"Serperior subiu para o Nv. 71!\"}]}','2026-11-23 19:01:11','2026-11-23 15:01:53'),(94,NULL,36,'leaf',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":593,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Timburr!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Timburr perdeu 13 HP.\"},{\"tipo\":\"status\",\"texto\":\"Timburr recebeu Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Timburr usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 5 HP.\"},{\"tipo\":\"status\",\"texto\":\"Timburr perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Timburr perdeu 1 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Timburr desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 6!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-23 21:34:59','2026-11-23 17:35:12'),(95,NULL,36,'leaf',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":597,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Throh!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 10 HP.\"},{\"tipo\":\"status\",\"texto\":\"Throh recebeu Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Throh aumentou!\"},{\"tipo\":\"status\",\"texto\":\"Throh perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 9 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Throh desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 7!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-23 21:35:25','2026-11-23 17:35:34'),(96,NULL,36,'leaf',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":200,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Grama quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Sewaddle!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Sewaddle perdeu 17 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Sewaddle desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Ferroseed!\"},{\"tipo\":\"golpe\",\"texto\":\"Ferroseed usou Bullet Punch!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 2 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Ferroseed perdeu 17 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Ferroseed desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 9!\"},{\"tipo\":\"nivel\",\"texto\":\"Stunfisk subiu para o Nv. 9!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-23 21:39:25','2026-11-23 17:39:33'),(97,NULL,36,'leaf',1,'DERROTA',0,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":1,\"turnos\":5,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 1 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Axew!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Stunfisk!\"},{\"tipo\":\"golpe\",\"texto\":\"Axew usou Dragon Claw!\"},{\"tipo\":\"dano\",\"texto\":\"Stunfisk perdeu 14 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Stunfisk usou Maquinação Maliciosa!\"},{\"tipo\":\"status\",\"texto\":\"Ataque Especial de Stunfisk aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Axew usou Dragon Claw!\"},{\"tipo\":\"dano\",\"texto\":\"Stunfisk perdeu 15 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Stunfisk usou Earth Power!\"},{\"tipo\":\"dano\",\"texto\":\"Axew perdeu 24 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Axew usou Dragon Claw!\"},{\"tipo\":\"dano\",\"texto\":\"Stunfisk perdeu 9 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Stunfisk desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Axew usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Axew aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Tepig aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Axew usou Dragon Claw!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 30 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-23 21:39:51','2026-11-23 17:41:35'),(98,NULL,37,'leaf',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":205,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Lutador quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Timburr!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Emolga!\"},{\"tipo\":\"golpe\",\"texto\":\"Emolga usou Acrobatics!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Timburr perdeu 15 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Timburr desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Sawk!\"},{\"tipo\":\"golpe\",\"texto\":\"Emolga usou Acrobatics!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Sawk perdeu 15 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Sawk desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Emolga subiu para o Nv. 7!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 7!\"},{\"tipo\":\"nivel\",\"texto\":\"Sandile subiu para o Nv. 7!\"},{\"tipo\":\"nivel\",\"texto\":\"Cubchoo subiu para o Nv. 7!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-23 21:55:01','2026-11-23 17:55:57'),(99,NULL,37,'leaf',1,'DERROTA',0,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":1,\"turnos\":6,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 1 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Druddigon!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Emolga!\"},{\"tipo\":\"golpe\",\"texto\":\"Emolga usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Emolga aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Druddigon usou Dragon Claw!\"},{\"tipo\":\"dano\",\"texto\":\"Emolga perdeu 24 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Emolga desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Druddigon usou Dragon Claw!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 26 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Sandile!\"},{\"tipo\":\"golpe\",\"texto\":\"Sandile usou Sucker Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Druddigon perdeu 6 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Druddigon usou Dragon Claw!\"},{\"tipo\":\"dano\",\"texto\":\"Sandile perdeu 24 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Sandile desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Vai! Cubchoo!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Druddigon perdeu 11 HP.\"},{\"tipo\":\"status\",\"texto\":\"Druddigon recebeu Congelamento!\"},{\"tipo\":\"status\",\"texto\":\"Druddigon está congelado!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Druddigon perdeu 10 HP.\"},{\"tipo\":\"status\",\"texto\":\"Druddigon está congelado!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Druddigon perdeu 11 HP.\"},{\"tipo\":\"status\",\"texto\":\"Druddigon descongelou!\"},{\"tipo\":\"golpe\",\"texto\":\"Druddigon usou Dragon Claw!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 24 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Cubchoo desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-23 21:56:17','2026-11-23 17:58:45'),(100,NULL,38,'leaf',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":623,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Panpour!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Snivy!\"},{\"tipo\":\"golpe\",\"texto\":\"Panpour usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Snivy perdeu 1 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Snivy usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Panpour perdeu 14 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Panpour desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Snivy subiu para o Nv. 6!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-23 22:00:20','2026-11-23 18:00:24'),(101,NULL,38,'leaf',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":627,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Roggenrola!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Snivy!\"},{\"tipo\":\"golpe\",\"texto\":\"Snivy usou Leaf Blade!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Roggenrola perdeu 16 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Roggenrola desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Snivy subiu para o Nv. 7!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-23 22:00:31','2026-11-23 18:00:35'),(102,NULL,38,'leaf',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":209,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Pedra quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Tirtouga!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Snivy!\"},{\"tipo\":\"golpe\",\"texto\":\"Tirtouga usou Aqua Jet!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Snivy perdeu 2 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Snivy usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Tirtouga perdeu 18 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tirtouga desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Snivy subiu para o Nv. 9!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-23 22:01:24','2026-11-23 18:01:29'),(103,NULL,38,'leaf',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":633,\"turnos\":4,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Deerling!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Snivy!\"},{\"tipo\":\"golpe\",\"texto\":\"Snivy usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Snivy aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Deerling usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Deerling aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Snivy usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Snivy aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Deerling usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Snivy perdeu 6 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Snivy usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Deerling perdeu 16 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Deerling usou Leaf Blade!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Snivy perdeu 13 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Snivy usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Deerling perdeu 7 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Deerling desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Snivy subiu para o Nv. 10!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-23 22:01:36','2026-11-23 18:01:50'),(104,NULL,38,'leaf',1,'DERROTA',0,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":1,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 1 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Druddigon!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Snivy!\"},{\"tipo\":\"golpe\",\"texto\":\"Snivy usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Druddigon perdeu 4 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Druddigon usou Dragon Claw!\"},{\"tipo\":\"dano\",\"texto\":\"Snivy perdeu 23 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Snivy usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Druddigon perdeu 3 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Druddigon usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Druddigon aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Snivy usou Leaf Blade!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Druddigon perdeu 3 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Druddigon usou Dragon Claw!\"},{\"tipo\":\"dano\",\"texto\":\"Snivy perdeu 6 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Snivy desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-23 22:01:56','2026-11-23 18:02:08'),(105,NULL,39,'leaf',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":211,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Lutador quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Timburr!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Timburr perdeu 14 HP.\"},{\"tipo\":\"status\",\"texto\":\"Timburr recebeu Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Timburr usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Timburr aumentou!\"},{\"tipo\":\"status\",\"texto\":\"Timburr perdeu HP por Queimadura!\"},{\"tipo\":\"desmaio\",\"texto\":\"Timburr desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Sawk!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Sawk perdeu 11 HP.\"},{\"tipo\":\"status\",\"texto\":\"Sawk recebeu Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Sawk usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 5 HP.\"},{\"tipo\":\"status\",\"texto\":\"Sawk perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Sawk perdeu 3 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Sawk desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 7!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-23 22:05:44','2026-11-23 18:05:58'),(106,NULL,39,'leaf',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":213,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Inseto quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Durant!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Durant usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Durant aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Durant perdeu 18 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Durant desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 9!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-23 22:06:07','2026-11-23 18:06:11'),(107,NULL,39,'leaf',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":646,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Ferroseed!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Ferroseed perdeu 21 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Ferroseed desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 10!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-23 22:08:12','2026-11-23 18:08:16'),(108,NULL,39,'leaf',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":215,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Grama quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Ferroseed!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Ferroseed perdeu 23 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Ferroseed desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 12!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-23 22:08:21','2026-11-23 18:08:25'),(109,NULL,39,'leaf',1,'DERROTA',0,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":1,\"turnos\":2,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 1 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Druddigon!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Druddigon usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Druddigon aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Druddigon perdeu 5 HP.\"},{\"tipo\":\"status\",\"texto\":\"Druddigon recebeu Queimadura!\"},{\"tipo\":\"status\",\"texto\":\"Druddigon perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Druddigon usou Dragon Claw!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 37 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"status\",\"texto\":\"Druddigon perdeu HP por Queimadura!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-23 22:08:36','2026-11-23 18:09:08'),(110,NULL,40,'leaf',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":653,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Maractus!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Maractus perdeu 15 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Maractus desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 6!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-23 22:40:49','2026-11-23 18:40:55'),(111,NULL,40,'leaf',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":657,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Deerling!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Deerling perdeu 16 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Deerling desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 7!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-23 22:41:00','2026-11-23 18:41:04'),(112,NULL,40,'leaf',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":661,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Sewaddle!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Sewaddle perdeu 17 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Sewaddle desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 8!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-23 22:41:09','2026-11-23 18:41:13'),(113,NULL,40,'leaf',NULL,'VITORIA',400,'{\"tipo_encontro\":\"selvagem\",\"id_alvo\":663,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um Pokémon selvagem apareceu: Throh!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 11 HP.\"},{\"tipo\":\"status\",\"texto\":\"Throh recebeu Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 10 HP.\"},{\"tipo\":\"status\",\"texto\":\"Throh perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 11 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Throh usou Drain Punch!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 10 HP.\"},{\"tipo\":\"status\",\"texto\":\"Throh perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Throh perdeu 3 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Throh desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu a batalha!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 9!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 400!\"}]}','2026-11-23 22:41:21','2026-11-23 18:41:29'),(114,NULL,40,'leaf',1,'DERROTA',0,'{\"tipo_encontro\":\"desafio\",\"id_alvo\":1,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Ginásio 1 quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Cubchoo!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Cubchoo aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 22 HP.\"},{\"tipo\":\"status\",\"texto\":\"Cubchoo recebeu Queimadura!\"},{\"tipo\":\"status\",\"texto\":\"Cubchoo perdeu HP por Queimadura!\"},{\"tipo\":\"golpe\",\"texto\":\"Cubchoo usou Ice Shard!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 18 HP.\"},{\"tipo\":\"status\",\"texto\":\"Tepig recebeu Congelamento!\"},{\"tipo\":\"status\",\"texto\":\"Tepig descongelou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Cubchoo perdeu 12 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Cubchoo desmaiou!\"},{\"tipo\":\"troca_automatica\",\"texto\":\"Treinador enviou Vanillish!\"},{\"tipo\":\"golpe\",\"texto\":\"Vanillish usou Ice Beam!\"},{\"tipo\":\"efetividade\",\"texto\":\"Não foi muito efetivo...\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 12 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-23 22:41:51','2026-11-23 18:42:05'),(115,NULL,41,'leaf',NULL,'VITORIA',600,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":221,\"turnos\":1,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Normal quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Deerling!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Fire Fang!\"},{\"tipo\":\"efetividade\",\"texto\":\"Foi super efetivo!\"},{\"tipo\":\"dano\",\"texto\":\"Deerling perdeu 14 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Deerling desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Você venceu o treinador!\"},{\"tipo\":\"nivel\",\"texto\":\"Tepig subiu para o Nv. 7!\"},{\"tipo\":\"recompensa\",\"texto\":\"Você recebeu ₽ 600!\"}]}','2026-11-24 17:27:04','2026-11-24 13:27:07'),(116,NULL,41,'leaf',NULL,'DERROTA',0,'{\"tipo_encontro\":\"treinador\",\"id_alvo\":222,\"turnos\":3,\"log\":[{\"tipo\":\"inicio\",\"texto\":\"Um treinador tipo Normal quer batalhar!\"},{\"tipo\":\"envio_adversario\",\"texto\":\"Treinador enviou Lillipup!\"},{\"tipo\":\"envio_jogador\",\"texto\":\"Vai! Tepig!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Tepig aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Lillipup usou Body Slam!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 14 HP.\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Tepig aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Lillipup usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Lillipup aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Tepig usou Dança Das Espadas!\"},{\"tipo\":\"status\",\"texto\":\"Ataque de Tepig aumentou!\"},{\"tipo\":\"golpe\",\"texto\":\"Lillipup usou Body Slam!\"},{\"tipo\":\"critico\",\"texto\":\"Um golpe crítico!\"},{\"tipo\":\"dano\",\"texto\":\"Tepig perdeu 12 HP.\"},{\"tipo\":\"desmaio\",\"texto\":\"Tepig desmaiou!\"},{\"tipo\":\"fim\",\"texto\":\"Todos os seus Pokémon desmaiaram!\"}]}','2026-11-24 17:27:14','2026-11-24 13:27:22');
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
) ENGINE=InnoDB AUTO_INCREMENT=414 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batalha_pokemon`
--

LOCK TABLES `batalha_pokemon` WRITE;
/*!40000 ALTER TABLE `batalha_pokemon` DISABLE KEYS */;
INSERT INTO `batalha_pokemon` VALUES (138,61,39,16,'JOGADOR',1,50,192,192,NULL,NULL),(139,61,NULL,82,'INIMIGO',1,3,56,0,NULL,NULL),(140,62,39,17,'JOGADOR',1,51,210,210,NULL,NULL),(141,62,NULL,27,'INIMIGO',1,6,60,0,NULL,NULL),(142,62,NULL,25,'INIMIGO',2,6,60,0,NULL,NULL),(143,63,39,18,'JOGADOR',1,53,231,231,NULL,NULL),(144,63,NULL,25,'INIMIGO',1,10,72,0,NULL,NULL),(230,78,39,18,'JOGADOR',1,54,145,145,NULL,NULL),(231,78,NULL,53,'INIMIGO',1,13,42,0,NULL,NULL),(232,79,39,18,'JOGADOR',1,55,147,147,NULL,NULL),(233,79,NULL,143,'INIMIGO',1,12,33,0,NULL,NULL),(234,79,NULL,154,'INIMIGO',2,15,48,0,NULL,NULL),(235,80,39,18,'JOGADOR',1,57,152,145,NULL,NULL),(236,80,46,102,'JOGADOR',2,57,112,112,NULL,NULL),(237,80,NULL,64,'JOGADOR',3,57,101,101,NULL,NULL),(238,80,NULL,61,'JOGADOR',4,57,118,118,NULL,NULL),(239,80,NULL,127,'INIMIGO',1,20,96,0,NULL,NULL),(240,80,NULL,126,'INIMIGO',2,20,70,0,NULL,NULL),(241,80,NULL,37,'INIMIGO',3,20,60,0,NULL,NULL),(242,81,39,18,'JOGADOR',1,59,150,150,NULL,NULL),(243,81,46,103,'JOGADOR',2,59,139,139,NULL,NULL),(244,81,NULL,66,'JOGADOR',3,59,139,139,NULL,NULL),(245,81,NULL,63,'JOGADOR',4,59,157,157,NULL,NULL),(246,81,NULL,109,'INIMIGO',1,18,49,0,NULL,NULL),(247,81,NULL,49,'INIMIGO',2,20,56,0,NULL,NULL),(248,81,NULL,39,'INIMIGO',3,22,83,0,NULL,NULL),(249,82,39,18,'JOGADOR',1,61,155,151,NULL,NULL),(250,82,46,103,'JOGADOR',2,61,144,144,NULL,NULL),(251,82,NULL,66,'JOGADOR',3,61,144,144,NULL,NULL),(252,82,NULL,63,'JOGADOR',4,61,162,162,NULL,NULL),(253,82,49,84,'JOGADOR',5,61,156,156,NULL,NULL),(254,82,51,128,'JOGADOR',6,61,132,132,NULL,NULL),(255,82,NULL,127,'INIMIGO',1,27,126,0,NULL,NULL),(256,83,39,18,'JOGADOR',1,63,167,167,NULL,NULL),(257,83,46,103,'JOGADOR',2,63,148,148,NULL,NULL),(258,83,NULL,66,'JOGADOR',3,63,148,148,NULL,NULL),(259,83,NULL,63,'JOGADOR',4,63,167,167,NULL,NULL),(260,83,49,73,'JOGADOR',5,63,224,224,NULL,NULL),(261,83,51,129,'JOGADOR',6,63,161,161,NULL,NULL),(262,83,NULL,97,'INIMIGO',1,23,58,0,NULL,NULL),(263,83,NULL,41,'INIMIGO',2,25,66,0,NULL,NULL),(264,83,NULL,115,'INIMIGO',3,27,77,0,NULL,NULL),(265,83,NULL,99,'INIMIGO',4,29,82,0,NULL,NULL),(266,84,39,18,'JOGADOR',1,65,172,4,NULL,NULL),(267,84,46,103,'JOGADOR',2,65,153,153,NULL,NULL),(268,84,NULL,66,'JOGADOR',3,65,153,153,NULL,NULL),(269,84,52,90,'JOGADOR',4,65,124,124,NULL,NULL),(270,84,49,73,'JOGADOR',5,65,231,231,NULL,NULL),(271,84,51,129,'JOGADOR',6,65,166,166,NULL,NULL),(272,84,NULL,63,'INIMIGO',1,34,95,0,NULL,NULL),(273,84,NULL,81,'INIMIGO',2,34,95,0,NULL,NULL),(274,84,NULL,131,'INIMIGO',3,34,94,0,NULL,NULL),(275,85,39,18,'JOGADOR',1,67,177,0,2,NULL),(276,85,46,103,'JOGADOR',2,67,157,157,NULL,NULL),(277,85,NULL,66,'JOGADOR',3,67,157,157,NULL,NULL),(278,85,52,91,'JOGADOR',4,67,154,154,NULL,NULL),(279,85,49,73,'JOGADOR',5,67,237,237,NULL,NULL),(280,85,51,129,'JOGADOR',6,67,170,170,NULL,NULL),(281,85,NULL,163,'INIMIGO',1,28,85,0,NULL,NULL),(282,85,NULL,35,'INIMIGO',2,30,85,0,NULL,NULL),(283,85,NULL,79,'INIMIGO',3,32,109,0,NULL,NULL),(284,85,NULL,142,'INIMIGO',4,34,84,0,NULL,NULL),(285,85,NULL,169,'INIMIGO',5,36,107,0,NULL,NULL),(286,86,39,18,'JOGADOR',1,69,0,0,2,NULL),(287,86,NULL,59,'JOGADOR',2,69,244,244,NULL,NULL),(288,86,46,103,'JOGADOR',3,69,161,161,NULL,NULL),(289,86,52,91,'JOGADOR',4,69,159,159,NULL,NULL),(290,86,49,73,'JOGADOR',5,69,244,244,NULL,NULL),(291,86,51,129,'JOGADOR',6,69,175,175,NULL,NULL),(292,86,NULL,82,'INIMIGO',1,32,74,0,NULL,NULL),(293,86,NULL,92,'INIMIGO',2,32,76,0,NULL,NULL),(294,87,39,18,'JOGADOR',1,69,0,0,2,NULL),(295,87,NULL,59,'JOGADOR',2,71,251,234,NULL,NULL),(296,87,46,103,'JOGADOR',3,71,166,166,NULL,NULL),(297,87,52,91,'JOGADOR',4,71,163,163,NULL,NULL),(298,87,49,73,'JOGADOR',5,71,251,251,NULL,NULL),(299,87,51,129,'JOGADOR',6,71,180,180,NULL,NULL),(300,87,NULL,92,'INIMIGO',1,37,86,0,NULL,NULL),(301,88,39,18,'JOGADOR',1,69,0,0,2,NULL),(302,88,NULL,59,'JOGADOR',2,73,241,224,NULL,NULL),(303,88,46,103,'JOGADOR',3,73,170,170,NULL,NULL),(304,88,52,91,'JOGADOR',4,73,167,167,NULL,NULL),(305,88,49,73,'JOGADOR',5,73,258,258,NULL,NULL),(306,88,51,129,'JOGADOR',6,73,185,185,NULL,NULL),(307,88,NULL,127,'INIMIGO',1,41,186,0,NULL,NULL),(308,89,39,18,'JOGADOR',1,69,0,0,2,NULL),(309,89,NULL,59,'JOGADOR',2,75,231,83,5,NULL),(310,89,46,103,'JOGADOR',3,75,175,175,NULL,NULL),(311,89,52,91,'JOGADOR',4,75,172,172,NULL,NULL),(312,89,49,73,'JOGADOR',5,75,265,265,NULL,NULL),(313,89,51,129,'JOGADOR',6,75,190,190,NULL,NULL),(314,89,NULL,86,'INIMIGO',1,33,85,0,NULL,NULL),(315,89,NULL,159,'INIMIGO',2,35,115,0,NULL,NULL),(316,89,NULL,124,'INIMIGO',3,37,131,0,NULL,NULL),(317,89,NULL,58,'INIMIGO',4,39,130,0,NULL,NULL),(318,89,NULL,147,'INIMIGO',5,41,128,0,NULL,NULL),(319,89,NULL,137,'INIMIGO',6,43,126,0,NULL,NULL),(320,90,39,18,'JOGADOR',1,69,0,0,2,NULL),(321,90,46,103,'JOGADOR',2,77,179,139,NULL,NULL),(322,90,52,91,'JOGADOR',3,77,176,176,NULL,NULL),(323,90,NULL,59,'JOGADOR',4,77,89,89,5,NULL),(324,90,49,73,'JOGADOR',5,77,271,271,NULL,NULL),(325,90,51,129,'JOGADOR',6,77,194,194,NULL,NULL),(326,90,NULL,131,'INIMIGO',1,33,91,0,NULL,NULL),(327,91,39,18,'JOGADOR',1,69,0,0,2,NULL),(328,91,46,103,'JOGADOR',2,78,141,141,NULL,NULL),(329,91,52,91,'JOGADOR',3,78,178,178,NULL,NULL),(330,91,54,140,'JOGADOR',4,78,166,166,NULL,NULL),(331,91,49,73,'JOGADOR',5,78,275,275,NULL,NULL),(332,91,51,129,'JOGADOR',6,78,197,197,NULL,NULL),(333,91,NULL,28,'INIMIGO',1,44,111,0,NULL,NULL),(334,91,NULL,120,'INIMIGO',2,44,124,0,NULL,NULL),(335,92,39,18,'JOGADOR',1,69,0,0,2,NULL),(336,92,46,103,'JOGADOR',2,80,146,146,NULL,NULL),(337,92,52,91,'JOGADOR',3,80,182,182,NULL,NULL),(338,92,54,142,'JOGADOR',4,80,186,186,NULL,NULL),(339,92,49,73,'JOGADOR',5,80,282,282,NULL,NULL),(340,92,51,129,'JOGADOR',6,80,202,202,NULL,NULL),(341,92,NULL,46,'INIMIGO',1,48,125,0,NULL,NULL),(342,93,46,103,'JOGADOR',1,81,188,0,NULL,NULL),(343,93,52,91,'JOGADOR',2,81,184,138,NULL,NULL),(344,93,54,142,'JOGADOR',3,81,188,188,NULL,NULL),(345,93,49,73,'JOGADOR',4,81,285,285,NULL,NULL),(346,93,51,129,'JOGADOR',5,81,204,204,NULL,NULL),(347,93,39,18,'JOGADOR',6,69,182,182,NULL,NULL),(348,93,NULL,66,'INIMIGO',1,40,98,0,NULL,NULL),(349,93,NULL,18,'INIMIGO',2,42,115,0,NULL,NULL),(350,93,NULL,24,'INIMIGO',3,44,137,0,NULL,NULL),(351,93,NULL,167,'INIMIGO',4,46,140,0,NULL,NULL),(352,93,NULL,21,'INIMIGO',5,48,163,0,NULL,NULL),(353,93,NULL,96,'INIMIGO',6,50,160,0,NULL,NULL),(354,94,NULL,19,'JOGADOR',1,5,21,16,NULL,NULL),(355,94,NULL,53,'INIMIGO',1,2,15,0,2,NULL),(356,95,NULL,19,'JOGADOR',1,6,18,18,NULL,NULL),(357,95,NULL,59,'INIMIGO',1,3,20,0,2,NULL),(358,96,NULL,19,'JOGADOR',1,7,21,19,NULL,NULL),(359,96,NULL,151,'JOGADOR',2,7,32,32,NULL,NULL),(360,96,NULL,61,'INIMIGO',1,4,17,0,NULL,NULL),(361,96,NULL,130,'INIMIGO',2,4,17,0,NULL,NULL),(362,97,NULL,151,'JOGADOR',1,9,38,0,NULL,NULL),(363,97,NULL,19,'JOGADOR',2,9,30,0,NULL,NULL),(364,97,NULL,143,'INIMIGO',1,12,33,9,NULL,NULL),(365,97,NULL,154,'INIMIGO',2,15,48,48,NULL,NULL),(366,98,NULL,97,'JOGADOR',1,5,20,20,NULL,NULL),(367,98,NULL,19,'JOGADOR',2,5,21,21,NULL,NULL),(368,98,NULL,74,'JOGADOR',3,5,20,20,NULL,NULL),(369,98,NULL,146,'JOGADOR',4,5,20,20,NULL,NULL),(370,98,NULL,53,'INIMIGO',1,2,15,0,NULL,NULL),(371,98,NULL,60,'INIMIGO',2,2,15,0,NULL,NULL),(372,99,NULL,97,'JOGADOR',1,7,24,0,NULL,NULL),(373,99,NULL,19,'JOGADOR',2,7,26,0,NULL,NULL),(374,99,NULL,74,'JOGADOR',3,7,24,0,NULL,NULL),(375,99,NULL,146,'JOGADOR',4,7,24,0,NULL,NULL),(376,99,NULL,154,'INIMIGO',1,12,40,2,NULL,NULL),(377,100,NULL,16,'JOGADOR',1,5,19,18,NULL,NULL),(378,100,NULL,36,'INIMIGO',1,2,14,0,NULL,NULL),(379,101,NULL,16,'JOGADOR',1,6,20,20,NULL,NULL),(380,101,NULL,45,'INIMIGO',1,3,16,0,NULL,NULL),(381,102,NULL,16,'JOGADOR',1,7,22,20,NULL,NULL),(382,102,NULL,92,'INIMIGO',1,4,18,0,NULL,NULL),(383,103,NULL,16,'JOGADOR',1,9,24,5,NULL,NULL),(384,103,NULL,119,'INIMIGO',1,6,23,0,NULL,NULL),(385,104,NULL,16,'JOGADOR',1,10,29,0,NULL,NULL),(386,104,NULL,154,'INIMIGO',1,12,40,30,NULL,NULL),(387,105,NULL,19,'JOGADOR',1,5,21,16,NULL,NULL),(388,105,NULL,53,'INIMIGO',1,2,15,0,2,NULL),(389,105,NULL,60,'INIMIGO',2,2,15,0,2,NULL),(390,106,NULL,19,'JOGADOR',1,7,21,21,NULL,NULL),(391,106,NULL,164,'INIMIGO',1,4,18,0,NULL,NULL),(392,107,NULL,19,'JOGADOR',1,9,25,25,NULL,NULL),(393,107,NULL,130,'INIMIGO',1,6,21,0,NULL,NULL),(394,108,NULL,19,'JOGADOR',1,10,28,28,NULL,NULL),(395,108,NULL,130,'INIMIGO',1,7,23,0,NULL,NULL),(396,109,NULL,19,'JOGADOR',1,12,37,0,NULL,NULL),(397,109,NULL,154,'INIMIGO',1,12,40,33,2,NULL),(398,110,NULL,19,'JOGADOR',1,5,21,21,NULL,NULL),(399,110,NULL,81,'INIMIGO',1,2,15,0,NULL,NULL),(400,111,NULL,19,'JOGADOR',1,6,23,23,NULL,NULL),(401,111,NULL,119,'INIMIGO',1,3,16,0,NULL,NULL),(402,112,NULL,19,'JOGADOR',1,7,26,26,NULL,NULL),(403,112,NULL,61,'INIMIGO',1,4,17,0,NULL,NULL),(404,113,NULL,19,'JOGADOR',1,8,28,8,NULL,NULL),(405,113,NULL,59,'INIMIGO',1,5,27,0,2,NULL),(406,114,NULL,19,'JOGADOR',1,9,30,0,NULL,NULL),(407,114,NULL,146,'INIMIGO',1,12,35,0,2,NULL),(408,114,NULL,117,'INIMIGO',2,15,40,40,NULL,NULL),(409,115,NULL,19,'JOGADOR',1,5,21,21,NULL,NULL),(410,115,NULL,119,'INIMIGO',1,2,14,0,NULL,NULL),(411,116,NULL,19,'JOGADOR',1,7,26,0,NULL,NULL),(412,116,NULL,27,'INIMIGO',1,4,17,17,NULL,NULL),(413,116,NULL,25,'INIMIGO',2,4,17,17,NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `desafio_pokemon`
--

LOCK TABLES `desafio_pokemon` WRITE;
/*!40000 ALTER TABLE `desafio_pokemon` DISABLE KEYS */;
INSERT INTO `desafio_pokemon` VALUES (6,3,97,NULL,23,1,NULL),(7,3,41,NULL,25,2,NULL),(8,3,115,NULL,27,3,NULL),(9,3,99,NULL,29,4,NULL),(10,4,163,NULL,28,1,NULL),(11,4,35,NULL,30,2,NULL),(12,4,79,NULL,32,3,NULL),(13,4,142,NULL,34,4,NULL),(14,4,169,NULL,36,5,NULL),(15,5,86,NULL,33,1,NULL),(16,5,159,NULL,35,2,NULL),(17,5,124,NULL,37,3,NULL),(18,5,58,NULL,39,4,NULL),(19,5,147,NULL,41,5,NULL),(20,5,137,NULL,43,6,NULL),(21,6,66,NULL,40,1,NULL),(22,6,18,NULL,42,2,NULL),(23,6,24,NULL,44,3,NULL),(24,6,167,NULL,46,4,NULL),(25,6,21,NULL,48,5,NULL),(26,6,96,NULL,50,6,NULL),(32,1,146,NULL,12,1,NULL),(33,1,117,NULL,15,2,NULL),(34,2,171,NULL,18,1,NULL),(35,2,127,NULL,20,2,NULL),(36,2,37,NULL,22,3,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evolucao`
--

LOCK TABLES `evolucao` WRITE;
/*!40000 ALTER TABLE `evolucao` DISABLE KEYS */;
INSERT INTO `evolucao` VALUES (1,NULL,'NIVEL',34,'level-up',82,83),(2,NULL,'NIVEL',17,'level-up',16,17),(3,NULL,'NIVEL',36,'level-up',17,18),(6,NULL,'NIVEL',17,'level-up',19,20),(7,NULL,'NIVEL',36,'level-up',20,21),(8,NULL,'NIVEL',17,'level-up',22,23),(9,NULL,'NIVEL',36,'level-up',23,24),(12,NULL,'NIVEL',20,'level-up',25,26),(13,NULL,'NIVEL',16,'level-up',27,28),(14,NULL,'NIVEL',32,'level-up',28,29),(15,NULL,'NIVEL',20,'level-up',30,31),(16,NULL,'NIVEL',20,'level-up',32,33),(17,NULL,'NIVEL',20,'level-up',34,35),(18,NULL,'NIVEL',20,'level-up',36,37),(19,NULL,'NIVEL',28,'level-up',38,39),(20,NULL,'NIVEL',21,'level-up',40,41),(21,NULL,'NIVEL',32,'level-up',41,42),(24,NULL,'NIVEL',27,'level-up',43,44),(25,NULL,'NIVEL',25,'level-up',45,46),(26,NULL,'NIVEL',40,'level-up',46,47),(29,NULL,'NIVEL',22,'level-up',48,49),(33,NULL,'NIVEL',31,'level-up',50,51),(34,NULL,'NIVEL',25,'level-up',53,54),(35,NULL,'NIVEL',30,'level-up',54,55),(36,NULL,'NIVEL',25,'level-up',56,57),(37,NULL,'NIVEL',36,'level-up',57,58),(38,NULL,'NIVEL',20,'level-up',61,62),(39,NULL,'NIVEL',28,'level-up',62,63),(40,NULL,'NIVEL',22,'level-up',64,65),(41,NULL,'NIVEL',30,'level-up',65,66),(42,NULL,'NIVEL',25,'level-up',67,68),(43,NULL,'NIVEL',25,'level-up',69,70),(46,NULL,'NIVEL',30,'level-up',84,73),(50,NULL,'NIVEL',39,'level-up',85,86),(52,NULL,'NIVEL',34,'level-up',88,89),(59,NULL,'NIVEL',37,'level-up',92,93),(60,NULL,'NIVEL',52,'level-up',94,95),(62,NULL,'NIVEL',55,'level-up',95,96),(63,NULL,'NIVEL',37,'level-up',98,99),(64,NULL,'NIVEL',36,'level-up',100,101),(65,NULL,'NIVEL',30,'level-up',102,103),(69,NULL,'NIVEL',20,'level-up',106,107),(70,NULL,'NIVEL',32,'level-up',108,109),(72,NULL,'NIVEL',41,'level-up',109,110),(73,NULL,'NIVEL',32,'level-up',111,112),(75,NULL,'NIVEL',41,'level-up',112,113),(76,NULL,'NIVEL',35,'level-up',114,115),(77,NULL,'NIVEL',35,'level-up',116,117),(79,NULL,'NIVEL',47,'level-up',117,118),(80,NULL,'NIVEL',34,'level-up',119,120),(81,NULL,'NIVEL',30,'level-up',121,122),(82,NULL,'NIVEL',39,'level-up',123,124),(83,NULL,'NIVEL',36,'level-up',128,129),(84,NULL,'NIVEL',40,'level-up',130,131),(85,NULL,'NIVEL',38,'level-up',132,133),(87,NULL,'NIVEL',49,'level-up',133,134),(88,NULL,'NIVEL',39,'level-up',135,136),(90,NULL,'NIVEL',48,'level-up',136,137),(91,NULL,'NIVEL',42,'level-up',138,139),(92,NULL,'NIVEL',41,'level-up',140,141),(94,NULL,'NIVEL',50,'level-up',141,142),(95,NULL,'NIVEL',38,'level-up',143,144),(97,NULL,'NIVEL',48,'level-up',144,145),(98,NULL,'NIVEL',37,'level-up',146,147),(99,NULL,'NIVEL',48,'level-up',149,150),(100,NULL,'NIVEL',50,'level-up',152,153),(101,NULL,'NIVEL',43,'level-up',155,156),(104,NULL,'NIVEL',54,'level-up',158,159),(106,NULL,'NIVEL',54,'level-up',161,162),(107,NULL,'NIVEL',50,'level-up',165,166),(109,NULL,'NIVEL',64,'level-up',166,167),(110,NULL,'NIVEL',59,'level-up',168,169),(115,NULL,'NIVEL',35,'level-up',90,91),(116,NULL,'NIVEL',35,'level-up',77,79),(117,NULL,'NIVEL',35,'level-up',78,80),(118,NULL,'NIVEL',25,'level-up',69,71),(119,NULL,'NIVEL',30,'level-up',104,105),(127,NULL,'NIVEL',40,'level-up',125,126),(131,NULL,'NIVEL',40,'level-up',171,172);
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
INSERT INTO `golpe` VALUES (1,34,'body-slam',1,'DANO',65,100,15,0,'PHYSICAL','Causa dano e tem 30% de chance de paralisar o oponente.'),(2,351,'shock-wave',3,'DANO',65,NULL,20,0,'SPECIAL','Golpe especial do tipo Elétrico que causa dano.'),(3,424,'fire-fang',2,'DANO',65,95,15,0,'PHYSICAL','Causa dano e tem 10% de chance de causar queimadura.'),(4,352,'water-pulse',4,'DANO',65,100,20,0,'SPECIAL','Golpe especial do tipo Água que causa dano.'),(5,72,'mega-drain',5,'DANO',65,100,15,0,'SPECIAL','Causa dano e recupera HP equivalente a 50% do dano causado.'),(6,409,'drain-punch',6,'DANO',65,100,10,0,'PHYSICAL','Causa dano e recupera HP equivalente a 50% do dano causado.'),(7,389,'sucker-punch',9,'DANO',65,100,5,1,'PHYSICAL','Golpe físico do tipo Sombrio com prioridade de execução 1.'),(8,418,'bullet-punch',7,'DANO',65,100,30,1,'PHYSICAL','Golpe físico do tipo Aço com prioridade de execução 1.'),(9,425,'shadow-sneak',13,'DANO',65,100,30,1,'PHYSICAL','Golpe físico do tipo Fantasma com prioridade de execução 1.'),(10,450,'bug-bite',14,'DANO',65,100,20,0,'PHYSICAL','Golpe físico do tipo Inseto que causa dano.'),(11,414,'earth-power',17,'DANO',65,100,10,0,'SPECIAL','Golpe especial do tipo Terra que causa dano.'),(12,317,'rock-tomb',16,'DANO',65,95,15,0,'PHYSICAL','Golpe físico do tipo Pedra que causa dano.'),(13,337,'dragon-claw',10,'DANO',65,100,15,0,'PHYSICAL','Golpe físico do tipo Dragão que causa dano.'),(14,605,'dazzling-gleam',18,'DANO',65,100,10,0,'SPECIAL','Golpe especial do tipo Fada que causa dano.'),(15,512,'acrobatics',15,'DANO',65,100,15,0,'PHYSICAL','Golpe físico do tipo Voador que causa dano.'),(16,94,'psychic',8,'DANO',65,100,10,0,'SPECIAL','Golpe especial do tipo Psíquico que causa dano.'),(17,188,'sludge-bomb',12,'DANO',65,100,10,0,'SPECIAL','Causa dano e tem 30% de chance de envenenar o oponente.'),(18,58,'ice-beam',11,'DANO',65,100,10,0,'SPECIAL','Causa dano e tem 10% de chance de congelar o oponente.'),(28,14,'Dança das Espadas',1,'STATUS',NULL,NULL,20,0,'status','Raises the user’s Attack by two stages.'),(29,417,'Maquinação Maliciosa',9,'STATUS',NULL,NULL,20,0,'status','Raises the user’s Special Attack by two stages.'),(30,86,'Onda Trovão',3,'STATUS',NULL,90,20,0,'status','Paralyzes the target.'),(31,92,'Tóxico',12,'STATUS',NULL,90,10,0,'status','Badly poisons the target.  Never misses when used by a Poison-type Pokémon.'),(32,347,'Paz Mental',8,'STATUS',NULL,NULL,20,0,'status','Raises the user’s Special Attack and Special Defense by one stage each.'),(33,339,'Corpulência',6,'STATUS',NULL,NULL,20,0,'status','Raises the user’s Attack and Defense by one stage each.'),(34,147,'Esporo',5,'STATUS',NULL,100,15,0,'status','Puts the target to sleep.'),(35,261,'Fogo Fátuo',2,'STATUS',NULL,85,15,0,'status','Burns the target.'),(37,496,'round',1,'DANO',65,100,15,0,'SPECIAL','Golpe especial do tipo Normal que causa dano.'),(39,209,'spark',3,'DANO',65,100,20,0,'PHYSICAL','Golpe físico do tipo Elétrico que causa dano.'),(41,510,'incinerate',2,'DANO',65,100,15,0,'SPECIAL','Golpe especial do tipo Fogo que causa dano.'),(43,453,'aqua-jet',4,'DANO',65,100,20,1,'PHYSICAL','Golpe físico do tipo Água com prioridade de execução 1.'),(45,348,'leaf-blade',5,'DANO',65,100,15,0,'PHYSICAL','Golpe físico do tipo Grama que causa dano.'),(47,396,'aura-sphere',6,'DANO',65,NULL,20,0,'SPECIAL','Golpe especial do tipo Lutador que causa dano.'),(49,399,'dark-pulse',9,'DANO',65,100,15,0,'SPECIAL','Golpe especial do tipo Sombrio que causa dano.'),(51,430,'flash-cannon',7,'DANO',65,100,10,0,'SPECIAL','Golpe especial do tipo Aço que causa dano.'),(53,247,'shadow-ball',13,'DANO',65,100,15,0,'SPECIAL','Golpe especial do tipo Fantasma que causa dano.'),(55,324,'signal-beam',14,'DANO',65,100,15,0,'SPECIAL','Golpe especial do tipo Inseto que causa dano.'),(57,523,'bulldoze',17,'DANO',65,100,20,0,'PHYSICAL','Golpe físico do tipo Terra que causa dano.'),(59,408,'power-gem',16,'DANO',65,100,20,0,'SPECIAL','Golpe especial do tipo Pedra que causa dano.'),(61,225,'dragon-breath',10,'DANO',65,100,20,0,'SPECIAL','Causa dano e tem 30% de chance de paralisar o oponente.'),(63,583,'play-rough',18,'DANO',65,90,10,0,'PHYSICAL','Golpe físico do tipo Fada que causa dano.'),(65,403,'air-slash',15,'DANO',65,95,15,0,'SPECIAL','Golpe especial do tipo Voador que causa dano.'),(67,428,'zen-headbutt',8,'DANO',65,90,15,0,'PHYSICAL','Golpe físico do tipo Psíquico que causa dano.'),(69,398,'poison-jab',12,'DANO',65,100,20,0,'PHYSICAL','Causa dano e tem 30% de chance de envenenar o oponente.'),(71,420,'ice-shard',11,'DANO',65,100,30,1,'PHYSICAL','Golpe físico do tipo Gelo com prioridade de execução 1.');
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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `golpe_efeito`
--

LOCK TABLES `golpe_efeito` WRITE;
/*!40000 ALTER TABLE `golpe_efeito` DISABLE KEYS */;
INSERT INTO `golpe_efeito` VALUES (1,28,'ALTERAR_ATRIBUTO','USUARIO',NULL,'ATAQUE',2,NULL,100),(2,29,'ALTERAR_ATRIBUTO','USUARIO',NULL,'ATAQUE_ESPECIAL',2,NULL,100),(3,32,'ALTERAR_ATRIBUTO','USUARIO',NULL,'ATAQUE_ESPECIAL',1,NULL,100),(4,32,'ALTERAR_ATRIBUTO','USUARIO',NULL,'DEFESA_ESPECIAL',1,NULL,100),(5,33,'ALTERAR_ATRIBUTO','USUARIO',NULL,'ATAQUE',1,NULL,100),(6,33,'ALTERAR_ATRIBUTO','USUARIO',NULL,'DEFESA',1,NULL,100),(7,30,'APLICAR_STATUS','OPONENTE',5,NULL,NULL,NULL,100),(8,31,'APLICAR_STATUS','OPONENTE',1,NULL,NULL,NULL,100),(9,34,'APLICAR_STATUS','OPONENTE',4,NULL,NULL,NULL,100),(10,35,'APLICAR_STATUS','OPONENTE',2,NULL,NULL,NULL,100),(16,1,'APLICAR_STATUS','OPONENTE',5,NULL,NULL,NULL,30),(17,3,'APLICAR_STATUS','OPONENTE',2,NULL,NULL,NULL,10),(18,5,'DRENAR_DANO','USUARIO',NULL,NULL,NULL,50,100),(19,6,'DRENAR_DANO','USUARIO',NULL,NULL,NULL,50,100),(22,17,'APLICAR_STATUS','OPONENTE',1,NULL,NULL,NULL,30),(23,18,'APLICAR_STATUS','OPONENTE',3,NULL,NULL,NULL,10),(24,61,'APLICAR_STATUS','OPONENTE',5,NULL,NULL,NULL,30),(25,69,'APLICAR_STATUS','OPONENTE',1,NULL,NULL,NULL,30);
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
INSERT INTO `inventario` VALUES (33,3,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=925 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mapa_conexao`
--

LOCK TABLES `mapa_conexao` WRITE;
/*!40000 ALTER TABLE `mapa_conexao` DISABLE KEYS */;
INSERT INTO `mapa_conexao` VALUES (745,562,565),(746,562,566),(747,563,566),(748,563,567),(749,564,567),(750,564,568),(751,565,569),(752,566,569),(753,566,570),(754,567,570),(755,567,571),(756,568,571),(757,569,572),(758,570,572),(759,570,573),(760,571,573),(761,572,574),(762,573,575),(763,574,576),(764,575,576),(905,682,685),(906,682,686),(907,683,686),(908,683,687),(909,684,687),(910,684,688),(911,685,689),(912,686,689),(913,686,690),(914,687,690),(915,687,691),(916,688,691),(917,689,692),(918,690,692),(919,690,693),(920,691,693),(921,692,694),(922,693,695),(923,694,696),(924,695,696);
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
) ENGINE=InnoDB AUTO_INCREMENT=697 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mapa_no`
--

LOCK TABLES `mapa_no` WRITE;
/*!40000 ALTER TABLE `mapa_no` DISABLE KEYS */;
INSERT INTO `mapa_no` VALUES (562,33,'POKEBOLA',NULL,NULL,14,79,1,1,'IGNORADO','2026-11-23 14:59:46',NULL),(563,33,'SELVAGEM',NULL,NULL,50,79,1,2,'CONCLUIDO','2026-11-23 14:59:46','2026-11-23 15:00:13'),(564,33,'TREINADOR',2,186,86,79,1,3,'IGNORADO','2026-11-23 14:59:46',NULL),(565,33,'SELVAGEM',NULL,NULL,10,61,2,1,'BLOQUEADO','2026-11-23 14:59:46',NULL),(566,33,'TREINADOR',4,187,36,61,2,2,'IGNORADO','2026-11-23 14:59:46',NULL),(567,33,'POKEBOLA',NULL,NULL,64,61,2,3,'CONCLUIDO','2026-11-23 14:59:46','2026-11-23 15:00:31'),(568,33,'TREINADOR',4,188,90,61,2,4,'BLOQUEADO','2026-11-23 14:59:46',NULL),(569,33,'SELVAGEM',NULL,NULL,25,43,3,1,'BLOQUEADO','2026-11-23 14:59:46',NULL),(570,33,'POKEBOLA',NULL,NULL,50,43,3,2,'IGNORADO','2026-11-23 14:59:46',NULL),(571,33,'TREINADOR',4,189,75,43,3,3,'CONCLUIDO','2026-11-23 14:59:46','2026-11-23 15:00:42'),(572,33,'TREINADOR',6,190,36,30,4,1,'BLOQUEADO','2026-11-23 14:59:46',NULL),(573,33,'SELVAGEM',NULL,NULL,64,30,4,2,'CONCLUIDO','2026-11-23 14:59:46','2026-11-23 15:00:47'),(574,33,'POKEMART',NULL,NULL,36,17,5,1,'BLOQUEADO','2026-11-23 14:59:46',NULL),(575,33,'CENTRO_POKEMON',NULL,NULL,64,17,5,2,'CONCLUIDO','2026-11-23 14:59:46','2026-11-23 15:00:54'),(576,33,'DESAFIO',NULL,NULL,50,7,6,1,'CONCLUIDO','2026-11-23 14:59:46','2026-11-23 15:02:01'),(682,42,'POKEBOLA',NULL,NULL,14,79,1,1,'DISPONIVEL','2026-11-24 13:33:31',NULL),(683,42,'SELVAGEM',NULL,NULL,50,79,1,2,'DISPONIVEL','2026-11-24 13:33:31',NULL),(684,42,'TREINADOR',4,226,86,79,1,3,'DISPONIVEL','2026-11-24 13:33:31',NULL),(685,42,'TREINADOR',1,227,10,61,2,1,'BLOQUEADO','2026-11-24 13:33:31',NULL),(686,42,'SELVAGEM',NULL,NULL,36,61,2,2,'BLOQUEADO','2026-11-24 13:33:31',NULL),(687,42,'POKEBOLA',NULL,NULL,64,61,2,3,'BLOQUEADO','2026-11-24 13:33:31',NULL),(688,42,'TREINADOR',3,228,90,61,2,4,'BLOQUEADO','2026-11-24 13:33:31',NULL),(689,42,'TREINADOR',6,229,25,43,3,1,'BLOQUEADO','2026-11-24 13:33:31',NULL),(690,42,'POKEBOLA',NULL,NULL,50,43,3,2,'BLOQUEADO','2026-11-24 13:33:31',NULL),(691,42,'SELVAGEM',NULL,NULL,75,43,3,3,'BLOQUEADO','2026-11-24 13:33:31',NULL),(692,42,'SELVAGEM',NULL,NULL,36,30,4,1,'BLOQUEADO','2026-11-24 13:33:31',NULL),(693,42,'TREINADOR',5,230,64,30,4,2,'BLOQUEADO','2026-11-24 13:33:31',NULL),(694,42,'CENTRO_POKEMON',NULL,NULL,36,17,5,1,'BLOQUEADO','2026-11-24 13:33:31',NULL),(695,42,'POKEMART',NULL,NULL,64,17,5,2,'BLOQUEADO','2026-11-24 13:33:31',NULL),(696,42,'DESAFIO',NULL,NULL,50,7,6,1,'BLOQUEADO','2026-11-24 13:33:31',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=231 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `npc_mapa`
--

LOCK TABLES `npc_mapa` WRITE;
/*!40000 ALTER TABLE `npc_mapa` DISABLE KEYS */;
INSERT INTO `npc_mapa` VALUES (186,33,2,860,790,1,0,'2026-11-23 14:59:46',NULL),(187,33,4,360,610,2,0,'2026-11-23 14:59:46',NULL),(188,33,4,900,610,3,0,'2026-11-23 14:59:46',NULL),(189,33,4,750,430,4,1,'2026-11-23 14:59:46','2026-11-23 15:00:36'),(190,33,6,360,300,5,0,'2026-11-23 14:59:46',NULL),(226,42,4,860,790,1,0,'2026-11-24 13:33:31',NULL),(227,42,1,100,610,2,0,'2026-11-24 13:33:31',NULL),(228,42,3,900,610,3,0,'2026-11-24 13:33:31',NULL),(229,42,6,250,430,4,0,'2026-11-24 13:33:31',NULL),(230,42,5,640,300,5,0,'2026-11-24 13:33:31',NULL);
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
INSERT INTO `npc_tipo` VALUES (1,14,'Treinador especializado em Pokemon do tipo Inseto.'),(2,6,'Treinador especializado em Pokemon do tipo Lutador.'),(3,5,'Treinador especializado em Pokemon do tipo Grama.'),(4,1,'Treinador especializado em Pokemon do tipo Normal.'),(5,16,'Treinador especializado em Pokemon do tipo Rocha.'),(6,8,'Treinador especializado em Pokemon do tipo Psiquico.');
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `npc_tipo_pokemon`
--

LOCK TABLES `npc_tipo_pokemon` WRITE;
/*!40000 ALTER TABLE `npc_tipo_pokemon` DISABLE KEYS */;
INSERT INTO `npc_tipo_pokemon` VALUES (1,3,1,61,62,63),(2,3,2,81,81,81),(3,3,3,130,131,131),(4,6,1,108,109,110),(5,6,2,48,49,49),(6,6,3,38,39,39),(7,4,1,27,28,29),(8,4,2,25,26,26),(9,4,3,119,120,120),(10,5,1,82,83,83),(11,5,2,45,46,47),(12,5,3,92,93,93),(13,2,1,53,54,55),(14,2,2,60,60,60),(15,2,3,59,59,59),(16,1,1,128,129,129),(17,1,2,149,150,150),(18,1,3,164,164,164);
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
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perfil`
--

LOCK TABLES `perfil` WRITE;
/*!40000 ALTER TABLE `perfil` DISABLE KEYS */;
INSERT INTO `perfil` VALUES (33,1,'red',1700,'2026-11-18 11:53:44'),(42,1,'leaf',0,'2026-11-24 13:33:29');
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
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perfil_log`
--

LOCK TABLES `perfil_log` WRITE;
/*!40000 ALTER TABLE `perfil_log` DISABLE KEYS */;
INSERT INTO `perfil_log` VALUES (51,33,'CRIACAO','Nova jornada criada.',NULL,'2026-11-18 11:53:44'),(52,33,'INICIAL_ESCOLHIDO','Pokémon inicial escolhido.','{\"pokemon\":\"snivy\"}','2026-11-18 11:53:46'),(71,33,'ROTA_GERADA',NULL,'{\"id_desafio\":1,\"area\":1}','2026-11-23 14:43:11'),(72,33,'ROTA_GERADA',NULL,'{\"id_desafio\":2,\"area\":3}','2026-11-23 14:43:40'),(73,33,'POKEBOLA_OFERTA','Encontro com uma Pokébola do mapa.','{\"id_mapa_no\":502,\"id_pokemon_especie\":102,\"nivel\":57}','2026-11-23 14:43:41'),(74,33,'POKEBOLA_CAPTURADA','Encontro com uma Pokébola do mapa.','{\"id_mapa_no\":502,\"id_pokemon_especie\":102,\"nivel\":57}','2026-11-23 14:43:43'),(75,33,'POKEBOLA_OFERTA','Encontro com uma Pokébola do mapa.','{\"id_mapa_no\":506,\"id_pokemon_especie\":64,\"nivel\":57}','2026-11-23 14:43:43'),(76,33,'POKEBOLA_CAPTURADA','Encontro com uma Pokébola do mapa.','{\"id_mapa_no\":506,\"id_pokemon_especie\":64,\"nivel\":57}','2026-11-23 14:43:44'),(77,33,'POKEBOLA_OFERTA','Encontro com uma Pokébola do mapa.','{\"id_mapa_no\":510,\"id_pokemon_especie\":61,\"nivel\":57}','2026-11-23 14:43:45'),(78,33,'POKEBOLA_CAPTURADA','Encontro com uma Pokébola do mapa.','{\"id_mapa_no\":510,\"id_pokemon_especie\":61,\"nivel\":57}','2026-11-23 14:43:46'),(79,33,'ROTA_GERADA',NULL,'{\"id_desafio\":3,\"area\":1}','2026-11-23 14:44:26'),(80,33,'POKEBOLA_OFERTA','Encontro com uma Pokébola do mapa.','{\"id_mapa_no\":518,\"id_pokemon_especie\":84,\"nivel\":61}','2026-11-23 14:44:30'),(81,33,'POKEBOLA_CAPTURADA','Encontro com uma Pokébola do mapa.','{\"id_mapa_no\":518,\"id_pokemon_especie\":84,\"nivel\":61}','2026-11-23 14:44:32'),(82,33,'POKEBOLA_OFERTA','Encontro com uma Pokébola do mapa.','{\"id_mapa_no\":521,\"id_pokemon_especie\":53,\"nivel\":61}','2026-11-23 14:44:33'),(83,33,'POKEBOLA_CAPTURADA','Encontro com uma Pokébola do mapa.','{\"id_mapa_no\":521,\"id_pokemon_especie\":53,\"nivel\":61}','2026-11-23 14:44:33'),(84,33,'POKEBOLA_OFERTA','Encontro com uma Pokébola do mapa.','{\"id_mapa_no\":525,\"id_pokemon_especie\":128,\"nivel\":61}','2026-11-23 14:44:34'),(85,33,'POKEBOLA_TROCADA','Encontro com uma Pokébola do mapa.','{\"id_mapa_no\":525,\"id_pokemon_especie\":128,\"nivel\":61,\"id_pokemon_time_substituido\":50,\"id_pokemon_especie_substituido\":53,\"posicao_substituida\":6}','2026-11-23 14:45:31'),(86,33,'ROTA_GERADA',NULL,'{\"id_desafio\":4,\"area\":3}','2026-11-23 14:46:51'),(87,33,'POKEBOLA_OFERTA','Encontro com uma Pokébola do mapa.','{\"id_mapa_no\":532,\"id_pokemon_especie\":148,\"nivel\":65}','2026-11-23 14:47:01'),(88,33,'POKEBOLA_RECUSADA','Encontro com uma Pokébola do mapa.','{\"id_mapa_no\":532,\"id_pokemon_especie\":148,\"nivel\":65}','2026-11-23 14:47:05'),(89,33,'POKEBOLA_OFERTA','Encontro com uma Pokébola do mapa.','{\"id_mapa_no\":536,\"id_pokemon_especie\":90,\"nivel\":65}','2026-11-23 14:47:06'),(90,33,'POKEBOLA_TROCADA','Encontro com uma Pokébola do mapa.','{\"id_mapa_no\":536,\"id_pokemon_especie\":90,\"nivel\":65,\"id_pokemon_time_substituido\":48,\"id_pokemon_especie_substituido\":63,\"posicao_substituida\":4}','2026-11-23 14:47:58'),(91,33,'POKEBOLA_OFERTA','Encontro com uma Pokébola do mapa.','{\"id_mapa_no\":540,\"id_pokemon_especie\":127,\"nivel\":65}','2026-11-23 14:48:00'),(92,33,'POKEBOLA_RECUSADA','Encontro com uma Pokébola do mapa.','{\"id_mapa_no\":540,\"id_pokemon_especie\":127,\"nivel\":65}','2026-11-23 14:48:05'),(93,33,'ROTA_GERADA',NULL,'{\"id_desafio\":5,\"area\":1}','2026-11-23 14:52:42'),(94,33,'POKEBOLA_OFERTA','Encontro com uma Pokébola do mapa.','{\"id_mapa_no\":549,\"id_pokemon_especie\":59,\"nivel\":69}','2026-11-23 14:55:32'),(95,33,'POKEBOLA_TROCADA','Encontro com uma Pokébola do mapa.','{\"id_mapa_no\":549,\"id_pokemon_especie\":59,\"nivel\":69,\"id_pokemon_time_substituido\":47,\"id_pokemon_especie_substituido\":66,\"posicao_substituida\":3}','2026-11-23 14:55:36'),(96,33,'ROTA_GERADA',NULL,'{\"id_desafio\":6,\"area\":2}','2026-11-23 14:59:46'),(97,33,'POKEBOLA_OFERTA','Encontro com uma Pokébola do mapa.','{\"id_mapa_no\":567,\"id_pokemon_especie\":140,\"nivel\":78}','2026-11-23 15:00:26'),(98,33,'POKEBOLA_TROCADA','Encontro com uma Pokébola do mapa.','{\"id_mapa_no\":567,\"id_pokemon_especie\":140,\"nivel\":78,\"id_pokemon_time_substituido\":53,\"id_pokemon_especie_substituido\":59,\"posicao_substituida\":4}','2026-11-23 15:00:31'),(130,42,'CRIACAO','Nova jornada criada.',NULL,'2026-11-24 13:33:29'),(131,42,'INICIAL_ESCOLHIDO','Pokémon inicial escolhido.','{\"pokemon\":\"tepig\"}','2026-11-24 13:33:31'),(132,42,'ROTA_GERADA',NULL,'{\"id_desafio\":1,\"area\":1}','2026-11-24 13:33:31');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pokemon_time`
--

LOCK TABLES `pokemon_time` WRITE;
/*!40000 ALTER TABLE `pokemon_time` DISABLE KEYS */;
INSERT INTO `pokemon_time` VALUES (39,33,18,NULL,NULL,71,187,187,111,139,111,139,165,'normal',5,28),(46,33,103,NULL,NULL,83,192,0,179,104,204,104,179,'normal',1,29),(49,33,73,NULL,NULL,83,292,292,190,112,137,129,134,'normal',4,28),(51,33,129,NULL,NULL,83,209,209,132,104,166,104,184,'normal',6,29),(52,33,91,NULL,NULL,83,189,143,162,245,88,179,54,'normal',2,28),(54,33,142,NULL,NULL,83,192,192,96,154,245,154,137,'normal',3,29),(67,42,19,NULL,NULL,5,21,21,11,9,9,9,9,'normal',1,28);
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
INSERT INTO `progresso_desafio` VALUES (33,1,1,'2026-11-23 14:43:36'),(33,2,1,'2026-11-23 14:44:21'),(33,3,1,'2026-11-23 14:46:45'),(33,4,1,'2026-11-23 14:52:36'),(33,5,1,'2026-11-23 14:59:41'),(33,6,1,'2026-11-23 15:01:53');
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

-- Dump completed on 2026-11-24 13:43:09
