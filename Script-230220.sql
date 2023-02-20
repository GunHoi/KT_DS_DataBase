-- 1. 부서장 정보 조회
-- 		* 부서장들의 부서명, 사원정보

-- 부서 정보 테이블에서 부서장번호를 조회한다.
-- Case 1 Scala Query
SELECT MANAGER_ID
     , DEPARTMENT_NAME
     , (SELECT FIRST_NAME 					-- Scala Query는 하나의 Column 만 조회가능하다. 
          FROM EMPLOYEES
         WHERE EMPLOYEE_ID = DEP.MANAGER_ID) AS FIRST_NAME	
     , (SELECT LAST_NAME  					-- Scala Query는 하나의 Column 만 조회가능하다. 
          FROM EMPLOYEES
         WHERE EMPLOYEE_ID = DEP.MANAGER_ID) LAST_NAME
  FROM DEPARTMENTS DEP
 WHERE MANAGER_ID IS NOT NULL 				-- 부서장 번호가 없는 부서는 제외한다.
;

SELECT MANAGER_ID
     , DEPARTMENT_NAME
     , (SELECT FIRST_NAME || ' ' || LAST_NAME
          FROM EMPLOYEES
         WHERE EMPLOYEE_ID = DEP.MANAGER_ID) NAME
  FROM DEPARTMENTS DEP
 WHERE MANAGER_ID IS NOT NULL 
; 
-- Case 2 Join
SELECT DEP.DEPARTMENT_NAME 
     , EMP.FIRST_NAME 
     , EMP.LAST_NAME
  FROM EMPLOYEES EMP
 INNER JOIN DEPARTMENTS DEP
    ON EMP.EMPLOYEE_ID = DEP.MANAGER_ID
;





-- 2. 재귀 조인
-- 		* 사원들의 상사를 조회
-- 		* 부하직원의 사원번호, 이름, 성, 상사의 사원번호, 이름, 성 조회
-- Case 1 Scala Query
SELECT EMP.EMPLOYEE_ID 
     , EMP.FIRST_NAME
     , EMP.LAST_NAME 
     , (SELECT EMPLOYEE_ID
          FROM EMPLOYEES -- 상사
         WHERE EMPLOYEE_ID = EMP.MANAGER_ID) MANAGER_ID -- 상사의 사원번호가 부하직원의 상사번호와 같은지
     , (SELECT FIRST_NAME || ' ' || LAST_NAME
          FROM EMPLOYEES
         WHERE EMPLOYEE_ID = EMP.MANAGER_ID) MANAGER_NAME
  FROM EMPLOYEES EMP -- 부하직원
 WHERE MANAGER_ID IS NOT NULL
; 
 
-- Case 2 Join
SELECT EMP.EMPLOYEE_ID
     , EMP.FIRST_NAME
     , EMP.LAST_NAME
     , MAN.EMPLOYEE_ID MANAGER_ID
     , MAN.FIRST_NAME MANAEGR_FIRST_NAME
     , MAN.LAST_NAME MANAGER_LAST_NAME
  FROM EMPLOYEES EMP -- 부하직원
 INNER JOIN EMPLOYEES MAN -- 상사
    ON EMP.MANAGER_ID = MAN.EMPLOYEE_ID -- 부하직원의 상사사원번호 = 상사의 사원 번호
;


SELECT MAN.EMPLOYEE_ID MANAGER_ID 
     , MAN.FIRST_NAME MANAGER_FIRST_NAME
     , MAN.LAST_NAME MANAGER_LAST_NAME
     , EMP.EMPLOYEE_ID
     , EMP.FIRST_NAME 
     , EMP.LAST_NAME 
  FROM EMPLOYEES MAN -- 상사
 INNER JOIN EMPLOYEES EMP -- 부하직원
    ON MAN.EMPLOYEE_ID = EMP.MANAGER_ID -- 상사의 아이디를 가지고, 부하직원의 상사를 가져와라.
