/*
-- ==============================
-- WHERE
-- ==============================

WHERE 비교 연산자
-- 표현식 사이의 관계를 비교하기 위해 사용하고, 비교 결과는 논리 결과 중에 하나 (TRUE/FALSE/NULL)가 된다.
-- 단, 비교하는 두 컬럼 값/표현식은 서로 동일한 데이터 타입이어야 한다.

연산자                    설명
--------------------------------------------------------------------------------
=                        같다
>,<                      크다/작다
>=,<=                    크거나 같다/작거나 같다
<>,!=                    같지 않다 (^= 없음)
BETWEEN AND              특정 범위에 포함되는지 비교
LIKE / NOT LIKE          문자 패턴 비교
IS NULL / IS NOT NULL    NULL 여부 비교
IN / NOT IN              비교 값 목록에 포함/미포함 되는지 여부 비교
WHERE 논리 연산자
-- 여러 개의 제한 조건 결과를 하나의 논리결과로 만들어 줌 (&&, 사용불가)
-- AND &&    여러 조건이 동시에 TRUE일 경우에만 TRUE 값 반환 //앞에값이 flase 일 경우 실행시간 --
-- OR     여러 조건들 중에 어느 하나의 조건만 TRUE이면 TRUE값 반환 //앞에값이 true 일 경우 실행시간 --
-- NOT !    조건에 대한 반대값으로 반환(NULL은 예외)
-- XOR        두 값이 같으면 거짓, 두 값이 다르면 참
*/

-- 1.비교연산자
SELECT
       menu_name
     , menu_price
     , orderable_status
   FROM
       tbl_menu
WHERE
       orderable_status = 'N'
ORDER BY 2 ASC;

-- querry 를 짤 때는 테이블 컬럼 테이블 이름 알아야함

SELECT
       CONCAT(menu_name,' ',menu_price,' ',orderable_status)
FROM tbl_menu
WHERE menu_price =13000;

SELECT
       menu_name
     , menu_price
     , orderable_status
FROM tbl_menu
WHERE
#     orderable_status <> 'Y';
#     orderable_status !='Y';
#     orderable_status = 'n';
      orderable_status = 'N'; -- MySQL은 비교나 검색을 수행할때 기본적으로 대소문자 구분없이 비교 및 검색이 가능하다.

-- 대소비교 연산자와 함께 WHERE절 사용
SELECT
    menu_name
     , menu_price
     , orderable_status
FROM
    tbl_menu
WHERE
     menu_price > 20000;

SELECT
    menu_name
     , menu_price
     , orderable_status
FROM
    tbl_menu
WHERE
    menu_price <= 20000
ORDER BY 2 ASC;

-- 2. AND 연산자와 함께 WHERE절 사용
-- 0은 FALSE를, 0외 숫자는 TRUE로 암시적으로 형변환 후 평가된다.
-- 문자열은 0으로 반환, FALSE로 평가
-- NULL과의 연산결과는 null이다(0 && null제외)

SELECT 1 AND 1, 2 && 2, -1 && 1,1 && 'abc';
SELECT 1 AND 0,0 AND 1, 0 AND 0, 0 AND NULL;
SELECT 1 AND NULL, NULL AND NULL;
SELECT 1 + NULL, 1 - NULL, 1 * NULL, 1 / NULL;

SELECT
       menu_code
      , menu_price
      , category_code
      , orderable_status
    FROM tbl_menu
WHERE
    orderable_status = 'Y'
  AND
    category_code='10';
-- 메뉴테이블에서 메뉴가격이 5000원보다 크고, 카테고리 코드가 10인 메뉴를 출력해라
-- 단 컬럼의 출력은 메뉴코드, 메뉴이름, 메뉴가격,카테고리 코드, 주문여부만 출력
SELECT
      menu_code
    , menu_name
    , menu_price
    , category_code
    , orderable_status
    FROM tbl_menu
WHERE
    menu_price > 5000
  AND
    category_code = 10;

-- 3. OR연산자와 함께 WHERE절 사용
SELECT 1 or 1, 1 or 0, 0 or 1;
SELECT 0 or 0;
SELECT 1 or NULL,0 or NULL, NULL or NULL;

SELECT
       menu_code
     , menu_price
     , category_code
     , orderable_status
    FROM tbl_menu
WHERE
     orderable_status = 'Y'
    OR
     category_code = 10;

-- 우선순위
-- 나열한 AND OR 중에는 AND가 우선순위가 높다.
SELECT 1 or 0 AND 0;
SELECT (1 or 0) AND 0;

-- 카테고리번호가 4 또는 가격이 9000원이면서 메뉴번호가 10번보다 큰 메뉴를 조회하자.
-- 모든 칼럼을 조회
SELECT
    *
    FROM tbl_menu
WHERE
    (category_code = 4
   OR
    menu_price = 9000)
   AND
    menu_code > 210;