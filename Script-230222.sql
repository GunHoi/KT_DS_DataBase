-- EXISTS (데이터가 존재한다.)
-- 사원이 있는 부서를 조회한다.
SELECT *
  FROM DEPARTMENTS DEP
 WHERE EXISTS (SELECT 1
                 FROM EMPLOYEES EMP
                WHERE EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID)
;

-- 사원이 없는 부서를 조회한다.
SELECT *
  FROM DEPARTMENTS DEP
 WHERE NOT EXISTS (SELECT 1
                 	 FROM EMPLOYEES EMP
               		WHERE EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID)
;

-- 사원이 있는 도시를 조회한다.
SELECT *
  FROM LOCATIONS LOC
 WHERE EXISTS (SELECT 1
 				 FROM DEPARTMENTS DEP
 				WHERE DEP.LOCATION_ID = LOC.LOCATION_ID		 				-- 논리상 이해가 쉽게 되도록 작성하는 것이 좋다.
 				  AND EXISTS (SELECT 1
 								FROM EMPLOYEES EMP
 							   WHERE EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID))
;

SELECT *
  FROM LOCATIONS LOC
 WHERE EXISTS (SELECT 1
 				 FROM DEPARTMENTS DEP
 				WHERE EXISTS (SELECT 1
 								FROM EMPLOYEES EMP
 							   WHERE EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
 							     AND DEP.LOCATION_ID = LOC.LOCATION_ID)) 	-- WHERE는 순서를 따지지 않기 때문에, 위와 동일한 결과 값이 나오게 된다.
;

-- 사원이 없는 도시를 조회한다.
SELECT *
  FROM LOCATIONS LOC
 WHERE NOT EXISTS (SELECT 1
 				 	 FROM DEPARTMENTS DEP
 					WHERE DEP.LOCATION_ID = LOC.LOCATION_ID
 				  	  AND EXISTS (SELECT 1
 								    FROM EMPLOYEES EMP
 							   	   WHERE EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID))
;

-- 부서가 없는 국가를 조회한다.


-- (1) 부서가 있는 지역 조회
-- (2) 부서가 있는 지역이 없는 국가 조회

SELECT *
  FROM COUNTRIES COU
 WHERE NOT EXISTS (SELECT 1
 				 FROM LOCATIONS LOC
 				WHERE LOC.COUNTRY_ID = COU.COUNTRY_ID 
 				  AND EXISTS (SELECT *
 				                FROM DEPARTMENTS DEP
 				               WHERE DEP.LOCATION_ID = LOC.LOCATION_ID))
;

-- IN (관련 데이터가 있다.)
-- 부서번호가 10, 20, 30인 사원의 모든 정보를 조회한다.
SELECT *
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
 						   FROM DEPARTMENTS
 						  WHERE DEPARTMENT_NAME = 'IT')
;

--사원이 있는 부서를 조회한다.
SELECT *
  FROM DEPARTMENTS DEP
 WHERE DEP.DEPARTMENT_ID IN (SELECT DISTINCT EMP.DEPARTMENT_ID 
                 	 		   FROM EMPLOYEES EMP)
;

-- 사원이 있는 도시를 조회한다.
SELECT *
  FROM LOCATIONS LOC
 WHERE LOC.LOCATION_ID IN (SELECT DISTINCT DEP.LOCATION_ID 
 				 			 FROM DEPARTMENTS DEP
 							WHERE DEP.DEPARTMENT_ID IN (SELECT DISTINCT EMP.DEPARTMENT_ID 
 														  FROM EMPLOYEES EMP))
;

-- NOT IN
-- 사원이 없는 부서를 조회한다.
SELECT *
  FROM DEPARTMENTS DEP
 WHERE DEP.DEPARTMENT_ID NOT IN (SELECT DISTINCT EMP.DEPARTMENT_ID 
                 	 			   FROM EMPLOYEES EMP)
; 

SELECT *
  FROM DEPARTMENTS DEP
 WHERE DEP.DEPARTMENT_ID NOT IN (SELECT DISTINCT EMP.DEPARTMENT_ID 
                 	 			   FROM EMPLOYEES EMP
                 	 			  WHERE EMP.DEPARTMENT_ID = EMP.DEPARTMENT_ID)
;                 	 			  
SELECT *
  FROM DEPARTMENTS DEP
 WHERE DEP.DEPARTMENT_ID NOT IN (SELECT DISTINCT EMP.DEPARTMENT_ID 
                 	 			   FROM EMPLOYEES EMP
                 	 			  WHERE DEPARTMENT_ID IS NOT NULL)         
;

-- 사원이 없는 도시를 조회한다.
SELECT *
  FROM LOCATIONS LOC
 WHERE LOC.LOCATION_ID NOT IN (SELECT DISTINCT DEP.LOCATION_ID 
 				 	 			 FROM DEPARTMENTS DEP
 				  	  			WHERE DEP.DEPARTMENT_ID IN (SELECT DISTINCT EMP.DEPARTMENT_ID 
 								    	    				  FROM EMPLOYEES EMP))
;

--1. 현재 시간을 조회한다.
SELECT SYSDATE 
  FROM DUAL
;
--2. 현재 시간을 "연-월-일" 포멧으로 조회한다.
SELECT TO_DATE(SYSDATE, 'YY-MM-DD')
  FROM DUAL
;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD')
  FROM DUAL
;
--3. 한 시간 전 시간을 "시:분:초" 포멧으로 조회한다.
SELECT TO_CHAR(SYSDATE - (1/24) , 'HH24:MI:SS')
  FROM DUAL
;
--4. EMPLOYEES 테이블의 모든 정보를 조회한다.
SELECT *
  FROM EMPLOYEES
;
--5. DEPARTMENTS 테이블의 모든 정보를 조회한다.

--6. JOBS 테이블의 모든 정보를 조회한다.

--7. LOCATIONS 테이블의 모든 정보를 조회한다.

--8. COUNTRIES 테이블의 모든 정보를 조회한다.

--9. REGIONS 테이블의 모든 정보를 조회한다.

--10. JOB_HISTORY 테이블의 모든 정보를 조회한다.

--11. 90번 부서에서 근무하는 사원들의 모든 정보를 조회한다.
SELECT *
  FROM EMPLOYEES EMP
 WHERE EMP.DEPARTMENT_ID = (SELECT DEP.DEPARTMENT_ID 
 							  FROM DEPARTMENTS DEP
 							  WHERE DEP.DEPARTMENT_ID = 90) 
;
--12. 90번, 100번 부서에서 근무하는 사원들의 모든 정보를 조회한다.
SELECT *
  FROM EMPLOYEES EMP
 WHERE DEPARTMENT_ID IN (90, 100)
;
--13. 100번 상사의 직속 부하직원의 모든 정보를 조회한다.
SELECT *
  FROM EMPLOYEES
 WHERE MANAGER_ID = 100
;
--14. 직무 아이디가 AD_VP 인 사원의 모든 정보를 조회한다.

--15. 연봉이 7000 이상인 사원의 모든 정보를 조회한다.
SELECT *
  FROM EMPLOYEES
 WHERE SALARY >= 7000
;
--16. 2005년 09월에 입사한 사원들의 모든 정보를 조회한다.
SELECT *
  FROM EMPLOYEES
 WHERE HIRE_DATE BETWEEN TO_DATE('2005-09-01','YYYY-MM-DD') AND TO_DATE('2005-09-30','YYYY-MM-DD')
;
 --17. 111번 사원의 모든 정보를 조회한다.
