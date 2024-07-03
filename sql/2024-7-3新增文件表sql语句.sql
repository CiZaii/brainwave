CREATE TABLE file_part_detail
(
    id          varchar(32) NOT NULL,
    platform    varchar(32),
    upload_id   varchar(128),
    e_tag       varchar(255),
    part_number integer,
    part_size   bigint,
    hash_info   text,
    create_time timestamp,
    PRIMARY KEY (id)
);

-- 添加字段注释
COMMENT ON COLUMN file_part_detail.id IS '分片id';
COMMENT ON COLUMN file_part_detail.platform IS '存储平台';
COMMENT ON COLUMN file_part_detail.upload_id IS '上传ID，仅在手动分片上传时使用';
COMMENT ON COLUMN file_part_detail.e_tag IS '分片 ETag';
COMMENT ON COLUMN file_part_detail.part_number IS '分片号。每一个上传的分片都有一个分片号，一般情况下取值范围是1~10000';
COMMENT ON COLUMN file_part_detail.part_size IS '文件大小，单位字节';
COMMENT ON COLUMN file_part_detail.hash_info IS '哈希信息';
COMMENT ON COLUMN file_part_detail.create_time IS '创建时间';

CREATE TABLE file_detail
(
    id                varchar(32)  NOT NULL,
    url               varchar(512) NOT NULL,
    size              bigint,
    filename          varchar(256),
    original_filename varchar(256),
    base_path         varchar(256),
    path              varchar(256),
    ext               varchar(32),
    content_type      varchar(128),
    platform          varchar(32),
    th_url            varchar(512),
    th_filename       varchar(256),
    th_size           bigint,
    th_content_type   varchar(128),
    object_id         varchar(32),
    object_type       varchar(32),
    metadata          text,
    user_metadata     text,
    th_metadata       text,
    th_user_metadata  text,
    attr              text,
    file_acl          varchar(32),
    th_file_acl       varchar(32),
    hash_info         text,
    upload_id         varchar(128),
    upload_status     integer,
    create_time       timestamp,
    PRIMARY KEY (id)
);

-- 添加字段注释
COMMENT ON COLUMN file_detail.id IS '文件id';
COMMENT ON COLUMN file_detail.url IS '文件访问地址';
COMMENT ON COLUMN file_detail.size IS '文件大小，单位字节';
COMMENT ON COLUMN file_detail.filename IS '文件名称';
COMMENT ON COLUMN file_detail.original_filename IS '原始文件名';
COMMENT ON COLUMN file_detail.base_path IS '基础存储路径';
COMMENT ON COLUMN file_detail.path IS '存储路径';
COMMENT ON COLUMN file_detail.ext IS '文件扩展名';
COMMENT ON COLUMN file_detail.content_type IS 'MIME类型';
COMMENT ON COLUMN file_detail.platform IS '存储平台';
COMMENT ON COLUMN file_detail.th_url IS '缩略图访问路径';
COMMENT ON COLUMN file_detail.th_filename IS '缩略图名称';
COMMENT ON COLUMN file_detail.th_size IS '缩略图大小，单位字节';
COMMENT ON COLUMN file_detail.th_content_type IS '缩略图MIME类型';
COMMENT ON COLUMN file_detail.object_id IS '文件所属对象id';
COMMENT ON COLUMN file_detail.object_type IS '文件所属对象类型，例如用户头像，评价图片';
COMMENT ON COLUMN file_detail.metadata IS '文件元数据';
COMMENT ON COLUMN file_detail.user_metadata IS '文件用户元数据';
COMMENT ON COLUMN file_detail.th_metadata IS '缩略图元数据';
COMMENT ON COLUMN file_detail.th_user_metadata IS '缩略图用户元数据';
COMMENT ON COLUMN file_detail.attr IS '附加属性';
COMMENT ON COLUMN file_detail.file_acl IS '文件ACL';
COMMENT ON COLUMN file_detail.th_file_acl IS '缩略图文件ACL';
COMMENT ON COLUMN file_detail.hash_info IS '哈希信息';
COMMENT ON COLUMN file_detail.upload_id IS '上传ID，仅在手动分片上传时使用';
COMMENT ON COLUMN file_detail.upload_status IS '上传状态，仅在手动分片上传时使用，1：初始化完成，2：上传完成';
COMMENT ON COLUMN file_detail.create_time IS '创建时间';