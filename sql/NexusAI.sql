/*
 Navicat Premium Dump SQL


 Source Server Type    : PostgreSQL
 Source Server Version : 160002 (160002)

 Source Catalog        : zang
 Source Schema         : NexusAI

 Target Server Type    : PostgreSQL
 Target Server Version : 160002 (160002)
 File Encoding         : 65001

 Date: 02/07/2024 15:24:56
*/


-- ----------------------------
-- Sequence structure for conversations_conversation_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "NexusAI"."conversations_conversation_id_seq";
CREATE SEQUENCE "NexusAI"."conversations_conversation_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "NexusAI"."conversations_conversation_id_seq" OWNER TO "zang";

-- ----------------------------
-- Sequence structure for messages_message_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "NexusAI"."messages_message_id_seq";
CREATE SEQUENCE "NexusAI"."messages_message_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "NexusAI"."messages_message_id_seq" OWNER TO "zang";

-- ----------------------------
-- Sequence structure for usage_stats_stat_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "NexusAI"."usage_stats_stat_id_seq";
CREATE SEQUENCE "NexusAI"."usage_stats_stat_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "NexusAI"."usage_stats_stat_id_seq" OWNER TO "zang";

-- ----------------------------
-- Table structure for chat_conversations
-- ----------------------------
DROP TABLE IF EXISTS "NexusAI"."chat_conversations";
CREATE TABLE "NexusAI"."chat_conversations" (
  "conversation_id" int4 NOT NULL DEFAULT nextval('"NexusAI".conversations_conversation_id_seq'::regclass),
  "user_id" int4 NOT NULL,
  "title" varchar(255) COLLATE "pg_catalog"."default",
  "create_time" date,
  "update_time" date,
  "gmt_deleted" date DEFAULT '2001-01-01'::date,
  "create_by" int4,
  "update_by" int4
)
;
ALTER TABLE "NexusAI"."chat_conversations" OWNER TO "zang";
COMMENT ON COLUMN "NexusAI"."chat_conversations"."conversation_id" IS '对话ID，主键';
COMMENT ON COLUMN "NexusAI"."chat_conversations"."user_id" IS '用户ID，关联sys_user表';
COMMENT ON COLUMN "NexusAI"."chat_conversations"."title" IS '对话标题';
COMMENT ON COLUMN "NexusAI"."chat_conversations"."create_time" IS '创建时间';
COMMENT ON COLUMN "NexusAI"."chat_conversations"."update_time" IS '更新时间';
COMMENT ON TABLE "NexusAI"."chat_conversations" IS '用户对话会话表';

-- ----------------------------
-- Records of chat_conversations
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for chat_messages
-- ----------------------------
DROP TABLE IF EXISTS "NexusAI"."chat_messages";
CREATE TABLE "NexusAI"."chat_messages" (
  "message_id" int4 NOT NULL DEFAULT nextval('"NexusAI".messages_message_id_seq'::regclass),
  "user_id" int4 NOT NULL,
  "content" text COLLATE "pg_catalog"."default" NOT NULL,
  "role" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "model" varchar(50) COLLATE "pg_catalog"."default",
  "response_time" float8,
  "tokens_used" int4,
  "conversation_id" int4 NOT NULL,
  "gmt_deleted" date DEFAULT '2001-01-01'::date,
  "create_time" date,
  "update_time" date
)
;
ALTER TABLE "NexusAI"."chat_messages" OWNER TO "zang";
COMMENT ON COLUMN "NexusAI"."chat_messages"."message_id" IS '对话ID，主键';
COMMENT ON COLUMN "NexusAI"."chat_messages"."user_id" IS '用户ID，关联sys_user表';
COMMENT ON COLUMN "NexusAI"."chat_messages"."content" IS '消息内容';
COMMENT ON COLUMN "NexusAI"."chat_messages"."role" IS '消息角色，user或assistant';
COMMENT ON COLUMN "NexusAI"."chat_messages"."model" IS '使用的AI模型名称';
COMMENT ON COLUMN "NexusAI"."chat_messages"."response_time" IS 'AI响应时间，单位秒';
COMMENT ON COLUMN "NexusAI"."chat_messages"."tokens_used" IS '消耗的token数量';
COMMENT ON TABLE "NexusAI"."chat_messages" IS '对话消息表';

-- ----------------------------
-- Records of chat_messages
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for chat_usage_stats
-- ----------------------------
DROP TABLE IF EXISTS "NexusAI"."chat_usage_stats";
CREATE TABLE "NexusAI"."chat_usage_stats" (
  "stat_id" int4 NOT NULL DEFAULT nextval('"NexusAI".usage_stats_stat_id_seq'::regclass),
  "user_id" int4 NOT NULL,
  "date" date NOT NULL,
  "model" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "total_conversations" int4 DEFAULT 0,
  "total_messages" int4 DEFAULT 0,
  "total_tokens" int4 DEFAULT 0,
  "total_response_time" float8 DEFAULT 0,
  "gmt_deleted" date DEFAULT '2001-01-01'::date,
  "create_time" date,
  "update_time" date
)
;
ALTER TABLE "NexusAI"."chat_usage_stats" OWNER TO "zang";
COMMENT ON COLUMN "NexusAI"."chat_usage_stats"."stat_id" IS '统计ID，主键';
COMMENT ON COLUMN "NexusAI"."chat_usage_stats"."user_id" IS '用户ID，关联sys_user表';
COMMENT ON COLUMN "NexusAI"."chat_usage_stats"."date" IS '统计日期';
COMMENT ON COLUMN "NexusAI"."chat_usage_stats"."model" IS '使用的AI模型名称';
COMMENT ON COLUMN "NexusAI"."chat_usage_stats"."total_conversations" IS '当日该模型总对话数';
COMMENT ON COLUMN "NexusAI"."chat_usage_stats"."total_messages" IS '当日该模型总消息数';
COMMENT ON COLUMN "NexusAI"."chat_usage_stats"."total_tokens" IS '当日该模型总消耗token数';
COMMENT ON COLUMN "NexusAI"."chat_usage_stats"."total_response_time" IS '当日该模型总响应时间，单位秒';
COMMENT ON TABLE "NexusAI"."chat_usage_stats" IS '用户使用统计表';

-- ----------------------------
-- Records of chat_usage_stats
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS "NexusAI"."gen_table";
CREATE TABLE "NexusAI"."gen_table" (
  "table_id" int8 NOT NULL,
  "data_name" varchar(200) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "table_name" varchar(200) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "table_comment" varchar(500) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "sub_table_name" varchar(64) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "sub_table_fk_name" varchar(64) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "class_name" varchar(100) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "tpl_category" varchar(200) COLLATE "pg_catalog"."default" DEFAULT 'crud'::character varying,
  "package_name" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "module_name" varchar(30) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "business_name" varchar(30) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "function_name" varchar(50) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "function_author" varchar(50) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "gen_type" char(1) COLLATE "pg_catalog"."default" NOT NULL DEFAULT '0'::bpchar,
  "gen_path" varchar(200) COLLATE "pg_catalog"."default" DEFAULT '/'::character varying,
  "options" varchar(1000) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying
)
;
ALTER TABLE "NexusAI"."gen_table" OWNER TO "zang";
COMMENT ON COLUMN "NexusAI"."gen_table"."table_id" IS '编号';
COMMENT ON COLUMN "NexusAI"."gen_table"."data_name" IS '数据源名称';
COMMENT ON COLUMN "NexusAI"."gen_table"."table_name" IS '表名称';
COMMENT ON COLUMN "NexusAI"."gen_table"."table_comment" IS '表描述';
COMMENT ON COLUMN "NexusAI"."gen_table"."sub_table_name" IS '关联子表的表名';
COMMENT ON COLUMN "NexusAI"."gen_table"."sub_table_fk_name" IS '子表关联的外键名';
COMMENT ON COLUMN "NexusAI"."gen_table"."class_name" IS '实体类名称';
COMMENT ON COLUMN "NexusAI"."gen_table"."tpl_category" IS '使用的模板（CRUD单表操作 TREE树表操作）';
COMMENT ON COLUMN "NexusAI"."gen_table"."package_name" IS '生成包路径';
COMMENT ON COLUMN "NexusAI"."gen_table"."module_name" IS '生成模块名';
COMMENT ON COLUMN "NexusAI"."gen_table"."business_name" IS '生成业务名';
COMMENT ON COLUMN "NexusAI"."gen_table"."function_name" IS '生成功能名';
COMMENT ON COLUMN "NexusAI"."gen_table"."function_author" IS '生成功能作者';
COMMENT ON COLUMN "NexusAI"."gen_table"."gen_type" IS '生成代码方式（0zip压缩包 1自定义路径）';
COMMENT ON COLUMN "NexusAI"."gen_table"."gen_path" IS '生成路径（不填默认项目路径）';
COMMENT ON COLUMN "NexusAI"."gen_table"."options" IS '其它生成选项';
COMMENT ON COLUMN "NexusAI"."gen_table"."create_dept" IS '创建部门';
COMMENT ON COLUMN "NexusAI"."gen_table"."create_by" IS '创建者';
COMMENT ON COLUMN "NexusAI"."gen_table"."create_time" IS '创建时间';
COMMENT ON COLUMN "NexusAI"."gen_table"."update_by" IS '更新者';
COMMENT ON COLUMN "NexusAI"."gen_table"."update_time" IS '更新时间';
COMMENT ON COLUMN "NexusAI"."gen_table"."remark" IS '备注';
COMMENT ON TABLE "NexusAI"."gen_table" IS '代码生成业务表';

-- ----------------------------
-- Records of gen_table
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS "NexusAI"."gen_table_column";
CREATE TABLE "NexusAI"."gen_table_column" (
  "column_id" int8 NOT NULL,
  "table_id" int8,
  "column_name" varchar(200) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "column_comment" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "column_type" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "java_type" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "java_field" varchar(200) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "is_pk" char(1) COLLATE "pg_catalog"."default" DEFAULT NULL::bpchar,
  "is_increment" char(1) COLLATE "pg_catalog"."default" DEFAULT NULL::bpchar,
  "is_required" char(1) COLLATE "pg_catalog"."default" DEFAULT NULL::bpchar,
  "is_insert" char(1) COLLATE "pg_catalog"."default" DEFAULT NULL::bpchar,
  "is_edit" char(1) COLLATE "pg_catalog"."default" DEFAULT NULL::bpchar,
  "is_list" char(1) COLLATE "pg_catalog"."default" DEFAULT NULL::bpchar,
  "is_query" char(1) COLLATE "pg_catalog"."default" DEFAULT NULL::bpchar,
  "query_type" varchar(200) COLLATE "pg_catalog"."default" DEFAULT 'EQ'::character varying,
  "html_type" varchar(200) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "dict_type" varchar(200) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "sort" int4,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6)
)
;
ALTER TABLE "NexusAI"."gen_table_column" OWNER TO "zang";
COMMENT ON COLUMN "NexusAI"."gen_table_column"."column_id" IS '编号';
COMMENT ON COLUMN "NexusAI"."gen_table_column"."table_id" IS '归属表编号';
COMMENT ON COLUMN "NexusAI"."gen_table_column"."column_name" IS '列名称';
COMMENT ON COLUMN "NexusAI"."gen_table_column"."column_comment" IS '列描述';
COMMENT ON COLUMN "NexusAI"."gen_table_column"."column_type" IS '列类型';
COMMENT ON COLUMN "NexusAI"."gen_table_column"."java_type" IS 'JAVA类型';
COMMENT ON COLUMN "NexusAI"."gen_table_column"."java_field" IS 'JAVA字段名';
COMMENT ON COLUMN "NexusAI"."gen_table_column"."is_pk" IS '是否主键（1是）';
COMMENT ON COLUMN "NexusAI"."gen_table_column"."is_increment" IS '是否自增（1是）';
COMMENT ON COLUMN "NexusAI"."gen_table_column"."is_required" IS '是否必填（1是）';
COMMENT ON COLUMN "NexusAI"."gen_table_column"."is_insert" IS '是否为插入字段（1是）';
COMMENT ON COLUMN "NexusAI"."gen_table_column"."is_edit" IS '是否编辑字段（1是）';
COMMENT ON COLUMN "NexusAI"."gen_table_column"."is_list" IS '是否列表字段（1是）';
COMMENT ON COLUMN "NexusAI"."gen_table_column"."is_query" IS '是否查询字段（1是）';
COMMENT ON COLUMN "NexusAI"."gen_table_column"."query_type" IS '查询方式（等于、不等于、大于、小于、范围）';
COMMENT ON COLUMN "NexusAI"."gen_table_column"."html_type" IS '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）';
COMMENT ON COLUMN "NexusAI"."gen_table_column"."dict_type" IS '字典类型';
COMMENT ON COLUMN "NexusAI"."gen_table_column"."sort" IS '排序';
COMMENT ON COLUMN "NexusAI"."gen_table_column"."create_dept" IS '创建部门';
COMMENT ON COLUMN "NexusAI"."gen_table_column"."create_by" IS '创建者';
COMMENT ON COLUMN "NexusAI"."gen_table_column"."create_time" IS '创建时间';
COMMENT ON COLUMN "NexusAI"."gen_table_column"."update_by" IS '更新者';
COMMENT ON COLUMN "NexusAI"."gen_table_column"."update_time" IS '更新时间';
COMMENT ON TABLE "NexusAI"."gen_table_column" IS '代码生成业务表字段';

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_client
-- ----------------------------
DROP TABLE IF EXISTS "NexusAI"."sys_client";
CREATE TABLE "NexusAI"."sys_client" (
  "id" int8 NOT NULL,
  "client_id" varchar(64) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "client_key" varchar(32) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "client_secret" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "grant_type" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "device_type" varchar(32) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "active_timeout" int4 DEFAULT 1800,
  "timeout" int4 DEFAULT 604800,
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6)
)
;
ALTER TABLE "NexusAI"."sys_client" OWNER TO "zang";
COMMENT ON COLUMN "NexusAI"."sys_client"."id" IS '主键';
COMMENT ON COLUMN "NexusAI"."sys_client"."client_id" IS '客户端id';
COMMENT ON COLUMN "NexusAI"."sys_client"."client_key" IS '客户端key';
COMMENT ON COLUMN "NexusAI"."sys_client"."client_secret" IS '客户端秘钥';
COMMENT ON COLUMN "NexusAI"."sys_client"."grant_type" IS '授权类型';
COMMENT ON COLUMN "NexusAI"."sys_client"."device_type" IS '设备类型';
COMMENT ON COLUMN "NexusAI"."sys_client"."active_timeout" IS 'token活跃超时时间';
COMMENT ON COLUMN "NexusAI"."sys_client"."timeout" IS 'token固定超时';
COMMENT ON COLUMN "NexusAI"."sys_client"."status" IS '状态（0正常 1停用）';
COMMENT ON COLUMN "NexusAI"."sys_client"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "NexusAI"."sys_client"."create_dept" IS '创建部门';
COMMENT ON COLUMN "NexusAI"."sys_client"."create_by" IS '创建者';
COMMENT ON COLUMN "NexusAI"."sys_client"."create_time" IS '创建时间';
COMMENT ON COLUMN "NexusAI"."sys_client"."update_by" IS '更新者';
COMMENT ON COLUMN "NexusAI"."sys_client"."update_time" IS '更新时间';
COMMENT ON TABLE "NexusAI"."sys_client" IS '系统授权表';

