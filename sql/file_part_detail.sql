/*
 Navicat Premium Dump SQL


 Date: 03/07/2024 11:43:32
*/


-- ----------------------------
-- Table structure for file_part_detail
-- ----------------------------
DROP TABLE IF EXISTS "NexusAI"."file_part_detail";
CREATE TABLE "NexusAI"."file_part_detail" (
  "id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "platform" varchar(32) COLLATE "pg_catalog"."default",
  "upload_id" varchar(128) COLLATE "pg_catalog"."default",
  "e_tag" varchar(255) COLLATE "pg_catalog"."default",
  "part_number" int4,
  "part_size" int8,
  "hash_info" text COLLATE "pg_catalog"."default",
  "create_time" timestamp(6)
)
;
ALTER TABLE "NexusAI"."file_part_detail" OWNER TO "zang";
COMMENT ON COLUMN "NexusAI"."file_part_detail"."id" IS '分片id';
COMMENT ON COLUMN "NexusAI"."file_part_detail"."platform" IS '存储平台';
COMMENT ON COLUMN "NexusAI"."file_part_detail"."upload_id" IS '上传ID，仅在手动分片上传时使用';
COMMENT ON COLUMN "NexusAI"."file_part_detail"."e_tag" IS '分片 ETag';
COMMENT ON COLUMN "NexusAI"."file_part_detail"."part_number" IS '分片号。每一个上传的分片都有一个分片号，一般情况下取值范围是1~10000';
COMMENT ON COLUMN "NexusAI"."file_part_detail"."part_size" IS '文件大小，单位字节';
COMMENT ON COLUMN "NexusAI"."file_part_detail"."hash_info" IS '哈希信息';
COMMENT ON COLUMN "NexusAI"."file_part_detail"."create_time" IS '创建时间';

-- ----------------------------
-- Primary Key structure for table file_part_detail
-- ----------------------------
ALTER TABLE "NexusAI"."file_part_detail" ADD CONSTRAINT "file_part_detail_pkey" PRIMARY KEY ("id");
