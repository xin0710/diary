/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 80012
Source Host           : localhost:3306
Source Database       : diary

Target Server Type    : MYSQL
Target Server Version : 80012
File Encoding         : 65001

Date: 2023-07-02 20:34:03
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for sys_blog_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_blog_type`;
CREATE TABLE `sys_blog_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(20) DEFAULT NULL,
  `create_date` varchar(20) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_blog_type
-- ----------------------------
INSERT INTO `sys_blog_type` VALUES ('5', null, null, null);
INSERT INTO `sys_blog_type` VALUES ('6', '情感', '2023-06-08 14:54:33', '3');
INSERT INTO `sys_blog_type` VALUES ('7', '工作', '2023-06-11 14:33:03', '3');
INSERT INTO `sys_blog_type` VALUES ('8', '支出', '2023-06-11 14:33:17', '3');
INSERT INTO `sys_blog_type` VALUES ('9', '生活', '2023-06-27 22:26:46', '3');
INSERT INTO `sys_blog_type` VALUES ('10', '旅游', '2023-06-28 12:00:32', '3');
INSERT INTO `sys_blog_type` VALUES ('11', '学习', '2023-06-29 14:20:15', '3');
INSERT INTO `sys_blog_type` VALUES ('12', '游玩', '2023-06-29 15:13:57', '3');

