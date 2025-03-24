use empdb;
SELECT * FROM employee;
-- 1. EMPLOYEE 테이블에서 여자사원의 급여 총 합을 계산

SELECT
        SUM(SALARY)
    FROM employee
    WHERE
         EMP_NO LIKE '_______2%'
    OR   EMP_NO LIKE '_______4%';


/*
    ---------- 출력 예시 ------------
    `급여 총 합`
    ---------------------------------
    24816240
*/


-- 2. 부서코드가 D5인 사원들의 급여총합, 보너스 총합 조회

SELECT FORMAT(SUM(SALARY), 0)
     , FORMAT(SUM(IFNULL(BONUS * SALARY, 0)), 0)
FROM employee
WHERE DEPT_CODE = 'D5';


/*
    ------- 출력 예시 ------------
    급여총합        `보너스 총합`
    ------------------------------
    15,760,000      745,000
*/


-- 3. 부서코드가 D5인 직원의 보너스 포함 연봉의 총합 을 계산
SELECT FORMAT(SUM(SALARY * 12 + IFNULL(BONUS * SALARY * 12, 0)), 0) 연봉
FROM   employee
WHERE DEPT_CODE = 'D5';


/*
    ------- 출력 예시 ----------
    연봉
    ----------------------------
    198,060,000
*/




-- 4. 남/여 사원 급여합계를 동시에 표현(가공된 컬럼의 합계)
-- 남여 구분하는 법을 모르겠음
SELECT

       FORMAT(SUM(SALARY * 12 + IFNULL(BONUS*SALARY*12, 0), 0)) 연봉
     , FORMAT(SALARY * 12 + IFNULL(BONUS*SALARY*12, 0), 0) 연봉
FROM employee
WHERE
      EMP_NO LIKE '_______1%'
   OR EMP_NO LIKE '_______3%';
/*
    ---------------- 출력 예시 -------------------
    `남사원 급여 합계`         `여사원 급여 합계`
    ----------------------------------------------
     49,760,000                24,816,240
*/



-- 5.  [EMPLOYEE] 테이블에서 사원들이 속해있는 부서의 수를 조회
-- (NULL은 제외하고, 중복된 부서는 하나로 카운팅)

SELECT
     COUNT(DISTINCT DEPT_CODE)
FROM employee

/*
    ------ 출력 예시 -------
    `부서 수`
    ------------------------
    6
*/

-- (NULL은 제외하고, 중복된 부서는 하나로 카운팅)
