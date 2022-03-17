-----------------------------------------
--version[2.13.0], DO NOT EDIT THIS LINE!
-----------------------------------------

--版本
CREATE TABLE DATAGEAR_VERSION
(
	VERSION_VALUE VARCHAR(100)
);

--用户
CREATE TABLE DATAGEAR_USER
(
	USER_ID VARCHAR(50) NOT NULL,
	USER_NAME VARCHAR(50) NOT NULL,
	USER_PASSWORD VARCHAR(200) NOT NULL,
	USER_REAL_NAME VARCHAR(100),
	USER_EMAIL VARCHAR(200),
	USER_IS_ADMIN VARCHAR(20),
	USER_CREATE_TIME TIMESTAMP
);

ALTER TABLE DATAGEAR_USER ADD CONSTRAINT DG_PK_USER_ID PRIMARY KEY (USER_ID);

ALTER TABLE DATAGEAR_USER ADD CONSTRAINT DG_UK_USER_NAME UNIQUE (USER_NAME);

--内置管理员账号：admin/admin
INSERT INTO DATAGEAR_USER VALUES('admin', 'admin', '4c6d8d058a4db956660f0ee51fcb515f93471a086fc676bfb71ba2ceece5bf4702c61cefab3fa54b', '', '', 'true', CURRENT_TIMESTAMP);

--角色
CREATE TABLE DATAGEAR_ROLE
(
	ROLE_ID VARCHAR(50) NOT NULL,
	ROLE_NAME VARCHAR(100) NOT NULL,
	ROLE_DESCRIPTION VARCHAR(200),
	ROLE_ENABLED VARCHAR(10) NOT NULL,
	ROLE_CREATE_TIME TIMESTAMP
);

ALTER TABLE DATAGEAR_ROLE ADD CONSTRAINT DG_PK_ROLE_ID PRIMARY KEY (ROLE_ID);

--内置角色
INSERT INTO DATAGEAR_ROLE VALUES('ROLE_REGISTRY', '注册用户', '系统新添加和注册的用户都会自动添加至此角色', 'true', CURRENT_TIMESTAMP);

INSERT INTO DATAGEAR_ROLE VALUES('ROLE_DATA_ADMIN', '数据管理员', '可以管理数据源、数据集、图表、看板', 'true', CURRENT_TIMESTAMP);

INSERT INTO DATAGEAR_ROLE VALUES('ROLE_DATA_ANALYST', '数据分析员', '仅可查看数据源、数据集、图表、看板，展示图表和看板', 'true', CURRENT_TIMESTAMP);

--角色用户
CREATE TABLE DATAGEAR_ROLE_USER
(
	RU_ID VARCHAR(50) NOT NULL,
	RU_ROLE_ID VARCHAR(50) NOT NULL,
	RU_USER_ID VARCHAR(50) NOT NULL
);

ALTER TABLE DATAGEAR_ROLE_USER ADD CONSTRAINT DG_PK_RU_ID PRIMARY KEY (RU_ID);

ALTER TABLE DATAGEAR_ROLE_USER ADD CONSTRAINT DG_FK_RU_ROLE_ID FOREIGN KEY (RU_ROLE_ID) REFERENCES DATAGEAR_ROLE (ROLE_ID) ON DELETE CASCADE;

ALTER TABLE DATAGEAR_ROLE_USER ADD CONSTRAINT DG_FK_RU_USER_ID FOREIGN KEY (RU_USER_ID) REFERENCES DATAGEAR_USER (USER_ID) ON DELETE CASCADE;

ALTER TABLE DATAGEAR_ROLE_USER ADD CONSTRAINT DG_UK_RU_ROLE_USER_ID UNIQUE (RU_ROLE_ID, RU_USER_ID);

--内置用户角色
INSERT INTO DATAGEAR_ROLE_USER VALUES('RUREGADMIN', 'ROLE_REGISTRY', 'admin');

INSERT INTO DATAGEAR_ROLE_USER VALUES('RUDAADMIN', 'ROLE_DATA_ADMIN', 'admin');

