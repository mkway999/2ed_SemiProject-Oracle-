-- CREATE TABLE
-- 1. ADMINS TABLE
CREATE TABLE ADMINS
( A_CODE           VARCHAR2(5)
, A_NAME           VARCHAR2(30)  CONSTRAINT ADMINS_A_NAME_NN NOT NULL
, A_SSN            VARCHAR2(14)  CONSTRAINT ADMINS_A_SSN NN NOT NULL
, A_TEL            VARCHAR2(15)
, A_PW             VARCHAR2(60)
,A_JOIN_DATE        DATE    DEFAULT SYSDATE
, CONSTRAINT ADMINS_A_CODE_PK   PRIMARY KEY(A_CODE)
, CONSTRAINT ADMINS_A_CODE_CK   CHECK (A_CODE LIKE 'A____' )
, CONSTRAINT ADMINS_A_SSN_UK UNIQUE(A_SSN)
);
--==>> Table ADMINS이(가) 생성되었습니다.
COMMENT ON TABLE ADMINS IS '관리자';

COMMENT ON COLUMN ADMINS.A_CODE IS '관리자 코드';
COMMENT ON COLUMN ADMINS.A_NAME IS '관리자 이름';
COMMENT ON COLUMN ADMINS.A_SSN IS '관리자 주민번호';
COMMENT ON COLUMN ADMINS.A_TEL IS '관리자 연락처';
COMMENT ON COLUMN ADMINS.A_PW IS '관리자 비밀번호';
COMMENT ON COLUMN ADMINS.A_JOIN_DATE IS '관리자 가입일';

--------------------------------------------------------------------------------
-- 2. PROFESSORS TABLE
CREATE TABLE PROFESSORS
( P_CODE        VARCHAR2(5)
, P_NAME        VARCHAR2(30)  CONSTRAINT PROFESSORS_NAME_NN NOT NULL
, P_SSN         VARCHAR2(14)  CONSTRAINT PROFESSORS_P_SSN_NN NOT NULL
, P_TEL         VARCHAR2(15)
, P_ID          VARCHAR2(30)  CONSTRAINT PROFESSORS_P_ID_NN NOT NULL
, P_PW          VARCHAR2(60)
, P_JOIN_DATE   DATE    DEFAULT SYSDATE
, CONSTRAINT PROFESSORS_P_CODE_PK PRIMARY KEY(P_CODE)
, CONSTRAINT PROFESSORS_P_CODE_CK CHECK(P_CODE LIKE 'P____')
, CONSTRAINT PROFESSORS_P_ID_UK UNIQUE(P_ID)
, CONSTRAINT PROFESSORS_P_SSN_UK UNIQUE(P_SSN)
);
--==>> Table PROFESSORS이(가) 생성되었습니다.

COMMENT ON TABLE PROFESSORS IS '교수';

COMMENT ON COLUMN PROFESSORS.P_CODE IS '교수 코드';
COMMENT ON COLUMN PROFESSORS.P_NAME IS '교수 이름';
COMMENT ON COLUMN PROFESSORS.P_SSN IS '교수 주민번호';
COMMENT ON COLUMN PROFESSORS.P_TEL IS '교수 연락처';
COMMENT ON COLUMN PROFESSORS.P_ID IS '교수 아이디';
COMMENT ON COLUMN PROFESSORS.P_PW IS '교수 비밀번호';
COMMENT ON COLUMN PROFESSORS.P_JOIN_DATE IS '관리자 가입일';

--------------------------------------------------------------------------------
-- 3. STUDENTS TABLE
CREATE TABLE STUDENTS
( S_CODE        NUMBER
, S_NAME        VARCHAR2(30)    CONSTRAINT STUDENTS_S_CODE_NN  NOT NULL
, S_SSN         VARCHAR2(14)    CONSTRAINT STUDENTS_S_SSN_NN   NOT NULL
, S_TEL         VARCHAR2(15)    
, S_ID          VARCHAR2(30)    CONSTRAINT STUDENTS_S_ID_NN NOT NULL
, S_PW          VARCHAR2(60)
, S_JOIN_DATE   DATE    DEFAULT SYSDATE
, CONSTRAINT STUDENTS_S_CODE_PK PRIMARY KEY(S_CODE)
, CONSTRAINT STUDENTS_S_SSN_UK UNIQUE (S_SSN)
, CONSTRAINT STUDENTS_S_ID_UK UNIQUE (S_ID)
);
--==>> Table STUDENTS이(가) 생성되었습니다.

COMMENT ON TABLE STUDENTS IS '학생';