-- ----------------------------
-- Records of sys_client
-- ----------------------------
BEGIN;
INSERT INTO "NexusAI"."sys_client" ("id", "client_id", "client_key", "client_secret", "grant_type", "device_type", "active_timeout", "timeout", "status", "del_flag", "create_dept", "create_by", "create_time", "update_by", "update_time") VALUES (1, 'e5cd7e4891bf95d1d19206ce24a7b32e', 'pc', 'pc123', 'password,social', 'pc', 1800, 604800, '0', '0', 103, 1, '2024-06-26 01:37:54.010394', 1, '2024-06-26 01:37:54.010394');
INSERT INTO "NexusAI"."sys_client" ("id", "client_id", "client_key", "client_secret", "grant_type", "device_type", "active_timeout", "timeout", "status", "del_flag", "create_dept", "create_by", "create_time", "update_by", "update_time") VALUES (2, '428a8310cd442757ae699df5d894f051', 'app', 'app123', 'password,sms,social', 'android', 1800, 604800, '0', '0', 103, 1, '2024-06-26 01:37:54.090233', 1, '2024-06-26 01:37:54.090233');
COMMIT;

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS "NexusAI"."sys_config";
CREATE TABLE "NexusAI"."sys_config" (
  "config_id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "config_name" varchar(100) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "config_key" varchar(100) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "config_value" varchar(500) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "config_type" char(1) COLLATE "pg_catalog"."default" DEFAULT 'N'::bpchar,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying
)
;
ALTER TABLE "NexusAI"."sys_config" OWNER TO "zang";
COMMENT ON COLUMN "NexusAI"."sys_config"."config_id" IS '参数主键';
COMMENT ON COLUMN "NexusAI"."sys_config"."tenant_id" IS '租户编号';
COMMENT ON COLUMN "NexusAI"."sys_config"."config_name" IS '参数名称';
COMMENT ON COLUMN "NexusAI"."sys_config"."config_key" IS '参数键名';
COMMENT ON COLUMN "NexusAI"."sys_config"."config_value" IS '参数键值';
COMMENT ON COLUMN "NexusAI"."sys_config"."config_type" IS '系统内置（Y是 N否）';
COMMENT ON COLUMN "NexusAI"."sys_config"."create_dept" IS '创建部门';
COMMENT ON COLUMN "NexusAI"."sys_config"."create_by" IS '创建者';
COMMENT ON COLUMN "NexusAI"."sys_config"."create_time" IS '创建时间';
COMMENT ON COLUMN "NexusAI"."sys_config"."update_by" IS '更新者';
COMMENT ON COLUMN "NexusAI"."sys_config"."update_time" IS '更新时间';
COMMENT ON COLUMN "NexusAI"."sys_config"."remark" IS '备注';
COMMENT ON TABLE "NexusAI"."sys_config" IS '参数配置表';

