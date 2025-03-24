
-- ==============================
-- WHERE
-- ==============================

# WHERE 비교 연산자
-- 표현식 사이의 관계를 비교하기 위해 사용하고, 비교 결과는 논리 결과 중에 하나 (TRUE/FALSE/NULL)가 된다.
-- 단, 비교하는 두 컬럼 값/표현식은 서로 동일한 데이터 타입이어야 한다.

#     연산자                    설명
#     --------------------------------------------------------------------------------
#     =                        같다
#     >,<                        크다/작다
#     >=,<=                    크거나 같다/작거나 같다
#     <>,!=                    같지 않다 (^= 없음)
#     BETWEEN AND                특정 범위에 포함되는지 비교
#     LIKE / NOT LIKE            문자 패턴 비교
#     IS NULL / IS NOT NULL    NULL 여부 비교
#     IN / NOT IN                비교 값 목록에 포함/미포함 되는지 여부 비교

# WHERE 논리 연산자
-- 여러 개의 제한 조건 결과를 하나의 논리결과로 만들어 줌 (&&,|| 사용불가)
-- AND &&    여러 조건이 동시에 TRUE일 경우에만 TRUE 값 반환
-- OR ||    여러 조건들 중에 어느 하나의 조건만 TRUE이면 TRUE값 반환
-- NOT !    조건에 대한 반대값으로 반환(NULL은 예외)
-- XOR        두 값이 같으면 거짓, 두 값이 다르면 참

-- 비교연산자
SELECT
          menu_name
        , menu_price
        , orderable_status
    FROM
        tbl_menu
WHERE
    orderable_status = 'N';

--  tbl_menu 테이블에서 가격이 만삼천원인 메뉴 이름, 메뉴 가격, 주문 여부 컬럼을 출력
SELECT
      menu_name
    , menu_price
    , orderable_status
    FROM
        tbl_menu
    WHERE
    menu_price = 13000;

-- 같지 않을 연산자와 함께 where절 사용
SELECT
       menu_name
     , menu_price
     , orderable_status
    FROM
        tbl_menu
    WHERE
#       orderable_status <> 'Y';
#       orderable_status != 'Y';
#       orderable_status = 'n';
        orderable_status = 'N';
-- MySQL은 비교나 검색을 수행할 때 기본적으로 대소문자 구별없이 비교 및 검색이 가능하다.

-- 대소비교 연산자와 함께 where절 사용
SELECT
        menu_name
      , menu_price
      , orderable_status
    FROM
        tbl_menu
    WHERE
        menu_price > 20000;

-- 위에서 조건만 바꿈
SELECT
    menu_name
     , menu_price
     , orderable_status
FROM
    tbl_menu
WHERE
    menu_price <= 20000;

-- 2. AND 연산자와 함께 WHERE절 사용
-- 0은 FALSE, 0외의 숫자는 TRUE로 임시적 형변환 후 평가된다.
-- 문자열은 0으로 반환, FALSE로 평가
-- NULL과의 연산결과는 null이다(0 && null 제외)

SELECT 1 AND 1, 2 && 2, -1 && 1, 1 && 'abc';
SELECT 1 AND 0, 0 && 1, 0 && 0, 0 && NULL;
SELECT 1 AND NULL, NULL && NULL;
SELECT 1 + NULL, 1 - NULL, 1 *  NULL, 1 / NULL;

-- 메뉴 테이블에서 주문여부가 'y'이면서, 카테고리 코드가 10인 메뉴 목록을 조회
SELECT
      menu_code
    , menu_price
    , category_code
    , orderable_status
    FROM
        tbl_menu
    WHERE
        orderable_status = 'Y' && category_code = 10;

-- 강사님 답변이 밑에꺼, 위에가 내가 생각한 답변
SELECT
    menu_code
     , menu_price
     , category_code
     , orderable_status
FROM
    tbl_menu
WHERE
    orderable_status = 'Y'
AND
    category_code = 10;

-- 메뉴 테이블에서 메뉴가격이 5000원보다 크고, 카테고리 코드가 10인 메뉴를 출력.
-- 단, 컬럼의 출력은 메뉴코드, 메뉴이름, 메뉴가격, 카테고리코드, 주문여부만 출력.
SELECT
       menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
    FROM
        tbl_menu
    WHERE
        menu_price > 5000
    AND
        category_code = 10;

-- OR 연산자와 함께 WHERE절 이용
SELECT  1 OR 1, 1 OR 0, 0 OR 1;
SELECT 0 OR 0;
SELECT 1 OR NULL, 0 OR NULL, NULL OR NULL;

-- 메뉴 테이블에서 주문여부가 'Y'이고, 카테고리 코드가 10인 메뉴 목록을 조회
SELECT
       menu_code
     , menu_price
     , category_code
     , orderable_status
    FROM
        tbl_menu
    WHERE
        orderable_status = 'Y'
    OR
        category_code = 10;

-- 우선순위
-- 나열되어 AND OR 중에는 AND가 높다.
SELECT 1 OR 0 AND 0;
SELECT (1 OR 0) AND 0;