SELECT *
  FROM EMPLOYEES EMP
 WHERE EMP.EMPLOYEE_ID = 111
;
--18. 인센티브를 안받는 사원들의 모든 정보를 조회한다.
SELECT *
  FROM EMPLOYEES
 WHERE COMMISSION_PCT IS NULL
;
--19. 인센티브를 받는 사원들의 모든 정보를 조회한다.
SELECT *
  FROM EMPLOYEES
 WHERE COMMISSION_PCT IS NOT NULL 
;
--20. 이름의 첫 글자가 'D' 인 사원들의 모든 정보를 조회한다.
SELECT *
  FROM EMPLOYEES
 WHERE FIRST_NAME LIKE 'D%'
;
--21. 성의 마지막 글자가 'a' 인 사원들의 모든 정보를 조회한다.
SELECT *
  FROM EMPLOYEES
 WHERE LAST_NAME LIKE '%a'
;
--22. 전화번호에 '.124.'이 포함된 사원들의 모든 정보를 조회한다.
SELECT *
  FROM EMPLOYEES
 WHERE PHONE_NUMBER LIKE '%.124.%'
;
 --23. 직무 아이디가 'PU_CLERK'인 사원 중 연봉이 3000 이상인 사원들의 모든 정보를 조회한다.
SELECT *
  FROM EMPLOYEES EMP
 WHERE EMP.JOB_ID = 'PU_CLERK'
   AND SALARY >= 3000
;

--24. 평균 연봉보다 많이 받는 사원들의 사원번호, 이름, 성, 연봉을 조회한다.
SELECT EMP.EMPLOYEE_ID
     , EMP.FIRST_NAME 
     , EMP.LAST_NAME 
     , EMP.SALARY 
  FROM EMPLOYEES EMP
 WHERE EMP.SALARY >= (SELECT AVG(SALARY)
 						FROM EMPLOYEES)
;
--25. 평균 연봉보다 적게 받는 사원들의 사원번호, 연봉, 부서번호를 조회한다.
SELECT EMP.EMPLOYEE_ID
     , EMP.SALARY 
     , EMP.DEPARTMENT_ID 
  FROM EMPLOYEES EMP
 WHERE EMP.SALARY <= (SELECT AVG(SALARY)
 						FROM EMPLOYEES)
;
--26. 가장 많은 연봉을 받는 사원의 사원번호, 이름, 연봉을 조회한다.
SELECT EMPLOYEE_ID
     , FIRST_NAME
     , SALARY
  FROM EMPLOYEES
 WHERE SALARY = (SELECT MAX(SALARY)
 				   FROM EMPLOYEES)
;
--27. 이름이 4글자인 사원의 모든 정보를 조회한다.
SELECT *
  FROM EMPLOYEES EMP
 WHERE FIRST_NAME LIKE '____'
;
--28. 'SA_REP' 직무인 직원 중 가장 높은 연봉과 가장 낮은 연봉을 조회한다.
SELECT MAX(SALARY)
	 , MIN(SALARY)
  FROM EMPLOYEES EMP
 WHERE JOB_ID = 'SA_REP'
;
--29. 직원의 입사일자를 '연-월-일' 형태로 조회한다.
SELECT TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
  FROM EMPLOYEES EMP
;
--30. 가장 늦게 입사한 사원의 모든 정보를 조회한다.
SELECT *
  FROM EMPLOYEES
 WHERE HIRE_DATE = (SELECT MAX(HIRE_DATE)
 					  FROM EMPLOYEES)
;

--31. 가장 일찍 입사한 사원의 모든 정보를 조회한다.
SELECT *
  FROM EMPLOYEES
 WHERE HIRE_DATE = (SELECT MIN(HIRE_DATE)
 					  FROM EMPLOYEES)
;
--32. 자신의 상사보다 더 많은 연봉을 받는 사원의 모든 정보를 조회한다.
SELECT *
  FROM EMPLOYEES EMP
 INNER JOIN EMPLOYEES MAN 
    ON EMP.MANAGER_ID = MAN.EMPLOYEE_ID 
   AND EMP.SALARY > MAN.SALARY
;
--33. 자신의 상사보다 더 일찍 입사한 사원의 모든 정보를 조회한다.
SELECT *
  FROM EMPLOYEES EMP
 INNER JOIN EMPLOYEES MAN
    ON EMP.MANAGER_ID = MAN.EMPLOYEE_ID
 WHERE EMP.HIRE_DATE < MAN.HIRE_DATE
;
--34. 부서아이디별 평균 연봉을 조회한다.
SELECT AVG(SALARY)
     , DEPARTMENT_ID
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
;
--35. 직무아이디별 평균 연봉, 최고연봉, 최저연봉을 조회한다.
SELECT AVG(SALARY)
     , MAX(SALARY)
     , MIN(SALARY)
  FROM EMPLOYEES
 GROUP BY JOB_ID
;
--36. 가장 많은 인센티브를 받는 사원의 모든 정보를 조회한다.
SELECT *
  FROM EMPLOYEES EMP
 WHERE COMMISSION_PCT  = (SELECT MAX(COMMISSION_PCT)
 							FROM EMPLOYEES)
;
--37. 가장 적은 인센티브를 받는 사원의 연봉과 인센티브를 조회한다.
SELECT SALARY
	 , COMMISSION_PCT
  FROM EMPLOYEES EMP
 WHERE COMMISSION_PCT = (SELECT MIN(COMMISSION_PCT)
 						   FROM EMPLOYEES)
;
--38. 직무아이디별 사원의 수를 조회한다.
SELECT COUNT(1)
	 , JOB_ID
  FROM EMPLOYEES
 GROUP BY JOB_ID
;
--39. 상사아이디별 부하직원의 수를 조회한다. 단, 부하직원이 2명 이하인 경우는 제외한다.
SELECT EMP.MANAGER_ID
     , COUNT(1)
  FROM EMPLOYEES EMP
 GROUP BY EMP.MANAGER_ID
HAVING COUNT(1) > 2
;
--40. 사원이 속한 부서의 평균연봉보다 적게 받는 사원의 모든 정보를 조회한다.
SELECT *
  FROM EMPLOYEES EMP
 WHERE EMP.SALARY <= (SELECT AVG(SALARY)
 						FROM EMPLOYEES EMP2
 					   WHERE EMP.DEPARTMENT_ID = EMP2.DEPARTMENT_ID)
;
--41. 사원이 근무하는 부서명, 이름, 성을 조회한다.
SELECT DEP.DEPARTMENT_NAME 
	 , EMP.FIRST_NAME
	 , EMP.LAST_NAME
  FROM EMPLOYEES EMP
 INNER JOIN DEPARTMENTS DEP
    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID 
;
--42. 가장 적은 연봉을 받는 사원의 부서명, 이름, 성, 연봉, 부서장사원번호를 조회한다.
SELECT *
  FROM EMPLOYEES EMP
 WHERE EMP.SALARY = (SELECT MIN(SALARY)
 					   FROM EMPLOYEES)
;
--43. 상사사원번호를 중복없이 조회한다.
SELECT DISTINCT EMP.MANAGER_ID 
  FROM EMPLOYEES EMP
;
--44. 50번 부서의 부서장의 이름, 성, 연봉을 조회한다.
SELECT DISTINCT EMP.FIRST_NAME
	 , EMP.LAST_NAME
	 , EMP.SALARY
  FROM EMPLOYEES EMP
 INNER JOIN DEPARTMENTS DEP
    ON EMP.DEPARTMENT_ID  = DEP.DEPARTMENT_ID
 WHERE DEP.DEPARTMENT_ID = 50
   AND EMP.EMPLOYEE_ID = DEP.MANAGER_ID