-- ----------------------------
-- Records of sys_config
-- ----------------------------
BEGIN;
INSERT INTO "NexusAI"."sys_config" ("config_id", "tenant_id", "config_name", "config_key", "config_value", "config_type", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1, '000000', '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 103, 1, '2024-06-26 01:37:42.923607', NULL, NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO "NexusAI"."sys_config" ("config_id", "tenant_id", "config_name", "config_key", "config_value", "config_type", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2, '000000', '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 103, 1, '2024-06-26 01:37:42.993497', NULL, NULL, '初始化密码 123456');
INSERT INTO "NexusAI"."sys_config" ("config_id", "tenant_id", "config_name", "config_key", "config_value", "config_type", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3, '000000', '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 103, 1, '2024-06-26 01:37:43.056137', NULL, NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO "NexusAI"."sys_config" ("config_id", "tenant_id", "config_name", "config_key", "config_value", "config_type", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (5, '000000', '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 103, 1, '2024-06-26 01:37:43.115734', NULL, NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO "NexusAI"."sys_config" ("config_id", "tenant_id", "config_name", "config_key", "config_value", "config_type", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (11, '000000', 'OSS预览列表资源开关', 'sys.oss.previewListResource', 'true', 'Y', 103, 1, '2024-06-26 01:37:43.175786', NULL, NULL, 'true:开启, false:关闭');
COMMIT;

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS "NexusAI"."sys_dept";
CREATE TABLE "NexusAI"."sys_dept" (
  "dept_id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "parent_id" int8 DEFAULT 0,
  "ancestors" varchar(500) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "dept_name" varchar(30) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "dept_category" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "order_num" int4 DEFAULT 0,
  "leader" int8,
  "phone" varchar(11) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "email" varchar(50) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6)
)
;
ALTER TABLE "NexusAI"."sys_dept" OWNER TO "zang";
COMMENT ON COLUMN "NexusAI"."sys_dept"."dept_id" IS '部门ID';
COMMENT ON COLUMN "NexusAI"."sys_dept"."tenant_id" IS '租户编号';
COMMENT ON COLUMN "NexusAI"."sys_dept"."parent_id" IS '父部门ID';
COMMENT ON COLUMN "NexusAI"."sys_dept"."ancestors" IS '祖级列表';
COMMENT ON COLUMN "NexusAI"."sys_dept"."dept_name" IS '部门名称';
COMMENT ON COLUMN "NexusAI"."sys_dept"."dept_category" IS '部门类别编码';
COMMENT ON COLUMN "NexusAI"."sys_dept"."order_num" IS '显示顺序';
COMMENT ON COLUMN "NexusAI"."sys_dept"."leader" IS '负责人';
COMMENT ON COLUMN "NexusAI"."sys_dept"."phone" IS '联系电话';
COMMENT ON COLUMN "NexusAI"."sys_dept"."email" IS '邮箱';
COMMENT ON COLUMN "NexusAI"."sys_dept"."status" IS '部门状态（0正常 1停用）';
COMMENT ON COLUMN "NexusAI"."sys_dept"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "NexusAI"."sys_dept"."create_dept" IS '创建部门';
COMMENT ON COLUMN "NexusAI"."sys_dept"."create_by" IS '创建者';
COMMENT ON COLUMN "NexusAI"."sys_dept"."create_time" IS '创建时间';
COMMENT ON COLUMN "NexusAI"."sys_dept"."update_by" IS '更新者';
COMMENT ON COLUMN "NexusAI"."sys_dept"."update_time" IS '更新时间';
COMMENT ON TABLE "NexusAI"."sys_dept" IS '部门表';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
BEGIN;
INSERT INTO "NexusAI"."sys_dept" ("dept_id", "tenant_id", "parent_id", "ancestors", "dept_name", "dept_category", "order_num", "leader", "phone", "email", "status", "del_flag", "create_dept", "create_by", "create_time", "update_by", "update_time") VALUES (100, '000000', 0, '0', 'XXX科技', NULL, 0, NULL, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2024-06-26 01:37:05.052812', NULL, NULL);
INSERT INTO "NexusAI"."sys_dept" ("dept_id", "tenant_id", "parent_id", "ancestors", "dept_name", "dept_category", "order_num", "leader", "phone", "email", "status", "del_flag", "create_dept", "create_by", "create_time", "update_by", "update_time") VALUES (101, '000000', 100, '0,100', '深圳总公司', NULL, 1, NULL, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2024-06-26 01:37:05.132985', NULL, NULL);
INSERT INTO "NexusAI"."sys_dept" ("dept_id", "tenant_id", "parent_id", "ancestors", "dept_name", "dept_category", "order_num", "leader", "phone", "email", "status", "del_flag", "create_dept", "create_by", "create_time", "update_by", "update_time") VALUES (102, '000000', 100, '0,100', '长沙分公司', NULL, 2, NULL, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2024-06-26 01:37:05.200792', NULL, NULL);
INSERT INTO "NexusAI"."sys_dept" ("dept_id", "tenant_id", "parent_id", "ancestors", "dept_name", "dept_category", "order_num", "leader", "phone", "email", "status", "del_flag", "create_dept", "create_by", "create_time", "update_by", "update_time") VALUES (103, '000000', 101, '0,100,101', '研发部门', NULL, 1, 1, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2024-06-26 01:37:05.273243', NULL, NULL);
INSERT INTO "NexusAI"."sys_dept" ("dept_id", "tenant_id", "parent_id", "ancestors", "dept_name", "dept_category", "order_num", "leader", "phone", "email", "status", "del_flag", "create_dept", "create_by", "create_time", "update_by", "update_time") VALUES (104, '000000', 101, '0,100,101', '市场部门', NULL, 2, NULL, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2024-06-26 01:37:05.333452', NULL, NULL);
INSERT INTO "NexusAI"."sys_dept" ("dept_id", "tenant_id", "parent_id", "ancestors", "dept_name", "dept_category", "order_num", "leader", "phone", "email", "status", "del_flag", "create_dept", "create_by", "create_time", "update_by", "update_time") VALUES (105, '000000', 101, '0,100,101', '测试部门', NULL, 3, NULL, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2024-06-26 01:37:05.403273', NULL, NULL);
INSERT INTO "NexusAI"."sys_dept" ("dept_id", "tenant_id", "parent_id", "ancestors", "dept_name", "dept_category", "order_num", "leader", "phone", "email", "status", "del_flag", "create_dept", "create_by", "create_time", "update_by", "update_time") VALUES (106, '000000', 101, '0,100,101', '财务部门', NULL, 4, NULL, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2024-06-26 01:37:05.474206', NULL, NULL);
INSERT INTO "NexusAI"."sys_dept" ("dept_id", "tenant_id", "parent_id", "ancestors", "dept_name", "dept_category", "order_num", "leader", "phone", "email", "status", "del_flag", "create_dept", "create_by", "create_time", "update_by", "update_time") VALUES (107, '000000', 101, '0,100,101', '运维部门', NULL, 5, NULL, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2024-06-26 01:37:05.547964', NULL, NULL);
INSERT INTO "NexusAI"."sys_dept" ("dept_id", "tenant_id", "parent_id", "ancestors", "dept_name", "dept_category", "order_num", "leader", "phone", "email", "status", "del_flag", "create_dept", "create_by", "create_time", "update_by", "update_time") VALUES (108, '000000', 102, '0,100,102', '市场部门', NULL, 1, NULL, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2024-06-26 01:37:05.632787', NULL, NULL);
INSERT INTO "NexusAI"."sys_dept" ("dept_id", "tenant_id", "parent_id", "ancestors", "dept_name", "dept_category", "order_num", "leader", "phone", "email", "status", "del_flag", "create_dept", "create_by", "create_time", "update_by", "update_time") VALUES (109, '000000', 102, '0,100,102', '财务部门', NULL, 2, NULL, '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2024-06-26 01:37:05.705906', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS "NexusAI"."sys_dict_data";
CREATE TABLE "NexusAI"."sys_dict_data" (
  "dict_code" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "dict_sort" int4 DEFAULT 0,
  "dict_label" varchar(100) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "dict_value" varchar(100) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "dict_type" varchar(100) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "css_class" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "list_class" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "is_default" char(1) COLLATE "pg_catalog"."default" DEFAULT 'N'::bpchar,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying
)
;
ALTER TABLE "NexusAI"."sys_dict_data" OWNER TO "zang";
COMMENT ON COLUMN "NexusAI"."sys_dict_data"."dict_code" IS '字典编码';
COMMENT ON COLUMN "NexusAI"."sys_dict_data"."dict_sort" IS '字典排序';
COMMENT ON COLUMN "NexusAI"."sys_dict_data"."dict_label" IS '字典标签';
COMMENT ON COLUMN "NexusAI"."sys_dict_data"."dict_value" IS '字典键值';
COMMENT ON COLUMN "NexusAI"."sys_dict_data"."dict_type" IS '字典类型';
COMMENT ON COLUMN "NexusAI"."sys_dict_data"."css_class" IS '样式属性（其他样式扩展）';
COMMENT ON COLUMN "NexusAI"."sys_dict_data"."list_class" IS '表格回显样式';
COMMENT ON COLUMN "NexusAI"."sys_dict_data"."is_default" IS '是否默认（Y是 N否）';
COMMENT ON COLUMN "NexusAI"."sys_dict_data"."create_dept" IS '创建部门';
COMMENT ON COLUMN "NexusAI"."sys_dict_data"."create_by" IS '创建者';
COMMENT ON COLUMN "NexusAI"."sys_dict_data"."create_time" IS '创建时间';
COMMENT ON COLUMN "NexusAI"."sys_dict_data"."update_by" IS '更新者';
COMMENT ON COLUMN "NexusAI"."sys_dict_data"."update_time" IS '更新时间';
COMMENT ON COLUMN "NexusAI"."sys_dict_data"."remark" IS '备注';
COMMENT ON TABLE "NexusAI"."sys_dict_data" IS '字典数据表';

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
BEGIN;
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1, '000000', 1, '男', '0', 'sys_user_sex', '', '', 'Y', 103, 1, '2024-06-26 01:37:39.836567', NULL, NULL, '性别男');
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2, '000000', 2, '女', '1', 'sys_user_sex', '', '', 'N', 103, 1, '2024-06-26 01:37:39.895769', NULL, NULL, '性别女');
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3, '000000', 3, '未知', '2', 'sys_user_sex', '', '', 'N', 103, 1, '2024-06-26 01:37:39.958207', NULL, NULL, '性别未知');
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (4, '000000', 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', 103, 1, '2024-06-26 01:37:40.015988', NULL, NULL, '显示菜单');
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (5, '000000', 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', 103, 1, '2024-06-26 01:37:40.083152', NULL, NULL, '隐藏菜单');
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (6, '000000', 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', 103, 1, '2024-06-26 01:37:40.142818', NULL, NULL, '正常状态');
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (7, '000000', 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', 103, 1, '2024-06-26 01:37:40.202923', NULL, NULL, '停用状态');
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (12, '000000', 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', 103, 1, '2024-06-26 01:37:40.272976', NULL, NULL, '系统默认是');
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (13, '000000', 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', 103, 1, '2024-06-26 01:37:40.327841', NULL, NULL, '系统默认否');
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (14, '000000', 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', 103, 1, '2024-06-26 01:37:40.391063', NULL, NULL, '通知');
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (15, '000000', 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', 103, 1, '2024-06-26 01:37:40.463031', NULL, NULL, '公告');
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (16, '000000', 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', 103, 1, '2024-06-26 01:37:40.531563', NULL, NULL, '正常状态');
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (17, '000000', 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', 103, 1, '2024-06-26 01:37:40.59828', NULL, NULL, '关闭状态');
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (29, '000000', 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', 103, 1, '2024-06-26 01:37:40.655829', NULL, NULL, '其他操作');
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (18, '000000', 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', 103, 1, '2024-06-26 01:37:40.72287', NULL, NULL, '新增操作');
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (19, '000000', 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', 103, 1, '2024-06-26 01:37:40.78323', NULL, NULL, '修改操作');
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (20, '000000', 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', 103, 1, '2024-06-26 01:37:40.840789', NULL, NULL, '删除操作');
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (21, '000000', 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', 103, 1, '2024-06-26 01:37:40.895935', NULL, NULL, '授权操作');
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (22, '000000', 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', 103, 1, '2024-06-26 01:37:40.955851', NULL, NULL, '导出操作');
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (23, '000000', 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', 103, 1, '2024-06-26 01:37:41.016025', NULL, NULL, '导入操作');
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (24, '000000', 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', 103, 1, '2024-06-26 01:37:41.09787', NULL, NULL, '强退操作');
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (25, '000000', 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', 103, 1, '2024-06-26 01:37:41.158411', NULL, NULL, '生成操作');
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (26, '000000', 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', 103, 1, '2024-06-26 01:37:41.221535', NULL, NULL, '清空操作');
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (27, '000000', 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', 103, 1, '2024-06-26 01:37:41.293143', NULL, NULL, '正常状态');
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (28, '000000', 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', 103, 1, '2024-06-26 01:37:41.3632', NULL, NULL, '停用状态');
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (30, '000000', 0, '密码认证', 'password', 'sys_grant_type', '', 'default', 'N', 103, 1, '2024-06-26 01:37:41.428158', NULL, NULL, '密码认证');
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (31, '000000', 0, '短信认证', 'sms', 'sys_grant_type', '', 'default', 'N', 103, 1, '2024-06-26 01:37:41.490879', NULL, NULL, '短信认证');
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (32, '000000', 0, '邮件认证', 'email', 'sys_grant_type', '', 'default', 'N', 103, 1, '2024-06-26 01:37:41.558299', NULL, NULL, '邮件认证');
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (33, '000000', 0, '小程序认证', 'xcx', 'sys_grant_type', '', 'default', 'N', 103, 1, '2024-06-26 01:37:41.616579', NULL, NULL, '小程序认证');
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (34, '000000', 0, '三方登录认证', 'social', 'sys_grant_type', '', 'default', 'N', 103, 1, '2024-06-26 01:37:41.682973', NULL, NULL, '三方登录认证');
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (35, '000000', 0, 'PC', 'pc', 'sys_device_type', '', 'default', 'N', 103, 1, '2024-06-26 01:37:41.747948', NULL, NULL, 'PC');
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (36, '000000', 0, '安卓', 'android', 'sys_device_type', '', 'default', 'N', 103, 1, '2024-06-26 01:37:41.81064', NULL, NULL, '安卓');
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (37, '000000', 0, 'iOS', 'ios', 'sys_device_type', '', 'default', 'N', 103, 1, '2024-06-26 01:37:41.873399', NULL, NULL, 'iOS');
INSERT INTO "NexusAI"."sys_dict_data" ("dict_code", "tenant_id", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (38, '000000', 0, '小程序', 'xcx', 'sys_device_type', '', 'default', 'N', 103, 1, '2024-06-26 01:37:41.942975', NULL, NULL, '小程序');
COMMIT;

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS "NexusAI"."sys_dict_type";
CREATE TABLE "NexusAI"."sys_dict_type" (
  "dict_id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "dict_name" varchar(100) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "dict_type" varchar(100) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying
)
;
ALTER TABLE "NexusAI"."sys_dict_type" OWNER TO "zang";
COMMENT ON COLUMN "NexusAI"."sys_dict_type"."dict_id" IS '字典主键';
COMMENT ON COLUMN "NexusAI"."sys_dict_type"."tenant_id" IS '租户编号';
COMMENT ON COLUMN "NexusAI"."sys_dict_type"."dict_name" IS '字典名称';
COMMENT ON COLUMN "NexusAI"."sys_dict_type"."dict_type" IS '字典类型';
COMMENT ON COLUMN "NexusAI"."sys_dict_type"."create_dept" IS '创建部门';
COMMENT ON COLUMN "NexusAI"."sys_dict_type"."create_by" IS '创建者';
COMMENT ON COLUMN "NexusAI"."sys_dict_type"."create_time" IS '创建时间';
COMMENT ON COLUMN "NexusAI"."sys_dict_type"."update_by" IS '更新者';
COMMENT ON COLUMN "NexusAI"."sys_dict_type"."update_time" IS '更新时间';
COMMENT ON COLUMN "NexusAI"."sys_dict_type"."remark" IS '备注';
COMMENT ON TABLE "NexusAI"."sys_dict_type" IS '字典类型表';

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
BEGIN;
INSERT INTO "NexusAI"."sys_dict_type" ("dict_id", "tenant_id", "dict_name", "dict_type", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1, '000000', '用户性别', 'sys_user_sex', 103, 1, '2024-06-26 01:37:38.095745', NULL, NULL, '用户性别列表');
INSERT INTO "NexusAI"."sys_dict_type" ("dict_id", "tenant_id", "dict_name", "dict_type", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2, '000000', '菜单状态', 'sys_show_hide', 103, 1, '2024-06-26 01:37:38.156368', NULL, NULL, '菜单状态列表');
INSERT INTO "NexusAI"."sys_dict_type" ("dict_id", "tenant_id", "dict_name", "dict_type", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3, '000000', '系统开关', 'sys_normal_disable', 103, 1, '2024-06-26 01:37:38.228281', NULL, NULL, '系统开关列表');
INSERT INTO "NexusAI"."sys_dict_type" ("dict_id", "tenant_id", "dict_name", "dict_type", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (6, '000000', '系统是否', 'sys_yes_no', 103, 1, '2024-06-26 01:37:38.2962', NULL, NULL, '系统是否列表');
INSERT INTO "NexusAI"."sys_dict_type" ("dict_id", "tenant_id", "dict_name", "dict_type", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (7, '000000', '通知类型', 'sys_notice_type', 103, 1, '2024-06-26 01:37:38.358361', NULL, NULL, '通知类型列表');
INSERT INTO "NexusAI"."sys_dict_type" ("dict_id", "tenant_id", "dict_name", "dict_type", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (8, '000000', '通知状态', 'sys_notice_status', 103, 1, '2024-06-26 01:37:38.41594', NULL, NULL, '通知状态列表');
INSERT INTO "NexusAI"."sys_dict_type" ("dict_id", "tenant_id", "dict_name", "dict_type", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (9, '000000', '操作类型', 'sys_oper_type', 103, 1, '2024-06-26 01:37:38.482792', NULL, NULL, '操作类型列表');
INSERT INTO "NexusAI"."sys_dict_type" ("dict_id", "tenant_id", "dict_name", "dict_type", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (10, '000000', '系统状态', 'sys_common_status', 103, 1, '2024-06-26 01:37:38.543184', NULL, NULL, '登录状态列表');
INSERT INTO "NexusAI"."sys_dict_type" ("dict_id", "tenant_id", "dict_name", "dict_type", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (11, '000000', '授权类型', 'sys_grant_type', 103, 1, '2024-06-26 01:37:38.608403', NULL, NULL, '认证授权类型');
INSERT INTO "NexusAI"."sys_dict_type" ("dict_id", "tenant_id", "dict_name", "dict_type", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (12, '000000', '设备类型', 'sys_device_type', 103, 1, '2024-06-26 01:37:38.673701', NULL, NULL, '客户端设备类型');
COMMIT;

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS "NexusAI"."sys_logininfor";
CREATE TABLE "NexusAI"."sys_logininfor" (
  "info_id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "user_name" varchar(50) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "client_key" varchar(32) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "device_type" varchar(32) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "ipaddr" varchar(128) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "login_location" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "browser" varchar(50) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "os" varchar(50) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "msg" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "login_time" timestamp(6)
)
;
ALTER TABLE "NexusAI"."sys_logininfor" OWNER TO "zang";
COMMENT ON COLUMN "NexusAI"."sys_logininfor"."info_id" IS '访问ID';
COMMENT ON COLUMN "NexusAI"."sys_logininfor"."tenant_id" IS '租户编号';
COMMENT ON COLUMN "NexusAI"."sys_logininfor"."user_name" IS '用户账号';
COMMENT ON COLUMN "NexusAI"."sys_logininfor"."client_key" IS '客户端';
COMMENT ON COLUMN "NexusAI"."sys_logininfor"."device_type" IS '设备类型';
COMMENT ON COLUMN "NexusAI"."sys_logininfor"."ipaddr" IS '登录IP地址';
COMMENT ON COLUMN "NexusAI"."sys_logininfor"."login_location" IS '登录地点';
COMMENT ON COLUMN "NexusAI"."sys_logininfor"."browser" IS '浏览器类型';
COMMENT ON COLUMN "NexusAI"."sys_logininfor"."os" IS '操作系统';
COMMENT ON COLUMN "NexusAI"."sys_logininfor"."status" IS '登录状态（0成功 1失败）';
COMMENT ON COLUMN "NexusAI"."sys_logininfor"."msg" IS '提示消息';
COMMENT ON COLUMN "NexusAI"."sys_logininfor"."login_time" IS '访问时间';
COMMENT ON TABLE "NexusAI"."sys_logininfor" IS '系统访问记录';

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS "NexusAI"."sys_menu";
CREATE TABLE "NexusAI"."sys_menu" (
  "menu_id" int8 NOT NULL,
  "menu_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "parent_id" int8 DEFAULT 0,
  "order_num" int4 DEFAULT 0,
  "path" varchar(200) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "component" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "query_param" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "is_frame" char(1) COLLATE "pg_catalog"."default" DEFAULT '1'::bpchar,
  "is_cache" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "menu_type" char(1) COLLATE "pg_catalog"."default" DEFAULT ''::bpchar,
  "visible" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "perms" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "icon" varchar(100) COLLATE "pg_catalog"."default" DEFAULT '#'::character varying,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default" DEFAULT ''::character varying
)
;
ALTER TABLE "NexusAI"."sys_menu" OWNER TO "zang";
COMMENT ON COLUMN "NexusAI"."sys_menu"."menu_id" IS '菜单ID';
COMMENT ON COLUMN "NexusAI"."sys_menu"."menu_name" IS '菜单名称';
COMMENT ON COLUMN "NexusAI"."sys_menu"."parent_id" IS '父菜单ID';
COMMENT ON COLUMN "NexusAI"."sys_menu"."order_num" IS '显示顺序';
COMMENT ON COLUMN "NexusAI"."sys_menu"."path" IS '路由地址';
COMMENT ON COLUMN "NexusAI"."sys_menu"."component" IS '组件路径';
COMMENT ON COLUMN "NexusAI"."sys_menu"."query_param" IS '路由参数';
COMMENT ON COLUMN "NexusAI"."sys_menu"."is_frame" IS '是否为外链（0是 1否）';
COMMENT ON COLUMN "NexusAI"."sys_menu"."is_cache" IS '是否缓存（0缓存 1不缓存）';
COMMENT ON COLUMN "NexusAI"."sys_menu"."menu_type" IS '菜单类型（M目录 C菜单 F按钮）';
COMMENT ON COLUMN "NexusAI"."sys_menu"."visible" IS '显示状态（0显示 1隐藏）';
COMMENT ON COLUMN "NexusAI"."sys_menu"."status" IS '菜单状态（0正常 1停用）';
COMMENT ON COLUMN "NexusAI"."sys_menu"."perms" IS '权限标识';
COMMENT ON COLUMN "NexusAI"."sys_menu"."icon" IS '菜单图标';
COMMENT ON COLUMN "NexusAI"."sys_menu"."create_dept" IS '创建部门';
COMMENT ON COLUMN "NexusAI"."sys_menu"."create_by" IS '创建者';
COMMENT ON COLUMN "NexusAI"."sys_menu"."create_time" IS '创建时间';
COMMENT ON COLUMN "NexusAI"."sys_menu"."update_by" IS '更新者';
COMMENT ON COLUMN "NexusAI"."sys_menu"."update_time" IS '更新时间';
COMMENT ON COLUMN "NexusAI"."sys_menu"."remark" IS '备注';
COMMENT ON TABLE "NexusAI"."sys_menu" IS '菜单权限表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
BEGIN;
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '1', '0', 'M', '0', '0', '', 'system', 103, 1, '2024-06-26 01:37:19.958286', NULL, NULL, '系统管理目录');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (6, '系统管理', 0, 2, 'tenant', NULL, '', '1', '0', 'M', '0', '0', '', 'chart', 103, 1, '2024-06-26 01:37:20.048616', NULL, NULL, '租户管理目录');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2, '系统监控', 0, 3, 'monitor', NULL, '', '1', '0', 'M', '0', '0', '', 'monitor', 103, 1, '2024-06-26 01:37:20.128262', NULL, NULL, '系统监控目录');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3, '系统工具', 0, 4, 'tool', NULL, '', '1', '0', 'M', '0', '0', '', 'tool', 103, 1, '2024-06-26 01:37:20.198559', NULL, NULL, '系统工具目录');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (4, 'PLUS官网', 0, 5, 'https://gitee.com/dromara/RuoYi-Vue-Plus', NULL, '', '0', '0', 'M', '0', '0', '', 'guide', 103, 1, '2024-06-26 01:37:20.25611', NULL, NULL, 'RuoYi-Vue-Plus官网地址');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (5, '测试菜单', 0, 5, 'demo', NULL, '', '1', '0', 'M', '0', '0', NULL, 'star', 103, 1, '2024-06-26 01:37:20.318896', NULL, NULL, '测试菜单');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '1', '0', 'C', '0', '0', 'system:user:list', 'user', 103, 1, '2024-06-26 01:37:20.401143', NULL, NULL, '用户管理菜单');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '1', '0', 'C', '0', '0', 'system:role:list', 'peoples', 103, 1, '2024-06-26 01:37:20.462793', NULL, NULL, '角色管理菜单');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '1', '0', 'C', '0', '0', 'system:menu:list', 'tree-table', 103, 1, '2024-06-26 01:37:20.523071', NULL, NULL, '菜单管理菜单');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '1', '0', 'C', '0', '0', 'system:dept:list', 'tree', 103, 1, '2024-06-26 01:37:20.60594', NULL, NULL, '部门管理菜单');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '1', '0', 'C', '0', '0', 'system:post:list', 'post', 103, 1, '2024-06-26 01:37:20.678417', NULL, NULL, '岗位管理菜单');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '1', '0', 'C', '0', '0', 'system:dict:list', 'dict', 103, 1, '2024-06-26 01:37:20.736361', NULL, NULL, '字典管理菜单');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '1', '0', 'C', '0', '0', 'system:config:list', 'edit', 103, 1, '2024-06-26 01:37:20.822895', NULL, NULL, '参数设置菜单');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '1', '0', 'C', '0', '0', 'system:notice:list', 'message', 103, 1, '2024-06-26 01:37:20.888232', NULL, NULL, '通知公告菜单');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (108, '日志管理', 1, 9, 'log', '', '', '1', '0', 'M', '0', '0', '', 'log', 103, 1, '2024-06-26 01:37:20.950991', NULL, NULL, '日志管理菜单');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '1', '0', 'C', '0', '0', 'monitor:online:list', 'online', 103, 1, '2024-06-26 01:37:21.016162', NULL, NULL, '在线用户菜单');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '1', '0', 'C', '0', '0', 'monitor:cache:list', 'redis', 103, 1, '2024-06-26 01:37:21.078287', NULL, NULL, '缓存监控菜单');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (115, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '1', '0', 'C', '0', '0', 'tool:gen:list', 'code', 103, 1, '2024-06-26 01:37:21.136139', NULL, NULL, '代码生成菜单');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (121, '租户管理', 6, 1, 'tenant', 'system/tenant/index', '', '1', '0', 'C', '0', '0', 'system:tenant:list', 'list', 103, 1, '2024-06-26 01:37:21.198124', NULL, NULL, '租户管理菜单');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (122, '租户套餐管理', 6, 2, 'tenantPackage', 'system/tenantPackage/index', '', '1', '0', 'C', '0', '0', 'system:tenantPackage:list', 'form', 103, 1, '2024-06-26 01:37:21.258882', NULL, NULL, '租户套餐管理菜单');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (123, '客户端管理', 1, 11, 'client', 'system/client/index', '', '1', '0', 'C', '0', '0', 'system:client:list', 'international', 103, 1, '2024-06-26 01:37:21.336154', NULL, NULL, '客户端管理菜单');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (117, 'Admin监控', 2, 5, 'Admin', 'monitor/admin/index', '', '1', '0', 'C', '0', '0', 'monitor:admin:list', 'dashboard', 103, 1, '2024-06-26 01:37:21.403096', NULL, NULL, 'Admin监控菜单');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (118, '文件管理', 1, 10, 'oss', 'system/oss/index', '', '1', '0', 'C', '0', '0', 'system:oss:list', 'upload', 103, 1, '2024-06-26 01:37:21.473276', NULL, NULL, '文件管理菜单');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (120, '任务调度中心', 2, 6, 'snailjob', 'monitor/snailjob/index', '', '1', '0', 'C', '0', '0', 'monitor:snailjob:list', 'job', 103, 1, '2024-06-26 01:37:21.54339', NULL, NULL, 'SnailJob控制台菜单');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '1', '0', 'C', '0', '0', 'monitor:operlog:list', 'form', 103, 1, '2024-06-26 01:37:21.611', NULL, NULL, '操作日志菜单');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '1', '0', 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 103, 1, '2024-06-26 01:37:21.688078', NULL, NULL, '登录日志菜单');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1001, '用户查询', 100, 1, '', '', '', '1', '0', 'F', '0', '0', 'system:user:query', '#', 103, 1, '2024-06-26 01:37:21.763338', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1002, '用户新增', 100, 2, '', '', '', '1', '0', 'F', '0', '0', 'system:user:add', '#', 103, 1, '2024-06-26 01:37:21.823411', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1003, '用户修改', 100, 3, '', '', '', '1', '0', 'F', '0', '0', 'system:user:edit', '#', 103, 1, '2024-06-26 01:37:21.907911', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1004, '用户删除', 100, 4, '', '', '', '1', '0', 'F', '0', '0', 'system:user:remove', '#', 103, 1, '2024-06-26 01:37:21.980741', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1005, '用户导出', 100, 5, '', '', '', '1', '0', 'F', '0', '0', 'system:user:export', '#', 103, 1, '2024-06-26 01:37:22.078551', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1006, '用户导入', 100, 6, '', '', '', '1', '0', 'F', '0', '0', 'system:user:import', '#', 103, 1, '2024-06-26 01:37:22.138387', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1007, '重置密码', 100, 7, '', '', '', '1', '0', 'F', '0', '0', 'system:user:resetPwd', '#', 103, 1, '2024-06-26 01:37:22.19874', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1008, '角色查询', 101, 1, '', '', '', '1', '0', 'F', '0', '0', 'system:role:query', '#', 103, 1, '2024-06-26 01:37:22.276555', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1009, '角色新增', 101, 2, '', '', '', '1', '0', 'F', '0', '0', 'system:role:add', '#', 103, 1, '2024-06-26 01:37:22.352916', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1010, '角色修改', 101, 3, '', '', '', '1', '0', 'F', '0', '0', 'system:role:edit', '#', 103, 1, '2024-06-26 01:37:22.448452', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1011, '角色删除', 101, 4, '', '', '', '1', '0', 'F', '0', '0', 'system:role:remove', '#', 103, 1, '2024-06-26 01:37:22.523164', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1012, '角色导出', 101, 5, '', '', '', '1', '0', 'F', '0', '0', 'system:role:export', '#', 103, 1, '2024-06-26 01:37:22.622987', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1013, '菜单查询', 102, 1, '', '', '', '1', '0', 'F', '0', '0', 'system:menu:query', '#', 103, 1, '2024-06-26 01:37:22.703362', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1014, '菜单新增', 102, 2, '', '', '', '1', '0', 'F', '0', '0', 'system:menu:add', '#', 103, 1, '2024-06-26 01:37:22.803104', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1015, '菜单修改', 102, 3, '', '', '', '1', '0', 'F', '0', '0', 'system:menu:edit', '#', 103, 1, '2024-06-26 01:37:22.878425', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1016, '菜单删除', 102, 4, '', '', '', '1', '0', 'F', '0', '0', 'system:menu:remove', '#', 103, 1, '2024-06-26 01:37:22.963282', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1017, '部门查询', 103, 1, '', '', '', '1', '0', 'F', '0', '0', 'system:dept:query', '#', 103, 1, '2024-06-26 01:37:23.023658', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1018, '部门新增', 103, 2, '', '', '', '1', '0', 'F', '0', '0', 'system:dept:add', '#', 103, 1, '2024-06-26 01:37:23.112764', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1019, '部门修改', 103, 3, '', '', '', '1', '0', 'F', '0', '0', 'system:dept:edit', '#', 103, 1, '2024-06-26 01:37:23.192974', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1020, '部门删除', 103, 4, '', '', '', '1', '0', 'F', '0', '0', 'system:dept:remove', '#', 103, 1, '2024-06-26 01:37:23.278199', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1021, '岗位查询', 104, 1, '', '', '', '1', '0', 'F', '0', '0', 'system:post:query', '#', 103, 1, '2024-06-26 01:37:23.346781', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1022, '岗位新增', 104, 2, '', '', '', '1', '0', 'F', '0', '0', 'system:post:add', '#', 103, 1, '2024-06-26 01:37:23.422783', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1023, '岗位修改', 104, 3, '', '', '', '1', '0', 'F', '0', '0', 'system:post:edit', '#', 103, 1, '2024-06-26 01:37:23.488352', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1024, '岗位删除', 104, 4, '', '', '', '1', '0', 'F', '0', '0', 'system:post:remove', '#', 103, 1, '2024-06-26 01:37:23.55849', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1025, '岗位导出', 104, 5, '', '', '', '1', '0', 'F', '0', '0', 'system:post:export', '#', 103, 1, '2024-06-26 01:37:23.653901', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1026, '字典查询', 105, 1, '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:query', '#', 103, 1, '2024-06-26 01:37:23.721018', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1027, '字典新增', 105, 2, '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:add', '#', 103, 1, '2024-06-26 01:37:23.793423', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1028, '字典修改', 105, 3, '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:edit', '#', 103, 1, '2024-06-26 01:37:23.858606', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1029, '字典删除', 105, 4, '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:remove', '#', 103, 1, '2024-06-26 01:37:23.925924', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1030, '字典导出', 105, 5, '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:export', '#', 103, 1, '2024-06-26 01:37:23.995847', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1031, '参数查询', 106, 1, '#', '', '', '1', '0', 'F', '0', '0', 'system:config:query', '#', 103, 1, '2024-06-26 01:37:24.063204', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1032, '参数新增', 106, 2, '#', '', '', '1', '0', 'F', '0', '0', 'system:config:add', '#', 103, 1, '2024-06-26 01:37:24.122963', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1033, '参数修改', 106, 3, '#', '', '', '1', '0', 'F', '0', '0', 'system:config:edit', '#', 103, 1, '2024-06-26 01:37:24.183463', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1034, '参数删除', 106, 4, '#', '', '', '1', '0', 'F', '0', '0', 'system:config:remove', '#', 103, 1, '2024-06-26 01:37:24.248013', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1035, '参数导出', 106, 5, '#', '', '', '1', '0', 'F', '0', '0', 'system:config:export', '#', 103, 1, '2024-06-26 01:37:24.316154', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1036, '公告查询', 107, 1, '#', '', '', '1', '0', 'F', '0', '0', 'system:notice:query', '#', 103, 1, '2024-06-26 01:37:24.378106', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1037, '公告新增', 107, 2, '#', '', '', '1', '0', 'F', '0', '0', 'system:notice:add', '#', 103, 1, '2024-06-26 01:37:24.442993', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1038, '公告修改', 107, 3, '#', '', '', '1', '0', 'F', '0', '0', 'system:notice:edit', '#', 103, 1, '2024-06-26 01:37:24.503132', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1039, '公告删除', 107, 4, '#', '', '', '1', '0', 'F', '0', '0', 'system:notice:remove', '#', 103, 1, '2024-06-26 01:37:24.562887', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1040, '操作查询', 500, 1, '#', '', '', '1', '0', 'F', '0', '0', 'monitor:operlog:query', '#', 103, 1, '2024-06-26 01:37:24.622747', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1041, '操作删除', 500, 2, '#', '', '', '1', '0', 'F', '0', '0', 'monitor:operlog:remove', '#', 103, 1, '2024-06-26 01:37:24.690966', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1042, '日志导出', 500, 4, '#', '', '', '1', '0', 'F', '0', '0', 'monitor:operlog:export', '#', 103, 1, '2024-06-26 01:37:24.768156', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1043, '登录查询', 501, 1, '#', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:query', '#', 103, 1, '2024-06-26 01:37:24.833578', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1044, '登录删除', 501, 2, '#', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:remove', '#', 103, 1, '2024-06-26 01:37:24.913191', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1045, '日志导出', 501, 3, '#', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:export', '#', 103, 1, '2024-06-26 01:37:24.975621', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1050, '账户解锁', 501, 4, '#', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:unlock', '#', 103, 1, '2024-06-26 01:37:25.036533', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1046, '在线查询', 109, 1, '#', '', '', '1', '0', 'F', '0', '0', 'monitor:online:query', '#', 103, 1, '2024-06-26 01:37:25.098633', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1047, '批量强退', 109, 2, '#', '', '', '1', '0', 'F', '0', '0', 'monitor:online:batchLogout', '#', 103, 1, '2024-06-26 01:37:25.159044', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1048, '单条强退', 109, 3, '#', '', '', '1', '0', 'F', '0', '0', 'monitor:online:forceLogout', '#', 103, 1, '2024-06-26 01:37:25.215736', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1055, '生成查询', 115, 1, '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:query', '#', 103, 1, '2024-06-26 01:37:25.276142', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1056, '生成修改', 115, 2, '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:edit', '#', 103, 1, '2024-06-26 01:37:25.338316', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1057, '生成删除', 115, 3, '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:remove', '#', 103, 1, '2024-06-26 01:37:25.403041', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1058, '导入代码', 115, 2, '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:import', '#', 103, 1, '2024-06-26 01:37:25.473373', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1059, '预览代码', 115, 4, '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:preview', '#', 103, 1, '2024-06-26 01:37:25.535691', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1060, '生成代码', 115, 5, '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:code', '#', 103, 1, '2024-06-26 01:37:25.596047', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1600, '文件查询', 118, 1, '#', '', '', '1', '0', 'F', '0', '0', 'system:oss:query', '#', 103, 1, '2024-06-26 01:37:25.662871', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1601, '文件上传', 118, 2, '#', '', '', '1', '0', 'F', '0', '0', 'system:oss:upload', '#', 103, 1, '2024-06-26 01:37:25.723426', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1602, '文件下载', 118, 3, '#', '', '', '1', '0', 'F', '0', '0', 'system:oss:download', '#', 103, 1, '2024-06-26 01:37:25.783483', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1603, '文件删除', 118, 4, '#', '', '', '1', '0', 'F', '0', '0', 'system:oss:remove', '#', 103, 1, '2024-06-26 01:37:25.852955', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1620, '配置列表', 118, 5, '#', '', '', '1', '0', 'F', '0', '0', 'system:ossConfig:list', '#', 103, 1, '2024-06-26 01:37:25.915898', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1621, '配置添加', 118, 6, '#', '', '', '1', '0', 'F', '0', '0', 'system:ossConfig:add', '#', 103, 1, '2024-06-26 01:37:25.983529', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1622, '配置编辑', 118, 6, '#', '', '', '1', '0', 'F', '0', '0', 'system:ossConfig:edit', '#', 103, 1, '2024-06-26 01:37:26.055958', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1623, '配置删除', 118, 6, '#', '', '', '1', '0', 'F', '0', '0', 'system:ossConfig:remove', '#', 103, 1, '2024-06-26 01:37:26.118479', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1606, '租户查询', 121, 1, '#', '', '', '1', '0', 'F', '0', '0', 'system:tenant:query', '#', 103, 1, '2024-06-26 01:37:26.178426', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1607, '租户新增', 121, 2, '#', '', '', '1', '0', 'F', '0', '0', 'system:tenant:add', '#', 103, 1, '2024-06-26 01:37:26.243158', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1608, '租户修改', 121, 3, '#', '', '', '1', '0', 'F', '0', '0', 'system:tenant:edit', '#', 103, 1, '2024-06-26 01:37:26.310982', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1609, '租户删除', 121, 4, '#', '', '', '1', '0', 'F', '0', '0', 'system:tenant:remove', '#', 103, 1, '2024-06-26 01:37:26.381262', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1610, '租户导出', 121, 5, '#', '', '', '1', '0', 'F', '0', '0', 'system:tenant:export', '#', 103, 1, '2024-06-26 01:37:26.450817', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1611, '租户套餐查询', 122, 1, '#', '', '', '1', '0', 'F', '0', '0', 'system:tenantPackage:query', '#', 103, 1, '2024-06-26 01:37:26.518702', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1612, '租户套餐新增', 122, 2, '#', '', '', '1', '0', 'F', '0', '0', 'system:tenantPackage:add', '#', 103, 1, '2024-06-26 01:37:26.581308', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1613, '租户套餐修改', 122, 3, '#', '', '', '1', '0', 'F', '0', '0', 'system:tenantPackage:edit', '#', 103, 1, '2024-06-26 01:37:26.642881', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1614, '租户套餐删除', 122, 4, '#', '', '', '1', '0', 'F', '0', '0', 'system:tenantPackage:remove', '#', 103, 1, '2024-06-26 01:37:26.723033', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1615, '租户套餐导出', 122, 5, '#', '', '', '1', '0', 'F', '0', '0', 'system:tenantPackage:export', '#', 103, 1, '2024-06-26 01:37:26.782714', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1061, '客户端管理查询', 123, 1, '#', '', '', '1', '0', 'F', '0', '0', 'system:client:query', '#', 103, 1, '2024-06-26 01:37:26.842802', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1062, '客户端管理新增', 123, 2, '#', '', '', '1', '0', 'F', '0', '0', 'system:client:add', '#', 103, 1, '2024-06-26 01:37:26.975908', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1063, '客户端管理修改', 123, 3, '#', '', '', '1', '0', 'F', '0', '0', 'system:client:edit', '#', 103, 1, '2024-06-26 01:37:27.035785', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1064, '客户端管理删除', 123, 4, '#', '', '', '1', '0', 'F', '0', '0', 'system:client:remove', '#', 103, 1, '2024-06-26 01:37:27.103299', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1065, '客户端管理导出', 123, 5, '#', '', '', '1', '0', 'F', '0', '0', 'system:client:export', '#', 103, 1, '2024-06-26 01:37:27.171243', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1500, '测试单表', 5, 1, 'demo', 'demo/demo/index', '', '1', '0', 'C', '0', '0', 'demo:demo:list', '#', 103, 1, '2024-06-26 01:37:27.398161', NULL, NULL, '测试单表菜单');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1501, '测试单表查询', 1500, 1, '#', '', '', '1', '0', 'F', '0', '0', 'demo:demo:query', '#', 103, 1, '2024-06-26 01:37:27.463034', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1502, '测试单表新增', 1500, 2, '#', '', '', '1', '0', 'F', '0', '0', 'demo:demo:add', '#', 103, 1, '2024-06-26 01:37:27.523313', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1503, '测试单表修改', 1500, 3, '#', '', '', '1', '0', 'F', '0', '0', 'demo:demo:edit', '#', 103, 1, '2024-06-26 01:37:27.590968', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1504, '测试单表删除', 1500, 4, '#', '', '', '1', '0', 'F', '0', '0', 'demo:demo:remove', '#', 103, 1, '2024-06-26 01:37:27.658279', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1505, '测试单表导出', 1500, 5, '#', '', '', '1', '0', 'F', '0', '0', 'demo:demo:export', '#', 103, 1, '2024-06-26 01:37:27.718459', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1506, '测试树表', 5, 1, 'tree', 'demo/tree/index', '', '1', '0', 'C', '0', '0', 'demo:tree:list', '#', 103, 1, '2024-06-26 01:37:27.798237', NULL, NULL, '测试树表菜单');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1507, '测试树表查询', 1506, 1, '#', '', '', '1', '0', 'F', '0', '0', 'demo:tree:query', '#', 103, 1, '2024-06-26 01:37:27.855624', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1508, '测试树表新增', 1506, 2, '#', '', '', '1', '0', 'F', '0', '0', 'demo:tree:add', '#', 103, 1, '2024-06-26 01:37:27.918151', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1509, '测试树表修改', 1506, 3, '#', '', '', '1', '0', 'F', '0', '0', 'demo:tree:edit', '#', 103, 1, '2024-06-26 01:37:27.983395', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1510, '测试树表删除', 1506, 4, '#', '', '', '1', '0', 'F', '0', '0', 'demo:tree:remove', '#', 103, 1, '2024-06-26 01:37:28.05596', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query_param", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1511, '测试树表导出', 1506, 5, '#', '', '', '1', '0', 'F', '0', '0', 'demo:tree:export', '#', 103, 1, '2024-06-26 01:37:28.118385', NULL, NULL, '');
COMMIT;

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS "NexusAI"."sys_notice";
CREATE TABLE "NexusAI"."sys_notice" (
  "notice_id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "notice_title" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "notice_type" char(1) COLLATE "pg_catalog"."default" NOT NULL,
  "notice_content" text COLLATE "pg_catalog"."default",
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "remark" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying
)
;
ALTER TABLE "NexusAI"."sys_notice" OWNER TO "zang";
COMMENT ON COLUMN "NexusAI"."sys_notice"."notice_id" IS '公告ID';
COMMENT ON COLUMN "NexusAI"."sys_notice"."tenant_id" IS '租户编号';
COMMENT ON COLUMN "NexusAI"."sys_notice"."notice_title" IS '公告标题';
COMMENT ON COLUMN "NexusAI"."sys_notice"."notice_type" IS '公告类型（1通知 2公告）';
COMMENT ON COLUMN "NexusAI"."sys_notice"."notice_content" IS '公告内容';
COMMENT ON COLUMN "NexusAI"."sys_notice"."status" IS '公告状态（0正常 1关闭）';
COMMENT ON COLUMN "NexusAI"."sys_notice"."create_dept" IS '创建部门';
COMMENT ON COLUMN "NexusAI"."sys_notice"."create_by" IS '创建者';
COMMENT ON COLUMN "NexusAI"."sys_notice"."create_time" IS '创建时间';
COMMENT ON COLUMN "NexusAI"."sys_notice"."update_by" IS '更新者';
COMMENT ON COLUMN "NexusAI"."sys_notice"."update_time" IS '更新时间';
COMMENT ON COLUMN "NexusAI"."sys_notice"."remark" IS '备注';
COMMENT ON TABLE "NexusAI"."sys_notice" IS '通知公告表';

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
BEGIN;
INSERT INTO "NexusAI"."sys_notice" ("notice_id", "tenant_id", "notice_title", "notice_type", "notice_content", "status", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1, '000000', '温馨提醒：2018-07-01 新版本发布啦', '2', '新版本内容', '0', 103, 1, '2024-06-26 01:37:46.075396', NULL, NULL, '管理员');
INSERT INTO "NexusAI"."sys_notice" ("notice_id", "tenant_id", "notice_title", "notice_type", "notice_content", "status", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2, '000000', '维护通知：2018-07-01 系统凌晨维护', '1', '维护内容', '0', 103, 1, '2024-06-26 01:37:46.162384', NULL, NULL, '管理员');
COMMIT;

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS "NexusAI"."sys_oper_log";
CREATE TABLE "NexusAI"."sys_oper_log" (
  "oper_id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "title" varchar(50) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "business_type" int4 DEFAULT 0,
  "method" varchar(100) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "request_method" varchar(10) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "operator_type" int4 DEFAULT 0,
  "oper_name" varchar(50) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "dept_name" varchar(50) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "oper_url" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "oper_ip" varchar(128) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "oper_location" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "oper_param" varchar(2000) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "json_result" varchar(2000) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "status" int4 DEFAULT 0,
  "error_msg" varchar(2000) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "oper_time" timestamp(6),
  "cost_time" int8 DEFAULT 0
)
;
ALTER TABLE "NexusAI"."sys_oper_log" OWNER TO "zang";
COMMENT ON COLUMN "NexusAI"."sys_oper_log"."oper_id" IS '日志主键';
COMMENT ON COLUMN "NexusAI"."sys_oper_log"."tenant_id" IS '租户编号';
COMMENT ON COLUMN "NexusAI"."sys_oper_log"."title" IS '模块标题';
COMMENT ON COLUMN "NexusAI"."sys_oper_log"."business_type" IS '业务类型（0其它 1新增 2修改 3删除）';
COMMENT ON COLUMN "NexusAI"."sys_oper_log"."method" IS '方法名称';
COMMENT ON COLUMN "NexusAI"."sys_oper_log"."request_method" IS '请求方式';
COMMENT ON COLUMN "NexusAI"."sys_oper_log"."operator_type" IS '操作类别（0其它 1后台用户 2手机端用户）';
COMMENT ON COLUMN "NexusAI"."sys_oper_log"."oper_name" IS '操作人员';
COMMENT ON COLUMN "NexusAI"."sys_oper_log"."dept_name" IS '部门名称';
COMMENT ON COLUMN "NexusAI"."sys_oper_log"."oper_url" IS '请求URL';
COMMENT ON COLUMN "NexusAI"."sys_oper_log"."oper_ip" IS '主机地址';
COMMENT ON COLUMN "NexusAI"."sys_oper_log"."oper_location" IS '操作地点';
COMMENT ON COLUMN "NexusAI"."sys_oper_log"."oper_param" IS '请求参数';
COMMENT ON COLUMN "NexusAI"."sys_oper_log"."json_result" IS '返回参数';
COMMENT ON COLUMN "NexusAI"."sys_oper_log"."status" IS '操作状态（0正常 1异常）';
COMMENT ON COLUMN "NexusAI"."sys_oper_log"."error_msg" IS '错误消息';
COMMENT ON COLUMN "NexusAI"."sys_oper_log"."oper_time" IS '操作时间';
COMMENT ON COLUMN "NexusAI"."sys_oper_log"."cost_time" IS '消耗时间';
COMMENT ON TABLE "NexusAI"."sys_oper_log" IS '操作日志记录';

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_oss
-- ----------------------------
DROP TABLE IF EXISTS "NexusAI"."sys_oss";
CREATE TABLE "NexusAI"."sys_oss" (
  "oss_id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "file_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "original_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "file_suffix" varchar(10) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "url" varchar(500) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "service" varchar(20) COLLATE "pg_catalog"."default" DEFAULT 'minio'::character varying
)
;
ALTER TABLE "NexusAI"."sys_oss" OWNER TO "zang";
COMMENT ON COLUMN "NexusAI"."sys_oss"."oss_id" IS '对象存储主键';
COMMENT ON COLUMN "NexusAI"."sys_oss"."tenant_id" IS '租户编码';
COMMENT ON COLUMN "NexusAI"."sys_oss"."file_name" IS '文件名';
COMMENT ON COLUMN "NexusAI"."sys_oss"."original_name" IS '原名';
COMMENT ON COLUMN "NexusAI"."sys_oss"."file_suffix" IS '文件后缀名';
COMMENT ON COLUMN "NexusAI"."sys_oss"."url" IS 'URL地址';
COMMENT ON COLUMN "NexusAI"."sys_oss"."create_dept" IS '创建部门';
COMMENT ON COLUMN "NexusAI"."sys_oss"."create_by" IS '上传人';
COMMENT ON COLUMN "NexusAI"."sys_oss"."create_time" IS '创建时间';
COMMENT ON COLUMN "NexusAI"."sys_oss"."update_by" IS '更新者';
COMMENT ON COLUMN "NexusAI"."sys_oss"."update_time" IS '更新时间';
COMMENT ON COLUMN "NexusAI"."sys_oss"."service" IS '服务商';
COMMENT ON TABLE "NexusAI"."sys_oss" IS 'OSS对象存储表';

-- ----------------------------
-- Records of sys_oss
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_oss_config
-- ----------------------------
DROP TABLE IF EXISTS "NexusAI"."sys_oss_config";
CREATE TABLE "NexusAI"."sys_oss_config" (
  "oss_config_id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "config_key" varchar(20) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "access_key" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "secret_key" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "bucket_name" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "prefix" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "endpoint" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "domain" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "is_https" char(1) COLLATE "pg_catalog"."default" DEFAULT 'N'::bpchar,
  "region" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "access_policy" char(1) COLLATE "pg_catalog"."default" NOT NULL DEFAULT '1'::bpchar,
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '1'::bpchar,
  "ext1" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default" DEFAULT ''::character varying
)
;
ALTER TABLE "NexusAI"."sys_oss_config" OWNER TO "zang";
COMMENT ON COLUMN "NexusAI"."sys_oss_config"."oss_config_id" IS '主键';
COMMENT ON COLUMN "NexusAI"."sys_oss_config"."tenant_id" IS '租户编码';
COMMENT ON COLUMN "NexusAI"."sys_oss_config"."config_key" IS '配置key';
COMMENT ON COLUMN "NexusAI"."sys_oss_config"."access_key" IS 'accessKey';
COMMENT ON COLUMN "NexusAI"."sys_oss_config"."secret_key" IS '秘钥';
COMMENT ON COLUMN "NexusAI"."sys_oss_config"."bucket_name" IS '桶名称';
COMMENT ON COLUMN "NexusAI"."sys_oss_config"."prefix" IS '前缀';
COMMENT ON COLUMN "NexusAI"."sys_oss_config"."endpoint" IS '访问站点';
COMMENT ON COLUMN "NexusAI"."sys_oss_config"."domain" IS '自定义域名';
COMMENT ON COLUMN "NexusAI"."sys_oss_config"."is_https" IS '是否https（Y=是,N=否）';
COMMENT ON COLUMN "NexusAI"."sys_oss_config"."region" IS '域';
COMMENT ON COLUMN "NexusAI"."sys_oss_config"."access_policy" IS '桶权限类型(0=private 1=public 2=custom)';
COMMENT ON COLUMN "NexusAI"."sys_oss_config"."status" IS '是否默认（0=是,1=否）';
COMMENT ON COLUMN "NexusAI"."sys_oss_config"."ext1" IS '扩展字段';
COMMENT ON COLUMN "NexusAI"."sys_oss_config"."create_dept" IS '创建部门';
COMMENT ON COLUMN "NexusAI"."sys_oss_config"."create_by" IS '创建者';
COMMENT ON COLUMN "NexusAI"."sys_oss_config"."create_time" IS '创建时间';
COMMENT ON COLUMN "NexusAI"."sys_oss_config"."update_by" IS '更新者';
COMMENT ON COLUMN "NexusAI"."sys_oss_config"."update_time" IS '更新时间';
COMMENT ON COLUMN "NexusAI"."sys_oss_config"."remark" IS '备注';
COMMENT ON TABLE "NexusAI"."sys_oss_config" IS '对象存储配置表';

-- ----------------------------
-- Records of sys_oss_config
-- ----------------------------
BEGIN;
INSERT INTO "NexusAI"."sys_oss_config" ("oss_config_id", "tenant_id", "config_key", "access_key", "secret_key", "bucket_name", "prefix", "endpoint", "domain", "is_https", "region", "access_policy", "status", "ext1", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1, '000000', 'minio', 'ruoyi', 'ruoyi123', 'ruoyi', '', '127.0.0.1:9000', '', 'N', '', '1', '0', '', 103, 1, '2024-06-26 01:37:52.490626', 1, '2024-06-26 01:37:52.490626', NULL);
INSERT INTO "NexusAI"."sys_oss_config" ("oss_config_id", "tenant_id", "config_key", "access_key", "secret_key", "bucket_name", "prefix", "endpoint", "domain", "is_https", "region", "access_policy", "status", "ext1", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2, '000000', 'qiniu', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'ruoyi', '', 's3-cn-north-1.qiniucs.com', '', 'N', '', '1', '1', '', 103, 1, '2024-06-26 01:37:52.555622', 1, '2024-06-26 01:37:52.555622', NULL);
INSERT INTO "NexusAI"."sys_oss_config" ("oss_config_id", "tenant_id", "config_key", "access_key", "secret_key", "bucket_name", "prefix", "endpoint", "domain", "is_https", "region", "access_policy", "status", "ext1", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3, '000000', 'aliyun', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'ruoyi', '', 'oss-cn-beijing.aliyuncs.com', '', 'N', '', '1', '1', '', 103, 1, '2024-06-26 01:37:52.617852', 1, '2024-06-26 01:37:52.617852', NULL);
INSERT INTO "NexusAI"."sys_oss_config" ("oss_config_id", "tenant_id", "config_key", "access_key", "secret_key", "bucket_name", "prefix", "endpoint", "domain", "is_https", "region", "access_policy", "status", "ext1", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (4, '000000', 'qcloud', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'ruoyi-1250000000', '', 'cos.ap-beijing.myqcloud.com', '', 'N', 'ap-beijing', '1', '1', '', 103, 1, '2024-06-26 01:37:52.690541', 1, '2024-06-26 01:37:52.690541', NULL);
INSERT INTO "NexusAI"."sys_oss_config" ("oss_config_id", "tenant_id", "config_key", "access_key", "secret_key", "bucket_name", "prefix", "endpoint", "domain", "is_https", "region", "access_policy", "status", "ext1", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (5, '000000', 'image', 'ruoyi', 'ruoyi123', 'ruoyi', 'image', '127.0.0.1:9000', '', 'N', '', '1', '1', '', 103, 1, '2024-06-26 01:37:52.755814', 1, '2024-06-26 01:37:52.755814', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS "NexusAI"."sys_post";
CREATE TABLE "NexusAI"."sys_post" (
  "post_id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "dept_id" int8,
  "post_code" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "post_category" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "post_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "post_sort" int4 NOT NULL,
  "status" char(1) COLLATE "pg_catalog"."default" NOT NULL,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying
)
;
ALTER TABLE "NexusAI"."sys_post" OWNER TO "zang";
COMMENT ON COLUMN "NexusAI"."sys_post"."post_id" IS '岗位ID';
COMMENT ON COLUMN "NexusAI"."sys_post"."tenant_id" IS '租户编号';
COMMENT ON COLUMN "NexusAI"."sys_post"."dept_id" IS '部门id';
COMMENT ON COLUMN "NexusAI"."sys_post"."post_code" IS '岗位编码';
COMMENT ON COLUMN "NexusAI"."sys_post"."post_category" IS '岗位类别编码';
COMMENT ON COLUMN "NexusAI"."sys_post"."post_name" IS '岗位名称';
COMMENT ON COLUMN "NexusAI"."sys_post"."post_sort" IS '显示顺序';
COMMENT ON COLUMN "NexusAI"."sys_post"."status" IS '状态（0正常 1停用）';
COMMENT ON COLUMN "NexusAI"."sys_post"."create_dept" IS '创建部门';
COMMENT ON COLUMN "NexusAI"."sys_post"."create_by" IS '创建者';
COMMENT ON COLUMN "NexusAI"."sys_post"."create_time" IS '创建时间';
COMMENT ON COLUMN "NexusAI"."sys_post"."update_by" IS '更新者';
COMMENT ON COLUMN "NexusAI"."sys_post"."update_time" IS '更新时间';
COMMENT ON COLUMN "NexusAI"."sys_post"."remark" IS '备注';
COMMENT ON TABLE "NexusAI"."sys_post" IS '岗位信息表';

-- ----------------------------
-- Records of sys_post
-- ----------------------------
BEGIN;
INSERT INTO "NexusAI"."sys_post" ("post_id", "tenant_id", "dept_id", "post_code", "post_category", "post_name", "post_sort", "status", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1, '000000', 103, 'ceo', NULL, '董事长', 1, '0', 103, 1, '2024-06-26 01:37:15.327794', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_post" ("post_id", "tenant_id", "dept_id", "post_code", "post_category", "post_name", "post_sort", "status", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2, '000000', 100, 'se', NULL, '项目经理', 2, '0', 103, 1, '2024-06-26 01:37:15.395662', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_post" ("post_id", "tenant_id", "dept_id", "post_code", "post_category", "post_name", "post_sort", "status", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3, '000000', 100, 'hr', NULL, '人力资源', 3, '0', 103, 1, '2024-06-26 01:37:15.472928', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_post" ("post_id", "tenant_id", "dept_id", "post_code", "post_category", "post_name", "post_sort", "status", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (4, '000000', 100, 'user', NULL, '普通员工', 4, '0', 103, 1, '2024-06-26 01:37:15.658097', NULL, NULL, '');
COMMIT;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS "NexusAI"."sys_role";
CREATE TABLE "NexusAI"."sys_role" (
  "role_id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "role_name" varchar(30) COLLATE "pg_catalog"."default" NOT NULL,
  "role_key" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "role_sort" int4 NOT NULL,
  "data_scope" char(1) COLLATE "pg_catalog"."default" DEFAULT '1'::bpchar,
  "menu_check_strictly" bool DEFAULT true,
  "dept_check_strictly" bool DEFAULT true,
  "status" char(1) COLLATE "pg_catalog"."default" NOT NULL,
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying
)
;
ALTER TABLE "NexusAI"."sys_role" OWNER TO "zang";
COMMENT ON COLUMN "NexusAI"."sys_role"."role_id" IS '角色ID';
COMMENT ON COLUMN "NexusAI"."sys_role"."tenant_id" IS '租户编号';
COMMENT ON COLUMN "NexusAI"."sys_role"."role_name" IS '角色名称';
COMMENT ON COLUMN "NexusAI"."sys_role"."role_key" IS '角色权限字符串';
COMMENT ON COLUMN "NexusAI"."sys_role"."role_sort" IS '显示顺序';
COMMENT ON COLUMN "NexusAI"."sys_role"."data_scope" IS '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）';
COMMENT ON COLUMN "NexusAI"."sys_role"."menu_check_strictly" IS '菜单树选择项是否关联显示';
COMMENT ON COLUMN "NexusAI"."sys_role"."dept_check_strictly" IS '部门树选择项是否关联显示';
COMMENT ON COLUMN "NexusAI"."sys_role"."status" IS '角色状态（0正常 1停用）';
COMMENT ON COLUMN "NexusAI"."sys_role"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "NexusAI"."sys_role"."create_dept" IS '创建部门';
COMMENT ON COLUMN "NexusAI"."sys_role"."create_by" IS '创建者';
COMMENT ON COLUMN "NexusAI"."sys_role"."create_time" IS '创建时间';
COMMENT ON COLUMN "NexusAI"."sys_role"."update_by" IS '更新者';
COMMENT ON COLUMN "NexusAI"."sys_role"."update_time" IS '更新时间';
COMMENT ON COLUMN "NexusAI"."sys_role"."remark" IS '备注';
COMMENT ON TABLE "NexusAI"."sys_role" IS '角色信息表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO "NexusAI"."sys_role" ("role_id", "tenant_id", "role_name", "role_key", "role_sort", "data_scope", "menu_check_strictly", "dept_check_strictly", "status", "del_flag", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1, '000000', '超级管理员', 'superadmin', 1, '1', 'f', 'f', '0', '0', 103, 1, '2024-06-26 01:37:17.768065', NULL, NULL, '超级管理员');
INSERT INTO "NexusAI"."sys_role" ("role_id", "tenant_id", "role_name", "role_key", "role_sort", "data_scope", "menu_check_strictly", "dept_check_strictly", "status", "del_flag", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3, '000000', '本部门及以下', 'test1', 3, '4', 'f', 'f', '0', '0', 103, 1, '2024-06-26 01:37:18.178691', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_role" ("role_id", "tenant_id", "role_name", "role_key", "role_sort", "data_scope", "menu_check_strictly", "dept_check_strictly", "status", "del_flag", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (4, '000000', '仅本人', 'test2', 4, '5', 'f', 'f', '0', '0', 103, 1, '2024-06-26 01:37:18.248316', NULL, NULL, '');
COMMIT;

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS "NexusAI"."sys_role_dept";
CREATE TABLE "NexusAI"."sys_role_dept" (
  "role_id" int8 NOT NULL,
  "dept_id" int8 NOT NULL
)
;
ALTER TABLE "NexusAI"."sys_role_dept" OWNER TO "zang";
COMMENT ON COLUMN "NexusAI"."sys_role_dept"."role_id" IS '角色ID';
COMMENT ON COLUMN "NexusAI"."sys_role_dept"."dept_id" IS '部门ID';
COMMENT ON TABLE "NexusAI"."sys_role_dept" IS '角色和部门关联表';

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS "NexusAI"."sys_role_menu";
CREATE TABLE "NexusAI"."sys_role_menu" (
  "role_id" int8 NOT NULL,
  "menu_id" int8 NOT NULL
)
;
ALTER TABLE "NexusAI"."sys_role_menu" OWNER TO "zang";
COMMENT ON COLUMN "NexusAI"."sys_role_menu"."role_id" IS '角色ID';
COMMENT ON COLUMN "NexusAI"."sys_role_menu"."menu_id" IS '菜单ID';
COMMENT ON TABLE "NexusAI"."sys_role_menu" IS '角色和菜单关联表';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
BEGIN;
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 5);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 100);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 101);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 102);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 103);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 104);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 105);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 106);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 107);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 108);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 500);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 501);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1001);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1002);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1003);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1004);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1005);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1006);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1007);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1008);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1009);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1010);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1011);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1012);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1013);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1014);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1015);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1016);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1017);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1018);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1019);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1020);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1021);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1022);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1023);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1024);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1025);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1026);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1027);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1028);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1029);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1030);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1031);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1032);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1033);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1034);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1035);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1036);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1037);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1038);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1039);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1040);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1041);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1042);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1043);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1044);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1045);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1500);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1501);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1502);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1503);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1504);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1505);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1506);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1507);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1508);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1509);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1510);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1511);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 5);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 1500);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 1501);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 1502);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 1503);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 1504);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 1505);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 1506);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 1507);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 1508);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 1509);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 1510);
INSERT INTO "NexusAI"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 1511);
COMMIT;