--授权
CREATE TABLE DATAGEAR_AUTHORIZATION
(
	AUTH_ID VARCHAR(50) NOT NULL,
	AUTH_RESOURCE VARCHAR(200) NOT NULL,
	AUTH_RESOURCE_TYPE VARCHAR(50) NOT NULL,
	AUTH_PRINCIPAL VARCHAR(200) NOT NULL,
	AUTH_PRINCIPAL_TYPE VARCHAR(50) NOT NULL,
	AUTH_PERMISSION SMALLINT NOT NULL,
	AUTH_ENABLED VARCHAR(10) NOT NULL,
	AUTH_CREATE_TIME TIMESTAMP
);

ALTER TABLE DATAGEAR_AUTHORIZATION ADD CONSTRAINT DG_PK_AUTH_ID PRIMARY KEY (AUTH_ID);

--数据源
CREATE TABLE DATAGEAR_SCHEMA
(
	SCHEMA_ID VARCHAR(50) NOT NULL,
	SCHEMA_TITLE VARCHAR(100) NOT NULL,
	SCHEMA_URL VARCHAR(1000) NOT NULL,
	SCHEMA_USER VARCHAR(200),
	SCHEMA_PASSWORD VARCHAR(200),
	SCHEMA_CREATE_USER_ID VARCHAR(50),
	SCHEMA_CREATE_TIME TIMESTAMP,
	SCHEMA_SHARED VARCHAR(20),
	DRIVER_ENTITY_ID VARCHAR(100)
);

ALTER TABLE DATAGEAR_SCHEMA ADD CONSTRAINT DG_PK_SCHEMA_ID PRIMARY KEY (SCHEMA_ID);

--数据源防护
CREATE TABLE DATAGEAR_SCHEMA_GUARD
(
	SG_ID VARCHAR(50) NOT NULL,
	SG_PATTERN VARCHAR(200) NOT NULL,
	SG_PERMITTED VARCHAR(20) NOT NULL,
	SG_PRIORITY INTEGER NOT NULL,
	SG_ENABLED VARCHAR(20) NOT NULL,
	SG_CREATE_TIME TIMESTAMP
);

ALTER TABLE DATAGEAR_SCHEMA_GUARD ADD CONSTRAINT DG_PK_SG_ID PRIMARY KEY (SG_ID);