;
--45. 부서명별 사원의 수를 조회한다.
SELECT DEP.DEPARTMENT_NAME 
	 , COUNT(1)
  FROM EMPLOYEES EMP
 INNER JOIN DEPARTMENTS DEP
    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
 GROUP BY DEPARTMENT_NAME
;
--46. 사원의 수가 가장 많은 부서명, 사원의 수를 조회한다.

-- step 1 사원수 별 부서
SELECT DEPARTMENT_ID 
	 , COUNT(1) CNT
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
;

-- step 2 사원수 별 부서를 내림차순 정렬
SELECT DEPARTMENT_ID
     , CNT
  FROM (SELECT DEPARTMENT_ID 
			 , COUNT(1) CNT
		  FROM EMPLOYEES
		 GROUP BY DEPARTMENT_ID)
 ORDER BY CNT DESC
;

-- step 3 사원수 별 부서를 내림차순 정렬한 값중 가장 큰 값 (첫번째 값)
SELECT DEPARTMENT_ID 
     , CNT
  FROM (SELECT DEPARTMENT_ID
		     , CNT
		  FROM (SELECT DEPARTMENT_ID 
					 , COUNT(1) CNT
				  FROM EMPLOYEES
				 GROUP BY DEPARTMENT_ID)
		 ORDER BY CNT DESC) 
 WHERE ROWNUM <= 1
;

-- step 4 사원수 별 부서를 내림차순 정렬한 값중 가장 큰 값 (첫번째 값)의 TABLE(MAX_DEP)과 DEPARTMENTS를 INNER JOIN
SELECT DEP.DEPARTMENT_NAME
     , MAX_DEP.CNT
  FROM DEPARTMENTS DEP
 INNER JOIN (SELECT DEPARTMENT_ID 
                  , CNT
               FROM (SELECT DEPARTMENT_ID
              		   	  , CNT
					   FROM (SELECT DEPARTMENT_ID 
								  , COUNT(1) CNT
							   FROM EMPLOYEES
							  GROUP BY DEPARTMENT_ID)
		 			  ORDER BY CNT DESC) 
 			  WHERE ROWNUM <= 1) MAX_DEP
   ON MAX_DEP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
;
--47. 사원이 없는 부서명을 조회한다.
SELECT DEP.DEPARTMENT_NAME
  FROM DEPARTMENTS DEP
 WHERE DEP.DEPARTMENT_ID NOT IN (SELECT EMP.DEPARTMENT_ID
 								   FROM EMPLOYEES EMP
 								  WHERE EMP.DEPARTMENT_ID IS NOT NULL)
;
--48. 직무가 변경된 사원의 모든 정보를 조회한다.
SELECT *
  FROM EMPLOYEES EMP
 WHERE EMP.EMPLOYEE_ID IN (SELECT JHT.EMPLOYEE_ID
 							FROM JOB_HISTORY JHT)
;

-- 중복이 제거 되지 않는다.
SELECT *
  FROM EMPLOYEES EMP
 INNER JOIN JOB_HISTORY JHT
    ON EMP.EMPLOYEE_ID = JHT.EMPLOYEE_ID
;

--49. 직무가 변경된적 없는 사원의 모든 정보를 조회한다.
SELECT *
  FROM EMPLOYEES EMP
 WHERE EMP.EMPLOYEE_ID NOT IN (SELECT JHT.EMPLOYEE_ID
 								 FROM JOB_HISTORY JHT
 								WHERE JHT.EMPLOYEE_ID IS NOT NULL)
;
--50. 직무가 변경된 사원의 과거 직무명과 현재 직무명을 조회한다.
SELECT PAST_JOB.JOB_TITLE "과거 직무명"
     , JOB.JOB_TITLE "현재 직무명"
  FROM EMPLOYEES EMP
 INNER JOIN JOBS JOB 			-- 현재 직무명
    ON EMP.JOB_ID = JOB.JOB_ID  
 INNER JOIN JOB_HISTORY JHT 	-- 과거 직무 ID
    ON EMP.EMPLOYEE_ID = JHT.EMPLOYEE_ID
 INNER JOIN JOBS PAST_JOB 		-- 과거 직무명
    ON JHT.JOB_ID = PAST_JOB.JOB_ID
;
 
--51. 직무가 가장 많이 변경된 부서의 이름을 조회한다.

-- 직무 변경된 횟수를 조회
SELECT COUNT(1)
     , DEPARTMENT_ID
  FROM JOB_HISTORY
 GROUP BY DEPARTMENT_ID
;
-- 직무 변경된 횟수가 가장 많은 것
SELECT *
  FROM (SELECT COUNT(1) CNT
		     , DEPARTMENT_ID
		  FROM JOB_HISTORY
		 GROUP BY DEPARTMENT_ID)
 ORDER BY CNT DESC
;
-- 1개만 가져오기
SELECT CNT
     , DEPARTMENT_ID
  FROM (SELECT CNT
		     , DEPARTMENT_ID
		  FROM (SELECT COUNT(1) CNT
				     , DEPARTMENT_ID
				  FROM JOB_HISTORY
				 GROUP BY DEPARTMENT_ID)
		 ORDER BY CNT DESC)
 WHERE ROWNUM = 1
;
-- 직무 변경이 가장 많은 부서의 이름을 조회
SELECT DEP.DEPARTMENT_NAME 
     , MAX_MOVE.CNT
  FROM DEPARTMENTS DEP
 INNER JOIN (SELECT CNT
			      , DEPARTMENT_ID
			   FROM (SELECT CNT
					      , DEPARTMENT_ID
					   FROM (SELECT COUNT(1) CNT
							      , DEPARTMENT_ID
							   FROM JOB_HISTORY
							  GROUP BY DEPARTMENT_ID)
					  ORDER BY CNT DESC)
			  WHERE ROWNUM = 1) MAX_MOVE
   ON DEP.DEPARTMENT_ID = MAX_MOVE.DEPARTMENT_ID
;
--52. 'Seattle' 에서 근무중인 사원의 이름, 성, 연봉, 부서명 을 조회한다.
SELECT EMP.FIRST_NAME
     , EMP.LAST_NAME
     , EMP.SALARY
     , DEP.DEPARTMENT_NAME 
  FROM EMPLOYEES EMP
 INNER JOIN DEPARTMENTS DEP
    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
 INNER JOIN LOCATIONS LOC
    ON DEP.LOCATION_ID = LOC.LOCATION_ID
 WHERE LOC.CITY = 'Seattle'
;
--53. 'Seattle' 에서 근무하지 않는 모든 사원의 이름, 성, 연봉, 부서명, 도시를 조회한다.
SELECT EMP.FIRST_NAME
     , EMP.LAST_NAME
     , EMP.SALARY
     , DEP.DEPARTMENT_NAME
     , LOC.CITY
  FROM EMPLOYEES EMP
 INNER JOIN DEPARTMENTS DEP
    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
 INNER JOIN LOCATIONS LOC
    ON DEP.LOCATION_ID = LOC.LOCATION_ID
 WHERE LOC.CITY != 'Seattle'
;
--54. 근무중인 사원이 가장 많은 도시와 사원의 수를 조회한다.