-- ----------------------------
-- Table structure for sys_social
-- ----------------------------
DROP TABLE IF EXISTS "NexusAI"."sys_social";
CREATE TABLE "NexusAI"."sys_social" (
  "id" int8 NOT NULL,
  "user_id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "auth_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "source" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "open_id" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "user_name" varchar(30) COLLATE "pg_catalog"."default" NOT NULL,
  "nick_name" varchar(30) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "email" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "avatar" varchar(500) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "access_token" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "expire_in" int8,
  "refresh_token" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "access_code" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "union_id" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "scope" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "token_type" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "id_token" varchar(2000) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "mac_algorithm" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "mac_key" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "code" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "oauth_token" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "oauth_token_secret" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar
)
;
ALTER TABLE "NexusAI"."sys_social" OWNER TO "zang";
COMMENT ON COLUMN "NexusAI"."sys_social"."id" IS '主键';
COMMENT ON COLUMN "NexusAI"."sys_social"."user_id" IS '用户ID';
COMMENT ON COLUMN "NexusAI"."sys_social"."tenant_id" IS '租户id';
COMMENT ON COLUMN "NexusAI"."sys_social"."auth_id" IS '平台+平台唯一id';
COMMENT ON COLUMN "NexusAI"."sys_social"."source" IS '用户来源';
COMMENT ON COLUMN "NexusAI"."sys_social"."open_id" IS '平台编号唯一id';
COMMENT ON COLUMN "NexusAI"."sys_social"."user_name" IS '登录账号';
COMMENT ON COLUMN "NexusAI"."sys_social"."nick_name" IS '用户昵称';
COMMENT ON COLUMN "NexusAI"."sys_social"."email" IS '用户邮箱';
COMMENT ON COLUMN "NexusAI"."sys_social"."avatar" IS '头像地址';
COMMENT ON COLUMN "NexusAI"."sys_social"."access_token" IS '用户的授权令牌';
COMMENT ON COLUMN "NexusAI"."sys_social"."expire_in" IS '用户的授权令牌的有效期，部分平台可能没有';
COMMENT ON COLUMN "NexusAI"."sys_social"."refresh_token" IS '刷新令牌，部分平台可能没有';
COMMENT ON COLUMN "NexusAI"."sys_social"."access_code" IS '平台的授权信息，部分平台可能没有';
COMMENT ON COLUMN "NexusAI"."sys_social"."union_id" IS '用户的 unionid';
COMMENT ON COLUMN "NexusAI"."sys_social"."scope" IS '授予的权限，部分平台可能没有';
COMMENT ON COLUMN "NexusAI"."sys_social"."token_type" IS '个别平台的授权信息，部分平台可能没有';
COMMENT ON COLUMN "NexusAI"."sys_social"."id_token" IS 'id token，部分平台可能没有';
COMMENT ON COLUMN "NexusAI"."sys_social"."mac_algorithm" IS '小米平台用户的附带属性，部分平台可能没有';
COMMENT ON COLUMN "NexusAI"."sys_social"."mac_key" IS '小米平台用户的附带属性，部分平台可能没有';
COMMENT ON COLUMN "NexusAI"."sys_social"."code" IS '用户的授权code，部分平台可能没有';
COMMENT ON COLUMN "NexusAI"."sys_social"."oauth_token" IS 'Twitter平台用户的附带属性，部分平台可能没有';
COMMENT ON COLUMN "NexusAI"."sys_social"."oauth_token_secret" IS 'Twitter平台用户的附带属性，部分平台可能没有';
COMMENT ON COLUMN "NexusAI"."sys_social"."create_dept" IS '创建部门';
COMMENT ON COLUMN "NexusAI"."sys_social"."create_by" IS '创建者';
COMMENT ON COLUMN "NexusAI"."sys_social"."create_time" IS '创建时间';
COMMENT ON COLUMN "NexusAI"."sys_social"."update_by" IS '更新者';
COMMENT ON COLUMN "NexusAI"."sys_social"."update_time" IS '更新时间';
COMMENT ON COLUMN "NexusAI"."sys_social"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON TABLE "NexusAI"."sys_social" IS '社会化关系表';