--SQL历史
CREATE TABLE DATAGEAR_SQL_HISTORY
(
	SQLHIS_ID VARCHAR(50) NOT NULL,
	SQLHIS_SQL VARCHAR(5000) NOT NULL,
	SQLHIS_SCHEMA_ID VARCHAR(50) NOT NULL,
	SQLHIS_USER_ID VARCHAR(50) NOT NULL,
	SQLHIS_CREATE_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE DATAGEAR_SQL_HISTORY ADD CONSTRAINT DG_PK_SQLHIS_ID PRIMARY KEY (SQLHIS_ID);

ALTER TABLE DATAGEAR_SQL_HISTORY ADD CONSTRAINT DG_FK_SQLHIS_SCHEMA_ID FOREIGN KEY (SQLHIS_SCHEMA_ID) REFERENCES DATAGEAR_SCHEMA (SCHEMA_ID) ON DELETE CASCADE;

--数据分析项目
CREATE TABLE DATAGEAR_ANALYSIS_PROJECT
(
	AP_ID VARCHAR(50) NOT NULL,
	AP_NAME VARCHAR(100) NOT NULL,
	AP_DESC VARCHAR(500),
	AP_CREATE_USER_ID VARCHAR(50),
	AP_CREATE_TIME TIMESTAMP
);

ALTER TABLE DATAGEAR_ANALYSIS_PROJECT ADD CONSTRAINT DG_PK_AP_ID PRIMARY KEY (AP_ID);

--数据集
CREATE TABLE DATAGEAR_DATA_SET
(
	DS_ID VARCHAR(50) NOT NULL,
	DS_NAME VARCHAR(100) NOT NULL,
	DS_TYPE VARCHAR(50) NOT NULL,
	DS_AP_ID VARCHAR(50),
	DS_DATA_FORMAT VARCHAR(500),
	DS_CREATE_USER_ID VARCHAR(50),
	DS_CREATE_TIME TIMESTAMP
);

ALTER TABLE DATAGEAR_DATA_SET ADD CONSTRAINT DG_PK_DS_ID PRIMARY KEY (DS_ID);

ALTER TABLE DATAGEAR_DATA_SET ADD CONSTRAINT DG_FK_DS_APP_ID FOREIGN KEY (DS_AP_ID) REFERENCES DATAGEAR_ANALYSIS_PROJECT (AP_ID);

CREATE INDEX DG_IDX_DS_CREATE_USER_ID ON DATAGEAR_DATA_SET(DS_CREATE_USER_ID);

--数据集属性
CREATE TABLE DATAGEAR_DATA_SET_PROP
(
	PROP_DS_ID VARCHAR(50) NOT NULL,
	PROP_NAME VARCHAR(100) NOT NULL,
	PROP_TYPE VARCHAR(50) NOT NULL,
	PROP_LABEL VARCHAR(100),
	PROP_DFT_VALUE VARCHAR(100),
	PROP_ORDER INTEGER
);

ALTER TABLE DATAGEAR_DATA_SET_PROP ADD CONSTRAINT DG_FK_DS_PROP_DS_ID FOREIGN KEY (PROP_DS_ID) REFERENCES DATAGEAR_DATA_SET (DS_ID) ON DELETE CASCADE;

ALTER TABLE DATAGEAR_DATA_SET_PROP ADD CONSTRAINT DG_UK_DS_PROP_DS_ID_NAME UNIQUE (PROP_DS_ID, PROP_NAME);

--数据集参数
CREATE TABLE DATAGEAR_DATA_SET_PAR
(
	PAR_DS_ID VARCHAR(50) NOT NULL,
	PAR_NAME VARCHAR(100) NOT NULL,
	PAR_TYPE VARCHAR(100) NOT NULL,
	PAR_REQUIRED VARCHAR(10),
	PAR_DESC VARCHAR(200),
	PAR_INPUT_TYPE VARCHAR(50),
	PAR_INPUT_PAYLOAD VARCHAR(1000),
	PAR_ORDER INTEGER
);

ALTER TABLE DATAGEAR_DATA_SET_PAR ADD CONSTRAINT DG_FK_DS_PAR_DS_ID FOREIGN KEY (PAR_DS_ID) REFERENCES DATAGEAR_DATA_SET (DS_ID) ON DELETE CASCADE;

ALTER TABLE DATAGEAR_DATA_SET_PAR ADD CONSTRAINT DG_UK_DS_PAR_DS_ID_NAME UNIQUE (PAR_DS_ID, PAR_NAME);

--数据集资源目录
CREATE TABLE DATAGEAR_DSR_DIRECTORY
(
	DD_ID VARCHAR(50) NOT NULL,
	DD_DIRECTORY VARCHAR(250) NOT NULL,
	DD_DESC VARCHAR(500),
	DD_CREATE_USER_ID VARCHAR(50),
	DD_CREATE_TIME TIMESTAMP
);

ALTER TABLE DATAGEAR_DSR_DIRECTORY ADD CONSTRAINT DG_PK_DD_ID PRIMARY KEY (DD_ID);

--SQL数据集
CREATE TABLE DATAGEAR_DATA_SET_SQL
(
	DS_ID VARCHAR(50) NOT NULL,
	DS_SCHEMA_ID VARCHAR(50) NOT NULL,
	DS_SQL VARCHAR(10000) NOT NULL
);

ALTER TABLE DATAGEAR_DATA_SET_SQL ADD CONSTRAINT DG_PK_DS_SQL_ID PRIMARY KEY (DS_ID);

ALTER TABLE DATAGEAR_DATA_SET_SQL ADD CONSTRAINT DG_FK_DS_SQL_SCHEMA_ID FOREIGN KEY (DS_SCHEMA_ID) REFERENCES DATAGEAR_SCHEMA (SCHEMA_ID);

ALTER TABLE DATAGEAR_DATA_SET_SQL ADD CONSTRAINT DG_FK_DS_SQL_DS_ID FOREIGN KEY (DS_ID) REFERENCES DATAGEAR_DATA_SET (DS_ID) ON DELETE CASCADE;

--JSON值数据集
CREATE TABLE DATAGEAR_DATA_SET_JSON_VALUE
(
	DS_ID VARCHAR(50) NOT NULL,
	DS_VALUE VARCHAR(10000) NOT NULL
);

ALTER TABLE DATAGEAR_DATA_SET_JSON_VALUE ADD CONSTRAINT DG_PK_DS_JSONV_ID PRIMARY KEY (DS_ID);

ALTER TABLE DATAGEAR_DATA_SET_JSON_VALUE ADD CONSTRAINT DG_FK_DS_JSONV_DS_ID FOREIGN KEY (DS_ID) REFERENCES DATAGEAR_DATA_SET (DS_ID) ON DELETE CASCADE;

--JSON文件数据集
CREATE TABLE DATAGEAR_DATA_SET_JSON_FILE
(
	DS_ID VARCHAR(50) NOT NULL,
	DS_FILE_NAME VARCHAR(100) NOT NULL,
	DS_DISPLAY_NAME VARCHAR(100) NOT NULL,
	DS_FILE_ENCODING VARCHAR(50),
	DS_DATA_JSON_PATH VARCHAR(200),
	DS_FILE_SOURCE_TYPE VARCHAR(50) NOT NULL,
	DS_DSRD_ID VARCHAR(50),
	DS_DSRD_FILE_NAME VARCHAR(500)
);

ALTER TABLE DATAGEAR_DATA_SET_JSON_FILE ADD CONSTRAINT DG_PK_DS_JSONF_ID PRIMARY KEY (DS_ID);

ALTER TABLE DATAGEAR_DATA_SET_JSON_FILE ADD CONSTRAINT DG_FK_DS_JSONF_DS_ID FOREIGN KEY (DS_ID) REFERENCES DATAGEAR_DATA_SET (DS_ID) ON DELETE CASCADE;

ALTER TABLE DATAGEAR_DATA_SET_JSON_FILE ADD CONSTRAINT DG_FK_DS_JSONF_DSRD_ID FOREIGN KEY (DS_DSRD_ID) REFERENCES DATAGEAR_DSR_DIRECTORY (DD_ID);

--Excel文件数据集
CREATE TABLE DATAGEAR_DATA_SET_EXCEL
(
	DS_ID VARCHAR(50) NOT NULL,
	DS_FILE_NAME VARCHAR(100) NOT NULL,
	DS_DISPLAY_NAME VARCHAR(100) NOT NULL,
	DS_SHEET_INDEX INTEGER,
	DS_NAME_ROW INTEGER,
	DS_DATA_ROW_EXP VARCHAR(100),
	DS_DATA_COLUMN_EXP VARCHAR(100),
	DS_FORCE_XLS VARCHAR(10),
	DS_FILE_SOURCE_TYPE VARCHAR(50) NOT NULL,
	DS_DSRD_ID VARCHAR(50),
	DS_DSRD_FILE_NAME VARCHAR(500)
);

ALTER TABLE DATAGEAR_DATA_SET_EXCEL ADD CONSTRAINT DG_PK_DS_EXCEL_ID PRIMARY KEY (DS_ID);

ALTER TABLE DATAGEAR_DATA_SET_EXCEL ADD CONSTRAINT DG_FK_DS_EXCEL_DS_ID FOREIGN KEY (DS_ID) REFERENCES DATAGEAR_DATA_SET (DS_ID) ON DELETE CASCADE;

ALTER TABLE DATAGEAR_DATA_SET_EXCEL ADD CONSTRAINT DG_FK_DS_EXCEL_DSRD_ID FOREIGN KEY (DS_DSRD_ID) REFERENCES DATAGEAR_DSR_DIRECTORY (DD_ID);

--CSV值数据集
CREATE TABLE DATAGEAR_DATA_SET_CSV_VALUE
(
	DS_ID VARCHAR(50) NOT NULL,
	DS_VALUE VARCHAR(10000) NOT NULL,
	DS_NAME_ROW INTEGER
);

ALTER TABLE DATAGEAR_DATA_SET_CSV_VALUE ADD CONSTRAINT DG_PK_DS_CSVV_ID PRIMARY KEY (DS_ID);

ALTER TABLE DATAGEAR_DATA_SET_CSV_VALUE ADD CONSTRAINT DG_FK_DS_CSVV_DS_ID FOREIGN KEY (DS_ID) REFERENCES DATAGEAR_DATA_SET (DS_ID) ON DELETE CASCADE;

--CSV文件数据集
CREATE TABLE DATAGEAR_DATA_SET_CSV_FILE
(
	DS_ID VARCHAR(50) NOT NULL,
	DS_FILE_NAME VARCHAR(100) NOT NULL,
	DS_DISPLAY_NAME VARCHAR(100) NOT NULL,
	DS_FILE_ENCODING VARCHAR(50),
	DS_NAME_ROW INTEGER,
	DS_FILE_SOURCE_TYPE VARCHAR(50) NOT NULL,
	DS_DSRD_ID VARCHAR(50),
	DS_DSRD_FILE_NAME VARCHAR(500)
);

ALTER TABLE DATAGEAR_DATA_SET_CSV_FILE ADD CONSTRAINT DG_PK_DS_CSVF_ID PRIMARY KEY (DS_ID);

ALTER TABLE DATAGEAR_DATA_SET_CSV_FILE ADD CONSTRAINT DG_FK_DS_CSVF_DS_ID FOREIGN KEY (DS_ID) REFERENCES DATAGEAR_DATA_SET (DS_ID) ON DELETE CASCADE;

ALTER TABLE DATAGEAR_DATA_SET_CSV_FILE ADD CONSTRAINT DG_FK_DS_CSVF_DSRD_ID FOREIGN KEY (DS_DSRD_ID) REFERENCES DATAGEAR_DSR_DIRECTORY (DD_ID);

--HTTP数据集
CREATE TABLE DATAGEAR_DATA_SET_HTTP
(
	DS_ID VARCHAR(50) NOT NULL,
	DS_URI VARCHAR(1000) NOT NULL,
	DS_HEADER_CONTENT VARCHAR(5000),
	DS_RQT_METHOD VARCHAR(50),
	DS_RQT_CONTENT_TYPE VARCHAR(100),
	DS_RQT_CONTENT_CHARSET VARCHAR(100),
	DS_RQT_CONTENT varchar(10000),
	DS_RPS_CONTENT_TYPE VARCHAR(100),
	DS_RPS_DATA_JSON_PATH VARCHAR(200)
);

ALTER TABLE DATAGEAR_DATA_SET_HTTP ADD CONSTRAINT DG_PK_DS_HTTP_ID PRIMARY KEY (DS_ID);

ALTER TABLE DATAGEAR_DATA_SET_HTTP ADD CONSTRAINT DG_FK_DS_HTTP_DS_ID FOREIGN KEY (DS_ID) REFERENCES DATAGEAR_DATA_SET (DS_ID) ON DELETE CASCADE;

--图表
CREATE TABLE DATAGEAR_HTML_CHART_WIDGET
(
	HCW_ID VARCHAR(50) NOT NULL,
	HCW_NAME VARCHAR(100) NOT NULL,
	HCW_PLUGIN_ID VARCHAR(100) NOT NULL,
	HCW_UPDATE_INTERVAL INTEGER,
	HCW_AP_ID VARCHAR(50),
	HCW_RD_FORMAT VARCHAR(500),
	HCW_CREATE_USER_ID VARCHAR(50),
	HCW_CREATE_TIME TIMESTAMP
);

ALTER TABLE DATAGEAR_HTML_CHART_WIDGET ADD CONSTRAINT DG_PK_HCW_ID PRIMARY KEY (HCW_ID);

ALTER TABLE DATAGEAR_HTML_CHART_WIDGET ADD CONSTRAINT DG_FK_HCW_AP_ID FOREIGN KEY (HCW_AP_ID) REFERENCES DATAGEAR_ANALYSIS_PROJECT (AP_ID);

CREATE INDEX DG_IDX_HCW_CREATE_USER_ID ON DATAGEAR_HTML_CHART_WIDGET(HCW_CREATE_USER_ID);

--图表数据集信息
CREATE TABLE DATAGEAR_HCW_DS
(
	HCW_ID VARCHAR(50) NOT NULL,
	DS_ID VARCHAR(50) NOT NULL,
	DS_PROPERTY_SIGNS VARCHAR(1000),
	DS_ALIAS VARCHAR(100),
	DS_ATTACHMENT VARCHAR(20),
	DS_QUERY VARCHAR(1000),
	DS_PROPERTY_ALIASES VARCHAR(1000),
	DS_PROPERTY_ORDERS VARCHAR(500),
	DS_ORDER INTEGER
);

ALTER TABLE DATAGEAR_HCW_DS ADD CONSTRAINT DG_FK_HCW_ID FOREIGN KEY (HCW_ID) REFERENCES DATAGEAR_HTML_CHART_WIDGET (HCW_ID) ON DELETE CASCADE;

ALTER TABLE DATAGEAR_HCW_DS ADD CONSTRAINT DG_FK_HCW_DS_ID FOREIGN KEY (DS_ID) REFERENCES DATAGEAR_DATA_SET (DS_ID);

--看板
CREATE TABLE DATAGEAR_HTML_DASHBOARD
(
	HD_ID VARCHAR(50) NOT NULL,
	HD_NAME VARCHAR(100) NOT NULL,
	HD_TEMPLATE VARCHAR(500) NOT NULL,
	HD_TEMPLATE_ENCODING VARCHAR(50),
	HD_AP_ID VARCHAR(50),
	HD_CREATE_USER_ID VARCHAR(50),
	HD_CREATE_TIME TIMESTAMP
);

ALTER TABLE DATAGEAR_HTML_DASHBOARD ADD CONSTRAINT DG_PK_HD_ID PRIMARY KEY (HD_ID);

ALTER TABLE DATAGEAR_HTML_DASHBOARD ADD CONSTRAINT DG_FK_HD_AP_ID FOREIGN KEY (HD_AP_ID) REFERENCES DATAGEAR_ANALYSIS_PROJECT (AP_ID);

CREATE INDEX DG_IDX_HD_CREATE_USER_ID ON DATAGEAR_HTML_DASHBOARD(HD_CREATE_USER_ID);

--整数取余函数
--valueNum    待取余的整数值
--divNum      除数
CREATE FUNCTION DATAGEAR_FUNC_MODINT(valueNum INTEGER, divNum INTEGER) RETURNS INTEGER
PARAMETER STYLE JAVA NO SQL LANGUAGE JAVA EXTERNAL NAME 'org.datagear.management.util.DerbyFunctionSupport.modInt';

-----------------------------------------
--version[3.0.0], DO NOT EDIT THIS LINE!
-----------------------------------------

--2022-03-07
--看板分享设置
CREATE TABLE DATAGEAR_DB_SHARE_SET
(
	DSS_ID VARCHAR(50) NOT NULL,
	DSS_ENABLE_PSD VARCHAR(20),
	DSS_ANONYMOUS_PSD VARCHAR(20),
	DSS_PSD VARCHAR(300)
);

ALTER TABLE DATAGEAR_DB_SHARE_SET ADD CONSTRAINT DG_PK_DSS_ID PRIMARY KEY (DSS_ID);

ALTER TABLE DATAGEAR_DB_SHARE_SET ADD CONSTRAINT DG_FK_DSS_ID FOREIGN KEY (DSS_ID) REFERENCES DATAGEAR_HTML_DASHBOARD (HD_ID) ON DELETE CASCADE;

--2022-03-17
--数据集表添加可变数据模型列
ALTER TABLE DATAGEAR_DATA_SET ADD COLUMN DS_MUTABLE_MODEL VARCHAR(20);