COMMENT ON COLUMN STUDENTS.S_CODE IS '학생 코드(학번)';
COMMENT ON COLUMN STUDENTS.S_NAME IS '학생 이름';
COMMENT ON COLUMN STUDENTS.S_SSN IS '학생 주민번호';
COMMENT ON COLUMN STUDENTS.S_TEL IS '학생 연락처';
COMMENT ON COLUMN STUDENTS.S_ID IS '아이디';
COMMENT ON COLUMN STUDENTS.S_PW IS '비밀번호';
COMMENT ON COLUMN STUDENTS.S_JOIN_DATE IS '가입일';

--------------------------------------------------------------------------------
-- 4. COURSES TABLE
CREATE TABLE COURSES
( CR_CODE   VARCHAR2(4)
, CR_NAME   VARCHAR2(100)       CONSTRAINT COURSES_CR_NAME_NN NOT NULL
, CONSTRAINT COURSES_CR_CODE_PK PRIMARY KEY(CR_CODE)
);

COMMENT ON TABLE COURSES IS '과정';

COMMENT ON COLUMN COURSES.CR_CODE IS '과정 코드';
COMMENT ON COLUMN COURSES.CR_NAME IS '과정 명';

--------------------------------------------------------------------------------
-- 5. OPEND_COURSES TABLE
CREATE TABLE OPENED_COURSES
( OC_CODE       VARCHAR2(5)
, CR_CODE       VARCHAR2(4)
, RM_CODE       VARCHAR2(5)
, OC_NUM        NUMBER      CONSTRAINT OC_OC_NUM_NN NOT NULL
, OC_START_DATE DATE
, OC_END_DATE   DATE
, OC_CRE_DATE   DATE        DEFAULT SYSDATE
, CONSTRAINT OC_OC_CODE_PK PRIMARY KEY(OC_CODE)
, CONSTRAINT OC_OC_CODE_CK CHECK (OC_CODE LIKE 'OC___')
, CONSTRAINT OC_OC_START_DATE_CK CHECK (OC_START_DATE < OC_END_DATE)
, CONSTRAINT OC_OC_END_DATE_CK CHECK (OC_END_DATE > OC_START_DATE)
);
--==>> Table OPENED_COURSES이(가) 생성되었습니다.

COMMENT ON TABLE OPENED_COURSES IS '개설 과정';

COMMENT ON COLUMN OPENED_COURSES.OC_CODE IS '개설 과정 코드';
COMMENT ON COLUMN OPENED_COURSES.CR_CODE IS '과정 코드(과정.과정코드)';
COMMENT ON COLUMN OPENED_COURSES.RM_CODE IS '강의실 코드(강의실.강의실코드)';
COMMENT ON COLUMN OPENED_COURSES.OC_NUM IS '차수';
COMMENT ON COLUMN OPENED_COURSES.OC_START_DATE IS '과정 기간(시작)';
COMMENT ON COLUMN OPENED_COURSES.OC_END_DATE IS '과정 기간(끝)';
COMMENT ON COLUMN OPENED_COURSES.OC_CRE_DATE IS '개설 과정 생성일';

ALTER TABLE OPENED_COURSES
ADD CONSTRAINT OC_CR_CODE_FK FOREIGN KEY(CR_CODE)
               REFERENCES COURSES(CR_CODE);
               
ALTER TABLE OPENED_COURSES
ADD CONSTRAINT OC_RM_CODE_FK FOREIGN KEY(RM_CODE)
               REFERENCES CLASSROOMS(RM_CODE);

--------------------------------------------------------------------------------
-- 6. SUBJECTS TABLE

CREATE TABLE SUBJECTS
( SB_CODE VARCHAR2(5)
, SB_NAME VARCHAR2(100)  CONSTRAINT SUBJECTS_SB_NAME_NN NOT NULL
, CONSTRAINT SUBJECTS_SB_CODE_PK PRIMARY KEY (SB_CODE)
);
--== Table SUBJECTS이(가) 생성되었습니다.

COMMENT ON TABLE SUBJECTS IS '과목';

COMMENT ON COLUMN SUBJECTS.SB_CODE IS '과목 코드';
COMMENT ON COLUMN SUBJECTS.SB_NAME IS '과목 명';