-- ----------------------------
-- Records of sys_social
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_tenant
-- ----------------------------
DROP TABLE IF EXISTS "NexusAI"."sys_tenant";
CREATE TABLE "NexusAI"."sys_tenant" (
  "id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "contact_user_name" varchar(20) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "contact_phone" varchar(20) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "company_name" varchar(50) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "license_number" varchar(30) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "address" varchar(200) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "intro" varchar(200) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "domain" varchar(200) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "remark" varchar(200) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "package_id" int8,
  "expire_time" timestamp(6),
  "account_count" int4 DEFAULT '-1'::integer,
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6)
)
;
ALTER TABLE "NexusAI"."sys_tenant" OWNER TO "zang";
COMMENT ON COLUMN "NexusAI"."sys_tenant"."tenant_id" IS '租户编号';
COMMENT ON COLUMN "NexusAI"."sys_tenant"."contact_phone" IS '联系电话';
COMMENT ON COLUMN "NexusAI"."sys_tenant"."company_name" IS '联系人';
COMMENT ON COLUMN "NexusAI"."sys_tenant"."license_number" IS '统一社会信用代码';
COMMENT ON COLUMN "NexusAI"."sys_tenant"."address" IS '地址';
COMMENT ON COLUMN "NexusAI"."sys_tenant"."intro" IS '企业简介';
COMMENT ON COLUMN "NexusAI"."sys_tenant"."domain" IS '域名';
COMMENT ON COLUMN "NexusAI"."sys_tenant"."remark" IS '备注';
COMMENT ON COLUMN "NexusAI"."sys_tenant"."package_id" IS '租户套餐编号';
COMMENT ON COLUMN "NexusAI"."sys_tenant"."expire_time" IS '过期时间';
COMMENT ON COLUMN "NexusAI"."sys_tenant"."account_count" IS '用户数量（-1不限制）';
COMMENT ON COLUMN "NexusAI"."sys_tenant"."status" IS '租户状态（0正常 1停用）';
COMMENT ON COLUMN "NexusAI"."sys_tenant"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "NexusAI"."sys_tenant"."create_dept" IS '创建部门';
COMMENT ON COLUMN "NexusAI"."sys_tenant"."create_by" IS '创建者';
COMMENT ON COLUMN "NexusAI"."sys_tenant"."create_time" IS '创建时间';
COMMENT ON COLUMN "NexusAI"."sys_tenant"."update_by" IS '更新者';
COMMENT ON COLUMN "NexusAI"."sys_tenant"."update_time" IS '更新时间';
COMMENT ON TABLE "NexusAI"."sys_tenant" IS '租户表';

