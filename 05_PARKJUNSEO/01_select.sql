-- =======================================
-- DQL
-- =======================================
-- DML 하위 분류
-- Data Query Language 데이터 질의 언어
-- 테이블의 데이터를 검색/조회하는 명령어
-- 조회결과를 ResultSet (결과집합)이라 하면, 0행이상을 가질 수 있다.
-- 특정테이블, 특정행, 시각화할 컬럼, 정렬방식등을 선택할 수 있다.


/*
    *** DQL 구조 ***
    SELECT 컬럼명    (5) -- 필수
    FROM 테이블명  (1) -- 필수
    WHERE 조건절(필터링) (2)
    GROUP BY 그룹핑 (3)
    HAVING 조건절(그룹핑에 대해 필터링) (4)
    ORDER BY 정렬기준 (6)

    조회를 한다면 FROM, WHERE, GROUP BY, HAVING, SELECT, ORDER BY 순서

    1. SELECT : 조회하고자 하는 컬럼명을 기술한다. 여러 개를 기술하고자 하면
             쉼표(,)로 구분하고 모든 컬럼 조회시 '*'을 사용
    2. FROM   : 조회 대상 컬럼이 포함된 테이블명을 기술
    3. WHERE  :
          행을 선택하는 조건을 기술한다.
          여러 개의 제한 조건을 포함할수 있으며, 각각의 제한 조건은 논리
          연산자로 연결한다.
          제한 조건을 만족시키는 행들만 ResultSet에 포함된다.
    4. ORDER BY : 정렬한 컬럼을 기준으로 오름(ASC)/내림차순(DESC) 지정 // default는 오름차순(ASC)
*/

-- -----------------------------------------------------------------------------------
SELECT * FROM tbl_menu; -- tbl_menu가 가지고 있는 모든 컬럼을 보겠다는 뜻
-- 대/소문자 구별 안하지만, 실제 사용하는 쿼리문에서의 명령어랑 컬럼명, 테이블명 등이 구분되면 좋음.
-- 따라서 SELECT, FROM 등은 대문자로 쓰기로 함 // 테이블 관련은 소문자로

SELECT
     menu_code
   , menu_name
   , menu_price
   , category_code
   , orderable_status
FROM tbl_menu;   -- 성능상 위보다 얘가 더 빠름 (같은 결과이지만, 지정을 다 해주기 때문임)

SELECT
      category_code
    , category_name
    , ref_category_code
  FROM tbl_category;


SELECT
       menu_name
     , category_name  -- tbl_menu에는 category_name이라는 column이 없음 (즉 테이블이 다름) --> 관계를 맺어줘야 함
  FROM tbl_menu
  JOIN tbl_category ON tbl_menu.category_code = tbl_category.category_code; -- 두 테이블에서 category_code가 같은 애들만 조인하는 것.

-- ------------------------------------------------------------------------------------------------------------------------------------

-- from절 없는 select 해보기 (가능함)
SELECT 7 + 3 ;
SELECT 10 * 2 ;
SELECT 6 % 3, 6 % 4 ;  -- 이러면 컬럼 모양으로 0과 2가 나옴 (식으로 쓴 거 자체가 column명으로 나옴. 이게 보기 싫으면 별칭을 붙일 수 있음)
SELECT NOW(); -- 연월일 시분초
SELECT CONCAT('유', ' ', '관순') ;-- 문자열 연결


-- 메뉴 이름은 생갈치쉐이크이고, 가격은 6000원입니다.
SELECT CONCAT('메뉴 이름은 ', menu_name, '이고, 가격은 '
              , menu_price, '원 입니다.')
  FROM tbl_menu ; -- 조회를 할 때도 정제하면서 조회할 수 있음

-- 별칭(alias)
SELECT 7 + 3 AS '합';  -- ' ' 안의 내용이 따옴표 없이 칸이 띄워져있거나 그러면 별칭 지정이 안 될 수도 있음
SELECT NOW() 현재시간; -- 이건 됨
-- SELECT NOW() 현재 시간; 이건 안됨. 띄어쓰고 싶으면 ' 쓰기
SELECT NOW() '현재 시간'; -- 별칭을 달 때 별칭에 특수기호나 띄어쓰기가 필요하면
                         -- 반드시 따옴표를 쓸 것

-- 리터럴(값)
-- 임의로 지정한 문자열은 SELECT 절에 사용하면, 테이블에 존재하는 데이터처럼 사용할 수 있다.
-- 문자 혹은 날짜 리터럴은 '' 기호를 사용해야한다.
-- 리터럴은 ResultSet의 모든 행에 반복 표시 된다.

SELECT
       menu_name 메뉴이름,   -- 칼럼 이름이 메뉴이름으로 됨. 별칭.
       menu_price + (menu_price * 0.1) AS "부가세포함 가격",  -- 얘가 2 (2번째 줄)
       '원'
  FROM tbl_menu
  ORDER BY 2 DESC ; -- ORDER BY "부가세포함 가격" DESC -- 이렇게 하는 게 정석임

-- DISTINCT
-- 칼럼에 포함된 중복 값을 한 번씩만 표시하고자 할 때 사용
-- SELECT문에 한 번만 사용 가능하고, 여러 칼럼에 대해 사용하면 두 칼럼값에 대해 중복값을 제거함

-- 단일 열 DISTINCT
SELECT
       DISTINCT category_code
  FROM tbl_menu ;

-- NULL값을 포함한 열의 DISTINCT // NULL값은 있지도 않은데, 없지도 않은...비워둘 수는 없으니...
SELECT
        DISTINCT ref_category_code
  FROM tbl_category ;

-- 열이 여러 개인 DISTINCT  // 두 컬럼에 대한 중복을 제외함
SELECT
       DISTINCT category_code
     , orderable_status
  FROM tbl_menu ; -- ex) 카테고리 코드가 4이면서 orderable_status(사용여부)가 N인게 두 개면 하나만 남겨둠

