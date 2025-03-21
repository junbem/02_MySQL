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

-- 1. 비교 연산자
SELECT menu_name,
       menu_price,
       orderable_status
FROM tbl_menu
WHERE orderable_status = 'N';

-- tbl_menu 테이블에서 가격이 13000원인 메뉴의 이름, 가격, 주문가능여부를 출력
SELECT menu_name,
       menu_price,
       orderable_status
FROM tbl_menu
WHERE menu_price = 13000;

-- 같지 않음 연산자와 함께 WHERE절 사용
SELECT menu_name,
       menu_price,
       orderable_status
FROM tbl_menu
# WHERE orderable_status != 'Y';
# WHERE orderable_status <> 'Y';
# WHERE orderable_status = 'N';
WHERE orderable_status = 'n'; -- MySQL은 비교나 검색에 대소문자를 구분하지 않음

-- 대소 비교 연산자와 함께 WHERE절 사용
SELECT menu_name,
       menu_price,
       orderable_status
FROM tbl_menu
WHERE menu_price > 20000;

SELECT menu_name,
       menu_price,
       orderable_status
FROM tbl_menu
WHERE menu_price <= 20000;

-- 2. AND 연산자와 함께 WHERE절 사용
-- 0은 FALSE, 0이 아닌 숫자는 TRUE로 평가됨
-- 문자열은 0(FALSE)로 평가
-- NULL과의 연산 결과는 NULL (단, 0 AND NULL = 0 이다. Short-Circuit Evaluation 때문)
SELECT 1 AND 1, 1 AND 'asdf', 0 AND NULL; -- 1, 0, 0
SELECT 1 AND NULL, NULL AND NULL; -- NULL, NULL
SELECT 1 + NULL, 1 - NULL, 1 * NULL, 1 / NULL; -- NULL, NULL, NULL, NULL

-- 메뉴 테이블에서 주문 여부가 Y 이면서, 카테고리 코드가 10인 메뉴 목록을 조회
SELECT menu_code,
       menu_price,
       category_code,
       orderable_status
FROM tbl_menu
WHERE orderable_status = 'Y'
  AND category_code = 10;

-- 메뉴 테이블에서 메뉴 가격이 5000원보다 크고, 카테고리 코드가 10인 메뉴를 출력하시오.
-- 단, 컬럼의 출력은 메뉴코드, 메뉴이름, 메뉴가격, 카테고리코드, 주문여부만 출력
SELECT menu_code,
       menu_name,
       menu_price,
       category_code,
       orderable_status
FROM tbl_menu
WHERE menu_price > 5000
  AND category_code = 10;

-- 3. OR 연산자와 함께 WHERE절 사용
SELECT 1 OR 1, 1 OR 0, 0 OR 1;
SELECT 0 OR 0;
SELECT 1 OR NULL, 0 OR NULL, NULL OR NULL;

-- 메뉴 테이블에서 주문 여부가 Y 이거나, 카테고리 코드가 10인 메뉴 목록을 조회
SELECT menu_code,
       menu_price,
       category_code,
       orderable_status
FROM tbl_menu
WHERE orderable_status = 'Y'
  OR category_code = 10;

-- 우선순위
-- AND가 OR보다 우선순위가 높다
SELECT 1 OR 0 AND 0;
SELECT (1 OR 0) AND 0;

-- 카테고리 번호가 4 또는 가격이 9000원이면서 메뉴번호가 10보다 큰 메뉴를 조회
SELECT *
FROM tbl_menu
WHERE category_code = 4
   OR menu_price = 9000
    AND menu_code > 10;