-- ----------------------------
-- Table structure for tbl_syn_blog
-- ----------------------------
DROP TABLE IF EXISTS `tbl_syn_blog`;
CREATE TABLE `tbl_syn_blog` (
  `id` int(11) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL COMMENT '用户ID',
  `blog_type` int(11) DEFAULT NULL COMMENT '类型',
  `content` text COMMENT '内容',
  `is_delete` varchar(1) DEFAULT '0',
  `create_date` varchar(20) DEFAULT NULL,
  `update_date` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_syn_blog
-- ----------------------------
INSERT INTO `tbl_syn_blog` VALUES ('0', '『2023年6月8日 星期四』', '2', null, '<p>11111<b>​</b></p>', '0', '2023-06-08 14:13:27', '2023-06-08 14:13:27');
INSERT INTO `tbl_syn_blog` VALUES ('1', '『2023年6月11日 星期日』', '3', '8', '<p>今天吃了海底捞，花了300块钱。</p>', '1', '2023-06-11 14:33:40', '2023-06-11 14:33:40');
INSERT INTO `tbl_syn_blog` VALUES ('2', '端午节旅游', '3', '10', '<p>这个端午假期，终于和朋友一起去旅游了。</p>', '0', '2023-06-28 12:02:11', '2023-06-28 12:02:11');
INSERT INTO `tbl_syn_blog` VALUES ('3', '一起去吃海底捞', '3', '8', '<p>今天和朋友去吃了海底捞，花了200块钱。</p>', '0', '2023-06-28 12:03:19', '2023-06-28 12:03:19');
INSERT INTO `tbl_syn_blog` VALUES ('4', '工作真的累', '3', '7', '<p>今天加班2小时，很累</p>', '0', '2023-06-29 14:12:21', '2023-06-29 14:12:21');
INSERT INTO `tbl_syn_blog` VALUES ('5', '公园的闲暇时光', '3', '9', '<p>今天天气很不错，去公园散步。</p>', '0', '2023-06-29 14:12:50', '2023-06-29 14:14:35');
INSERT INTO `tbl_syn_blog` VALUES ('6', '雨伞丢在了外面吃饭的店', '3', '6', '<p>今天伞弄丢了，心情很糟糕</p>', '0', '2023-06-29 14:14:02', '2023-06-29 14:15:07');
INSERT INTO `tbl_syn_blog` VALUES ('10', '去吃了烤肉', '3', '8', '<p style=\"text-align: center;\"><span style=\"background-color: rgb(249, 150, 59);\"><font color=\"#4d80bf\">今天又和朋友聚餐，去吃了烤肉，花了1</font></span></p>', '0', '2023-06-29 14:18:48', '2023-06-29 15:13:24');
INSERT INTO `tbl_syn_blog` VALUES ('11', '『2023年6月29日 星期四』', '3', '9', '<p>111</p>', '0', '2023-06-29 14:19:56', '2023-06-29 14:19:56');
INSERT INTO `tbl_syn_blog` VALUES ('12', '『2023年6月29日 星期四』', '3', '11', '<p>123456789</p>', '0', '2023-06-29 14:27:17', '2023-06-29 14:28:07');
INSERT INTO `tbl_syn_blog` VALUES ('13', '『2023年6月29日 星期四』', '3', '9', '<p>55555555555</p>', '0', '2023-06-29 14:27:23', '2023-06-29 14:27:55');
INSERT INTO `tbl_syn_blog` VALUES ('14', '『2023年6月29日 星期四』', '3', null, '<p>6666666+666</p>', '0', '2023-06-29 14:27:29', '2023-06-29 14:27:29');
INSERT INTO `tbl_syn_blog` VALUES ('15', '『2023年6月29日 星期四』', '3', '10', '<p>777777777777</p>', '0', '2023-06-29 14:27:35', '2023-06-29 14:28:20');
INSERT INTO `tbl_syn_blog` VALUES ('16', '『2023年6月29日 星期四』', '3', '9', '<p>8888888888</p>', '0', '2023-06-29 14:27:48', '2023-06-29 14:27:48');
INSERT INTO `tbl_syn_blog` VALUES ('17', 'jtxqw', '3', '6', '<p>8998988988</p>', '0', '2023-06-29 15:13:10', '2023-06-29 15:13:10');
INSERT INTO `tbl_syn_blog` VALUES ('18', '『2023年7月2日 星期日』', '3', '7', '<p>今天工作是真的很累，受不了了</p>', '0', '2023-07-02 19:37:46', '2023-07-02 19:37:46');

-- ----------------------------
-- Table structure for user_base
-- ----------------------------
DROP TABLE IF EXISTS `user_base`;
CREATE TABLE `user_base` (
  `uid` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_role` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `register_source` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '注册来源：1手机号 2邮箱 3用户名 4qq 5微信 6腾讯微博 7新浪微博',
  `user_name` varchar(32) NOT NULL DEFAULT '' COMMENT '用户账号，必须唯一',
  `password` varchar(64) NOT NULL DEFAULT '' COMMENT '密码',
  `nick_name` varchar(32) NOT NULL DEFAULT '' COMMENT '用户昵称',
  `gender` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '用户性别 0-female 1-male',
  `birthday` varchar(20) NOT NULL DEFAULT '0' COMMENT '用户生日',
  `signature` varchar(255) NOT NULL DEFAULT '' COMMENT '用户个人签名',
  `mobile` varchar(16) NOT NULL DEFAULT '' COMMENT '手机号码(唯一)',
  `mobile_bind_time` varchar(20) NOT NULL DEFAULT '0' COMMENT '手机号码绑定时间',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT '邮箱(唯一)',
  `email_bind_time` varchar(20) NOT NULL DEFAULT '0' COMMENT '邮箱绑定时间',
  `face` varchar(255) NOT NULL DEFAULT '' COMMENT '头像',
  `face200` varchar(255) NOT NULL DEFAULT '' COMMENT '头像 200x200x80',
  `srcface` varchar(255) NOT NULL DEFAULT '' COMMENT '原图头像',
  `create_time` varchar(20) NOT NULL COMMENT '创建时间',
  `update_time` varchar(20) NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='用户基础信息表';

-- ----------------------------
-- Records of user_base
-- ----------------------------
INSERT INTO `user_base` VALUES ('1', '1', '0', '2', '2', '', '0', '0', '', '', '0', '', '0', '', '', '', '312312', '123123');
INSERT INTO `user_base` VALUES ('2', '1', '0', 'cc', '4d726e341b256ba0afd2db33c3df997b', '', '0', '0', '', '', '0', '', '0', '', '', '', '2023-05-29 14:21:37', '2023-05-29 14:21:37');
INSERT INTO `user_base` VALUES ('3', '1', '0', 'ss', 'bb1c1cdf039f2bb560fbd6fdfaa086a7', '别来无恙@', '0', '2002-07-10', '待会记些什么好呢？记录一下生活吧', '', '0', '', '0', '/3/1688022855288.png', '', '', '2023-06-08 14:29:29', '2023-06-29 15:14:16');