;






-- 3. 계층 조회 (Oracle의 계층에서는 JOIN을 하지 않는다. 다른 DB에서는 JOIN을 함.)
-- 		* 계층으로 보여주기
 SELECT LEVEL
      , EMPLOYEE_ID
      , FIRST_NAME
      , LAST_NAME
      , MANAGER_ID
   FROM EMPLOYEES
  START WITH MANAGER_ID IS NULL 				-- MANAGER_ID부터 시작해서
CONNECT BY PRIOR MANAGER_ID = EMPLOYEE_ID       -- 우선순위로 연결해라
;
-- MANAGER ID가 NULL로 시작해서
-- MANAGER ID가 NULL인 사람의 MANAGER_ID가 누군가의 EMPLOYEE_ID 가지고 있으면 그 둘을 연결해서 순차대로 떨어뜨려라


 SELECT LEVEL									-- 계층 순서를 보여준다.
      , EMPLOYEE_ID
      , FIRST_NAME
      , LAST_NAME
      , MANAGER_ID
   FROM EMPLOYEES
  START WITH MANAGER_ID IS NULL 				-- MANAGER_ID부터 시작해서
CONNECT BY PRIOR EMPLOYEE_ID = MANAGER_ID		-- 우선순위로 연결해라.
-- MANAGER ID가 NULL로 시작해서
-- MANAGER ID가 NULL인 사람의 EMPLOYEE_ID가 누군가의 MANANGER_ID로 가지고 있으면 그 둘을 연결해서 순차대로 떨어뜨려라
;


-- 113번 사원의 모든 상사를 조회 (계층 쿼리)
 SELECT LEVEL
      , EMPLOYEE_ID
      , FIRST_NAME
      , LAST_NAME
      , MANAGER_ID
   FROM EMPLOYEES
  START WITH EMPLOYEE_ID = 113
CONNECT BY PRIOR MANAGER_ID = EMPLOYEE_ID -- 113번의 상사번호가 누군가의 사원번호이면 그 둘을 연결해서 나열해라
  ORDER BY LEVEL DESC
;

-- 5. (NOT) EXISTS
-- 부하직원이 없는 사원의 모든 사원정보 조회
SELECT *
  FROM EMPLOYEES E1 									 -- 서브쿼리의 결과가 없는 것만을 가져온다.
 WHERE NOT EXISTS (SELECT 1								 -- ROW의 여부만을	 판단하기 때문에 일반적으로 1을 준다.
 					 FROM EMPLOYEES E2
 					WHERE E2.MANAGER_ID = E1.EMPLOYEE_ID) -- E2의 매니저 아이디에 E1의 사원번호가 없는 것만을 가져와라
;
-- 부하직원이 있는 사원의 모든 사원정보 조회
SELECT *
  FROM EMPLOYEES E1 								 -- 서브쿼리의 결과가 있는 것만을 가져온다.
 WHERE EXISTS (SELECT 1								 -- ROW의 여부만을 판단하기 때문에 일반적으로 1을 준다.
 			     FROM EMPLOYEES E2
 				WHERE E2.MANAGER_ID = E1.EMPLOYEE_ID) -- E2의 매니저 아이디에 E1의 사원번호가 있는 것만을 가져와라
;

-- 6. (NOT) IN
-- 부하직원이 없는 사원의 모든 사원정보 조회
SELECT EMPLOYEE_ID
     , MANAGER_ID
  FROM EMPLOYEES E1
 WHERE E1.EMPLOYEE_ID NOT IN (SELECT MANAGER_ID                      -- (NOT IN : 존재하지 않는 것)들을 가져와라. 
 							    FROM EMPLOYEES E2
 							   WHERE E2.MANAGER_ID = E1.EMPLOYEE_ID) -- 말단사원인 104번을 조회하려하는데, 상사번호가 104번인 것이 존재하는가? 
