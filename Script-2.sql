SELECT DEPARTMENT_ID
	 , DEPARTMENT_NAME 
	 , MANAGER_ID 
	 , LOCATION_ID 
  FROM DEPARTMENTS
 WHERE MANAGER_ID = 103
;

SELECT FIRST_NAME 
     , LAST_NAME 
  FROM EMPLOYEES
 WHERE MANAGER_ID = 103
 ORDER BY FIRST_NAME ASC
;

SELECT LAST_NAME 
  FROM EMPLOYEES
 WHERE FIRST_NAME = 'Steven'
 ORDER BY LAST_NAME DESC
;

SELECT CITY 
  FROM LOCATIONS
 WHERE COUNTRY_ID = 'US'
 ORDER BY CITY ASC
;

SELECT EMPLOYEE_ID 
     , FIRST_NAME 
     , SALARY 
  FROM EMPLOYEES
 WHERE SALARY BETWEEN 10000 AND 15000
 /*
 WHERE SALARY >= 10000 
   AND SALARY <= 15000
*/
 ORDER BY SALARY DESC
;

SELECT EMPLOYEE_ID 
     , FIRST_NAME 
     , MANAGER_ID 
     , COMMISSION_PCT 
  FROM EMPLOYEES
 WHERE COMMISSION_PCT IS NULL 
-- AND MANAGER_ID = 100
   AND MANAGER_ID IN 100
 ORDER BY EMPLOYEE_ID ASC
;

SELECT *
  FROM EMPLOYEES
 WHERE (JOB_ID = 'FI_MGR'
    OR JOB_ID = 'ST_MAN')
   AND SALARY <= 10000
 ORDER BY HIRE_DATE ASC
;

SELECT *
  FROM EMPLOYEES
 WHERE (FIRST_NAME = 'Bruce'
    OR LAST_NAME = 'Chen')
   AND JOB_ID = 'FI_ACCOUNT'
;

SELECT *
  FROM EMPLOYEES
 WHERE JOB_ID != 'FI_ACCOUNT'
;

SELECT *
  FROM EMPLOYEES
 WHERE JOB_ID IN ('FI_MGR', 'ST_MAN')
   AND SALARY <= 10000
 ORDER BY HIRE_DATE ASC 
;

SELECT *
  FROM EMPLOYEES
 WHERE JOB_ID != 'FI_MGR'
   AND JOB_ID != 'ST_MAN'
   AND SALARY <= 10000
 ORDER BY HIRE_DATE ASC 
;

SELECT *
  FROM EMPLOYEES
 WHERE JOB_ID NOT IN ('FI_MGR', 'ST_MAN')
   AND SALARY <= 10000
 ORDER BY HIRE_DATE ASC 
;

SELECT *
  FROM EMPLOYEES
 WHERE FIRST_NAME LIKE 'S%'
;

SELECT *
  FROM EMPLOYEES
 WHERE FIRST_NAME LIKE '%n'
;

SELECT *
  FROM EMPLOYEES
 WHERE FIRST_NAME LIKE 'S%n'
;

SELECT *
  FROM EMPLOYEES
 WHERE FIRST_NAME LIKE '%eve%'
;

SELECT *
  FROM EMPLOYEES
 WHERE FIRST_NAME LIKE '%Ste%'
;

SELECT *
  FROM EMPLOYEES
 WHERE PHONE_NUMBER LIKE '515.%'
 ORDER BY FIRST_NAME DESC 
;

SELECT *
  FROM EMPLOYEES
 WHERE JOB_ID LIKE '%PRES'
 ORDER BY LAST_NAME ASC 
;

SELECT DEPARTMENT_ID 
     , DEPARTMENT_NAME
  FROM DEPARTMENTS
 WHERE DEPARTMENT_NAME LIKE '%I%'
    OR DEPARTMENT_NAME LIKE '%i%'
 ORDER BY LOCATION_ID DESC
;

SELECT DEPARTMENT_NAME
  FROM DEPARTMENTS
 WHERE DEPARTMENT_NAME NOT LIKE '%IT%'
 ORDER BY DEPARTMENT_NAME DESC
;

SELECT DEPARTMENT_NAME
  FROM DEPARTMENTS
 WHERE DEPARTMENT_NAME LIKE '%Co%'
   AND DEPARTMENT_NAME NOT LIKE '%T%'
;

SELECT *
  FROM EMPLOYEES
 WHERE FIRST_NAME LIKE '___'
;

SELECT *
  FROM EMPLOYEES
 WHERE FIRST_NAME LIKE '____d'
;

SELECT *
  FROM EMPLOYEES
 WHERE LAST_NAME LIKE '_e%'
;

SELECT JOB_ID
     , COUNT(1)
  FROM EMPLOYEES
 GROUP BY JOB_ID
;

