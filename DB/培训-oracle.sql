/*==============================================================*/
/* DBMS name:      ORACLE Version 10gR2                         */
/* Created on:     2017.06.27 14:04:14                          */
/*==============================================================*/


DROP TABLE "B_P_001" CASCADE CONSTRAINTS;

DROP TABLE "B_P_001_REC" CASCADE CONSTRAINTS;

DROP TABLE "B_P_002" CASCADE CONSTRAINTS;

DROP INDEX "IDX_BP0020101_MAINID";

DROP TABLE "B_P_00201" CASCADE CONSTRAINTS;

DROP TABLE "B_P_00201_REC" CASCADE CONSTRAINTS;

DROP TABLE "B_P_002_REC" CASCADE CONSTRAINTS;

DROP TABLE "B_P_003" CASCADE CONSTRAINTS;

DROP TABLE "B_P_003_REC" CASCADE CONSTRAINTS;

DROP TABLE "B_P_004" CASCADE CONSTRAINTS;

DROP TABLE "B_P_004_REC" CASCADE CONSTRAINTS;

DROP TABLE "B_P_005" CASCADE CONSTRAINTS;

DROP TABLE "B_P_005_REC" CASCADE CONSTRAINTS;

DROP TABLE "B_P_006" CASCADE CONSTRAINTS;

DROP TABLE "B_P_006_REC" CASCADE CONSTRAINTS;

/*==============================================================*/
/* Table: "B_P_001"                                             */
/*==============================================================*/
CREATE TABLE "B_P_001"  (
   "ID"                 VARCHAR2(50)                    NOT NULL,
   "DPRTCODE"           VARCHAR2(50),
   "DGBH"               VARCHAR2(50),
   "DGMC"               VARCHAR2(200),
   "BZ"                 VARCHAR2(1000),
   "ZT"                 INTEGER,
   "WHBMID"             VARCHAR2(50),
   "WHRID"              VARCHAR2(50),
   "WHSJ"               DATE,
   CONSTRAINT PK_B_P_001 PRIMARY KEY ("ID")
         USING INDEX TABLESPACE TS_INDEX
)
TABLESPACE TS_YWHD;

COMMENT ON TABLE "B_P_001" IS
'b_p_001 ��λ';

COMMENT ON COLUMN "B_P_001"."ID" IS
'id uuid';

COMMENT ON COLUMN "B_P_001"."DPRTCODE" IS
'��������';

COMMENT ON COLUMN "B_P_001"."DGBH" IS
'��ٱ��';

COMMENT ON COLUMN "B_P_001"."DGMC" IS
'�������';

COMMENT ON COLUMN "B_P_001"."BZ" IS
'��ע';

COMMENT ON COLUMN "B_P_001"."ZT" IS
'״̬��0��Ч��1��Ч';

COMMENT ON COLUMN "B_P_001"."WHBMID" IS
'ά������id';

COMMENT ON COLUMN "B_P_001"."WHRID" IS
'ά����id';

COMMENT ON COLUMN "B_P_001"."WHSJ" IS
'ά��ʱ��';

/*==============================================================*/
/* Table: "B_P_001_REC"                                         */
/*==============================================================*/
CREATE TABLE "B_P_001_REC"  (
   "ID"                 VARCHAR2(50)                    NOT NULL,
   "DPRTCODE"           VARCHAR2(50),
   "DGBH"               VARCHAR2(50),
   "DGMC"               VARCHAR2(200),
   "BZ"                 VARCHAR2(1000),
   "ZT"                 INTEGER,
   "WHBMID"             VARCHAR2(50),
   "WHRID"              VARCHAR2(50),
   "WHSJ"               DATE,
   "REC_XGLX"           INTEGER,
   "REC_CZRID"          VARCHAR2(50),
   "REC_CZSJ"           DATE,
   "REC_IP"             VARCHAR2(20),
   "REC_CZSM"           VARCHAR2(300),
   "REC_CZLS"           VARCHAR2(50),
   "REC_ZBID"           VARCHAR2(50)
)
TABLESPACE TS_HIS;

COMMENT ON TABLE "B_P_001_REC" IS
'b_p_001_rec ��λ--�޸ļ�¼';

COMMENT ON COLUMN "B_P_001_REC"."ID" IS
'id uuid';

COMMENT ON COLUMN "B_P_001_REC"."DPRTCODE" IS
'��������';

COMMENT ON COLUMN "B_P_001_REC"."DGBH" IS
'��ٱ��';

COMMENT ON COLUMN "B_P_001_REC"."DGMC" IS
'�������';

COMMENT ON COLUMN "B_P_001_REC"."BZ" IS
'��ע';

COMMENT ON COLUMN "B_P_001_REC"."ZT" IS
'״̬��0��Ч��1��Ч';

COMMENT ON COLUMN "B_P_001_REC"."WHBMID" IS
'ά������id';

COMMENT ON COLUMN "B_P_001_REC"."WHRID" IS
'ά����id';

COMMENT ON COLUMN "B_P_001_REC"."WHSJ" IS
'ά��ʱ��';

