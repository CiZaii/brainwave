/*
 Navicat Premium Data Transfer

 Source Server         : root
 Source Server Type    : PostgreSQL
 Source Server Version : 140012 (140012)
 Source Host           : localhost:5432
 Source Catalog        : zang
 Source Schema         : NexusAI

 Target Server Type    : PostgreSQL
 Target Server Version : 140012 (140012)
 File Encoding         : 65001

 Date: 04/07/2024 14:29:01
*/


-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS "NexusAI"."sys_role";
CREATE TABLE "NexusAI"."sys_role" (
  "role_id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "role_name" varchar(30) COLLATE "pg_catalog"."default" NOT NULL,
  "role_key" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "key_desc" varchar(255) COLLATE "pg_catalog"."default",
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying
)
;
ALTER TABLE "NexusAI"."sys_role" OWNER TO "fengweizhao";
COMMENT ON COLUMN "NexusAI"."sys_role"."role_id" IS '角色ID';
COMMENT ON COLUMN "NexusAI"."sys_role"."tenant_id" IS '租户编号';
COMMENT ON COLUMN "NexusAI"."sys_role"."role_name" IS '角色名称';
COMMENT ON COLUMN "NexusAI"."sys_role"."role_key" IS '角色权限字符串';
COMMENT ON COLUMN "NexusAI"."sys_role"."key_desc" IS '权限描述';
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
INSERT INTO "NexusAI"."sys_role" ("role_id", "tenant_id", "role_name", "role_key", "key_desc", "del_flag", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1, '000000', '超级管理员', 'superadmin', '1', '0', 103, 1, '2024-06-26 01:37:17.768065', NULL, NULL, '超级管理员');
INSERT INTO "NexusAI"."sys_role" ("role_id", "tenant_id", "role_name", "role_key", "key_desc", "del_flag", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3, '000000', '本部门及以下', 'test1', '3', '0', 103, 1, '2024-06-26 01:37:18.178691', NULL, NULL, '');
INSERT INTO "NexusAI"."sys_role" ("role_id", "tenant_id", "role_name", "role_key", "key_desc", "del_flag", "create_dept", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (4, '000000', '仅本人', 'test2', '4', '0', 103, 1, '2024-06-26 01:37:18.248316', NULL, NULL, '');
COMMIT;

-- ----------------------------
-- Primary Key structure for table sys_role
-- ----------------------------
ALTER TABLE "NexusAI"."sys_role" ADD CONSTRAINT "sys_role_pk" PRIMARY KEY ("role_id");
