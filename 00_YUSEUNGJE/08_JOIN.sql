-- =============================
-- JOIN
-- =============================
-- 두개 이상의 테이블의 레코드를 연결해서 가상테이블(relation) 생성
-- 연관성을 가지고 있는 컬럼을 기준(데이터)으로 조합

# relation을 생성하는 2가지 방법
-- 1. join :  특정컬럼 기준으로 행과 행을 연결한다. (가로)
-- 2. union : 컬럼과 컬럼을 연결한다.(세로)
-- join은 두 테이블의 행사이의 공통된 데이터를 기준으로 **선을 연결해서** 새로운 하나의 행을 만든다.

# JOIN 구분
-- 1. Equi JOIN : 일반적으로 사용하는 Equality Condition(=)에 의한 조인
-- 2. Non-Equi JOIN : 동등조건(=)이 아닌 BETWEEN AND, IS NULL, IS NOT NULL, IN, NOT IN, !=  등으로 사용.

# EQUI JOIN 구분
-- 1. INNER JOIN(내부 조인) : 교집합 (일반적으로 사용하는 JOIN)
-- 2. OUTER JOIN(외부 조인) : 합집합
-- LEFT (OUTER) JOIN (왼쪽 외부 조인)
-- RIGHT (OUTER) JOIN (오른쪽 외부 조인)
-- FULL (OUTER) JOIN (완전 외부 조인)
-- 3. CROSS JOIN
-- 4. SELF JOIN(자가 조인)
-- 5. MULTIPLE JOIN(다중 조인)

SELECT
       *
  FROM
       tbl_menu a
#   INNER JOIN tbl_category b ON a.category_code = b.category_code;
  JOIN tbl_category b ON a.category_code = b.category_code;

-- USING
-- 동일한 이름의 컬럼을 기준컬럼으로 사용
SELECT
       a.menu_name
     , b.category_name
  FROM tbl_menu a
  JOIN tbl_category b USING(category_code);

-- ===============================
-- OUTER JOIN
-- ===============================
-- 좌/우측 테이블 기준으로 조인. 기준이 된 테이블은 누락되는 행이 없다.
-- INNER JOIN에서 해당 테이블의 누락된 행이 모두 추가된다.

-- ================ LEFT JOIN ==============================
SELECT
       a.menu_name
     , b.category_name
  FROM tbl_menu a
  LEFT JOIN tbl_category b USING(category_code);
-- ================ RIGHT JOIN =============================
SELECT
       a.menu_name
     , b.category_name
  FROM tbl_menu a
  RIGHT JOIN tbl_category b USING(category_code);