COMMENT ON COLUMN "B_P_001_REC"."REC_XGLX" IS
'��¼-�޸����ͣ�1������2�޸ġ�3ɾ��';

COMMENT ON COLUMN "B_P_001_REC"."REC_CZRID" IS
'��¼-������id';

COMMENT ON COLUMN "B_P_001_REC"."REC_CZSJ" IS
'��¼-����ʱ�䡣yyymmddhh24miss';

COMMENT ON COLUMN "B_P_001_REC"."REC_IP" IS
'��¼-ip';

COMMENT ON COLUMN "B_P_001_REC"."REC_CZSM" IS
'��¼-����˵��';

COMMENT ON COLUMN "B_P_001_REC"."REC_CZLS" IS
'��¼-������ˮ uuid';

COMMENT ON COLUMN "B_P_001_REC"."REC_ZBID" IS
'��¼-����ID';

/*==============================================================*/
/* Table: "B_P_002"                                             */
/*==============================================================*/
CREATE TABLE "B_P_002"  (
   "ID"                 VARCHAR2(50)                    NOT NULL,
   "DPRTCODE"           VARCHAR2(50),
   "KCID"               VARCHAR2(50),
   "KCRQ"               DATE,
   "KCSJ"               VARCHAR2(20),
   "KCDD"               VARCHAR2(50),
   "JSID"               VARCHAR2(50),
   "JSXM"               VARCHAR2(300),
   "BZ"                 VARCHAR2(1000),
   "ZT"                 INTEGER,
   "WHBMID"             VARCHAR2(50),
   "WHRID"              VARCHAR2(50),
   "WHSJ"               DATE,
   "ZDJSRID"            VARCHAR2(50),
   "ZDJSRQ"             DATE,
   "ZDJSYY"             VARCHAR2(500),
   CONSTRAINT PK_B_P_002 PRIMARY KEY ("ID")
         USING INDEX TABLESPACE TS_INDEX
)
TABLESPACE TS_YWHD;

COMMENT ON TABLE "B_P_002" IS
'b_p_002 ��ѵ�ƻ�';

COMMENT ON COLUMN "B_P_002"."ID" IS
'id uuid';

COMMENT ON COLUMN "B_P_002"."DPRTCODE" IS
'��������';

COMMENT ON COLUMN "B_P_002"."KCID" IS
'�γ�ID';

COMMENT ON COLUMN "B_P_002"."KCRQ" IS
'�γ�����';

COMMENT ON COLUMN "B_P_002"."KCSJ" IS
'�γ�ʱ�� hh:mm';

COMMENT ON COLUMN "B_P_002"."KCDD" IS
'�γ̵ص�';

COMMENT ON COLUMN "B_P_002"."JSID" IS
'��ʦID����Ӧά����Ա������ID';

COMMENT ON COLUMN "B_P_002"."JSXM" IS
'��ʦ����';

COMMENT ON COLUMN "B_P_002"."BZ" IS
'��ע';

COMMENT ON COLUMN "B_P_002"."ZT" IS
'״̬��0���桢1�ύ��8���ϡ�9�رա�10���';

COMMENT ON COLUMN "B_P_002"."WHBMID" IS
'ά������id';

COMMENT ON COLUMN "B_P_002"."WHRID" IS
'ά����id';

COMMENT ON COLUMN "B_P_002"."WHSJ" IS
'ά��ʱ��';

COMMENT ON COLUMN "B_P_002"."ZDJSRID" IS
'ָ��������id�������û���';

COMMENT ON COLUMN "B_P_002"."ZDJSRQ" IS
'ָ���������ڡ���Ӧ�ر�';

COMMENT ON COLUMN "B_P_002"."ZDJSYY" IS
'ָ������ԭ��';

/*==============================================================*/
/* Table: "B_P_00201"                                           */
/*==============================================================*/
CREATE TABLE "B_P_00201"  (
   "ID"                 VARCHAR2(50)                    NOT NULL,
   "MAINID"             VARCHAR2(50),
   "WXRYDAID"           VARCHAR2(50),
   "KQ"                 INTEGER,
   "CQL"                NUMBER(12,2),
   "CJ"                 VARCHAR2(50),
   "KCBM"               VARCHAR2(50),
   "KCNR"               VARCHAR2(1000),
   "PXDW"               VARCHAR2(300),
   "IS_TG"              INTEGER,
   "BZ"                 VARCHAR2(1000),
   "CYBS"               INTEGER,
   "ZT"                 INTEGER,
   "JSZT"               INTEGER,
   "WHBMID"             VARCHAR2(50),
   "WHRID"              VARCHAR2(50),
   "WHSJ"               DATE,
   CONSTRAINT PK_B_P_00201 PRIMARY KEY ("ID")
         USING INDEX TABLESPACE TS_INDEX
)
TABLESPACE TS_YWHD;

COMMENT ON TABLE "B_P_00201" IS
'b_p_00201 ��ѵ�ƻ�-��ѵ�γ���Ա��';

COMMENT ON COLUMN "B_P_00201"."ID" IS
'id uuid';

COMMENT ON COLUMN "B_P_00201"."MAINID" IS
'mainid��������λ��id';