-- 근무중인 사원의 수
SELECT COUNT(EMPLOYEE_ID)
     , LOC.CITY
  FROM EMPLOYEES EMP
 INNER JOIN DEPARTMENTS DEP
    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
 INNER JOIN LOCATIONS LOC
    ON DEP.LOCATION_ID = LOC.LOCATION_ID
 GROUP BY LOC.CITY
;
-- 근무중인 사원의 수로 내림차순 정렬
SELECT CNT
     , CITY
  FROM (SELECT COUNT(EMPLOYEE_ID) CNT
             , LOC.CITY CITY
		  FROM EMPLOYEES EMP
		 INNER JOIN DEPARTMENTS DEP
		    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
		 INNER JOIN LOCATIONS LOC
		    ON DEP.LOCATION_ID = LOC.LOCATION_ID
		 GROUP BY LOC.CITY)
 ORDER BY CNT DESC
;
-- 근무중인 사원의 수가 가장 많은 곳 하나 가져오기 (도시와 사원의 수 조회)
SELECT CNT
     , CITY
  FROM (SELECT CNT
		     , CITY
		  FROM (SELECT COUNT(EMPLOYEE_ID) CNT
		             , LOC.CITY CITY
				  FROM EMPLOYEES EMP
				 INNER JOIN DEPARTMENTS DEP
				    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
				 INNER JOIN LOCATIONS LOC
				    ON DEP.LOCATION_ID = LOC.LOCATION_ID
				 GROUP BY LOC.CITY)
		 ORDER BY CNT DESC)
 WHERE ROWNUM = 1
;
--55. 근무중인 사원이 없는 도시를 조회한다.
-- 근무중인 사원이 있는 도시
SELECT LOC.CITY
  FROM LOCATIONS LOC
 WHERE LOC.LOCATION_ID NOT IN (SELECT DISTINCT DEP.LOCATION_ID 
 				 			 	 FROM DEPARTMENTS DEP
 								WHERE DEP.DEPARTMENT_ID IN (SELECT DISTINCT EMP.DEPARTMENT_ID 
 														  	  FROM EMPLOYEES EMP)
 							      AND DEP.LOCATION_ID IS NOT NULL)
;
--56. 연봉이 7000 에서 12000 사이인 사원이 근무중인 도시를 조회한다.
-- 연봉이 7000 ~ 12000 사이인 사원
SELECT *
  FROM EMPLOYEES
 WHERE SALARY BETWEEN 7000 AND 12000
;
-- 그 사원이 근무중인 도시
SELECT LOC.CITY
  FROM LOCATIONS LOC
 WHERE LOC.LOCATION_ID IN (SELECT DEP.LOCATION_ID 
 							 FROM DEPARTMENTS DEP
 							WHERE DEP.DEPARTMENT_ID IN (SELECT EMP.DEPARTMENT_ID
														  FROM EMPLOYEES EMP
														 WHERE SALARY BETWEEN 7000 AND 12000))
;


--57. 'Seattle' 에서 근무중인 사원의 직무명을 중복없이 조회한다. -> SubQuery
-- 'Seattle' 에서 근무중인 사원
SELECT *
  FROM EMPLOYEES EMP
 INNER JOIN DEPARTMENTS DEP
    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
 INNER JOIN LOCATIONS LOC
    ON DEP.LOCATION_ID = LOC.LOCATION_ID
 WHERE LOC.CITY = 'Seattle'
;

-- 사원의 직무명을 조회
SELECT JOB.JOB_TITLE 
  FROM JOBS JOB
 INNER JOIN (SELECT DISTINCT EMP.JOB_ID
			  FROM EMPLOYEES EMP
			 INNER JOIN DEPARTMENTS DEP
			    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
			 INNER JOIN LOCATIONS LOC
			    ON DEP.LOCATION_ID = LOC.LOCATION_ID
			 WHERE LOC.CITY = 'Seattle') EMP_SEA
    ON JOB.JOB_ID = EMP_SEA.JOB_ID
;

SELECT JOB.JOB_TITLE 
  FROM JOBS JOB
 WHERE JOB.JOB_ID IN (SELECT DISTINCT EMP.JOB_ID
					  FROM EMPLOYEES EMP
					 INNER JOIN DEPARTMENTS DEP
					    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
					 INNER JOIN LOCATIONS LOC
					    ON DEP.LOCATION_ID = LOC.LOCATION_ID
					 WHERE LOC.CITY = 'Seattle')
;
--58. 사내의 최고연봉과 최저연봉의 차이를 조회한다.
SELECT MAX(SALARY) - MIN(SALARY) "최고연봉 최저연봉 차이"
  FROM EMPLOYEES
;
--59. 이름이 'Renske' 인 사원의 연봉과 같은 연봉을 받는 사원의 모든 정보를 조회한다. 단, 'Renske' 사원은 조회에서 제외한다.

-- 이름이 Renske인 사원의 연봉을 조회
SELECT SALARY
  FROM EMPLOYEES
 WHERE FIRST_NAME = 'Renske'
;
-- 같은 연봉을 받는 사원을 조회
SELECT *
  FROM EMPLOYEES EMP
 WHERE EMP.SALARY = (SELECT SALARY
					   FROM EMPLOYEES
					  WHERE FIRST_NAME = 'Renske')
;
-- Renske는 제외
SELECT *
  FROM EMPLOYEES EMP
 WHERE EMP.SALARY = (SELECT SALARY
					   FROM EMPLOYEES
					  WHERE FIRST_NAME = 'Renske')
   AND FIRST_NAME != 'Renske'
;

--60. 회사 전체의 평균 연봉보다 많이 받는 사원들 중 이름에 'u' 가 포함된 사원과 동일한 부서에서 근무중인 사원들의 모든 정보를 조회한다.
-- 회사 전체의 평균 연봉
SELECT AVG(SALARY)
  FROM EMPLOYEES
;
-- 이름에 u가 포함된 사원의 부서
SELECT DEPARTMENT_ID
  FROM EMPLOYEES
 WHERE FIRST_NAME LIKE '%u%'
;

-- 완성
SELECT *
  FROM EMPLOYEES EMP
 WHERE EMP.DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
							  FROM EMPLOYEES
							 WHERE FIRST_NAME LIKE '%u%')
   AND EMP.SALARY >= (SELECT AVG(SALARY)
  						FROM EMPLOYEES)
;

--61. 부서가 없는 국가명을 조회한다.
SELECT *
  FROM COUNTRIES COU
 WHERE COU.COUNTRY_ID NOT IN (SELECT LOC.COUNTRY_ID 
 						  	    FROM LOCATIONS LOC
 						   	   WHERE LOC.LOCATION_ID IN (SELECT DEP.LOCATION_ID
 						  							   	   FROM DEPARTMENTS DEP))
;
--62. 'Europe' 에서 근무중인 사원들의 모든 정보를 조회한다.
SELECT *
  FROM EMPLOYEES EMP
 WHERE EMP.DEPARTMENT_ID IN (SELECT DEP.DEPARTMENT_ID 
	  						   FROM DEPARTMENTS DEP
							  WHERE DEP.LOCATION_ID IN (SELECT LOC.LOCATION_ID 
							 							  FROM LOCATIONS LOC
							 						     WHERE LOC.COUNTRY_ID IN (SELECT COU.COUNTRY_ID
							 						   							    FROM COUNTRIES COU
							 						   							   WHERE COU.REGION_ID = (SELECT REG.REGION_ID 
							 						   													    FROM REGIONS REG
							 						   													   WHERE REG.REGION_NAME = 'Europe'))))						 						   													   