SELECT DEPARTMENT_ID
     , COUNT(1)
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
;

SELECT SUM(SALARY)
  FROM EMPLOYEES
;

SELECT DEPARTMENT_ID
     , SUM(SALARY) AS "연봉의 합"
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
;

SELECT JOB_ID
     , SUM(SALARY) AS "연봉의 합"
  FROM EMPLOYEES
 GROUP BY JOB_ID
;

SELECT DEPARTMENT_ID
     , JOB_ID
     , SUM(SALARY) AS "연봉의 합"
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
     , JOB_ID
;

SELECT DEPARTMENT_ID
     , MAX(SALARY) AS "최고 연봉"
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
;

SELECT JOB_ID
     , MIN(SALARY) AS "최저 연봉"
  FROM EMPLOYEES
 GROUP BY JOB_ID
;

SELECT DEPARTMENT_ID
     , JOB_ID
     , MAX(SALARY) AS "최고 연봉"
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
     , JOB_ID 
;

SELECT MAX(SALARY) AS "최고 연봉"
     , MIN(SALARY) AS "최저 연봉"
     , AVG(SALARY) AS "평균 연봉"
     , SUM(SALARY) AS "연봉의 합"
  FROM EMPLOYEES
;

SELECT DEPARTMENT_ID
	 , COUNT(1) AS "데이터의 수"
	 , MAX(SALARY) AS "최고 연봉"
	 , MIN(SALARY) AS "최저 연봉"
	 , AVG(SALARY) AS "평균 연봉"
	 , SUM(SALARY) AS "연봉의 합"
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
;

SELECT MANAGER_ID
     , COUNT(1)
     , MAX(SALARY)
     , MIN(SALARY)
     , AVG(SALARY)
     , SUM(SALARY)
  FROM EMPLOYEES
 GROUP BY MANAGER_ID
;

SELECT DEPARTMENT_ID
     , MAX(SALARY)
     , MIN(SALARY)
     , AVG(SALARY)
  FROM EMPLOYEES
 WHERE JOB_ID != 'SA_REP'
 GROUP BY DEPARTMENT_ID 
;

SELECT DEPARTMENT_ID 
     , COUNT(1) AS "데이터 수"
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
 HAVING COUNT(1)  >= 3
;

SELECT MANAGER_ID AS "상사의 번호"
     , COUNT(1) AS "부하직원의 수"
  FROM EMPLOYEES
 GROUP BY MANAGER_ID
HAVING COUNT(1) >= 2
;

SELECT JOB_ID
     , AVG(SALARY)
     , MAX(SALARY)
     , MIN(SALARY)
  FROM EMPLOYEES
 GROUP BY JOB_ID
HAVING AVG(SALARY) >= 7000
 ORDER BY AVG(SALARY) ASC
;

SELECT DEPARTMENT_ID
     , COUNT(1)
     , AVG(SALARY)
     , MAX(SALARY)
     , MIN(SALARY)
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
HAVING COUNT(1) >= 3
   AND AVG(SALARY) >= 5000
;

-- 최저 연봉보다 많이 받는 사원들의 모든 정보를 조회
SELECT *
  FROM EMPLOYEES
 WHERE SALARY > (SELECT MIN(SALARY)
                    FROM EMPLOYEES)
;
-- 평균 연봉보다 많이 받는 사원들의 모든 정보를 조회
SELECT *
  FROM EMPLOYEES
 WHERE SALARY > (SELECT AVG(SALARY)
 				   FROM EMPLOYEES)
 ;
-- EMPLOYEES 테이블에서 FIRST_NAME은 Steven LAST_NAME은 King을 MANAGER_ID로 두고있는 모든 데이터를 조회한다.
SELECT *
  FROM EMPLOYEES
 WHERE MANAGER_ID = (SELECT EMPLOYEE_ID
 		  			   FROM EMPLOYEES
 		 			  WHERE FIRST_NAME = 'Steven'
 		   				AND LAST_NAME = 'King')
;
/*
 * EMPLOYEES 테이블에서 EMPLOYEE_ID 가 102번인 사원의 연봉과
 * 동일한 연봉을 받는 모든 사원의 정보를 조회한다.
 * 단, 102번은 조회에서 제외한다.
 */
SELECT *
  FROM EMPLOYEES
 WHERE SALARY = (SELECT SALARY
 				   FROM EMPLOYEES
 				  WHERE EMPLOYEE_ID = 102)
   AND EMPLOYEE_ID != 102
;
/*
 * EMPLOYEES 테이블에서 EMPLOYEE_ID 가 113번인 사원과 동일한 DEPARTMENT_ID를 가지는 모든 사원의 정보를 출력한다.
 * 단, 113번은 조회에서 제외한다.
 */