COMMENT ON COLUMN "B_P_00201"."WXRYDAID" IS
'ά����Ա����id������ά����Ա������id';

COMMENT ON COLUMN "B_P_00201"."KQ" IS
'���ڣ�0δ�μӡ�1����';

COMMENT ON COLUMN "B_P_00201"."CQL" IS
'�����ʣ���λ���ٷֱ�%��';

COMMENT ON COLUMN "B_P_00201"."CJ" IS
'�ɼ�';

COMMENT ON COLUMN "B_P_00201"."KCBM" IS
'�γ̱���';

COMMENT ON COLUMN "B_P_00201"."KCNR" IS
'�γ�����';

COMMENT ON COLUMN "B_P_00201"."PXDW" IS
'��ѵ��λ';

COMMENT ON COLUMN "B_P_00201"."IS_TG" IS
'�Ƿ�ͨ����0��ͨ����1ͨ��';

COMMENT ON COLUMN "B_P_00201"."BZ" IS
'��ע';

COMMENT ON COLUMN "B_P_00201"."CYBS" IS
'���ı�ʶ��0δ���ġ�1�Ѳ���';

COMMENT ON COLUMN "B_P_00201"."ZT" IS
'״̬��0��Ч��1��Ч';

COMMENT ON COLUMN "B_P_00201"."JSZT" IS
'����״̬��0δ���ա�1�ѽ���';

COMMENT ON COLUMN "B_P_00201"."WHBMID" IS
'ά������id';

COMMENT ON COLUMN "B_P_00201"."WHRID" IS
'ά����id';

COMMENT ON COLUMN "B_P_00201"."WHSJ" IS
'ά��ʱ��';

/*==============================================================*/
/* Index: "IDX_BP0020101_MAINID"                                */
/*==============================================================*/
CREATE INDEX "IDX_BP0020101_MAINID" ON "B_P_00201" (
   "MAINID" ASC
)
TABLESPACE TS_INDEX;

/*==============================================================*/
/* Table: "B_P_00201_REC"                                       */
/*==============================================================*/
CREATE TABLE "B_P_00201_REC"  (
   "ID"                 VARCHAR2(50)                    NOT NULL,
   "MAINID"             VARCHAR2(50),
   "WXRYDAID"           VARCHAR2(50),
   "KQ"                 INTEGER,
   "CJ"                 VARCHAR2(50),
   "CQL"                NUMBER(12,2),
   "KCBM"               VARCHAR2(50),
   "KCNR"               VARCHAR2(1000),
   "PXDW"               VARCHAR2(300),
   "IS_TG"              INTEGER,
   "BZ"                 VARCHAR2(1000),
   "CYBS"               INTEGER,
   "ZT"                 INTEGER,
   "JSZT"               INTEGER,
   "WHBMID"             VARCHAR2(50),
   "WHRID"              VARCHAR2(50),
   "WHSJ"               DATE,
   "REC_XGLX"           INTEGER,
   "REC_CZRID"          VARCHAR2(50),
   "REC_CZSJ"           DATE,
   "REC_IP"             VARCHAR2(20),
   "REC_CZSM"           VARCHAR2(300),
   "REC_CZLS"           VARCHAR2(50),
   "REC_ZBID"           VARCHAR2(50)
)
TABLESPACE TS_HIS;

COMMENT ON TABLE "B_P_00201_REC" IS
'b_p_00201_rec ��ѵ�ƻ�-��ѵ�γ���Ա��-�޸ļ�¼';

COMMENT ON COLUMN "B_P_00201_REC"."ID" IS
'id uuid';

COMMENT ON COLUMN "B_P_00201_REC"."MAINID" IS
'mainid��������λ��id';

COMMENT ON COLUMN "B_P_00201_REC"."WXRYDAID" IS
'ά����Ա����id������ά����Ա������id';

COMMENT ON COLUMN "B_P_00201_REC"."KQ" IS
'���ڣ�0δ�μӡ�1����';

COMMENT ON COLUMN "B_P_00201_REC"."CJ" IS
'�ɼ�';

COMMENT ON COLUMN "B_P_00201_REC"."CQL" IS
'�����ʣ���λ���ٷֱ�%��';

COMMENT ON COLUMN "B_P_00201_REC"."KCBM" IS
'�γ̱���';

COMMENT ON COLUMN "B_P_00201_REC"."KCNR" IS
'�γ�����';

COMMENT ON COLUMN "B_P_00201_REC"."PXDW" IS
'��ѵ��λ';

COMMENT ON COLUMN "B_P_00201_REC"."IS_TG" IS
'�Ƿ�ͨ����0��ͨ����1ͨ��';

COMMENT ON COLUMN "B_P_00201_REC"."BZ" IS
'��ע';

COMMENT ON COLUMN "B_P_00201_REC"."CYBS" IS
'���ı�ʶ��0δ���ġ�1�Ѳ���';

COMMENT ON COLUMN "B_P_00201_REC"."ZT" IS
'״̬��0��Ч��1��Ч';

COMMENT ON COLUMN "B_P_00201_REC"."JSZT" IS
'����״̬��0δ���ա�1�ѽ���';

