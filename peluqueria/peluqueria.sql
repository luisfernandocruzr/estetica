/*
 Navicat Premium Data Transfer

 Source Server         : loquesea
 Source Server Type    : MySQL
 Source Server Version : 50733
 Source Host           : localhost:3306
 Source Schema         : peluqueria

 Target Server Type    : MySQL
 Target Server Version : 50733
 File Encoding         : 65001

 Date: 15/06/2023 15:11:50
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for citas
-- ----------------------------
DROP TABLE IF EXISTS `citas`;
CREATE TABLE `citas`  (
  `id_cita` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_cliente` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `fecha_hora_cita` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_servicio` int(11) NULL DEFAULT NULL,
  `precio_cita` float NULL DEFAULT NULL,
  PRIMARY KEY (`id_cita`) USING BTREE,
  INDEX `id_servicio`(`id_servicio`) USING BTREE,
  CONSTRAINT `id_servicio` FOREIGN KEY (`id_servicio`) REFERENCES `servicio` (`id_servicio`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of citas
-- ----------------------------
INSERT INTO `citas` VALUES (1, 'Luis', '2023-06-16 13:18:54', 3, 100);
INSERT INTO `citas` VALUES (2, 'Brandon', '2023-06-16 13:18:54', 3, 100);
INSERT INTO `citas` VALUES (3, 'Carlos', '2023-06-16 13:18:54', 5, 50);
INSERT INTO `citas` VALUES (5, 'Alejandra', '2023-06-16 13:18:54', 2, 200);
INSERT INTO `citas` VALUES (6, 'Gustavo', '2023-06-16 13:18:54', 5, 50);
INSERT INTO `citas` VALUES (7, 'Juan', '2023-06-16 13:18:54', 5, 50);
INSERT INTO `citas` VALUES (22, 'Veronica', '2023-06-16 13:18:54', 4, 100);
INSERT INTO `citas` VALUES (23, 'Fer', '2023-06-16 13:18:54', 3, 100);
INSERT INTO `citas` VALUES (25, NULL, NULL, NULL, NULL);
INSERT INTO `citas` VALUES (26, NULL, NULL, NULL, NULL);
INSERT INTO `citas` VALUES (27, NULL, NULL, NULL, NULL);
INSERT INTO `citas` VALUES (28, NULL, NULL, NULL, NULL);
INSERT INTO `citas` VALUES (29, NULL, NULL, NULL, NULL);
INSERT INTO `citas` VALUES (30, NULL, NULL, NULL, NULL);
INSERT INTO `citas` VALUES (31, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for servicio
-- ----------------------------
DROP TABLE IF EXISTS `servicio`;
CREATE TABLE `servicio`  (
  `id_servicio` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_servicio` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_servicio`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of servicio
-- ----------------------------
INSERT INTO `servicio` VALUES (1, 'Uñas');
INSERT INTO `servicio` VALUES (2, 'Peinados');
INSERT INTO `servicio` VALUES (3, 'Barba');
INSERT INTO `servicio` VALUES (4, 'Pestañas');
INSERT INTO `servicio` VALUES (5, 'Corte de cabello');

-- ----------------------------
-- Procedure structure for ver_cita
-- ----------------------------
DROP PROCEDURE IF EXISTS `ver_cita`;
delimiter ;;
CREATE PROCEDURE `ver_cita`()
BEGIN
SELECT
	citas.id_cita, 
	citas.nombre_cliente, 
	citas.fecha_hora_cita, 
	citas.precio_cita, 
	servicio.nombre_servicio
FROM
	citas
	INNER JOIN
	servicio
	ON 
		citas.id_servicio = servicio.id_servicio;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
