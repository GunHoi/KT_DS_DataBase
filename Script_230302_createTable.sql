-- BBS계정에서 실행
CREATE TABLE "BBS"."ARTICLE" 
   (    "ARTICLE_NO" VARCHAR2(20 CHAR) NOT NULL ENABLE, 
    "EMAIL" VARCHAR2(30 CHAR) NOT NULL ENABLE, 
    "TITLE" VARCHAR2(100 CHAR) NOT NULL ENABLE, 
    "DESCRIPT" CLOB, 
    "REGIST_DATE" DATE NOT NULL ENABLE, 
    "SOURCE" VARCHAR2(20 CHAR) NOT NULL ENABLE, 
    "NOTI_YN" CHAR(1 CHAR) DEFAULT 'N' NOT NULL ENABLE, 
     CONSTRAINT "ARTICLE_PK" PRIMARY KEY ("ARTICLE_NO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 
 LOB ("DESCRIPT") STORE AS SECUREFILE (
  TABLESPACE "USERS" ENABLE STORAGE IN ROW 4000 CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES 
  STORAGE(INITIAL 262144 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)) ;

COMMENT ON TABLE BBS.ARTICLE IS '게시글 정보를 담고 있음.';
COMMENT ON COLUMN BBS.ARTICLE.ARTICLE_NO IS '연속된 번호로 증가함.';
COMMENT ON COLUMN BBS.ARTICLE.EMAIL IS '작성자의 이메일';

CREATE TABLE "BBS"."ARTICLE_DECLARATION" 
   (    "ARTICLE_NO" VARCHAR2(20 CHAR) NOT NULL ENABLE, 
    "EMAIL" VARCHAR2(30 CHAR) NOT NULL ENABLE, 
    "REGIST_DATE" DATE NOT NULL ENABLE, 
    "REASON" VARCHAR2(200 CHAR) NOT NULL ENABLE, 
     CONSTRAINT "ARTICLE_DECLARATION_PK" PRIMARY KEY ("ARTICLE_NO", "EMAIL")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "USERS"  ENABLE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;

COMMENT ON TABLE BBS.ARTICLE_DECLARATION IS '신고받은 게시글의 정보를 담고있음.';

CREATE TABLE "BBS"."ARTICLE_LIKE_DISLIKE" 
   (    "EMAIL" VARCHAR2(30 CHAR) NOT NULL ENABLE, 
    "ARTICLE_NO" VARCHAR2(20 CHAR) NOT NULL ENABLE, 
    "TYPE" CHAR(1 CHAR) NOT NULL ENABLE, 
     CONSTRAINT "ARTICLE_LIKE_DISLIKE_PK" PRIMARY KEY ("EMAIL", "ARTICLE_NO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "USERS"  ENABLE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;

COMMENT ON TABLE BBS.ARTICLE_LIKE_DISLIKE IS '게시글 좋아요/싫어요 한 회원의 정보';
COMMENT ON COLUMN BBS.ARTICLE_LIKE_DISLIKE."TYPE" IS 'L: 좋아요, D: 싫어요';

CREATE TABLE "BBS"."BLOCKED_MEMBER" 
   (    "EMAIL" VARCHAR2(30 CHAR) NOT NULL ENABLE, 
    "BLOCKED_EMAIL" VARCHAR2(30 CHAR) NOT NULL ENABLE, 
    "REGIST_DATE" DATE NOT NULL ENABLE, 
     CONSTRAINT "BLOCKED_MEMBER_PK" PRIMARY KEY ("EMAIL", "BLOCKED_EMAIL")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "USERS"  ENABLE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;

COMMENT ON TABLE BBS.BLOCKED_MEMBER IS '차단한 회원의 정보를 담고있음.';

CREATE TABLE "BBS"."MEMBER" 
   (    "EMAIL" VARCHAR2(30 CHAR) NOT NULL ENABLE, 
    "NICKNAME" VARCHAR2(10 CHAR) NOT NULL ENABLE, 
    "VERIFIED_YN" CHAR(1 CHAR) DEFAULT 'N' NOT NULL ENABLE, 
    "PASSWORD" VARCHAR2(4000 CHAR) NOT NULL ENABLE, 
    "JOIN_DATE" DATE NOT NULL ENABLE, 
     CONSTRAINT "MEMBER_PK" PRIMARY KEY ("EMAIL")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE, 
     CONSTRAINT "MEMBER_UN" UNIQUE ("NICKNAME")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;

COMMENT ON TABLE BBS."MEMBER" IS '회원 정보를 담고 있음.';

CREATE TABLE "BBS"."REPLIES" 
   (    "REPLY_NO" VARCHAR2(20 CHAR) NOT NULL ENABLE, 
    "ARTICLE_NO" VARCHAR2(20 CHAR) NOT NULL ENABLE, 
    "EMAIL" VARCHAR2(30 CHAR) NOT NULL ENABLE, 
    "REPLY" VARCHAR2(4000 CHAR) NOT NULL ENABLE, 
    "REGIST_DATE" DATE NOT NULL ENABLE, 
    "MODIFY_DATE" DATE NOT NULL ENABLE, 
    "PARENT_REPLY_NO" VARCHAR2(20 CHAR), 
     CONSTRAINT "REPLIES_PK" PRIMARY KEY ("REPLY_NO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "USERS"  ENABLE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;

COMMENT ON TABLE BBS.REPLIES IS '게시글의 댓글 정보를 담고 있음.';
COMMENT ON COLUMN BBS.REPLIES.PARENT_REPLY_NO IS '대댓글일 경우, 상위 댓글 아이디';

CREATE TABLE "BBS"."REPLY_DECLARATION" 
   (    "REPLY_NO" VARCHAR2(20 CHAR) NOT NULL ENABLE, 
    "EMAIL" VARCHAR2(30 CHAR) NOT NULL ENABLE, 
    "ARTICLE_NO" VARCHAR2(20 CHAR) NOT NULL ENABLE, 
    "REGIST_DATE" DATE NOT NULL ENABLE, 
    "REASON" VARCHAR2(200 CHAR) NOT NULL ENABLE, 
     CONSTRAINT "REPLY_DECLARATION_PK" PRIMARY KEY ("REPLY_NO", "EMAIL")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "USERS"  ENABLE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;

COMMENT ON TABLE BBS.REPLY_DECLARATION IS '신고된 댓글의 정보를 담고 있음.';

CREATE TABLE "BBS"."REPLY_LIKE_DISLIKE" 
   (    "EMAIL" VARCHAR2(30 CHAR) NOT NULL ENABLE, 
    "REPLY_NO" VARCHAR2(20 CHAR) NOT NULL ENABLE, 
    "ARTICLE_NO" VARCHAR2(20 CHAR) NOT NULL ENABLE, 
    "TYPE" CHAR(1) NOT NULL ENABLE, 
     CONSTRAINT "REPLY_LIKE_DISLIKE_PK" PRIMARY KEY ("EMAIL", "REPLY_NO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "USERS"  ENABLE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;

COMMENT ON TABLE BBS.REPLY_LIKE_DISLIKE IS '댓글의 좋아요/싫어요 정보';
COMMENT ON COLUMN BBS.REPLY_LIKE_DISLIKE."TYPE" IS 'L: 좋아요, D: 싫어요';

CREATE SEQUENCE BBS.SEQ_ARTICLE_PK INCREMENT BY 1 MINVALUE 1 MAXVALUE 99999 CYCLE CACHE 24 NOORDER ;