COMMENT ON COLUMN "B_P_00201_REC"."WHBMID" IS
'ά������id';

COMMENT ON COLUMN "B_P_00201_REC"."WHRID" IS
'ά����id';

COMMENT ON COLUMN "B_P_00201_REC"."WHSJ" IS
'ά��ʱ��';

COMMENT ON COLUMN "B_P_00201_REC"."REC_XGLX" IS
'��¼-�޸����ͣ�1������2�޸ġ�3ɾ��';

COMMENT ON COLUMN "B_P_00201_REC"."REC_CZRID" IS
'��¼-������id';

COMMENT ON COLUMN "B_P_00201_REC"."REC_CZSJ" IS
'��¼-����ʱ�䡣yyymmddhh24miss';

COMMENT ON COLUMN "B_P_00201_REC"."REC_IP" IS
'��¼-ip';

COMMENT ON COLUMN "B_P_00201_REC"."REC_CZSM" IS
'��¼-����˵��';

COMMENT ON COLUMN "B_P_00201_REC"."REC_CZLS" IS
'��¼-������ˮ uuid';

COMMENT ON COLUMN "B_P_00201_REC"."REC_ZBID" IS
'��¼-����ID';

/*==============================================================*/
/* Table: "B_P_002_REC"                                         */
/*==============================================================*/
CREATE TABLE "B_P_002_REC"  (
   "ID"                 VARCHAR2(50)                    NOT NULL,
   "DPRTCODE"           VARCHAR2(50),
   "KCID"               VARCHAR2(50),
   "KCRQ"               DATE,
   "KCSJ"               VARCHAR2(20),
   "KCDD"               VARCHAR2(50),
   "JSID"               VARCHAR2(50),
   "JSXM"               VARCHAR2(300),
   "BZ"                 VARCHAR2(1000),
   "ZT"                 INTEGER,
   "WHBMID"             VARCHAR2(50),
   "WHRID"              VARCHAR2(50),
   "WHSJ"               DATE,
   "ZDJSRID"            VARCHAR2(50),
   "ZDJSRQ"             DATE,
   "ZDJSYY"             VARCHAR2(500),
   "REC_XGLX"           INTEGER,
   "REC_CZRID"          VARCHAR2(50),
   "REC_CZSJ"           DATE,
   "REC_IP"             VARCHAR2(20),
   "REC_CZSM"           VARCHAR2(300),
   "REC_CZLS"           VARCHAR2(50),
   "REC_ZBID"           VARCHAR2(50)
)
TABLESPACE TS_HIS;

COMMENT ON TABLE "B_P_002_REC" IS
'b_p_002_rec ��ѵ�ƻ�-�޸ļ�¼';

COMMENT ON COLUMN "B_P_002_REC"."ID" IS
'id uuid';

COMMENT ON COLUMN "B_P_002_REC"."DPRTCODE" IS
'��������';

COMMENT ON COLUMN "B_P_002_REC"."KCID" IS
'�γ�ID';

COMMENT ON COLUMN "B_P_002_REC"."KCRQ" IS
'�γ�����';

COMMENT ON COLUMN "B_P_002_REC"."KCSJ" IS
'�γ�ʱ�� hh:mm';

COMMENT ON COLUMN "B_P_002_REC"."KCDD" IS
'�γ̵ص�';

COMMENT ON COLUMN "B_P_002_REC"."JSID" IS
'��ʦID����Ӧά����Ա������ID';

COMMENT ON COLUMN "B_P_002_REC"."JSXM" IS
'��ʦ����';

COMMENT ON COLUMN "B_P_002_REC"."BZ" IS
'��ע';

COMMENT ON COLUMN "B_P_002_REC"."ZT" IS
'״̬��0���桢1�ύ��8���ϡ�9�رա�10���';

COMMENT ON COLUMN "B_P_002_REC"."WHBMID" IS
'ά������id';

COMMENT ON COLUMN "B_P_002_REC"."WHRID" IS
'ά����id';

COMMENT ON COLUMN "B_P_002_REC"."WHSJ" IS
'ά��ʱ��';

COMMENT ON COLUMN "B_P_002_REC"."ZDJSRID" IS
'ָ��������id�������û���';

COMMENT ON COLUMN "B_P_002_REC"."ZDJSRQ" IS
'ָ���������ڡ���Ӧ�ر�';

COMMENT ON COLUMN "B_P_002_REC"."ZDJSYY" IS
'ָ������ԭ��';

COMMENT ON COLUMN "B_P_002_REC"."REC_XGLX" IS
'��¼-�޸����ͣ�1������2�޸ġ�3ɾ��';

COMMENT ON COLUMN "B_P_002_REC"."REC_CZRID" IS
'��¼-������id';

COMMENT ON COLUMN "B_P_002_REC"."REC_CZSJ" IS
'��¼-����ʱ�䡣yyymmddhh24miss';

COMMENT ON COLUMN "B_P_002_REC"."REC_IP" IS
'��¼-ip';

COMMENT ON COLUMN "B_P_002_REC"."REC_CZSM" IS
'��¼-����˵��';