--------------------------------------------------------------------------------
-- 7. OPEND_SUBJECTS TABLE
CREATE TABLE OPENED_SUBJECTS
( OS_CODE   VARCHAR2(5)
, SB_CODE   VARCHAR2(4)
, OC_CODE   VARCHAR2(5)
, BK_CODE   VARCHAR2(5)
, P_CODE    VARCHAR2(5)
, OS_START_DATE DATE
, OS_END_DATE   DATE
, ATT_RATE  NUMBER(3)   DEFAULT 20
, WRI_RATE  NUMBER(3)   DEFAULT 40
, PRC_RATE  NUMBER(3)   DEFAULT 40
, OS_CRE_DATE   DATE    DEFAULT SYSDATE

, CONSTRAINT OS_MULTI_PK PRIMARY KEY (OS_CODE, SB_CODE, OC_CODE)
, CONSTRAINT OS_OS_CODE_CK    CHECK (OS_CODE LIKE 'OS___')
, CONSTRAINT OS_OS_START_DATE_CK CHECK (OS_START_DATE < OS_END_DATE)
, CONSTRAINT OS_OS_END_DATE_CK   CHECK (OS_START_DATE < OS_END_DATE)
);
--== Table OPENED_SUBJECTS이(가) 생성되었습니다.

ALTER TABLE OPENED_SUBJECTS
ADD (CONSTRAINT OS_SB_CODE_FK FOREIGN KEY(SB_CODE) REFERENCES SUBJECTS (SB_CODE)
    , CONSTRAINT OS_OC_CODE_FK FOREIGN KEY(OC_CODE) REFERENCES OPENED_COURSES (OC_CODE)
    , CONSTRAINT OS_BK_CODE_FK FOREIGN KEY(BK_CODE) REFERENCES BOOKS (BK_CODE)
    , CONSTRAINT OS_P_CODE_FK FOREIGN KEY(P_CODE) REFERENCES PROFESSORS (P_CODE)
    , CONSTRAINT OS_OS_CODE_UK UNIQUE(OS_CODE));

COMMENT ON TABLE OPENED_SUBJECTS IS '개설 과목';

COMMENT ON COLUMN OPENED_SUBJECTS.OS_CODE IS '개설 과목 코드';
COMMENT ON COLUMN OPENED_SUBJECTS.SB_CODE IS '과목 코드(과목 참조)';
COMMENT ON COLUMN OPENED_SUBJECTS.OC_CODE IS '개설 과정 코드(개설과정 참조)';
COMMENT ON COLUMN OPENED_SUBJECTS.BK_CODE IS '교재 코드(교재 참조)';
COMMENT ON COLUMN OPENED_SUBJECTS.P_CODE IS '교수 코드(교수 참조)';
COMMENT ON COLUMN OPENED_SUBJECTS.OS_START_DATE IS '과목 시작 기간';
COMMENT ON COLUMN OPENED_SUBJECTS.OS_END_DATE IS '과목 종료 기간';
COMMENT ON COLUMN OPENED_SUBJECTS.ATT_RATE IS '출결 배점';
COMMENT ON COLUMN OPENED_SUBJECTS.WRI_RATE IS '실기 배점';
COMMENT ON COLUMN OPENED_SUBJECTS.PRC_RATE IS '실기 배점';
COMMENT ON COLUMN OPENED_SUBJECTS.OS_CRE_DATE IS '개설 과목 생성일';

--------------------------------------------------------------------------------
-- 8. SCORE TABLE
CREATE TABLE SCORE
( SC_CODE   NUMBER      -- 성적 코드
, RG_CODE   NUMBER      -- 수강신청 코드
, OS_CODE   VARCHAR2(5) -- 개설 과목 코드
, ATT_SCORE NUMBER      -- 출결 점수
, WRI_SCORE NUMBER      -- 필기 점수
, PRC_SCORE NUMBER      -- 실기 점수
-- 기본키 제약조건 설정
, CONSTRAINT SCORE_MULTI_PK PRIMARY KEY(SC_CODE, RG_CODE, OS_CODE)

-- SC_CODE 제약조건 설정
, CONSTRAINT SCORE_SC_CODE_UK UNIQUE(SC_CODE)

-- 출결, 필기, 실기 점수 제약조건 설정
, CONSTRAINT SCORE_ATT_SCORE_CK CHECK(ATT_SCORE BETWEEN 0 AND 100)
, CONSTRAINT SCORE_WRI_SCORE_CK CHECK(WRI_SCORE BETWEEN 0 AND 100)
, CONSTRAINT SCORE_PRC_SCORE_CK CHECK(PRC_SCORE BETWEEN 0 AND 100)
);
--==>> Table SCORE이(가) 생성되었습니다.