-- ----------------------------
-- Records of sys_tenant
-- ----------------------------
BEGIN;
INSERT INTO "NexusAI"."sys_tenant" ("id", "tenant_id", "contact_user_name", "contact_phone", "company_name", "license_number", "address", "intro", "domain", "remark", "package_id", "expire_time", "account_count", "status", "del_flag", "create_dept", "create_by", "create_time", "update_by", "update_time") VALUES (1, '000000', '管理组', '15888888888', 'XXX有限公司', NULL, NULL, '多租户通用后台管理管理系统', NULL, NULL, NULL, NULL, -1, '0', '0', 103, 1, '2024-06-26 01:36:59.415414', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_tenant_package
-- ----------------------------
DROP TABLE IF EXISTS "NexusAI"."sys_tenant_package";
CREATE TABLE "NexusAI"."sys_tenant_package" (
  "package_id" int8 NOT NULL,
  "package_name" varchar(20) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "menu_ids" varchar(3000) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "remark" varchar(200) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "menu_check_strictly" bool DEFAULT true,
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6)
)
;
ALTER TABLE "NexusAI"."sys_tenant_package" OWNER TO "zang";
COMMENT ON COLUMN "NexusAI"."sys_tenant_package"."package_id" IS '租户套餐id';
COMMENT ON COLUMN "NexusAI"."sys_tenant_package"."package_name" IS '套餐名称';
COMMENT ON COLUMN "NexusAI"."sys_tenant_package"."menu_ids" IS '关联菜单id';
COMMENT ON COLUMN "NexusAI"."sys_tenant_package"."remark" IS '备注';
COMMENT ON COLUMN "NexusAI"."sys_tenant_package"."status" IS '状态（0正常 1停用）';
COMMENT ON COLUMN "NexusAI"."sys_tenant_package"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "NexusAI"."sys_tenant_package"."create_dept" IS '创建部门';
COMMENT ON COLUMN "NexusAI"."sys_tenant_package"."create_by" IS '创建者';
COMMENT ON COLUMN "NexusAI"."sys_tenant_package"."create_time" IS '创建时间';
COMMENT ON COLUMN "NexusAI"."sys_tenant_package"."update_by" IS '更新者';
COMMENT ON COLUMN "NexusAI"."sys_tenant_package"."update_time" IS '更新时间';
COMMENT ON TABLE "NexusAI"."sys_tenant_package" IS '租户套餐表';