;

SELECT EMPLOYEE_ID
     , MANAGER_ID
  FROM EMPLOYEES E1
 WHERE E1.EMPLOYEE_ID NOT IN (SELECT MANAGER_ID
 							    FROM EMPLOYEES E2) 					-- 값이 나오지 않는 이유?? 
;

SELECT EMPLOYEE_ID
     , MANAGER_ID
  FROM EMPLOYEES E1
 WHERE E1.EMPLOYEE_ID NOT IN (SELECT MANAGER_ID
 							    FROM EMPLOYEES E2
 							   WHERE E2.MANAGER_ID IS NOT NULL) 	-- IN 값에 NULL이 들어가면 나오지 않는다.
;
-- 부하직원이 있는 사원의 모든 사원정보 조회
SELECT EMPLOYEE_ID
     , MANAGER_ID
  FROM EMPLOYEES E1
 WHERE E1.EMPLOYEE_ID IN (SELECT MANAGER_ID 
 							FROM EMPLOYEES E2
 						   WHERE E2.MANAGER_ID = E1.EMPLOYEE_ID)

SELECT EMPLOYEE_ID
     , MANAGER_ID
  FROM EMPLOYEES E1
 WHERE E1.EMPLOYEE_ID IN (SELECT MANAGER_ID
 							FROM EMPLOYEES E2)
;

-- 7. DECODE 
-- AD_PRES -> AP
-- AD_VP -> AV
-- IT_PROG -> IP
-- FI_MGR -> FM
-- FI_ACCOUNT -> FA
-- PU_MAN -> PM
-- 다 아니면 '-'
-- 으로 변환하여 조회
-- JOB_ID, MIN_JOB_ID
SELECT JOB_ID
     , DECODE(JOB_ID                 -- DECODE(디코딩할 컬럼, 변환할 내용)
            , 'AD_PRES', 'AP'
            , 'AD_VP', 'AV'
            , 'IT_PROG', 'IP'
            , 'FI_MGR', 'FM'
            , 'FI_ACCOUNT', 'FA'
            , 'PU_MAN', 'PM'
            , '-') MIN_JOB_ID
  FROM EMPLOYEES
;

-- JOB_ID 의 자리수가 4라면 'FOUR'
--				   5라면 'FIVE'
--				   6이라면 'SIX'
--                 그 외 '-'
SELECT JOB_ID
     , LENGTH(JOB_ID)
	 , DECODE(LENGTH(JOB_ID)
	        , 4, 'FOUR'
	        , 5,'FIVE'
	        , 6,'SIX'
	        ,'-') LEN
  FROM EMPLOYEES
;


-- 8. CASE
-- AD_PRES -> AP
-- AD_VP -> AV
-- IT_PROG -> IP
-- FI_MGR -> FM
-- FI_ACCOUNT -> FA
-- PU_MAN -> PM
-- 다 아니면 '-'
-- 으로 변환하여 조회
-- JOB_ID, MIN_JOB_ID


/*
 * SELECT JOB_ID
        , CASE [컬럼명]
             WHEN 값 또는 조건 THEN
                결과값
             WHEN 값 또는 조건 THEN
                결과값
             [ELSE]
                결과값
           END ALIAS
     FROM EMPLOYEES
;
 */

SELECT JOB_ID
     , CASE JOB_ID
         WHEN 'AD_PRES' THEN 
           'AP'
         WHEN 'AD_VP' THEN 
           'AV'
         WHEN 'IT_PROG' THEN 
           'IP'
         WHEN 'FI_MGR' THEN 
           'FM'
         WHEN 'FI_ACCOUNT' THEN 
           'FA'
         WHEN 'PU_MAN' THEN 
           'PM'
         ELSE 
           '-'
        END MIN_JOB_ID
  FROM EMPLOYEES
;