COMMENT ON COLUMN "B_P_002_REC"."REC_CZLS" IS
'��¼-������ˮ uuid';

COMMENT ON COLUMN "B_P_002_REC"."REC_ZBID" IS
'��¼-����ID';

/*==============================================================*/
/* Table: "B_P_003"                                             */
/*==============================================================*/
CREATE TABLE "B_P_003"  (
   "ID"                 VARCHAR2(50)                    NOT NULL,
   "DPRTCODE"           VARCHAR2(50),
   "KCBH"               VARCHAR2(50),
   "KCMC"               VARCHAR2(300),
   "KS"                 NUMBER(12,2),
   "PXXS"               INTEGER,
   "IS_FX"              INTEGER,
   "ZQZ"                INTEGER,
   "ZQDW"               INTEGER,
   "BZ"                 VARCHAR2(1000),
   "ZT"                 INTEGER,
   "WHBMID"             VARCHAR2(50),
   "WHRID"              VARCHAR2(50),
   "WHSJ"               DATE,
   CONSTRAINT PK_B_P_003 PRIMARY KEY ("ID")
         USING INDEX TABLESPACE TS_INDEX
)
TABLESPACE TS_YWHD;

COMMENT ON TABLE "B_P_003" IS
'b_p_003 �γ̴��';

COMMENT ON COLUMN "B_P_003"."ID" IS
'id uuid';

COMMENT ON COLUMN "B_P_003"."DPRTCODE" IS
'��������';

COMMENT ON COLUMN "B_P_003"."KCBH" IS
'�γ̱��';

COMMENT ON COLUMN "B_P_003"."KCMC" IS
'�γ�����';

COMMENT ON COLUMN "B_P_003"."KS" IS
'��ʱ';

COMMENT ON COLUMN "B_P_003"."PXXS" IS
'��ѵ��ʽ��1���á�2��ѧ��3OJT';

COMMENT ON COLUMN "B_P_003"."IS_FX" IS
'�Ƿ�ѵ��0��1��';

COMMENT ON COLUMN "B_P_003"."ZQZ" IS
'��ѵ����ֵ';

COMMENT ON COLUMN "B_P_003"."ZQDW" IS
'���ڵ�λ��1�죻2�£�3�꣩';

COMMENT ON COLUMN "B_P_003"."BZ" IS
'��ע';

COMMENT ON COLUMN "B_P_003"."ZT" IS
'״̬��0��Ч��1��Ч';

COMMENT ON COLUMN "B_P_003"."WHBMID" IS
'ά������id';

COMMENT ON COLUMN "B_P_003"."WHRID" IS
'ά����id';

COMMENT ON COLUMN "B_P_003"."WHSJ" IS
'ά��ʱ��';

/*==============================================================*/
/* Table: "B_P_003_REC"                                         */
/*==============================================================*/
CREATE TABLE "B_P_003_REC"  (
   "ID"                 VARCHAR2(50)                    NOT NULL,
   "DPRTCODE"           VARCHAR2(50),
   "KCBH"               VARCHAR2(50),
   "KCMC"               VARCHAR2(300),
   "KS"                 NUMBER(12,2),
   "PXXS"               INTEGER,
   "IS_FX"              INTEGER,
   "ZQZ"                INTEGER,
   "ZQDW"               INTEGER,
   "BZ"                 VARCHAR2(1000),
   "ZT"                 INTEGER,
   "WHBMID"             VARCHAR2(50),
   "WHRID"              VARCHAR2(50),
   "WHSJ"               DATE,
   "REC_XGLX"           INTEGER,
   "REC_CZRID"          VARCHAR2(50),
   "REC_CZSJ"           DATE,
   "REC_IP"             VARCHAR2(20),
   "REC_CZSM"           VARCHAR2(300),
   "REC_CZLS"           VARCHAR2(50),
   "REC_ZBID"           VARCHAR2(50)
)
TABLESPACE TS_HIS;

COMMENT ON TABLE "B_P_003_REC" IS
'b_p_003_rec �γ̴��-�޸ļ�¼';

COMMENT ON COLUMN "B_P_003_REC"."ID" IS
'id uuid';

COMMENT ON COLUMN "B_P_003_REC"."DPRTCODE" IS
'��������';

COMMENT ON COLUMN "B_P_003_REC"."KCBH" IS
'�γ̱��';

COMMENT ON COLUMN "B_P_003_REC"."KCMC" IS
'�γ�����';

COMMENT ON COLUMN "B_P_003_REC"."KS" IS
'��ʱ';

COMMENT ON COLUMN "B_P_003_REC"."PXXS" IS
'��ѵ��ʽ��1���á�2��ѧ��3OJT';

COMMENT ON COLUMN "B_P_003_REC"."IS_FX" IS
'�Ƿ�ѵ��0��1��';

COMMENT ON COLUMN "B_P_003_REC"."ZQZ" IS
'��ѵ����ֵ';

COMMENT ON COLUMN "B_P_003_REC"."ZQDW" IS
'���ڵ�λ��1�죻2�£�3�꣩';

COMMENT ON COLUMN "B_P_003_REC"."BZ" IS
'��ע';