;
--63. 'Europe' 에서 가장 많은 사원들이 있는 부서명을 조회한다.
-- 유럽에서 부서별 사원 수
SELECT COUNT(1)
     , EMP.DEPARTMENT_ID
  FROM EMPLOYEES EMP
 WHERE EMP.DEPARTMENT_ID IN (SELECT DEP.DEPARTMENT_ID
	  						   FROM DEPARTMENTS DEP
							  WHERE DEP.LOCATION_ID IN (SELECT LOC.LOCATION_ID 
							 							  FROM LOCATIONS LOC
							 						     WHERE LOC.COUNTRY_ID IN (SELECT COU.COUNTRY_ID
							 						   							    FROM COUNTRIES COU
							 						   							   WHERE COU.REGION_ID = (SELECT REG.REGION_ID 
							 						   													    FROM REGIONS REG
							 						   													   WHERE REG.REGION_NAME = 'Europe'))))
 GROUP BY EMP.DEPARTMENT_ID				
;

-- 내림차순으로 정렬
SELECT DEPARTMENT_ID
  FROM (SELECT COUNT(1) CNT
		     , EMP.DEPARTMENT_ID
		  FROM EMPLOYEES EMP
		 WHERE EMP.DEPARTMENT_ID IN (SELECT DEP.DEPARTMENT_ID
			  						   FROM DEPARTMENTS DEP
									  WHERE DEP.LOCATION_ID IN (SELECT LOC.LOCATION_ID 
									 							  FROM LOCATIONS LOC
									 						     WHERE LOC.COUNTRY_ID IN (SELECT COU.COUNTRY_ID
									 						   							    FROM COUNTRIES COU
									 						   							   WHERE COU.REGION_ID = (SELECT REG.REGION_ID 
									 						   													    FROM REGIONS REG
									 						   													   WHERE REG.REGION_NAME = 'Europe'))))
		 GROUP BY EMP.DEPARTMENT_ID) DEP_EU
 ORDER BY DEP_EU.CNT DESC
;


-- 가장 많은 곳 가져오기
SELECT DEPARTMENT_ID
  FROM (SELECT DEPARTMENT_ID
		  FROM (SELECT COUNT(1) CNT
				     , EMP.DEPARTMENT_ID
				  FROM EMPLOYEES EMP
				 WHERE EMP.DEPARTMENT_ID IN (SELECT DEP.DEPARTMENT_ID
					  						   FROM DEPARTMENTS DEP
											  WHERE DEP.LOCATION_ID IN (SELECT LOC.LOCATION_ID 
											 							  FROM LOCATIONS LOC
											 						     WHERE LOC.COUNTRY_ID IN (SELECT COU.COUNTRY_ID
											 						   							    FROM COUNTRIES COU
											 						   							   WHERE COU.REGION_ID = (SELECT REG.REGION_ID 
											 						   													    FROM REGIONS REG
											 						   													   WHERE REG.REGION_NAME = 'Europe'))))
				 GROUP BY EMP.DEPARTMENT_ID) DEP_EU
		 ORDER BY DEP_EU.CNT DESC)
  WHERE ROWNUM = 1
;

-- 완성
SELECT DEPARTMENT_NAME
  FROM DEPARTMENTS
 WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
						  FROM (SELECT DEPARTMENT_ID
								  FROM (SELECT COUNT(1) CNT
										     , EMP.DEPARTMENT_ID
										  FROM EMPLOYEES EMP
										 WHERE EMP.DEPARTMENT_ID IN (SELECT DEP.DEPARTMENT_ID
											  						   FROM DEPARTMENTS DEP
																	  WHERE DEP.LOCATION_ID IN (SELECT LOC.LOCATION_ID 
																	 							  FROM LOCATIONS LOC
																	 						     WHERE LOC.COUNTRY_ID IN (SELECT COU.COUNTRY_ID
																	 						   							    FROM COUNTRIES COU
																	 						   							   WHERE COU.REGION_ID = (SELECT REG.REGION_ID 
																	 						   													    FROM REGIONS REG
																	 						   													   WHERE REG.REGION_NAME = 'Europe'))))
										 GROUP BY EMP.DEPARTMENT_ID) DEP_EU
								 ORDER BY DEP_EU.CNT DESC)
						  WHERE ROWNUM = 1)	
;
--64. 대륙 별 사원의 수를 조회한다.
-- Join
SELECT REG.REGION_NAME 
     , COUNT(EMP.EMPLOYEE_ID)
  FROM REGIONS REG
  LEFT OUTER JOIN COUNTRIES COU
    ON REG.REGION_ID = COU.REGION_ID
  LEFT OUTER JOIN LOCATIONS LOC
    ON COU.COUNTRY_ID = LOC.COUNTRY_ID
  LEFT OUTER JOIN DEPARTMENTS DEP
    ON LOC.LOCATION_ID = DEP.LOCATION_ID
  LEFT OUTER JOIN EMPLOYEES EMP
    ON DEP.DEPARTMENT_ID = EMP.DEPARTMENT_ID
 GROUP BY REG.REGION_NAME 
;
--65. 연봉이 2500, 3500, 7000 이 아니며 직업이 SA_REP 이나 ST_CLERK 인 사람들을 조회한다.
SELECT *
  FROM EMPLOYEES
 WHERE SALARY NOT IN (2500, 3500, 7000)
   AND JOB_ID IN ('SA_REP', 'ST_CLERK')
;
 --66. 사원의 사원번호, 이름, 성, 상사의 사원번호, 상사의 이름, 상사의 성을 조회한다.
SELECT EMP.EMPLOYEE_ID
     , EMP.FIRST_NAME
     , EMP.LAST_NAME 
     , MAN.EMPLOYEE_ID 
     , MAN.FIRST_NAME 
     , MAN.LAST_NAME 
  FROM EMPLOYEES EMP
 INNER JOIN EMPLOYEES MAN
    ON EMP.MANAGER_ID = MAN.EMPLOYEE_ID
;
--67. 101번 사원의 모든 부하직원 들의 이름, 성, 상사사원번호, 상사사원명을 조회한다.
 SELECT *
   FROM EMPLOYEES
  START WITH EMPLOYEE_ID = 101
CONNECT BY PRIOR EMPLOYEE_ID = MANAGER_ID
;
--68. 114번 직원의 모든 상사들의 이름, 성, 상사사원번호, 상사사원명을 조회한다.
 SELECT EMPLOYEE_ID
      , FIRST_NAME
      , LAST_NAME
      , MANAGER_ID
   FROM EMPLOYEES
  WHERE EMPLOYEE_ID != 114
  START WITH EMPLOYEE_ID = 114
CONNECT BY PRIOR MANAGER_ID  = EMPLOYEE_ID

;
--69. 114번 직원의 모든 상사들의 이름, 성, 상사사원번호, 상사사원명을 조회한다. 단, 역순으로 조회한다.
 SELECT LEVEL
      , EMPLOYEE_ID
      , FIRST_NAME
      , LAST_NAME
      , MANAGER_ID
   FROM EMPLOYEES
  START WITH EMPLOYEE_ID = 114
CONNECT BY PRIOR MANAGER_ID  = EMPLOYEE_ID
  ORDER BY LEVEL DESC
;
--70. 모든 사원들을 연봉 오름차순 정렬하여 조회한다.
SELECT *
  FROM EMPLOYEES
 ORDER BY SALARY ASC
;
--71. 모든 사원들을 이름 내림차순 정렬하여 조회한다.
SELECT *
  FROM EMPLOYEES
 ORDER BY FIRST_NAME DESC