DESC SCORE;
--==>>
/*
이름        널?       유형          
--------- -------- ----------- 
SC_CODE   NOT NULL NUMBER      
RG_CODE   NOT NULL NUMBER      
OS_CODE   NOT NULL VARCHAR2(5) 
ATT_SCORE          NUMBER      
WRI_SCORE          NUMBER      
PRC_SCORE          NUMBER  
*/

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'SCORE';
--==>>
/*
SCORE_ATT_SCORE_CK	C	ATT_SCORE BETWEEN 0 AND 100
SCORE_WRI_SCORE_CK	C	WRI_SCORE BETWEEN 0 AND 100
SCORE_PRC_SCORE_CK	C	PRC_SCORE BETWEEN 0 AND 100
SCORE_MULTI_PK	    P	
SCORE_SC_CODE_UK	U	
*/

-- 테이블 코멘트 생성
COMMENT ON TABLE SCORE IS '성적';
--==>> Comment이(가) 생성되었습니다.

SELECT *
FROM USER_TAB_COMMENTS;
--==>> SCORE	TABLE	성적

-- 컬럼 코멘트 생성
COMMENT ON COLUMN SCORE.SC_CODE IS '성적 코드';
COMMENT ON COLUMN SCORE.RG_CODE IS '수강신청 코드';
COMMENT ON COLUMN SCORE.OS_CODE IS '개설 과목 코드';
COMMENT ON COLUMN SCORE.ATT_SCORE IS '출결 점수';
COMMENT ON COLUMN SCORE.WRI_SCORE IS '필기 점수';
COMMENT ON COLUMN SCORE.PRC_SCORE IS '실기 점수';
--==>> Comment이(가) 생성되었습니다. * 6

SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'SCORE';
--==>>
/*
SCORE	SC_CODE	성적 코드
SCORE	RG_CODE	수강신청 코드
SCORE	OS_CODE	개설 과목 코드
SCORE	ATT_SCORE	출결 점수
SCORE	WRI_SCORE	필기 점수
SCORE	PRC_SCORE	실기 점수
*/

ALTER TABLE SCORE
ADD CONSTRAINT SOCRE_RG_CODE_FK FOREIGN KEY(RG_CODE) REFERENCES REGISTRATION(RG_CODE);
--==>> Table SCORE이(가) 변경되었습니다.

ALTER TABLE SCORE
ADD CONSTRAINT SCORE_OS_CODE_FK FOREIGN KEY(OS_CODE) REFERENCES OPENED_SUBJECTS(OS_CODE);
--==>> Table SCORE이(가) 변경되었습니다.

--------------------------------------------------------------------------------
-- 9. CLASSROOMS TABLE
CREATE TABLE CLASSROOMS
( RM_CODE   VARCHAR2(5)
, RM_NAME   VARCHAR2(100)   CONSTRAINT CLASSROOMS_RM_NAME_NN NOT NULL
, RM_INFO   VARCHAR2(400)
-- 기본키 제약조건 설정
, CONSTRAINT CLASSROOMS_RM_CODE_PK PRIMARY KEY(RM_CODE)

-- RM_CODE 제약조건 설정
, CONSTRAINT CLASSROOMS_RM_CODE_CK CHECK(RM_CODE LIKE ('RM___'))
);
--==>> Table CLASSROOMS이(가) 생성되었습니다.

DESC CLASSROOMS;
--==>>
/*
이름      널?       유형            
------- -------- ------------- 
RM_CODE NOT NULL VARCHAR2(5)   
RM_NAME NOT NULL VARCHAR2(100) 
RM_INFO          VARCHAR2(400) 
*/

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'CLASSROOMS';
--==>>
/*
CLASSROOMS_RM_NAME_NN	C	"RM_NAME" IS NOT NULL
CLASSROOMS_RM_CODE_CK	C	RM_CODE LIKE ('RM___')
CLASSROOMS_RM_CODE_PK	P	
*/

-- 테이블 코멘트 생성
COMMENT ON TABLE CLASSROOMS IS '강의실';
--==>> Comment이(가) 생성되었습니다.

SELECT *
FROM USER_TAB_COMMENTS;
--==>>
/*
CLASSROOMS	TABLE	강의실
SCORE	TABLE	성적
*/

-- 컬럼 코멘트 생성
COMMENT ON COLUMN CLASSROOMS.RM_CODE IS '강의실 코드';
COMMENT ON COLUMN CLASSROOMS.RM_NAME IS '강의실 이름';
COMMENT ON COLUMN CLASSROOMS.RM_INFO IS '강의실 설명';
--==>> Comment이(가) 생성되었습니다. * 3

SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'CLASSROOMS';
--==>>
/*
CLASSROOMS	RM_CODE	강의실 코드
CLASSROOMS	RM_NAME	강의실 이름
CLASSROOMS	RM_INFO	강의실 설명
*/

