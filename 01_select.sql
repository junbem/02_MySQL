SELECT * FROM tbl_menu;

SELECT
        menu_code
    ,   menu_name
    ,   menu_price
    ,   category_code
    ,   orderable_status
    FROM tbl_menu;

SELECT
        category_code
    ,   category_name
    ,   ref_category_code
    FROM tbl_category;

SELECT
        menu_name
    ,   category_name
    FROM tbl_menu;
    JOIN tbl_category 1..n<->1: ON tbl_menu.category_code = tbl_category.category_code

SELECT 7 + 3;

SELECT 10 * 2;
SELECT 6% 3,  6 % 4;
SELECT CONCAT('유', '', '관순');

SELECT CONCAT('메뉴 이름은', menu_name, '이고, 가격은'
        ,menu_price, '원 입니다');
    FROM tbl_menu;

SELECT  7 + 3 AS '합';
SELECT now() '현재시간'; -- 별칭을 달 때 별칠에 특수기호나 칸띄우기가 필요하면싱글퀘테이션을
                        -- 반드시 추가한다

-- 리터럴(값)
-- 임의로 지정한 문자열은 SELECT 절에 사용하면, 테이블에 존재하는 데이터처럼 사용할 수 있다.
-- 문자 혹은 날짜 리터럴은 '' 기호를 사용해야한다.
-- 리터럴은 ResultSet의 모든 행에 반복표시 된다.
SELECT
        menu_name 메뉴이름,
        menu_price + (menu_price * .1) AS "부가세포함 가격" ,
        '원'
    FROM tbl_menu
ORDER BY 2 DESC;

-- DISTINCT
-- 컬럼에 포함된 중복 값을 한번씩만 표시하고자 할 때 사용
-- SELECT문에 한번만 사용가능하고, 여러 컬럼에 대해서 사용하면,
-- 두 컬럼값에 대해 중복값을 제거한다.

-- 단일 열 DISTINCT
SELECT
        DISTINCT tbl_menu.category_code
    FROM tbl_menu;

-- NULL값을 포함한 열의 DISTINCT
SELECT
        DISTINCT tbl_category.ref_category_code
    FROM tbl_category;

-- 열이 여러개인 DISTINCT
SELECT
        DISTINCT category_code
       , orderable_status
    FROM tbl_menu;