COMMENT ON COLUMN "B_P_003_REC"."ZT" IS
'״̬��0��Ч��1��Ч';

COMMENT ON COLUMN "B_P_003_REC"."WHBMID" IS
'ά������id';

COMMENT ON COLUMN "B_P_003_REC"."WHRID" IS
'ά����id';

COMMENT ON COLUMN "B_P_003_REC"."WHSJ" IS
'ά��ʱ��';

COMMENT ON COLUMN "B_P_003_REC"."REC_XGLX" IS
'��¼-�޸����ͣ�1������2�޸ġ�3ɾ��';

COMMENT ON COLUMN "B_P_003_REC"."REC_CZRID" IS
'��¼-������id';

COMMENT ON COLUMN "B_P_003_REC"."REC_CZSJ" IS
'��¼-����ʱ�䡣yyymmddhh24miss';

COMMENT ON COLUMN "B_P_003_REC"."REC_IP" IS
'��¼-ip';

COMMENT ON COLUMN "B_P_003_REC"."REC_CZSM" IS
'��¼-����˵��';

COMMENT ON COLUMN "B_P_003_REC"."REC_CZLS" IS
'��¼-������ˮ uuid';

COMMENT ON COLUMN "B_P_003_REC"."REC_ZBID" IS
'��¼-����ID';

/*==============================================================*/
/* Table: "B_P_004"                                             */
/*==============================================================*/
CREATE TABLE "B_P_004"  (
   "ID"                 VARCHAR2(50)                    NOT NULL,
   "DPRTCODE"           VARCHAR2(50),
   "WXRYDAID"           VARCHAR2(50),
   "KCID"               VARCHAR2(50),
   "PXJHID"             VARCHAR2(50),
   "KCRQ"               DATE,
   "KCSJ"               VARCHAR2(20),
   "CJ"                 VARCHAR2(50),
   "CQL"                NUMBER(12,2),
   "IS_TG"              INTEGER,
   "KCBM"               VARCHAR2(50),
   "KCNR"               VARCHAR2(1000),
   "PXDW"               VARCHAR2(300),
   CONSTRAINT PK_B_P_004 PRIMARY KEY ("ID")
         USING INDEX TABLESPACE TS_INDEX
)
TABLESPACE TS_YWHD;

COMMENT ON TABLE "B_P_004" IS
'b_p_004 ��Ա�����ѵ��¼';

COMMENT ON COLUMN "B_P_004"."ID" IS
'id uuid';

COMMENT ON COLUMN "B_P_004"."DPRTCODE" IS
'��������';

COMMENT ON COLUMN "B_P_004"."WXRYDAID" IS
'ά����Ա����ID';

COMMENT ON COLUMN "B_P_004"."KCID" IS
'�γ�ID';

COMMENT ON COLUMN "B_P_004"."PXJHID" IS
'��ѵ�ƻ�ID';

COMMENT ON COLUMN "B_P_004"."KCRQ" IS
'�γ�����';

COMMENT ON COLUMN "B_P_004"."KCSJ" IS
'�γ�ʱ�� hh:mm';

COMMENT ON COLUMN "B_P_004"."CJ" IS
'�ɼ�';

COMMENT ON COLUMN "B_P_004"."CQL" IS
'�����ʣ���λ���ٷֱ�%��';

COMMENT ON COLUMN "B_P_004"."IS_TG" IS
'�Ƿ�ͨ����0��ͨ����1ͨ��';

COMMENT ON COLUMN "B_P_004"."KCBM" IS
'�γ̱���';

COMMENT ON COLUMN "B_P_004"."KCNR" IS
'�γ�����';

COMMENT ON COLUMN "B_P_004"."PXDW" IS
'��ѵ��λ';

/*==============================================================*/
/* Table: "B_P_004_REC"                                         */
/*==============================================================*/
CREATE TABLE "B_P_004_REC"  (
   "ID"                 VARCHAR2(50)                    NOT NULL,
   "DPRTCODE"           VARCHAR2(50),
   "WXRYDAID"           VARCHAR2(50),
   "KCID"               VARCHAR2(50),
   "PXJHID"             VARCHAR2(50),
   "KCRQ"               DATE,
   "KCSJ"               VARCHAR2(20),
   "CJ"                 VARCHAR2(50),
   "CQL"                NUMBER(12,2),
   "KCBM"               VARCHAR2(50),
   "KCNR"               VARCHAR2(1000),
   "PXDW"               VARCHAR2(300),
   "IS_TG"              INTEGER,
   "REC_XGLX"           INTEGER,
   "REC_CZRID"          VARCHAR2(50),
   "REC_CZSJ"           DATE,
   "REC_IP"             VARCHAR2(20),
   "REC_CZSM"           VARCHAR2(300),
   "REC_CZLS"           VARCHAR2(50),
   "REC_ZBID"           VARCHAR2(50)
)
TABLESPACE TS_HIS;

COMMENT ON TABLE "B_P_004_REC" IS
'b_p_004_rec ��Ա�����ѵ��¼-�޸ļ�¼';

COMMENT ON COLUMN "B_P_004_REC"."ID" IS
'id uuid';