-- ----------------------------
-- Records of sys_tenant_package
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS "NexusAI"."sys_user";
CREATE TABLE "NexusAI"."sys_user" (
  "user_id" int8 NOT NULL,
  "dept_id" int8,
  "user_name" varchar(30) COLLATE "pg_catalog"."default" NOT NULL,
  "nick_name" varchar(30) COLLATE "pg_catalog"."default" NOT NULL,
  "user_type" varchar(10) COLLATE "pg_catalog"."default" DEFAULT 'sys_user'::character varying,
  "email" varchar(50) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "phonenumber" varchar(11) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "sex" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "avatar" int8,
  "password" varchar(100) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "login_ip" varchar(128) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "login_date" timestamp(6),
  "create_dept" int8,
  "create_by" int8,
  "create_time" time(6),
  "update_by" int8,
  "update_time" date,
  "remark" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "gmt_deleted" date DEFAULT '2001-01-01'::date
)
;
ALTER TABLE "NexusAI"."sys_user" OWNER TO "zang";
COMMENT ON COLUMN "NexusAI"."sys_user"."user_id" IS '用户ID';
COMMENT ON COLUMN "NexusAI"."sys_user"."dept_id" IS '部门ID';
COMMENT ON COLUMN "NexusAI"."sys_user"."user_name" IS '用户账号';
COMMENT ON COLUMN "NexusAI"."sys_user"."nick_name" IS '用户昵称';
COMMENT ON COLUMN "NexusAI"."sys_user"."user_type" IS '用户类型（sys_user系统用户）';
COMMENT ON COLUMN "NexusAI"."sys_user"."email" IS '用户邮箱';
COMMENT ON COLUMN "NexusAI"."sys_user"."phonenumber" IS '手机号码';
COMMENT ON COLUMN "NexusAI"."sys_user"."sex" IS '用户性别（0男 1女 2未知）';
COMMENT ON COLUMN "NexusAI"."sys_user"."avatar" IS '头像地址';
COMMENT ON COLUMN "NexusAI"."sys_user"."password" IS '密码';
COMMENT ON COLUMN "NexusAI"."sys_user"."status" IS '帐号状态（0正常 1停用）';
COMMENT ON COLUMN "NexusAI"."sys_user"."login_ip" IS '最后登陆IP';
COMMENT ON COLUMN "NexusAI"."sys_user"."login_date" IS '最后登陆时间';
COMMENT ON COLUMN "NexusAI"."sys_user"."create_dept" IS '创建部门';
COMMENT ON COLUMN "NexusAI"."sys_user"."create_by" IS '创建者';
COMMENT ON COLUMN "NexusAI"."sys_user"."create_time" IS '创建时间';
COMMENT ON COLUMN "NexusAI"."sys_user"."update_by" IS '更新者';
COMMENT ON COLUMN "NexusAI"."sys_user"."update_time" IS '更新时间';
COMMENT ON COLUMN "NexusAI"."sys_user"."remark" IS '备注';
COMMENT ON TABLE "NexusAI"."sys_user" IS '用户信息表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO "NexusAI"."sys_user" ("user_id", "dept_id", "user_name", "nick_name", "user_type", "email", "phonenumber", "sex", "avatar", "password", "status", "login_ip", "login_date", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark", "gmt_deleted") VALUES (1, 103, 'admin', '疯狂的狮子Li', 'sys_user', 'crazyLionLi@163.com', '15888888888', '1', NULL, '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '127.0.0.1', '2024-06-26 01:37:13.29806', 103, 1, '01:37:13.29806', NULL, NULL, '管理员', '2001-01-01');
INSERT INTO "NexusAI"."sys_user" ("user_id", "dept_id", "user_name", "nick_name", "user_type", "email", "phonenumber", "sex", "avatar", "password", "status", "login_ip", "login_date", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark", "gmt_deleted") VALUES (3, 108, 'test', '本部门及以下 密码666666', 'sys_user', '', '', '0', NULL, '$2a$10$b8yUzN0C71sbz.PhNOCgJe.Tu1yWC3RNrTyjSQ8p1W0.aaUXUJ.Ne', '0', '127.0.0.1', '2024-06-26 01:37:13.370913', 103, 1, '01:37:13.370913', 3, '2024-06-26', NULL, '2001-01-01');
INSERT INTO "NexusAI"."sys_user" ("user_id", "dept_id", "user_name", "nick_name", "user_type", "email", "phonenumber", "sex", "avatar", "password", "status", "login_ip", "login_date", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark", "gmt_deleted") VALUES (4, 102, 'test1', '仅本人 密码666666', 'sys_user', '', '', '0', NULL, '$2a$10$b8yUzN0C71sbz.PhNOCgJe.Tu1yWC3RNrTyjSQ8p1W0.aaUXUJ.Ne', '0', '127.0.0.1', '2024-06-26 01:37:13.49844', 103, 1, '01:37:13.49844', 4, '2024-06-26', NULL, '2001-01-01');
INSERT INTO "NexusAI"."sys_user" ("user_id", "dept_id", "user_name", "nick_name", "user_type", "email", "phonenumber", "sex", "avatar", "password", "status", "login_ip", "login_date", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark", "gmt_deleted") VALUES (2, 1, 'userName_fqlme', 'nickName_b2x9o', 'userTyp', 'email_1da80', '11111111111', '0', 1, 'password_bnij8', '1', 'loginIp_hlq1u', '2024-06-26 14:23:18', NULL, NULL, '15:48:22.326', NULL, '2024-06-26', 'remark_qn4ll', '2001-01-01');
COMMIT;

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS "NexusAI"."sys_user_post";
CREATE TABLE "NexusAI"."sys_user_post" (
  "user_id" int8 NOT NULL,
  "post_id" int8 NOT NULL
)
;
ALTER TABLE "NexusAI"."sys_user_post" OWNER TO "zang";
COMMENT ON COLUMN "NexusAI"."sys_user_post"."user_id" IS '用户ID';
COMMENT ON COLUMN "NexusAI"."sys_user_post"."post_id" IS '岗位ID';
COMMENT ON TABLE "NexusAI"."sys_user_post" IS '用户与岗位关联表';

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
BEGIN;
INSERT INTO "NexusAI"."sys_user_post" ("user_id", "post_id") VALUES (1, 1);
COMMIT;

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS "NexusAI"."sys_user_role";
CREATE TABLE "NexusAI"."sys_user_role" (
  "user_id" int8 NOT NULL,
  "role_id" int8 NOT NULL
)
;
ALTER TABLE "NexusAI"."sys_user_role" OWNER TO "zang";
COMMENT ON COLUMN "NexusAI"."sys_user_role"."user_id" IS '用户ID';
COMMENT ON COLUMN "NexusAI"."sys_user_role"."role_id" IS '角色ID';
COMMENT ON TABLE "NexusAI"."sys_user_role" IS '用户和角色关联表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
BEGIN;
INSERT INTO "NexusAI"."sys_user_role" ("user_id", "role_id") VALUES (1, 1);
INSERT INTO "NexusAI"."sys_user_role" ("user_id", "role_id") VALUES (3, 3);
INSERT INTO "NexusAI"."sys_user_role" ("user_id", "role_id") VALUES (4, 4);
COMMIT;

-- ----------------------------
-- Table structure for test_demo
-- ----------------------------
DROP TABLE IF EXISTS "NexusAI"."test_demo";
CREATE TABLE "NexusAI"."test_demo" (
  "id" int8,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "dept_id" int8,
  "user_id" int8,
  "order_num" int4 DEFAULT 0,
  "test_key" varchar(255) COLLATE "pg_catalog"."default",
  "value" varchar(255) COLLATE "pg_catalog"."default",
  "version" int4 DEFAULT 0,
  "create_dept" int8,
  "create_time" timestamp(6),
  "create_by" int8,
  "update_time" timestamp(6),
  "update_by" int8,
  "del_flag" int4 DEFAULT 0
)
;
ALTER TABLE "NexusAI"."test_demo" OWNER TO "zang";
COMMENT ON COLUMN "NexusAI"."test_demo"."id" IS '主键';
COMMENT ON COLUMN "NexusAI"."test_demo"."tenant_id" IS '租户编号';
COMMENT ON COLUMN "NexusAI"."test_demo"."dept_id" IS '部门id';
COMMENT ON COLUMN "NexusAI"."test_demo"."user_id" IS '用户id';
COMMENT ON COLUMN "NexusAI"."test_demo"."order_num" IS '排序号';
COMMENT ON COLUMN "NexusAI"."test_demo"."test_key" IS 'key键';
COMMENT ON COLUMN "NexusAI"."test_demo"."value" IS '值';
COMMENT ON COLUMN "NexusAI"."test_demo"."version" IS '版本';
COMMENT ON COLUMN "NexusAI"."test_demo"."create_dept" IS '创建部门';
COMMENT ON COLUMN "NexusAI"."test_demo"."create_time" IS '创建时间';
COMMENT ON COLUMN "NexusAI"."test_demo"."create_by" IS '创建人';
COMMENT ON COLUMN "NexusAI"."test_demo"."update_time" IS '更新时间';
COMMENT ON COLUMN "NexusAI"."test_demo"."update_by" IS '更新人';
COMMENT ON COLUMN "NexusAI"."test_demo"."del_flag" IS '删除标志';
COMMENT ON TABLE "NexusAI"."test_demo" IS '测试单表';

-- ----------------------------
-- Records of test_demo
-- ----------------------------
BEGIN;
INSERT INTO "NexusAI"."test_demo" ("id", "tenant_id", "dept_id", "user_id", "order_num", "test_key", "value", "version", "create_dept", "create_time", "create_by", "update_time", "update_by", "del_flag") VALUES (1, '000000', 102, 4, 1, '测试数据权限', '测试', 0, 103, '2024-06-26 01:37:56.315299', 1, NULL, NULL, 0);
INSERT INTO "NexusAI"."test_demo" ("id", "tenant_id", "dept_id", "user_id", "order_num", "test_key", "value", "version", "create_dept", "create_time", "create_by", "update_time", "update_by", "del_flag") VALUES (2, '000000', 102, 3, 2, '子节点1', '111', 0, 103, '2024-06-26 01:37:56.37803', 1, NULL, NULL, 0);
INSERT INTO "NexusAI"."test_demo" ("id", "tenant_id", "dept_id", "user_id", "order_num", "test_key", "value", "version", "create_dept", "create_time", "create_by", "update_time", "update_by", "del_flag") VALUES (3, '000000', 102, 3, 3, '子节点2', '222', 0, 103, '2024-06-26 01:37:56.450628', 1, NULL, NULL, 0);
INSERT INTO "NexusAI"."test_demo" ("id", "tenant_id", "dept_id", "user_id", "order_num", "test_key", "value", "version", "create_dept", "create_time", "create_by", "update_time", "update_by", "del_flag") VALUES (4, '000000', 108, 4, 4, '测试数据', 'demo', 0, 103, '2024-06-26 01:37:56.512737', 1, NULL, NULL, 0);
INSERT INTO "NexusAI"."test_demo" ("id", "tenant_id", "dept_id", "user_id", "order_num", "test_key", "value", "version", "create_dept", "create_time", "create_by", "update_time", "update_by", "del_flag") VALUES (5, '000000', 108, 3, 13, '子节点11', '1111', 0, 103, '2024-06-26 01:37:56.577914', 1, NULL, NULL, 0);
INSERT INTO "NexusAI"."test_demo" ("id", "tenant_id", "dept_id", "user_id", "order_num", "test_key", "value", "version", "create_dept", "create_time", "create_by", "update_time", "update_by", "del_flag") VALUES (6, '000000', 108, 3, 12, '子节点22', '2222', 0, 103, '2024-06-26 01:37:56.635411', 1, NULL, NULL, 0);
INSERT INTO "NexusAI"."test_demo" ("id", "tenant_id", "dept_id", "user_id", "order_num", "test_key", "value", "version", "create_dept", "create_time", "create_by", "update_time", "update_by", "del_flag") VALUES (7, '000000', 108, 3, 11, '子节点33', '3333', 0, 103, '2024-06-26 01:37:56.697778', 1, NULL, NULL, 0);
INSERT INTO "NexusAI"."test_demo" ("id", "tenant_id", "dept_id", "user_id", "order_num", "test_key", "value", "version", "create_dept", "create_time", "create_by", "update_time", "update_by", "del_flag") VALUES (8, '000000', 108, 3, 10, '子节点44', '4444', 0, 103, '2024-06-26 01:37:56.763213', 1, NULL, NULL, 0);
INSERT INTO "NexusAI"."test_demo" ("id", "tenant_id", "dept_id", "user_id", "order_num", "test_key", "value", "version", "create_dept", "create_time", "create_by", "update_time", "update_by", "del_flag") VALUES (9, '000000', 108, 3, 9, '子节点55', '5555', 0, 103, '2024-06-26 01:37:56.827279', 1, NULL, NULL, 0);
INSERT INTO "NexusAI"."test_demo" ("id", "tenant_id", "dept_id", "user_id", "order_num", "test_key", "value", "version", "create_dept", "create_time", "create_by", "update_time", "update_by", "del_flag") VALUES (10, '000000', 108, 3, 8, '子节点66', '6666', 0, 103, '2024-06-26 01:37:56.898181', 1, NULL, NULL, 0);
INSERT INTO "NexusAI"."test_demo" ("id", "tenant_id", "dept_id", "user_id", "order_num", "test_key", "value", "version", "create_dept", "create_time", "create_by", "update_time", "update_by", "del_flag") VALUES (11, '000000', 108, 3, 7, '子节点77', '7777', 0, 103, '2024-06-26 01:37:56.977732', 1, NULL, NULL, 0);
INSERT INTO "NexusAI"."test_demo" ("id", "tenant_id", "dept_id", "user_id", "order_num", "test_key", "value", "version", "create_dept", "create_time", "create_by", "update_time", "update_by", "del_flag") VALUES (12, '000000', 108, 3, 6, '子节点88', '8888', 0, 103, '2024-06-26 01:37:57.035451', 1, NULL, NULL, 0);
INSERT INTO "NexusAI"."test_demo" ("id", "tenant_id", "dept_id", "user_id", "order_num", "test_key", "value", "version", "create_dept", "create_time", "create_by", "update_time", "update_by", "del_flag") VALUES (13, '000000', 108, 3, 5, '子节点99', '9999', 0, 103, '2024-06-26 01:37:57.098147', 1, NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for test_tree
-- ----------------------------
DROP TABLE IF EXISTS "NexusAI"."test_tree";
CREATE TABLE "NexusAI"."test_tree" (
  "id" int8,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "parent_id" int8 DEFAULT 0,
  "dept_id" int8,
  "user_id" int8,
  "tree_name" varchar(255) COLLATE "pg_catalog"."default",
  "version" int4 DEFAULT 0,
  "create_dept" int8,
  "create_time" timestamp(6),
  "create_by" int8,
  "update_time" timestamp(6),
  "update_by" int8,
  "del_flag" int4 DEFAULT 0
)
;
ALTER TABLE "NexusAI"."test_tree" OWNER TO "zang";
COMMENT ON COLUMN "NexusAI"."test_tree"."id" IS '主键';
COMMENT ON COLUMN "NexusAI"."test_tree"."tenant_id" IS '租户编号';
COMMENT ON COLUMN "NexusAI"."test_tree"."parent_id" IS '父id';
COMMENT ON COLUMN "NexusAI"."test_tree"."dept_id" IS '部门id';
COMMENT ON COLUMN "NexusAI"."test_tree"."user_id" IS '用户id';
COMMENT ON COLUMN "NexusAI"."test_tree"."tree_name" IS '值';
COMMENT ON COLUMN "NexusAI"."test_tree"."version" IS '版本';
COMMENT ON COLUMN "NexusAI"."test_tree"."create_dept" IS '创建部门';
COMMENT ON COLUMN "NexusAI"."test_tree"."create_time" IS '创建时间';
COMMENT ON COLUMN "NexusAI"."test_tree"."create_by" IS '创建人';
COMMENT ON COLUMN "NexusAI"."test_tree"."update_time" IS '更新时间';
COMMENT ON COLUMN "NexusAI"."test_tree"."update_by" IS '更新人';
COMMENT ON COLUMN "NexusAI"."test_tree"."del_flag" IS '删除标志';
COMMENT ON TABLE "NexusAI"."test_tree" IS '测试树表';

-- ----------------------------
-- Records of test_tree
-- ----------------------------
BEGIN;
INSERT INTO "NexusAI"."test_tree" ("id", "tenant_id", "parent_id", "dept_id", "user_id", "tree_name", "version", "create_dept", "create_time", "create_by", "update_time", "update_by", "del_flag") VALUES (1, '000000', 0, 102, 4, '测试数据权限', 0, 103, '2024-06-26 01:37:57.175362', 1, NULL, NULL, 0);
INSERT INTO "NexusAI"."test_tree" ("id", "tenant_id", "parent_id", "dept_id", "user_id", "tree_name", "version", "create_dept", "create_time", "create_by", "update_time", "update_by", "del_flag") VALUES (2, '000000', 1, 102, 3, '子节点1', 0, 103, '2024-06-26 01:37:57.242673', 1, NULL, NULL, 0);
INSERT INTO "NexusAI"."test_tree" ("id", "tenant_id", "parent_id", "dept_id", "user_id", "tree_name", "version", "create_dept", "create_time", "create_by", "update_time", "update_by", "del_flag") VALUES (3, '000000', 2, 102, 3, '子节点2', 0, 103, '2024-06-26 01:37:57.308302', 1, NULL, NULL, 0);
INSERT INTO "NexusAI"."test_tree" ("id", "tenant_id", "parent_id", "dept_id", "user_id", "tree_name", "version", "create_dept", "create_time", "create_by", "update_time", "update_by", "del_flag") VALUES (4, '000000', 0, 108, 4, '测试树1', 0, 103, '2024-06-26 01:37:57.387736', 1, NULL, NULL, 0);
INSERT INTO "NexusAI"."test_tree" ("id", "tenant_id", "parent_id", "dept_id", "user_id", "tree_name", "version", "create_dept", "create_time", "create_by", "update_time", "update_by", "del_flag") VALUES (5, '000000', 4, 108, 3, '子节点11', 0, 103, '2024-06-26 01:37:57.450359', 1, NULL, NULL, 0);
INSERT INTO "NexusAI"."test_tree" ("id", "tenant_id", "parent_id", "dept_id", "user_id", "tree_name", "version", "create_dept", "create_time", "create_by", "update_time", "update_by", "del_flag") VALUES (6, '000000', 4, 108, 3, '子节点22', 0, 103, '2024-06-26 01:37:57.515542', 1, NULL, NULL, 0);
INSERT INTO "NexusAI"."test_tree" ("id", "tenant_id", "parent_id", "dept_id", "user_id", "tree_name", "version", "create_dept", "create_time", "create_by", "update_time", "update_by", "del_flag") VALUES (7, '000000', 4, 108, 3, '子节点33', 0, 103, '2024-06-26 01:37:57.577771', 1, NULL, NULL, 0);
INSERT INTO "NexusAI"."test_tree" ("id", "tenant_id", "parent_id", "dept_id", "user_id", "tree_name", "version", "create_dept", "create_time", "create_by", "update_time", "update_by", "del_flag") VALUES (8, '000000', 5, 108, 3, '子节点44', 0, 103, '2024-06-26 01:37:57.647575', 1, NULL, NULL, 0);
INSERT INTO "NexusAI"."test_tree" ("id", "tenant_id", "parent_id", "dept_id", "user_id", "tree_name", "version", "create_dept", "create_time", "create_by", "update_time", "update_by", "del_flag") VALUES (9, '000000', 6, 108, 3, '子节点55', 0, 103, '2024-06-26 01:37:57.715856', 1, NULL, NULL, 0);
INSERT INTO "NexusAI"."test_tree" ("id", "tenant_id", "parent_id", "dept_id", "user_id", "tree_name", "version", "create_dept", "create_time", "create_by", "update_time", "update_by", "del_flag") VALUES (10, '000000', 7, 108, 3, '子节点66', 0, 103, '2024-06-26 01:37:57.795779', 1, NULL, NULL, 0);
INSERT INTO "NexusAI"."test_tree" ("id", "tenant_id", "parent_id", "dept_id", "user_id", "tree_name", "version", "create_dept", "create_time", "create_by", "update_time", "update_by", "del_flag") VALUES (11, '000000', 7, 108, 3, '子节点77', 0, 103, '2024-06-26 01:37:57.857919', 1, NULL, NULL, 0);
INSERT INTO "NexusAI"."test_tree" ("id", "tenant_id", "parent_id", "dept_id", "user_id", "tree_name", "version", "create_dept", "create_time", "create_by", "update_time", "update_by", "del_flag") VALUES (12, '000000', 10, 108, 3, '子节点88', 0, 103, '2024-06-26 01:37:57.930286', 1, NULL, NULL, 0);
INSERT INTO "NexusAI"."test_tree" ("id", "tenant_id", "parent_id", "dept_id", "user_id", "tree_name", "version", "create_dept", "create_time", "create_by", "update_time", "update_by", "del_flag") VALUES (13, '000000', 10, 108, 3, '子节点99', 0, 103, '2024-06-26 01:37:58.002733', 1, NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Function structure for cast_varchar_to_timestamp
-- ----------------------------
DROP FUNCTION IF EXISTS "NexusAI"."cast_varchar_to_timestamp"(varchar);
CREATE OR REPLACE FUNCTION "NexusAI"."cast_varchar_to_timestamp"(varchar)
  RETURNS "pg_catalog"."timestamptz" AS $BODY$
select to_timestamp($1, 'yyyy-mm-dd hh24:mi:ss');
$BODY$
  LANGUAGE sql VOLATILE STRICT
  COST 100;
ALTER FUNCTION "NexusAI"."cast_varchar_to_timestamp"(varchar) OWNER TO "zang";

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "NexusAI"."conversations_conversation_id_seq"
OWNED BY "NexusAI"."chat_conversations"."conversation_id";
SELECT setval('"NexusAI"."conversations_conversation_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "NexusAI"."messages_message_id_seq"
OWNED BY "NexusAI"."chat_messages"."message_id";
SELECT setval('"NexusAI"."messages_message_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "NexusAI"."usage_stats_stat_id_seq"
OWNED BY "NexusAI"."chat_usage_stats"."stat_id";
SELECT setval('"NexusAI"."usage_stats_stat_id_seq"', 1, false);

-- ----------------------------
-- Primary Key structure for table chat_conversations
-- ----------------------------
ALTER TABLE "NexusAI"."chat_conversations" ADD CONSTRAINT "conversations_pkey" PRIMARY KEY ("conversation_id");

-- ----------------------------
-- Primary Key structure for table chat_messages
-- ----------------------------
ALTER TABLE "NexusAI"."chat_messages" ADD CONSTRAINT "messages_pkey" PRIMARY KEY ("message_id");

-- ----------------------------
-- Primary Key structure for table chat_usage_stats
-- ----------------------------
ALTER TABLE "NexusAI"."chat_usage_stats" ADD CONSTRAINT "usage_stats_pkey" PRIMARY KEY ("stat_id");

-- ----------------------------
-- Primary Key structure for table gen_table
-- ----------------------------
ALTER TABLE "NexusAI"."gen_table" ADD CONSTRAINT "gen_table_pk" PRIMARY KEY ("table_id");

-- ----------------------------
-- Primary Key structure for table gen_table_column
-- ----------------------------
ALTER TABLE "NexusAI"."gen_table_column" ADD CONSTRAINT "gen_table_column_pk" PRIMARY KEY ("column_id");

-- ----------------------------
-- Primary Key structure for table sys_client
-- ----------------------------
ALTER TABLE "NexusAI"."sys_client" ADD CONSTRAINT "sys_client_pk" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table sys_config
-- ----------------------------
ALTER TABLE "NexusAI"."sys_config" ADD CONSTRAINT "sys_config_pk" PRIMARY KEY ("config_id");

-- ----------------------------
-- Primary Key structure for table sys_dept
-- ----------------------------
ALTER TABLE "NexusAI"."sys_dept" ADD CONSTRAINT "sys_dept_pk" PRIMARY KEY ("dept_id");

-- ----------------------------
-- Primary Key structure for table sys_dict_data
-- ----------------------------
ALTER TABLE "NexusAI"."sys_dict_data" ADD CONSTRAINT "sys_dict_data_pk" PRIMARY KEY ("dict_code");

-- ----------------------------
-- Indexes structure for table sys_dict_type
-- ----------------------------
CREATE UNIQUE INDEX "sys_dict_type_index1" ON "NexusAI"."sys_dict_type" USING btree (
  "tenant_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "dict_type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table sys_dict_type
-- ----------------------------
ALTER TABLE "NexusAI"."sys_dict_type" ADD CONSTRAINT "sys_dict_type_pk" PRIMARY KEY ("dict_id");

-- ----------------------------
-- Indexes structure for table sys_logininfor
-- ----------------------------
CREATE INDEX "idx_sys_logininfor_lt" ON "NexusAI"."sys_logininfor" USING btree (
  "login_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_sys_logininfor_s" ON "NexusAI"."sys_logininfor" USING btree (
  "status" COLLATE "pg_catalog"."default" "pg_catalog"."bpchar_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table sys_logininfor
-- ----------------------------
ALTER TABLE "NexusAI"."sys_logininfor" ADD CONSTRAINT "sys_logininfor_pk" PRIMARY KEY ("info_id");

-- ----------------------------
-- Primary Key structure for table sys_menu
-- ----------------------------
ALTER TABLE "NexusAI"."sys_menu" ADD CONSTRAINT "sys_menu_pk" PRIMARY KEY ("menu_id");

-- ----------------------------
-- Primary Key structure for table sys_notice
-- ----------------------------
ALTER TABLE "NexusAI"."sys_notice" ADD CONSTRAINT "sys_notice_pk" PRIMARY KEY ("notice_id");

-- ----------------------------
-- Indexes structure for table sys_oper_log
-- ----------------------------
CREATE INDEX "idx_sys_oper_log_bt" ON "NexusAI"."sys_oper_log" USING btree (
  "business_type" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_sys_oper_log_ot" ON "NexusAI"."sys_oper_log" USING btree (
  "oper_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_sys_oper_log_s" ON "NexusAI"."sys_oper_log" USING btree (
  "status" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table sys_oper_log
-- ----------------------------
ALTER TABLE "NexusAI"."sys_oper_log" ADD CONSTRAINT "sys_oper_log_pk" PRIMARY KEY ("oper_id");

-- ----------------------------
-- Primary Key structure for table sys_oss
-- ----------------------------
ALTER TABLE "NexusAI"."sys_oss" ADD CONSTRAINT "sys_oss_pk" PRIMARY KEY ("oss_id");

-- ----------------------------
-- Primary Key structure for table sys_oss_config
-- ----------------------------
ALTER TABLE "NexusAI"."sys_oss_config" ADD CONSTRAINT "sys_oss_config_pk" PRIMARY KEY ("oss_config_id");

-- ----------------------------
-- Primary Key structure for table sys_post
-- ----------------------------
ALTER TABLE "NexusAI"."sys_post" ADD CONSTRAINT "sys_post_pk" PRIMARY KEY ("post_id");

-- ----------------------------
-- Primary Key structure for table sys_role
-- ----------------------------
ALTER TABLE "NexusAI"."sys_role" ADD CONSTRAINT "sys_role_pk" PRIMARY KEY ("role_id");

-- ----------------------------
-- Primary Key structure for table sys_role_dept
-- ----------------------------
ALTER TABLE "NexusAI"."sys_role_dept" ADD CONSTRAINT "sys_role_dept_pk" PRIMARY KEY ("role_id", "dept_id");

-- ----------------------------
-- Primary Key structure for table sys_role_menu
-- ----------------------------
ALTER TABLE "NexusAI"."sys_role_menu" ADD CONSTRAINT "sys_role_menu_pk" PRIMARY KEY ("role_id", "menu_id");

-- ----------------------------
-- Primary Key structure for table sys_social
-- ----------------------------
ALTER TABLE "NexusAI"."sys_social" ADD CONSTRAINT "pk_sys_social" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table sys_tenant
-- ----------------------------
ALTER TABLE "NexusAI"."sys_tenant" ADD CONSTRAINT "pk_sys_tenant" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table sys_tenant_package
-- ----------------------------
ALTER TABLE "NexusAI"."sys_tenant_package" ADD CONSTRAINT "pk_sys_tenant_package" PRIMARY KEY ("package_id");

-- ----------------------------
-- Primary Key structure for table sys_user
-- ----------------------------
ALTER TABLE "NexusAI"."sys_user" ADD CONSTRAINT "sys_user_pk" PRIMARY KEY ("user_id");

-- ----------------------------
-- Primary Key structure for table sys_user_post
-- ----------------------------
ALTER TABLE "NexusAI"."sys_user_post" ADD CONSTRAINT "sys_user_post_pk" PRIMARY KEY ("user_id", "post_id");

-- ----------------------------
-- Primary Key structure for table sys_user_role
-- ----------------------------
ALTER TABLE "NexusAI"."sys_user_role" ADD CONSTRAINT "sys_user_role_pk" PRIMARY KEY ("user_id", "role_id");