;
--72. 모든 사원들의 이름, 성, 연봉, 부서명을 부서번호로 내림차순 정렬하여 조회한다.
SELECT FIRST_NAME
     , LAST_NAME
     , SALARY 
     , EMPLOYEE_ID 
  FROM EMPLOYEES
 ORDER BY DEPARTMENT_ID DESC
;
--73. 부서별 연봉의 합을 내림차순 정렬하여 조회한다.
-- 부서별 연봉의 합
SELECT DEP_SUM_SAL.SALARY_SUM
  FROM (SELECT SUM(SALARY) SALARY_SUM
		  FROM EMPLOYEES
		 GROUP BY DEPARTMENT_ID) DEP_SUM_SAL
  ORDER BY DEP_SUM_SAL.SALARY_SUM DESC
;

--74. 직무별 사원의 수를 오름차순 정렬하여 조회한다.
SELECT EMP_CNT_JOB.JOB_ID 
     , EMP_CNT_JOB.CNT
  FROM (SELECT JOB_ID
		     , COUNT(EMPLOYEE_ID) CNT
		  FROM EMPLOYEES
		 GROUP BY JOB_ID) EMP_CNT_JOB
 ORDER BY EMP_CNT_JOB.CNT ASC
;
--75. 모든 사원들의 모든 정보를 조회한다. 단, 인센티브를 받는 사원은 "인센티브여부" 컬럼에 "Y"를, 아닌 경우 "N"으로 조회한다.
SELECT EMP.EMPLOYEE_ID
     , EMP.FIRST_NAME 
     , EMP.LAST_NAME 
     , EMP.EMAIL
     , EMP.COMMISSION_PCT 
     , CASE
          WHEN EMP.COMMISSION_PCT IS NULL THEN
             'N'
          ELSE
             'Y'
        END "인센티브 여부"
 FROM EMPLOYEES EMP
;
--76. 모든 사원들의 이름을 10자리로 맞추어 조회한다.
SELECT LPAD(FIRST_NAME, 10, ' ')
  FROM EMPLOYEES
;
--77. 2007년에 직무가 변경된 사원들의 현재 직무명, 부서명,  사원번호, 이름, 성을 조회한다.
SELECT JOB.JOB_TITLE
     , DEP.DEPARTMENT_NAME
     , EMP.EMPLOYEE_ID
     , EMP.FIRST_NAME
     , EMP.LAST_NAME
  FROM JOB_HISTORY JHT
 INNER JOIN EMPLOYEES EMP
    ON JHT.EMPLOYEE_ID = EMP.EMPLOYEE_ID
 INNER JOIN DEPARTMENTS DEP
    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
 INNER JOIN JOBS JOB
    ON EMP.JOB_ID = JOB.JOB_ID
 WHERE JHT.START_DATE BETWEEN TO_DATE('2007-01-01', 'YYYY-MM-DD') AND TO_DATE('2007-12-31', 'YYYY-MM-DD')
;

-- 연도별 통계를 낼 때 사용한다.
SELECT *
  FROM (SELECT JH.JOB_ID
		     , TO_NUMBER(TO_CHAR(JH.START_DATE, 'YYYY')) START_YEAR
		  FROM JOB_HISTORY JH) JH_2007
 WHERE JH_2007.START_YEAR = 2007
;
--78. 직무별 최대 연봉보다 더 많은 연봉을 받는 사원의 모든 정보를 조회한다.
SELECT *
  FROM EMPLOYEES EMP
 INNER JOIN JOBS JOB
    ON EMP.JOB_ID = JOB.JOB_ID
 WHERE EMP.SALARY > JOB.MAX_SALARY
;
--79. 사원들의 입사일자 중 이름, 성, 연도만 조회한다.
SELECT FIRST_NAME
     , LAST_NAME 
     , TO_CHAR(HIRE_DATE, 'YYYY')
  FROM EMPLOYEES
;
--80. 사원들의 입사일자 중 이름, 성, 연도, 월 만 조회한다.
SELECT FIRST_NAME
     , LAST_NAME 
     , TO_CHAR(HIRE_DATE, 'YYYY')
     , TO_CHAR(HIRE_DATE, 'MM')
  FROM EMPLOYEES
;
--81. 100번 사원의 모든 부하직원을 계층조회한다. 단, LEVEL이 4인 사원은 제외한다.
 SELECT LEVEL
      , EMP.EMPLOYEE_ID
   FROM EMPLOYEES EMP
  WHERE LEVEL != 4
  START WITH EMP.EMPLOYEE_ID = 100
CONNECT BY PRIOR EMP.EMPLOYEE_ID = EMP.MANAGER_ID
;
--82. 많은 연봉을 받는 10명을 조회한다.
SELECT *
  FROM (SELECT *
		  FROM EMPLOYEES
		 ORDER BY SALARY DESC)
WHERE ROWNUM <= 10  
;
--83. 가장 적은 연봉을 받는 사원의 상사명, 부서명을 조회한다.
SELECT MAN.FIRST_NAME
     , DEP.DEPARTMENT_NAME 
  FROM (SELECT MANAGER_ID 
		  FROM (SELECT MANAGER_ID
				  FROM EMPLOYEES
				 ORDER BY SALARY ASC) 
		 WHERE ROWNUM = 1) LOW_EMP
 INNER JOIN EMPLOYEES MAN
    ON LOW_EMP.MANAGER_ID = MAN.EMPLOYEE_ID
 INNER JOIN DEPARTMENTS DEP
    ON MAN.DEPARTMENT_ID = DEP.DEPARTMENT_ID 
;


-- 84. 많은 연봉을 받는 사원 중 11번 째 부터 20번째를 조회한다. -- PAGING
SELECT ROWNUM       -- ROWNUM이라는 컬럼을 가져온다.
     , E.*
  FROM EMPLOYEES E
;

SELECT *
  FROM (SELECT ROWNUM RNUM
		     , E.*
		  FROM EMPLOYEES E
		 ORDER BY SALARY)
 WHERE RNUM <= 20
   AND RNUM >= 11
;


SELECT * 
  FROM (SELECT ROWNUM RNUM
             , E.*
          FROM (SELECT *
				  FROM EMPLOYEES
				 ORDER BY SALARY DESC)	E
		 WHERE ROWNUM <= 20)
 WHERE RNUM >= 11
;

SELECT *
  FROM (SELECT * 
		  FROM (SELECT *
				  FROM (SELECT *
						  FROM EMPLOYEES
						 ORDER BY SALARY DESC)	
				 WHERE ROWNUM <= 20)
		 ORDER BY SALARY ASC)
  WHERE ROWNUM <= 10
;
-- 85. 가장 적은 연봉을 받는 중 90번 째 부터 100번째를 조회한다.
SELECT *
  FROM (SELECT * 
		  FROM (SELECT *
				  FROM (SELECT *
						  FROM EMPLOYEES
						 ORDER BY SALARY ASC)	
				 WHERE ROWNUM <= 100)
		 ORDER BY SALARY DESC)
  WHERE ROWNUM <= 11