SELECT *
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID  = (SELECT DEPARTMENT_ID 
 						   FROM EMPLOYEES
 						  WHERE EMPLOYEE_ID	= 113)
   AND EMPLOYEE_ID != 113
;

/* EMPLOYEES 테이블에서
 * (EMPLOYEE_ID 가 115번인) 데이터의 JOB_ID와
 * 같은 JOB_ID를 가진 데이터를 모두 조회한다.
 * 단, 115번은 조회에서 제외한다.
 */

SELECT *
  FROM EMPLOYEES
 WHERE JOB_ID = (SELECT JOB_ID
 				   FROM EMPLOYEES
 				  WHERE EMPLOYEE_ID = 115)
   AND EMPLOYEE_ID != 115
;

/*
 * EMPLOYEES 테이블에서 (FIRST_NAME 이 J로 시작하는 데이터의 JOB_ID)와
 * 같은 JOB_ID를 가진 데이터를 모두 조회한다.
 */
SELECT *
  FROM EMPLOYEES
 WHERE JOB_ID IN (SELECT JOB_ID
 				   FROM EMPLOYEES
 				  WHERE FIRST_NAME LIKE 'J%')
;

/*
 * EMPLOYEES 테이블에서 (EMPLOYEE_ID가 116번, 201번의 데이터의 SALARY)와
 * 같은 SALARY를 가진 데이터를 모두 조회한다.
 * 단, 116번과 201번은 조회에서 제외한다.
 */
SELECT *
  FROM EMPLOYEES
 WHERE SALARY IN (SELECT SALARY
                    FROM EMPLOYEES
                   WHERE EMPLOYEE_ID IN (116, 201))
   AND EMPLOYEE_ID NOT IN (116, 201)
;

/*
 * EMPLOYEE 테이블에서 (EMPLOYEE_ID가 103번, 206, 115번의 데이터의 MANAGER_ID)와
 * 같은 MANAGER_ID를 가진 데이터를 모두 조회한다.
 * 단, 103번, 206번, 115번은 조회에서 제외한다.
 */
SELECT *
  FROM EMPLOYEES
 WHERE MANAGER_ID IN (SELECT MANAGER_ID
 					    FROM EMPLOYEES
 					   WHERE EMPLOYEE_ID IN (103, 206, 115))
   AND EMPLOYEE_ID NOT IN (103, 206, 115)
;

/* (서브 쿼리 문제)
 * IT 부서에서 일하는 사원의 이름과 성을 조회한다.
 */ 

-- IT 부서의 부서번호 조회
SELECT DEPARTMENT_ID
  FROM DEPARTMENTS
 WHERE DEPARTMENT_NAME = 'IT'
;

-- IT 부서위 부서번호로 사원의 이름과 성을 조회
SELECT FIRST_NAME
     , LAST_NAME
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = 60
;

-- 위의 2가지를 통합
SELECT FIRST_NAME
     , LAST_NAME
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                          FROM DEPARTMENTS
                         WHERE DEPARTMENT_NAME = 'IT')
;

/*
 * ((직무명이 'Programmer'인) 사원의 이메일을 조회한다).
 */
SELECT EMAIL
  FROM EMPLOYEES
 WHERE JOB_ID = (SELECT JOB_ID
                   FROM JOBS
                  WHERE JOB_TITLE = 'Programmer')
;

-- JOIN 을 이용해 풀이
SELECT EMAIL
  FROM EMPLOYEES e
     , JOBS j
 WHERE j.JOB_TITLE = 'Programmer'
   AND e.JOB_ID = j.JOB_ID
;

/*
 * Beijing 도시에 있는 부서명을 조회
 */

SELECT DEPARTMENT_NAME
  FROM DEPARTMENTS
 WHERE LOCATION_ID = (SELECT LOCATION_ID
 						FROM LOCATIONS
 					   WHERE CITY = 'Beijing')
;

-- JOIN 을 이용해 풀이
SELECT DEPARTMENT_NAME
  FROM DEPARTMENTS d 
     , LOCATIONS l 
 WHERE l.CITY = 'Beijing'
   AND d.LOCATION_ID = l.LOCATION_ID
;

/*
 * 'Canada' 에 있는 모든 도시명을 조회
 */

SELECT CITY
  FROM LOCATIONS
 WHERE COUNTRY_ID = (SELECT COUNTRY_ID
 					   FROM COUNTRIES
 					  WHERE COUNTRY_NAME = 'Canada')
;

-- JOIN 으로 풀이
SELECT l.CITY
     , c.COUNTRY_NAME
  FROM LOCATIONS l 
     , COUNTRIES c 
 WHERE c.COUNTRY_NAME = 'Canada'
   AND l.COUNTRY_ID = c.COUNTRY_ID
;
 
/*
 * 'United States of America' 국가에 있는 모든 부서명과 부서번호를 조회한다.
 */