COMMENT ON COLUMN "B_P_004_REC"."DPRTCODE" IS
'��������';

COMMENT ON COLUMN "B_P_004_REC"."WXRYDAID" IS
'ά����Ա����ID';

COMMENT ON COLUMN "B_P_004_REC"."KCID" IS
'�γ�ID';

COMMENT ON COLUMN "B_P_004_REC"."PXJHID" IS
'��ѵ�ƻ�ID';

COMMENT ON COLUMN "B_P_004_REC"."KCRQ" IS
'�γ�����';

COMMENT ON COLUMN "B_P_004_REC"."KCSJ" IS
'�γ�ʱ�� hh:mm';

COMMENT ON COLUMN "B_P_004_REC"."CJ" IS
'�ɼ�';

COMMENT ON COLUMN "B_P_004_REC"."CQL" IS
'�����ʣ���λ���ٷֱ�%��';

COMMENT ON COLUMN "B_P_004_REC"."KCBM" IS
'�γ̱���';

COMMENT ON COLUMN "B_P_004_REC"."KCNR" IS
'�γ�����';

COMMENT ON COLUMN "B_P_004_REC"."PXDW" IS
'��ѵ��λ';

COMMENT ON COLUMN "B_P_004_REC"."IS_TG" IS
'�Ƿ�ͨ����0��ͨ����1ͨ��';

COMMENT ON COLUMN "B_P_004_REC"."REC_XGLX" IS
'��¼-�޸����ͣ�1������2�޸ġ�3ɾ��';

COMMENT ON COLUMN "B_P_004_REC"."REC_CZRID" IS
'��¼-������id';

COMMENT ON COLUMN "B_P_004_REC"."REC_CZSJ" IS
'��¼-����ʱ�䡣yyymmddhh24miss';

COMMENT ON COLUMN "B_P_004_REC"."REC_IP" IS
'��¼-ip';

COMMENT ON COLUMN "B_P_004_REC"."REC_CZSM" IS
'��¼-����˵��';

COMMENT ON COLUMN "B_P_004_REC"."REC_CZLS" IS
'��¼-������ˮ uuid';

COMMENT ON COLUMN "B_P_004_REC"."REC_ZBID" IS
'��¼-����ID';

/*==============================================================*/
/* Table: "B_P_005"                                             */
/*==============================================================*/
CREATE TABLE "B_P_005"  (
   "ID"                 VARCHAR2(50)                    NOT NULL,
   "GWID"               VARCHAR2(50),
   "KCID"               VARCHAR2(50),
   "ZT"                 INTEGER,
   "WHBMID"             VARCHAR2(50),
   "WHRID"              VARCHAR2(50),
   "WHSJ"               DATE,
   CONSTRAINT PK_B_P_005 PRIMARY KEY ("ID")
         USING INDEX TABLESPACE TS_INDEX
)
TABLESPACE TS_YWHD;

COMMENT ON TABLE "B_P_005" IS
'b_p_005 ��λ-�γ̹�ϵ';

COMMENT ON COLUMN "B_P_005"."ID" IS
'id uuid';

COMMENT ON COLUMN "B_P_005"."GWID" IS
'��λid';

COMMENT ON COLUMN "B_P_005"."KCID" IS
'�γ�ID';

COMMENT ON COLUMN "B_P_005"."ZT" IS
'״̬��0��Ч��1��Ч';

COMMENT ON COLUMN "B_P_005"."WHBMID" IS
'ά������id';

COMMENT ON COLUMN "B_P_005"."WHRID" IS
'ά����id';

COMMENT ON COLUMN "B_P_005"."WHSJ" IS
'ά��ʱ��';

/*==============================================================*/
/* Table: "B_P_005_REC"                                         */
/*==============================================================*/
CREATE TABLE "B_P_005_REC"  (
   "ID"                 VARCHAR2(50)                    NOT NULL,
   "GWID"               VARCHAR2(50),
   "KCID"               VARCHAR2(50),
   "ZT"                 INTEGER,
   "WHBMID"             VARCHAR2(50),
   "WHRID"              VARCHAR2(50),
   "WHSJ"               DATE,
   "REC_XGLX"           INTEGER,
   "REC_CZRID"          VARCHAR2(50),
   "REC_CZSJ"           DATE,
   "REC_IP"             VARCHAR2(20),
   "REC_CZSM"           VARCHAR2(300),
   "REC_CZLS"           VARCHAR2(50),
   "REC_ZBID"           VARCHAR2(50)
)
TABLESPACE TS_HIS;

COMMENT ON TABLE "B_P_005_REC" IS
'b_p_005_rec ��λ-�γ̹�ϵ-�޸ļ�¼';

COMMENT ON COLUMN "B_P_005_REC"."ID" IS
'id uuid';

COMMENT ON COLUMN "B_P_005_REC"."GWID" IS
'��λid';

COMMENT ON COLUMN "B_P_005_REC"."KCID" IS
'�γ�ID';

COMMENT ON COLUMN "B_P_005_REC"."ZT" IS
'״̬��0��Ч��1��Ч';

COMMENT ON COLUMN "B_P_005_REC"."WHBMID" IS
'ά������id';