;
-- 86. 'PU_CLERK' 직무인 2번째 부터 5번째 사원의 부서명, 직무명을 조회한다.
SELECT EMP.FIRST_NAME
     , DEP.DEPARTMENT_NAME 
     , JOB.JOB_TITLE
  FROM (SELECT DEPARTMENT_ID
			 , JOB_ID
			 , FIRST_NAME
		  FROM (SELECT DEPARTMENT_ID
					 , JOB_ID
					 , FIRST_NAME
				  FROM (SELECT DEPARTMENT_ID
						     , JOB_ID
						     , FIRST_NAME
						  FROM (SELECT DEPARTMENT_ID
						             , JOB_ID
						             , FIRST_NAME
								  FROM EMPLOYEES
								 WHERE JOB_ID = 'PU_CLERK'
								 ORDER BY FIRST_NAME ASC)
						 WHERE ROWNUM <= 5)
				 ORDER BY FIRST_NAME DESC) 
		 WHERE ROWNUM <= 4 ) EMP
 INNER JOIN DEPARTMENTS DEP
    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
 INNER JOIN JOBS JOB
    ON EMP.JOB_ID = JOB.JOB_ID
;
-- 87. 모든 사원의 정보를 직무 오름차순, 연봉 내림차순으로 조회한다.
SELECT *
  FROM EMPLOYEES EMP
 ORDER BY JOB_ID ASC
     , SALARY DESC
;
-- 88. 직무별 평균연봉을 평균연봉순으로 오름차순 정렬하여 조회한다.
SELECT *
  FROM (SELECT JOB_ID
		     , AVG(SALARY) AVG_SALARY
		  FROM EMPLOYEES EMP
		 GROUP BY EMP.JOB_ID)
 ORDER BY AVG_SALARY ASC
;
-- 89. 부서별 평균연봉을 최대연봉순으로 내림차순 정렬하여 조회한다.
SELECT *
  FROM (SELECT EMP.DEPARTMENT_ID
		     , AVG(SALARY) AVG_SALARY
		  FROM EMPLOYEES EMP
		 GROUP BY EMP.DEPARTMENT_ID)
 ORDER BY AVG_SALARY DESC
;
-- 90. 이름의 첫 번째 글자별 평균연봉을 조회한다.
SELECT FNAME
     , AVG(SALARY)
  FROM (SELECT SUBSTR(FIRST_NAME, 1, 1) FNAME
		     , SALARY
		  FROM EMPLOYEES)
 GROUP BY FNAME
;
-- 91. 연도별 최소연봉을 조회한다.
SELECT YEAR_GROUP
     , MIN(SALARY)
  FROM (SELECT TO_CHAR(HIRE_DATE, 'YYYY') YEAR_GROUP
		     , SALARY
  		  FROM EMPLOYEES)
 GROUP BY YEAR_GROUP
;
-- 92. 월별 최대연봉 중 2번째 4번째 데이터만 조회한다.
SELECT MONTH_GROUP 
     , MONTH_GROUP_MAX_SAL 
  FROM (SELECT ROWNUM RNUM
		     , MONTH_GROUP
		     , MONTH_GROUP_MAX_SAL
		  FROM (SELECT MONTH_GROUP
				     , MAX(SALARY) MONTH_GROUP_MAX_SAL
				  FROM (SELECT TO_CHAR(HIRE_DATE, 'MM') MONTH_GROUP
						     , SALARY
						  FROM EMPLOYEES)
				 GROUP BY MONTH_GROUP))
 WHERE RNUM IN (2,4)
;
-- 93. 직무명별 최소연봉을 조회한다.
SELECT JOB_TITLE
     , MIN(SALARY)
  FROM JOBS JOB
 INNER JOIN EMPLOYEES EMP
    ON JOB.JOB_ID = EMP.JOB_ID
 GROUP BY JOB_TITLE
;
-- 94. 부서명별 최대연봉을 조회한다.
SELECT DEP.DEPARTMENT_NAME
     , MAX(SALARY)
  FROM DEPARTMENTS DEP
 INNER JOIN EMPLOYEES EMP
    ON DEP.DEPARTMENT_ID = EMP.DEPARTMENT_ID
 GROUP BY DEP.DEPARTMENT_NAME
;
-- 95. 직무명, 부서명 별 사원 수, 평균연봉을 조회한다.
SELECT JOB.JOB_TITLE
     , DEP.DEPARTMENT_NAME
     , COUNT(EMP.EMPLOYEE_ID)
     , AVG(EMP.SALARY)
  FROM EMPLOYEES EMP
  JOIN JOBS JOB
    ON JOB.JOB_ID = EMP.JOB_ID 
  JOIN DEPARTMENTS DEP
    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
 GROUP BY JOB.JOB_TITLE 
     , DEP.DEPARTMENT_NAME 
;
-- 96. 도시별 사원 수를 조회한다.
SELECT LOC.CITY
     , COUNT(EMP.EMPLOYEE_ID)
  FROM LOCATIONS LOC
 INNER JOIN DEPARTMENTS DEP
    ON LOC.LOCATION_ID = DEP.LOCATION_ID
 INNER JOIN EMPLOYEES EMP
    ON DEP.DEPARTMENT_ID = EMP.DEPARTMENT_ID
 GROUP BY LOC.CITY
;

-- 97. 국가별 사원 수, 최대연봉, 최소연봉을 조회한다.
SELECT COU.COUNTRY_NAME 
     , COUNT(EMP.EMPLOYEE_ID)
     , MAX(EMP.SALARY)
     , MIN(EMP.SALARY)
  FROM COUNTRIES COU
  JOIN LOCATIONS LOC
    ON COU.COUNTRY_ID = LOC.COUNTRY_ID
  JOIN DEPARTMENTS DEP
    ON LOC.LOCATION_ID = DEP.LOCATION_ID
  JOIN EMPLOYEES EMP
    ON DEP.DEPARTMENT_ID = EMP.DEPARTMENT_ID
 GROUP BY COU.COUNTRY_NAME 
;
-- 98. 대륙별 사원 수를 대륙명으로 오름차순 정렬하여 조회한다.
SELECT REG_BY_EMP.REG_NAME
     , REG_BY_EMP.REG_CNT
  FROM (SELECT REG.REGION_NAME REG_NAME
		     , COUNT(EMP.EMPLOYEE_ID) REG_CNT
		  FROM REGIONS REG
		  JOIN COUNTRIES COU
		    ON REG.REGION_ID = COU.REGION_ID
		  JOIN LOCATIONS LOC
		    ON COU.COUNTRY_ID = LOC.COUNTRY_ID 
		  JOIN DEPARTMENTS DEP
		    ON LOC.LOCATION_ID = DEP.LOCATION_ID 
		  JOIN EMPLOYEES EMP
		    ON DEP.DEPARTMENT_ID = EMP.DEPARTMENT_ID
		 GROUP BY REG.REGION_NAME) REG_BY_EMP
 ORDER BY REG_BY_EMP.REG_NAME ASC
;
-- 99. 이름이나 성에 'A' 혹은 'a' 가 포함된 사원의 모든 정보를 조회한다.
SELECT *
  FROM EMPLOYEES
 WHERE FIRST_NAME LIKE '%A%'
    OR LAST_NAME LIKE '%a%'
;
-- 100. 국가별로 연봉이 5000 이상인 사원의 수를 조회한다.
SELECT EMPLOYEE_ID
  FROM EMPLOYEES
 WHERE SALARY >= 5000
;

SELECT COU.COUNTRY_NAME
     , COUNT(EMP.EMPLOYEE_ID)
  FROM COUNTRIES COU
  JOIN LOCATIONS LOC
    ON COU.COUNTRY_ID = LOC.COUNTRY_ID 
  JOIN DEPARTMENTS DEP
    ON LOC.LOCATION_ID = DEP.LOCATION_ID 
  JOIN EMPLOYEES EMP
    ON DEP.DEPARTMENT_ID = EMP.DEPARTMENT_ID
 WHERE EMP.EMPLOYEE_ID IN (SELECT EMPLOYEE_ID
						    FROM EMPLOYEES
						   WHERE SALARY >= 5000)
 GROUP BY COU.COUNTRY_NAME