SELECT DEPARTMENT_ID
     , DEPARTMENT_NAME
  FROM DEPARTMENTS
 WHERE LOCATION_ID IN (SELECT LOCATION_ID
 						 FROM LOCATIONS
 					    WHERE COUNTRY_ID = (SELECT COUNTRY_ID
 					   						  FROM COUNTRIES
 					   						 WHERE COUNTRY_NAME = 'United States of America'))
;

SELECT d.DEPARTMENT_ID
     , d.DEPARTMENT_NAME
  FROM DEPARTMENTS d 
     , LOCATIONS l
     , COUNTRIES c 
 WHERE c.COUNTRY_NAME = 'United States of America'
   AND d.LOCATION_ID = l.LOCATION_ID 
   AND l.COUNTRY_ID = c.COUNTRY_ID
;
 

/*
 * EMPLOYEES 와 DEPARTMENT를 조인할 결과를 모두 조회
 */

-- ORACLE SQL
SELECT *
  FROM EMPLOYEES e
     , DEPARTMENTS d 
 WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID;
;

-- ANSI SQL (표준 : 어디서든 사용 가능)
SELECT *
  FROM EMPLOYEES EMP
 INNER JOIN DEPARTMENTS DEP
    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
;

SELECT *
  FROM EMPLOYEES EMP
  LEFT OUTER JOIN DEPARTMENTS DEP
    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
;

SELECT *
  FROM EMPLOYEES EMP
 RIGHT OUTER JOIN DEPARTMENTS DEP
    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
;

SELECT *
  FROM EMPLOYEES EMP
 FULL OUTER JOIN DEPARTMENTS DEP
    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
;

/*
 * IT 부서에서 일하는 모든 사원들의 이름과 부서장 번호를 조회한다.
 */
SELECT EMP.FIRST_NAME
     , DEP.MANAGER_ID
  FROM EMPLOYEES EMP
 INNER JOIN DEPARTMENTS DEP
    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
 WHERE DEP.DEPARTMENT_NAME = 'IT'
;

/*
 * 'Seattle' 에 존재하는 부서명과 우편번호를 조회한다.
 */
SELECT DEP.DEPARTMENT_NAME
     , LOC.POSTAL_CODE
  FROM DEPARTMENTS DEP
 INNER JOIN LOCATIONS LOC
    ON DEP.LOCATION_ID = LOC.LOCATION_ID
 WHERE LOC.CITY = 'Seattle'
;

/*
 * 145번 사원이 부서장으로 근무하는 부서에 있는 사원들의 이름과 부서명을 조회.
 */

SELECT EMP.FIRST_NAME
     , DEP.DEPARTMENT_NAME 
  FROM EMPLOYEES EMP
 INNER JOIN DEPARTMENTS DEP
    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID -- 40몇 개가 나온다.
 WHERE DEP.MANAGER_ID = 145
;

SELECT EMP.FIRST_NAME
     , DEP.DEPARTMENT_NAME 
  FROM EMPLOYEES EMP
 INNER JOIN DEPARTMENTS DEP
    ON EMP.EMPLOYEE_ID  = DEP.MANAGER_ID -- 1개가 나온다.
 WHERE DEP.MANAGER_ID = 145
;


/*
 * 직무아이디 가 'ST_CLERK'인 사원의 이름, 성, 직무명, 최저연봉 을 조회
 */

SELECT EMP.FIRST_NAME 
     , EMP.LAST_NAME 
     , JOB.JOB_TITLE
     , JOB.MIN_SALARY
  FROM EMPLOYEES EMP
 INNER JOIN JOBS JOB
    ON EMP.JOB_ID = JOB.JOB_ID
 WHERE EMP.JOB_ID = 'ST_CLERK'
-- WHERE JOB.JOB_ID = 'ST_CLERK' 동일한 의미
;

/*
 * 100번 부서장이 근무하는 부서명, 도시명, 우편번호를 조회
 */
SELECT DEP.DEPARTMENT_NAME
     , LOC.CITY
     , LOC.POSTAL_CODE
  FROM DEPARTMENTS DEP
 INNER JOIN LOCATIONS LOC
    ON DEP.LOCATION_ID = LOC.LOCATION_ID
 WHERE DEP.MANAGER_ID = 100
;

/*
 * 국가 아이디가 'CN' 인 주, 도시, 주소와 국가명을 조회
 */

SELECT LOC.STREET_ADDRESS 주소
     , LOC.CITY 도시
     , LOC.STATE_PROVINCE 주
     , COU.COUNTRY_NAME 국가명
  FROM LOCATIONS LOC
 INNER JOIN COUNTRIES COU
    ON LOC.COUNTRY_ID = COU.COUNTRY_ID
 WHERE COU.COUNTRY_ID = 'CN'
;