-- 연봉이 평균연봉보다 많이 받으면 "고액연봉"
-- 연봉이 평균연봉보다 적게 받으면 "저연봉"
-- 둘 다 아니면, "평균연봉"
-- 으로 조회
SELECT SALARY
     , CASE 
     	 WHEN SALARY >= (SELECT AVG(SALARY)
     	                   FROM EMPLOYEES) THEN
     	 	'고액연봉'
     	 WHEN SALARY < (SELECT AVG(SALARY)
     	 				  FROM EMPLOYEES) THEN
     	 	'저연봉'
     	 ELSE 
     	 	'평균연봉'
     END SALARY_TYPE
  FROM EMPLOYEES
;

-- 9. NVL
-- 상사가 없는 경우 "-" 로 출력
SELECT EMPLOYEE_ID
     , MANAGER_ID
     , NVL(MANAGER_ID, -1)
     , NVL(TO_CHAR(MANAGER_ID), '-')
     , NVL(FIRST_NAME, '-')
  FROM EMPLOYEES
;
-- CASE
SELECT EMPLOYEE_ID
     , MANAGER_ID
     , CASE
     	 WHEN MANAGER_ID IS NULL THEN
     	 	-1
     	 ELSE 
     	 	MANAGER_ID 
     END NVL_MANAGER_ID
  FROM EMPLOYEES
;
-- 10. LPAD
SELECT LPAD(EMPLOYEE_ID, 10, 'B')
  FROM EMPLOYEES
;
-- 11. RPAD
SELECT RPAD(EMPLOYEE_ID, 10, 'B')
  FROM EMPLOYEES
;
-- 12. TO_CHAR
SELECT HIRE_DATE
     , TO_CHAR(HIRE_DATE)
     , TO_CHAR(HIRE_DATE, 'YYYY/MM/DD HH:MI:SS')
     , TO_CHAR(HIRE_DATE, 'YYYY-MM-DD HH24:MI:SS')
  FROM EMPLOYEES
;
-- 13. TO_DATE
SELECT '20230220162457'
     , TO_DATE('20230220162457', 'YYYY-MM-DD HH24:MI:SS')
  FROM DUAL
;

SELECT *
  FROM DUAL
;
-- 14. SUBSTR
SELECT FIRST_NAME
     , SUBSTR(FIRST_NAME, 0, 1)
     , SUBSTR(FIRST_NAME, 1, 2)
     , SUBSTR(FIRST_NAME, 4, 3)
     , SUBSTR(FIRST_NAME, 6, 2)
  FROM EMPLOYEES
;
-- 15. LENGTH
SELECT FIRST_NAME
     , LENGTH(FIRST_NAME)
  FROM EMPLOYEES
;
-- 16. LTRIM
SELECT '   ABC   '
     , LTRIM('   ABC   ')
  FROM DUAL
;
-- 17. RTRIM
SELECT '   ABC   '
     , RTRIM('   ABC   ')
  FROM DUAL
;
-- 18. TRIM
SELECT '   ABC   '
     , TRIM('   ABC   ')
  FROM DUAL
;
-- 19. ADD_MONTHS
SELECT ADD_MONTHS(SYSDATE, 3) "3달 뒤"
     , ADD_MONTHS(SYSDATE, 12) "1년 뒤"
     , ADD_MONTHS(SYSDATE, -12) "1년 전"
     , ADD_MONTHS(SYSDATE, 12*100) "100년 뒤"
  FROM DUAL
;

-- 20. SYSDATE
SELECT SYSDATE "오늘"
     , SYSDATE - 1 "어제"
     , SYSDATE + 1 "내일"
     , SYSDATE - (1/24) "1시간 전"
     , SYSDATE - (1/24/60) "1분 전"
  FROM DUAL
;

SELECT HIRE_DATE
     , HIRE_DATE - 1 "입사 전날"
     , HIRE_DATE - (1/24) "입사 1시간 전"
  FROM EMPLOYEES
;





