COMMENT ON COLUMN "B_P_005_REC"."WHRID" IS
'ά����id';

COMMENT ON COLUMN "B_P_005_REC"."WHSJ" IS
'ά��ʱ��';

COMMENT ON COLUMN "B_P_005_REC"."REC_XGLX" IS
'��¼-�޸����ͣ�1������2�޸ġ�3ɾ��';

COMMENT ON COLUMN "B_P_005_REC"."REC_CZRID" IS
'��¼-������id';

COMMENT ON COLUMN "B_P_005_REC"."REC_CZSJ" IS
'��¼-����ʱ�䡣yyymmddhh24miss';

COMMENT ON COLUMN "B_P_005_REC"."REC_IP" IS
'��¼-ip';

COMMENT ON COLUMN "B_P_005_REC"."REC_CZSM" IS
'��¼-����˵��';

COMMENT ON COLUMN "B_P_005_REC"."REC_CZLS" IS
'��¼-������ˮ uuid';

COMMENT ON COLUMN "B_P_005_REC"."REC_ZBID" IS
'��¼-����ID';

/*==============================================================*/
/* Table: "B_P_006"                                             */
/*==============================================================*/
CREATE TABLE "B_P_006"  (
   "ID"                 VARCHAR2(50)                    NOT NULL,
   "GWID"               VARCHAR2(50),
   "WXRYDAID"           VARCHAR2(50),
   "ZT"                 INTEGER,
   "WHBMID"             VARCHAR2(50),
   "WHRID"              VARCHAR2(50),
   "WHSJ"               DATE,
   CONSTRAINT PK_B_P_006 PRIMARY KEY ("ID")
         USING INDEX TABLESPACE TS_INDEX
)
TABLESPACE TS_YWHD;

COMMENT ON TABLE "B_P_006" IS
'b_p_006 ��λ-��Ա��ϵ';

COMMENT ON COLUMN "B_P_006"."ID" IS
'id uuid';

COMMENT ON COLUMN "B_P_006"."GWID" IS
'��λid';

COMMENT ON COLUMN "B_P_006"."WXRYDAID" IS
'ά����Ա����ID';

COMMENT ON COLUMN "B_P_006"."ZT" IS
'״̬��0��Ч��1��Ч';

COMMENT ON COLUMN "B_P_006"."WHBMID" IS
'ά������id';

COMMENT ON COLUMN "B_P_006"."WHRID" IS
'ά����id';

COMMENT ON COLUMN "B_P_006"."WHSJ" IS
'ά��ʱ��';

/*==============================================================*/
/* Table: "B_P_006_REC"                                         */
/*==============================================================*/
CREATE TABLE "B_P_006_REC"  (
   "ID"                 VARCHAR2(50),
   "GWID"               VARCHAR2(50),
   "WXRYDAID"           VARCHAR2(50),
   "ZT"                 INTEGER,
   "WHBMID"             VARCHAR2(50),
   "WHRID"              VARCHAR2(50),
   "WHSJ"               DATE,
   "REC_XGLX"           INTEGER,
   "REC_CZRID"          VARCHAR2(50),
   "REC_CZSJ"           DATE,
   "REC_IP"             VARCHAR2(20),
   "REC_CZSM"           VARCHAR2(300),
   "REC_CZLS"           VARCHAR2(50),
   "REC_ZBID"           VARCHAR2(50)
)
TABLESPACE TS_HIS;

COMMENT ON TABLE "B_P_006_REC" IS
'b_p_006_rec ��λ-��Ա��ϵ-�޸ļ�¼';

COMMENT ON COLUMN "B_P_006_REC"."ID" IS
'id uuid';

COMMENT ON COLUMN "B_P_006_REC"."GWID" IS
'��λid';

COMMENT ON COLUMN "B_P_006_REC"."WXRYDAID" IS
'ά����Ա����ID';

COMMENT ON COLUMN "B_P_006_REC"."ZT" IS
'״̬��0��Ч��1��Ч';

COMMENT ON COLUMN "B_P_006_REC"."WHBMID" IS
'ά������id';

COMMENT ON COLUMN "B_P_006_REC"."WHRID" IS
'ά����id';

COMMENT ON COLUMN "B_P_006_REC"."WHSJ" IS
'ά��ʱ��';

COMMENT ON COLUMN "B_P_006_REC"."REC_XGLX" IS
'��¼-�޸����ͣ�1������2�޸ġ�3ɾ��';

COMMENT ON COLUMN "B_P_006_REC"."REC_CZRID" IS
'��¼-������id';

COMMENT ON COLUMN "B_P_006_REC"."REC_CZSJ" IS
'��¼-����ʱ�䡣yyymmddhh24miss';

COMMENT ON COLUMN "B_P_006_REC"."REC_IP" IS
'��¼-ip';

COMMENT ON COLUMN "B_P_006_REC"."REC_CZSM" IS
'��¼-����˵��';

COMMENT ON COLUMN "B_P_006_REC"."REC_CZLS" IS
'��¼-������ˮ uuid';

COMMENT ON COLUMN "B_P_006_REC"."REC_ZBID" IS
'��¼-����ID';

