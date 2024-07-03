/*
 Navicat Premium Dump SQL

 Source Catalog        : zang
 Source Schema         : NexusAI

 Target Server Type    : PostgreSQL
 Target Server Version : 160002 (160002)
 File Encoding         : 65001

 Date: 03/07/2024 11:42:30
*/


-- ----------------------------
-- Table structure for file_detail
-- ----------------------------
DROP TABLE IF EXISTS "NexusAI"."file_detail";
CREATE TABLE "NexusAI"."file_detail" (
  "id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "url" varchar(512) COLLATE "pg_catalog"."default" NOT NULL,
  "size" int8,
  "filename" varchar(256) COLLATE "pg_catalog"."default",
  "original_filename" varchar(256) COLLATE "pg_catalog"."default",
  "base_path" varchar(256) COLLATE "pg_catalog"."default",
  "path" varchar(256) COLLATE "pg_catalog"."default",
  "ext" varchar(32) COLLATE "pg_catalog"."default",
  "content_type" varchar(128) COLLATE "pg_catalog"."default",
  "platform" varchar(32) COLLATE "pg_catalog"."default",
  "th_url" varchar(512) COLLATE "pg_catalog"."default",
  "th_filename" varchar(256) COLLATE "pg_catalog"."default",
  "th_size" int8,
  "th_content_type" varchar(128) COLLATE "pg_catalog"."default",
  "object_id" varchar(32) COLLATE "pg_catalog"."default",
  "object_type" varchar(32) COLLATE "pg_catalog"."default",
  "metadata" text COLLATE "pg_catalog"."default",
  "user_metadata" text COLLATE "pg_catalog"."default",
  "th_metadata" text COLLATE "pg_catalog"."default",
  "th_user_metadata" text COLLATE "pg_catalog"."default",
  "attr" text COLLATE "pg_catalog"."default",
  "file_acl" varchar(32) COLLATE "pg_catalog"."default",
  "th_file_acl" varchar(32) COLLATE "pg_catalog"."default",
  "hash_info" text COLLATE "pg_catalog"."default",
  "upload_id" varchar(128) COLLATE "pg_catalog"."default",
  "upload_status" int4,
  "create_time" timestamp(6),
  "user_id" int8
)
;
ALTER TABLE "NexusAI"."file_detail" OWNER TO "zang";
COMMENT ON COLUMN "NexusAI"."file_detail"."id" IS '文件id';
COMMENT ON COLUMN "NexusAI"."file_detail"."url" IS '文件访问地址';
COMMENT ON COLUMN "NexusAI"."file_detail"."size" IS '文件大小，单位字节';
COMMENT ON COLUMN "NexusAI"."file_detail"."filename" IS '文件名称';
COMMENT ON COLUMN "NexusAI"."file_detail"."original_filename" IS '原始文件名';
COMMENT ON COLUMN "NexusAI"."file_detail"."base_path" IS '基础存储路径';
COMMENT ON COLUMN "NexusAI"."file_detail"."path" IS '存储路径';
COMMENT ON COLUMN "NexusAI"."file_detail"."ext" IS '文件扩展名';
COMMENT ON COLUMN "NexusAI"."file_detail"."content_type" IS 'MIME类型';
COMMENT ON COLUMN "NexusAI"."file_detail"."platform" IS '存储平台';
COMMENT ON COLUMN "NexusAI"."file_detail"."th_url" IS '缩略图访问路径';
COMMENT ON COLUMN "NexusAI"."file_detail"."th_filename" IS '缩略图名称';
COMMENT ON COLUMN "NexusAI"."file_detail"."th_size" IS '缩略图大小，单位字节';
COMMENT ON COLUMN "NexusAI"."file_detail"."th_content_type" IS '缩略图MIME类型';
COMMENT ON COLUMN "NexusAI"."file_detail"."object_id" IS '文件所属对象id';
COMMENT ON COLUMN "NexusAI"."file_detail"."object_type" IS '文件所属对象类型，例如用户头像，评价图片';
COMMENT ON COLUMN "NexusAI"."file_detail"."metadata" IS '文件元数据';
COMMENT ON COLUMN "NexusAI"."file_detail"."user_metadata" IS '文件用户元数据';
COMMENT ON COLUMN "NexusAI"."file_detail"."th_metadata" IS '缩略图元数据';
COMMENT ON COLUMN "NexusAI"."file_detail"."th_user_metadata" IS '缩略图用户元数据';
COMMENT ON COLUMN "NexusAI"."file_detail"."attr" IS '附加属性';
COMMENT ON COLUMN "NexusAI"."file_detail"."file_acl" IS '文件ACL';
COMMENT ON COLUMN "NexusAI"."file_detail"."th_file_acl" IS '缩略图文件ACL';
COMMENT ON COLUMN "NexusAI"."file_detail"."hash_info" IS '哈希信息';
COMMENT ON COLUMN "NexusAI"."file_detail"."upload_id" IS '上传ID，仅在手动分片上传时使用';
COMMENT ON COLUMN "NexusAI"."file_detail"."upload_status" IS '上传状态，仅在手动分片上传时使用，1：初始化完成，2：上传完成';
COMMENT ON COLUMN "NexusAI"."file_detail"."create_time" IS '创建时间';

-- ----------------------------
-- Primary Key structure for table file_detail
-- ----------------------------
ALTER TABLE "NexusAI"."file_detail" ADD CONSTRAINT "file_detail_pkey" PRIMARY KEY ("id");
