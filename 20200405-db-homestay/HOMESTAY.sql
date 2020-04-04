/*
Navicat MySQL Data Transfer

Source Server         : test
Source Server Version : 50540
Source Host           : localhost:3306
Source Database       : homestay

Target Server Type    : MYSQL
Target Server Version : 50540
File Encoding         : 65001

Date: 2020-04-05 01:29:02
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `ADMIN_ID` int(11) NOT NULL COMMENT '管理员编号',
  `ADMIN_USERNAME` varchar(32) DEFAULT NULL COMMENT '用户名',
  `ADMIN_PASSWORD` varchar(32) DEFAULT NULL COMMENT '密码',
  `ADMIN_NAME` varchar(32) DEFAULT NULL COMMENT '姓名',
  `ADMIN_PHONE` varchar(32) DEFAULT NULL COMMENT '手机号码',
  `REVISION` int(11) DEFAULT NULL COMMENT '乐观锁',
  `CREATED_BY` varchar(32) DEFAULT NULL COMMENT '创建人',
  `CREATED_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATED_BY` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATED_TIME` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ADMIN_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员表';

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', 'admin', '123456', '阿东', '3251310', null, null, '2020-04-04 16:17:15', '', '2020-04-04 16:17:22');

-- ----------------------------
-- Table structure for booking
-- ----------------------------
DROP TABLE IF EXISTS `booking`;
CREATE TABLE `booking` (
  `BOOKING_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单编号',
  `GUEST_ID` int(11) DEFAULT NULL COMMENT '客户编号',
  `ROOM_ID` int(11) DEFAULT NULL COMMENT '房间编号',
  `CHECKIN_DATE` date DEFAULT NULL COMMENT '入住日期',
  `CHECKOUT_DATE` date DEFAULT NULL COMMENT '离店日期',
  `BOOKING_TIME` datetime DEFAULT NULL COMMENT '预定时间',
  `BOOKING_STATUS` varchar(32) DEFAULT NULL COMMENT '订单状态 0待支付，表订单已生成，但用户未支付//\n1已付款，表明订单已经支付\n2已完成 ，表明订单已进行入住，在生成入住表的同时，因为入住的同时肯定先要完成支付，所有不存在支付和完成冲突，完成即已支付，修改为\n3已取消，表明该订未入住。',
  `BOOKING_NOTE` varchar(512) DEFAULT NULL COMMENT '备注',
  `IF_COMMENT` varchar(1) DEFAULT NULL COMMENT '是否已评论',
  PRIMARY KEY (`BOOKING_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='预订表';

-- ----------------------------
-- Records of booking
-- ----------------------------
INSERT INTO `booking` VALUES ('1', '1', '1101', '2020-04-06', '2020-04-08', '2020-04-04 16:18:18', '1', '带有一个1岁婴儿，麻烦安排比较方便的房间和床位', null);
INSERT INTO `booking` VALUES ('2', '1', '1101', '2020-04-20', '2020-04-22', '2020-04-04 16:24:11', '0', null, null);

-- ----------------------------
-- Table structure for booking_detatil
-- ----------------------------
DROP TABLE IF EXISTS `booking_detatil`;
CREATE TABLE `booking_detatil` (
  `BOOKING_ID` int(11) NOT NULL COMMENT '预订详情编号',
  `ISPAY` varchar(32) DEFAULT NULL COMMENT '是否付款',
  `ISCHECK` varchar(32) DEFAULT NULL COMMENT '是否入住',
  `PAY_TYPE` varchar(32) DEFAULT NULL COMMENT '付款方式 付款类型：1.现金，2：支付宝，3微信。。',
  `PAY_AMOUNT` decimal(32,2) DEFAULT NULL COMMENT '付款金额',
  `PAY_TIME` datetime DEFAULT NULL COMMENT '付款时间',
  PRIMARY KEY (`BOOKING_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='预订支付表';

-- ----------------------------
-- Records of booking_detatil
-- ----------------------------
INSERT INTO `booking_detatil` VALUES ('1', 'Y', 'N', '2', '150.00', '2020-04-04 16:22:25');
INSERT INTO `booking_detatil` VALUES ('2', 'N', 'N', null, null, null);

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `COMMENT_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '评论编号',
  `BOOKING_ID` varchar(32) DEFAULT NULL COMMENT '订单编号',
  `COMMENT_USERID` int(11) DEFAULT NULL COMMENT '评论人编号',
  `COMMENT_USERNAME` varchar(32) DEFAULT NULL COMMENT '评论人姓名',
  `COMMENT_PARENT_ID` int(11) DEFAULT NULL COMMENT '父级评论编号',
  `COMMENT_CONTENT` varchar(32) DEFAULT NULL COMMENT '评论内容',
  `IF_Merchant` varchar(32) DEFAULT NULL COMMENT '是否商家回复',
  `CREATED_TIME` datetime DEFAULT NULL COMMENT '发表时间',
  `UPDATED_BY` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATED_TIME` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`COMMENT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='评论表 ';

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES ('1', '1', '1', 'hyy', null, 'sfgsdfg', 'N', '2020-04-04 23:45:40', null, null);
INSERT INTO `comment` VALUES ('2', '1', '1', 'admin', '1', 'sdfg', 'Y', '2020-04-04 23:46:51', null, null);

-- ----------------------------
-- Table structure for grade
-- ----------------------------
DROP TABLE IF EXISTS `grade`;
CREATE TABLE `grade` (
  `GRADE_ID` int(11) DEFAULT NULL COMMENT '等级编号',
  `GRADE_NAME` varchar(32) DEFAULT NULL COMMENT '等级名称',
  `DISCOUNT` decimal(32,10) DEFAULT NULL COMMENT '优惠折扣',
  `CREATED_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATED_TIME` datetime DEFAULT NULL COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='等级';

-- ----------------------------
-- Records of grade
-- ----------------------------

-- ----------------------------
-- Table structure for guest
-- ----------------------------
DROP TABLE IF EXISTS `guest`;
CREATE TABLE `guest` (
  `GUEST_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '客户编号',
  `GUEST_PHONE` varchar(32) DEFAULT NULL COMMENT '手机号码',
  `GUEST_NAME` varchar(32) NOT NULL COMMENT '姓名',
  `GUEST_SEX` char(1) DEFAULT NULL COMMENT '性别',
  `GUEST_IDCARD` varchar(32) DEFAULT NULL COMMENT '身份证号码',
  `GUEST_USERNAME` varchar(32) DEFAULT NULL COMMENT '昵称',
  `GUEST_PASSWORD` varchar(32) DEFAULT NULL COMMENT '密码',
  `GUEST_GRADE` int(11) DEFAULT NULL COMMENT '客户等级',
  `GUEST_CHECKINTIMES` int(11) DEFAULT NULL COMMENT '入住次数',
  `GUEST_CONSUMPTION` decimal(32,8) DEFAULT NULL COMMENT '消费总金额',
  `UPDATED_TIME` datetime DEFAULT NULL COMMENT '更新时间',
  `CREATED_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`GUEST_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='客户表';

-- ----------------------------
-- Records of guest
-- ----------------------------
INSERT INTO `guest` VALUES ('1', '137880076675', '黄彦耀', '女', '450603199703160024', 'hyy', '123456', '1', '0', '0.00000000', '2020-04-04 16:12:18', '2020-04-04 16:12:25');
INSERT INTO `guest` VALUES ('2', '18877606561', '黄彦耀', '男', '45282219412210020', null, null, null, null, null, null, null);
INSERT INTO `guest` VALUES ('3', null, '黄彦耀', null, null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for guest_checkin
-- ----------------------------
DROP TABLE IF EXISTS `guest_checkin`;
CREATE TABLE `guest_checkin` (
  `CHRCKIN_ID` int(11) DEFAULT NULL COMMENT '入住单编号',
  `GUEST_ID` int(11) DEFAULT NULL COMMENT '客户编号',
  `CREATED_TIME` datetime DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户入住详情';

-- ----------------------------
-- Records of guest_checkin
-- ----------------------------
INSERT INTO `guest_checkin` VALUES ('1', '1', '2020-04-04 16:40:41');
INSERT INTO `guest_checkin` VALUES ('1', '3', '2020-04-04 16:40:44');

-- ----------------------------
-- Table structure for homestay
-- ----------------------------
DROP TABLE IF EXISTS `homestay`;
CREATE TABLE `homestay` (
  `NAME` varchar(32) DEFAULT NULL COMMENT '民宿名称',
  `PRINCIPAL` varchar(32) DEFAULT NULL COMMENT '民宿负责人',
  `PHONE` varchar(32) DEFAULT NULL COMMENT '联系方式',
  `ADDRESS` varchar(32) DEFAULT NULL COMMENT '民宿地址',
  `Description` varchar(32) DEFAULT NULL COMMENT '民宿介绍',
  `COMMEN_ID` varchar(32) DEFAULT NULL COMMENT '评价表单id',
  `hasWifi` varchar(1) DEFAULT NULL COMMENT '是否有wifi',
  `hasParking` varchar(1) DEFAULT NULL COMMENT '可否停车',
  `hasPackage` varchar(1) DEFAULT NULL COMMENT '可否寄存行李',
  `startTime` datetime DEFAULT NULL COMMENT '开业时间',
  `decorateTime` datetime DEFAULT NULL COMMENT '装修时间',
  `image1` varchar(128) DEFAULT NULL COMMENT '民宿图片1',
  `image2` varchar(128) DEFAULT NULL COMMENT '民宿图片2',
  `image3` varchar(128) DEFAULT NULL COMMENT '民宿图片3',
  `untitled7` varchar(32) DEFAULT NULL COMMENT '状态'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='民宿信息表';

-- ----------------------------
-- Records of homestay
-- ----------------------------

-- ----------------------------
-- Table structure for order_detatil
-- ----------------------------
DROP TABLE IF EXISTS `order_detatil`;
CREATE TABLE `order_detatil` (
  `ACCOUNT_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '账单编号',
  `BOOKING_ID` int(11) DEFAULT NULL COMMENT '订单编号',
  `TOTLE_PRICE` decimal(32,8) DEFAULT NULL COMMENT '应收金额',
  `HAS_PRICE` decimal(32,8) DEFAULT NULL COMMENT '实收金额',
  `DISCOUNTED_PRICE` decimal(32,8) DEFAULT NULL COMMENT '优惠金额',
  `STUTAS` varchar(32) DEFAULT NULL COMMENT '状态',
  `CREATED_BY` varchar(32) DEFAULT NULL COMMENT '创建人',
  `CREATED_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATED_BY` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATED_TIME` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ACCOUNT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='账单明细表';

-- ----------------------------
-- Records of order_detatil
-- ----------------------------

-- ----------------------------
-- Table structure for room
-- ----------------------------
DROP TABLE IF EXISTS `room`;
CREATE TABLE `room` (
  `ROOM_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '房间编号',
  `ROOM_NAME` varchar(32) DEFAULT NULL COMMENT '房间名称',
  `ROOM_DESCRIPTION` varchar(32) DEFAULT NULL COMMENT '房间描述',
  `ROOM_PERSON` int(11) DEFAULT NULL COMMENT '可住人数',
  `ROOM_PRICE` decimal(32,2) DEFAULT NULL COMMENT '房间价格',
  `ROOM_IMGE` varchar(32) DEFAULT NULL COMMENT '图片',
  `ROOM_STATUS` varchar(1) DEFAULT NULL COMMENT '是否可用',
  PRIMARY KEY (`ROOM_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='房间表';

-- ----------------------------
-- Records of room
-- ----------------------------
INSERT INTO `room` VALUES ('1', '1101', '房间有wifi,空调，环境舒适', '2', '150.00', null, 'Y');
INSERT INTO `room` VALUES ('2', '1102', '房间真正装修', '3', '200.00', null, 'N');

-- ----------------------------
-- Table structure for roomuse
-- ----------------------------
DROP TABLE IF EXISTS `roomuse`;
CREATE TABLE `roomuse` (
  `ROOM_ID` int(11) DEFAULT NULL COMMENT '房间编号',
  `ROOMUSE_DATE` date DEFAULT NULL COMMENT '使用日期',
  `ROOMUSE_STATUS` varchar(32) DEFAULT NULL COMMENT '使用状态 0 入住\n1 预订\n3 锁定',
  `REVISION` int(11) DEFAULT NULL COMMENT '乐观锁',
  `CREATED_BY` varchar(32) DEFAULT NULL COMMENT '创建人',
  `CREATED_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATED_BY` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATED_TIME` datetime DEFAULT NULL COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='房间使用';

-- ----------------------------
-- Records of roomuse
-- ----------------------------
INSERT INTO `roomuse` VALUES ('1101', '2020-04-06', '1', null, null, null, null, null);
INSERT INTO `roomuse` VALUES ('1101', '2020-04-07', '1', null, null, null, null, null);

-- ----------------------------
-- Table structure for room_checkin
-- ----------------------------
DROP TABLE IF EXISTS `room_checkin`;
CREATE TABLE `room_checkin` (
  `CHRCKIN_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '入住单编号',
  `BOOKING_ID` int(11) DEFAULT NULL COMMENT '订单编号',
  `ROOM_ID` int(11) DEFAULT NULL COMMENT '房间编号',
  `CHRCKIN_TIME` datetime DEFAULT NULL COMMENT '入住时间',
  `CHRCKOUT_TIME` datetime DEFAULT NULL COMMENT '离店时间',
  `COMSUMPTION` decimal(32,8) DEFAULT NULL COMMENT '订单总额',
  `AMOUNT_RECEIVED` decimal(32,8) DEFAULT NULL COMMENT '已收金额',
  `STATUS` varchar(32) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`CHRCKIN_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='入住表';

-- ----------------------------
-- Records of room_checkin
-- ----------------------------
INSERT INTO `room_checkin` VALUES ('1', '1', '1101', '2020-04-04 16:37:45', null, '150.00000000', '150.00000000', '1');