;
-- 101. 커미션을 안받는 사원이 근무하는 도시를 조회한다.
SELECT DISTINCT LOC.CITY
  FROM LOCATIONS LOC
  JOIN DEPARTMENTS DEP
    ON LOC.LOCATION_ID = DEP.LOCATION_ID 
  JOIN EMPLOYEES EMP 
    ON DEP.DEPARTMENT_ID = EMP.DEPARTMENT_ID
 WHERE EMP.COMMISSION_PCT IS NULL
;
-- 102. 커미션을 포함한 연봉이 10000 이상인 사원의 모든 정보를 조회한다.
SELECT *
  FROM EMPLOYEES EMP
 WHERE EMP.SALARY + (EMP.SALARY * EMP.COMMISSION_PCT) >= 10000
;
-- 103. 가장 많은 부서가 있는 도시를 조회한다.
SELECT *
  FROM (SELECT *
		  FROM (SELECT LOC.CITY
				     , COUNT(1) DEP_CNT
				  FROM LOCATIONS LOC
				  JOIN DEPARTMENTS DEP
				    ON LOC.LOCATION_ID = DEP.LOCATION_ID
				 GROUP BY LOC.CITY)
		 ORDER BY DEP_CNT DESC)
 WHERE ROWNUM <= 1
;
-- 104. 가장 많은 사원이 있는 부서의 국가명을 조회한다.

-- 105. 우편번호가 5자리인 도시에서 근무하는 사원명, 부서명, 도시명, 우편번호를 조회한다.

-- 106. 우편번호에 공백이 없는 도시에서 근무하는 사원의 이름, 부서명, 우편번호를 조회한다.

-- 107. "주"가 없는 도시에서 근무하는 사원의 이름, 도시를 조회한다.

-- 108. 국가명이 6자리인 국가의 모든 정보를 조회한다.

-- 109. 사원의 이름과 성을 이용해 EMAIL과 같은 값으로 만들어 조회한다.

-- 110. 모든 사원들의 이름을 10자리로 변환해 조회한다. 예> 이름 => "        이름"

-- 111. 모든 사원들의 성을 10자리로 변환해 조회한다. 예> 성 => "성         "

-- 112. 109번 사원의 입사일 부터 1년 내에 입사한 사원의 모든 정보를 조회한다.

-- 113. 가장 먼저 입사한 사원의 입사일로부터 2년 내에 입사한 사원의 모든 정보를 조회한다.

-- 114. 가장 늦게 입사한 사원의 입사일 보다 1년 앞서 입사한 사원의 모든 정보를 조회한다.

-- 115. 도시명에 띄어쓰기 " " 가 포함된 도시에서 근무중인 사원들의 부서명, 도시명, 사원명을 조회한다.

-- 116. MOD 함수를 통해 사원번호가 홀수면 남자, 짝수면 여자 로 구분해 조회한다. MOD(값, 나눌값)

-- 117. '20230222' 문자 데이터를 날짜로 변환해 조회한다. (DUAL)

-- 118. '20230222' 문자 데이터를 'YYYY-MM' 으로 변환해 조회한다. (DUAL)

-- 119. '20230222130140' 문자 데이터를 'YYYY-MM-DD HH24:MI:SS' 으로 변환해 조회한다. (DUAL)

-- 120. '20230222' 날짜의 열흘 후의 날짜를 'YYYY-MM-DD' 으로 변환해 조회한다. (DUAL)

-- 121. 사원 이름의 글자수 별 사원의 수를 조회한다.

-- 122. 사원 성의 글자수 별 사원의 수를 조회한다.

-- 123. 사원의 연봉이 5000 이하이면 "사원", 7000 이하이면 "대리", 9000 이하이면 "과장", 그 외에는 임원 으로 조회한다.

-- 124. 부서별 사원의 수를 조인을 이용해 다음과 같이 조회한다. "부서명 (사원의 수)"

-- 125. 부서별 사원의 수를 스칼라쿼리를 이용해 다음과 같이 조회한다. "부서명 (사원의 수)"

-- 126. 사원의 정보를 다음과 같이 조회한다. "사원번호 번 사원의 이름은 성이름 입니다."

-- 127. 사원의 정보를 스칼라쿼리를 이용해 다음과 같이 조회한다. "사원번호 번 사원의 상사명은 상사명 입니다."

-- 128. 사원의 정보를 조인을 이용해 다음고 같이 조회한다. "사원명 (직무명)"

-- 129. 사원의 정보를 스칼라쿼리를 이용해 다음과 같이 조회한다. "사원명 (직무명)"

-- 130. 부서별 연봉 차이(최고연봉 - 최저연봉)가 가장 큰 부서명을 조회한다.

-- 131. 부서별 연봉 차이(최고연봉 - 최저연봉)가 가장 큰 부서에서 근무하는 사원들의 직무명을 중복없이 조회한다.

-- 132. 부서장이 없는 부서명 중 첫 글자가 'C' 로 시작하는 부서명을 조회한다.

-- 133. 부서장이 있는 부서명 중 첫 글자가 'S' 로 시작하는 부서에서 근무중인 사원의 이름과 직무명, 부서명을 조회한다.

-- 134. 지역변호가 1000 ~ 1999 사이인 지역의 부서의 모든 정보를 조회한다.

-- 135. 90, 60, 100번 부서에서 근무중인 사원의 이름, 성, 부서명을 조회한다.

-- 136. 부서명이 5글자 미만인 부서에서 근무중인 사원의 이름, 부서명을 조회한다.

-- 137. 국가 아이디가 'C'로 시작하는 국가의 지역을 모두 조회한다.

-- 138. 국가 아이디의 첫 글자와 국가명의 첫 글자가 다른 모든 국가를 조회한다.

-- 139. 사원 모든 정보 중 이메일만 모두 소문자로 조회하여 조회한다.

-- 140. 사원의 연봉을 TRUNK(소수점 버림) 함수를 사용해 100 단위는 버린채 다음과 같이 조회한다.  예> 3700 -> 3000, 12700 -> 12000

-- 141. 100단위를 버린 사원의 연봉 별 사원의 수를 조회한다.

-- 142. 현재 시간으로부터 20년 전 보다 일찍 입사한 사원의 모든 정보를 조회한다.

-- 143. 부서번호별 현재 시간으로부터 15년 전 보다 일찍 입사한 사원의 수를 조회한다.

-- 144. 부서명, 직무명 별 평균 연봉을 조회한다.

-- 145. 도시명, 지역명 별 사원의 수를 조회한다.

-- 146. 부서명, 직무명 별 평균 연봉 중 가장 작은 평균연봉을 받는 부서명, 직무명을 조회한다.

-- 147. 102번 직원의 모든 부하직원의 수를 조회한다.

-- 148. 113번 직원의 모든 부하직원의 수를 조회한다.

-- 149. 부하직원이 없는 사원의 모든 정보를 조회한다.

-- 150. 사원번호가 100번인 사원의 사원번호, 이름과 사원번호로 내림차순 정렬된 사원의 사원번호, 이름 조회한다.

-- 조회 예
----------------------
-- 100	Steven
-- 206	William
-- 205	Shelley
-- 204	Hermann
-- 203	Susan
-- 202	Pat
-- 201	Michael
-- 200	Jennifer
-- 199	Douglas
-- 198	Donald
-- 197	Kevin
-- 196	Alana
-- ...