-- 카테고리 번호가 4 또는 가격이 9000이면서 메뉴번호가 10번보다 큰 메뉴를 조회하자.
-- 모든 컬럼을 조회
SELECT
        menu_code
      , menu_price
      , category_code
    FROM
        tbl_menu
    WHERE
        category_code = 4
    OR
        menu_price = 9000
    AND
        menu_code = 10;
-- 123

-- 5. BETWEEN 연산자
-- 숫자, 문자열, 날짜, 시간 값의 범위 안에 있다면 TURE를 반환하는 연산자
SELECT
       menu_name
     , menu_price
     , category_code
    FROM
        tbl_menu
    WHERE
        menu_price >= 10000
    AND
        menu_price <= 25000;

-- 위와 내용은 같지만 BETWWEN 사용
SELECT
       menu_name
     , menu_price
     , category_code
    FROM
        tbl_menu
    WHERE
        menu_price BETWEEN 10000 AND 25000;

-- 사전등재순으로 문자열 범위 비교
SELECT
        menu_name
     , menu_price
     , category_code
    FROM
        tbl_menu
    WHERE
        menu_name BETWEEN '가' AND '마'
    ORDER BY
        menu_name;

-- 범위를 원래 구하던 곳의 바깥을 구하고 싶다면 간단히 NOT만 붙이면 됨.
SELECT
        menu_name
      , menu_price
      , category_code
    FROM
        tbl_menu
    WHERE
        menu_price NOT BETWEEN 10000 AND 25000;


-- 6. LIKE 연산자
-- 비교하려는 값이 지정한 특정 패턴을 만족시키면 TRUE를 리턴하는 연산자로 '%', '_'를 와일드카드로 사용할 수있다.

-- 와일드카드란? 다른 문자로 대체가능한 특수한 의미를 가진 문자
-- 1. '%' 글자가 없든지, 글자가 1개 이상 여러개를 의미한다.
-- 2. _개수에 따라 문자 1개를 의미한다 _가 3개라면 문자 3개를 의미한다.

-- %의 위치에 따라서 검색
-- %문자     : 문자로 끝나는 내용만
-- 문자%     : 문자로 시작하는 내용만
-- %문자%    : 문자가 포함되어 있는 내용만

SELECT
        menu_name
      , menu_price
    FROM
        tbl_menu
    WHERE
        menu_name LIKE '%마늘%';

SELECT
         menu_name
        , menu_price
    FROM
        tbl_menu
    WHERE
        menu_name LIKE '마%';

SELECT
       menu_name
     , menu_price
    FROM
        tbl_menu
    WHERE
        menu_name LIKE '%밥';

-- 쥬스 앞글자가 3글자인 메뉴조회
SELECT
        menu_name
      , menu_price
    FROM
        tbl_menu
    WHERE
        menu_name LIKE '______쥬스';

SELECT
        menu_name
      , menu_price
    FROM
        tbl_menu
    WHERE
        menu_name LIKE '%갈치%';

SELECT
       menu_name
     , menu_price
    FROM
        tbl_menu
    WHERE
        menu_name NOT LIKE '%갈치%';

-- IN 연산자
-- 카테고리 코드가 4,5,6인 메뉴를 조회하세요.
SELECT
        menu_name
      , category_code
    FROM
        tbl_menu
    WHERE
        category_code = 4
    OR
        category_code = 5
    OR
        category_code = 6;

-- 위에거를 IN 으로 고치면 간단, 깔끔. 반복문 사용시 IN 많이 사용.
SELECT
    menu_name
     , category_code
FROM
    tbl_menu
WHERE
    category_code IN (4,5,6);

-- 부정한다면
SELECT
        menu_name
     , category_code
    FROM
        tbl_menu
    WHERE
        category_code NOT IN (4,5,6);

-- IS NULL을 사용해 널 인것만 받음.
SELECT
        category_code
      , category_name
      , ref_category_code
    FROM
        tbl_category
    WHERE
        ref_category_code IS NULL;

-- NULL 처리 함수를 통해서 찾을 수 있다.
SELECT
        category_code
      , category_name
      , ref_category_code
      , IFNULL(ref_category_code,0)
    FROM
        tbl_category
    WHERE
 #       IFNULL(ref_category_code,0) = 0; //아래 함수와 의미는 같지만 MySQL에서만 사용하고 아래껀 넓게 사용됨.
        COALESCE(ref_category_code,0) = 0;

-- 부정표현, - 그러면 널 빼고 다 가지는 것.
SELECT
    category_code
     , category_name
     , ref_category_code
FROM
    tbl_category
WHERE
    ref_category_code IS NOT NULL;

-- 강사님이 보내주신 실습 문제
create table tb_escape_watch(
        watchname varchar(40),
        description varchar(200)
);
insert into tb_escape_watch values('금시계', '순금 99.99% 함유 고급시계');
insert into tb_escape_watch values('은시계', '고객 만족도 99.99점를 획득한 고급시계');

SELECT * FROM tb_escape_watch;

-- escape문자 : """"를 사용하고 싶을 때 \% 를 사용하면 문자로만 인지함. 사용 예시는 99.99\%
-- tb_escape_watch 테이블에서 description컬럼에 99.99%라는 글자가 들어가있는 동안 행만 추출하세요.
SELECT
    tb_escape_watch.watchname
, tb_escape_watch.description
FROM
    tb_escape_watch
WHERE
    description LIKE '%99.99\%%';