--------------------------------------------------------------------------------
-- 10. REGISTRATION TABLE
CREATE TABLE REGISTRATION
( RG_CODE   NUMBER
, S_CODE    NUMBER
, OC_CODE   VARCHAR2(5)
, RG_DATE   DATE DEFAULT SYSDATE
, CONSTRAINT REGISTRATION_MULTI_PK PRIMARY KEY(RG_CODE, S_CODE, OC_CODE)
, CONSTRAINT REGISTRATION_RG_CODE_UK UNIQUE(RG_CODE)
);
--==>> Table REGISTRATION이(가) 생성되었습니다.

-- 수강신청 테이블 코멘트 설정
COMMENT ON TABLE REGISTRATION IS '수강신청 테이블';
COMMENT ON COLUMN REGISTRATION.RG_CODE IS '수강신청 코드';
COMMENT ON COLUMN REGISTRATION.S_CODE  IS '학생코드(학번)';
COMMENT ON COLUMN REGISTRATION.OC_CODE IS '개설 과정 코드';
COMMENT ON COLUMN REGISTRATION.RG_DATE IS '수강신청 날짜';

ALTER TABLE REGISTRATION
ADD CONSTRAINT  REGISTRATION_S_CODE_FK FOREIGN KEY(S_CODE)
            REFERENCES STUDENTS(S_CODE);
--==>> Table REGISTRATION이(가) 변경되었습니다.
           
ALTER TABLE REGISTRATION
ADD CONSTRAINT REGISTRATION_OC_CODE_FK FOREIGN KEY(OC_CODE)
            REFERENCES OPENED_COURSES(OC_CODE);
--==>> Table REGISTRATION이(가) 변경되었습니다.

--------------------------------------------------------------------------------
-- 11. DROP_LIST TABLE
CREATE TABLE DROP_LIST
( DL_CODE   NUMBER
, RG_CODE   NUMBER
, DR_CODE   VARCHAR2(5)
, DL_DATE   DATE DEFAULT SYSDATE
, CONSTRAINT DL_MULTI_PK PRIMARY KEY(DL_CODE, RG_CODE)
, CONSTRAINT DL_DL_CODE_UK UNIQUE(DL_CODE) 
);
--==>> Table DROP_LIST이(가) 생성되었습니다.

-- 중도포기 목록 코멘트 설정
COMMENT ON TABLE DROP_LIST IS '중도포기목록 테이블';
COMMENT ON COLUMN DROP_LIST.DL_CODE  IS '중도포기 코드';
COMMENT ON COLUMN DROP_LIST.RG_CODE  IS '수강신청 코드';
COMMENT ON COLUMN DROP_LIST.DR_CODE  IS '포기 사유 코드';
COMMENT ON COLUMN DROP_LIST.DL_DATE  IS '포기날짜';

ALTER TABLE DROP_LIST 
ADD CONSTRAINT DL_RG_CODE_FK FOREIGN KEY(RG_CODE)
               REFERENCES REGISTRATION(RG_CODE);


ALTER TABLE DROP_LIST
ADD CONSTRAINT DL_DR_CODE_FK FOREIGN KEY(DR_CODE)
               REFERENCES DROP_REASONS(DR_CODE); 

--------------------------------------------------------------------------------
-- 12. DROP_REASONS TABLE
CREATE TABLE DROP_REASONS
( DR_CODE   VARCHAR2(5)
, DR_REASON VARCHAR2(400)
, CONSTRAINT DR_DR_CODE_PK PRIMARY KEY(DR_CODE)
);
--==>> Table DROP_REASONS이(가) 생성되었습니다.

-- 중도포기 사유 코멘트 설정
COMMENT ON TABLE DROP_REASONS IS '중도포기 사유 테이블';
COMMENT ON COLUMN DROP_REASONS.DR_CODE IS '포기 사유 코드';
COMMENT ON COLUMN DROP_REASONS.DR_REASON IS '포기사유';

--------------------------------------------------------------------------------
-- 13. BOOKS TABLE
CREATE TABLE BOOKS
( BK_CODE   VARCHAR2(5)
, BK_NAME   VARCHAR2(100)
,CONSTRAINT BOOKS_BK_CODE_PK PRIMARY KEY(BK_CODE)
);
--==>> Table BOOKS이(가) 생성되었습니다.
-- 교재 테이블 코멘트 설정
COMMENT ON TABLE BOOKS IS '교재 테이블';
COMMENT ON COLUMN BOOKS.BK_CODE IS '교재 코드';
COMMENT ON COLUMN BOOKS.BK_NAME IS '교재 명';
