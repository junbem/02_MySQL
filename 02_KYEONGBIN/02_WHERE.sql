-- ==============================
-- WHERE
-- ==============================

# WHERE 비교 연산자
-- 표현식 사이의 관계를 비교하기 위해 사용하고, 비교 결과는 논리 결과 중에 하나 (TRUE/FALSE/NULL)가 된다.
-- 단, 비교하는 두 컬럼 값/표현식은 서로 동일한 데이터 타입이어야 한다.

#     연산자                    설명
#     --------------------------------------------------------------------------------
#     =                        같다
#     >,<                      크다/작다
#     >=,<=                    크거나 같다/작거나 같다
#     <>,!=                    같지 않다 (^= 없음)
#     BETWEEN AND              특정 범위에 포함되는지 비교
#     LIKE / NOT LIKE          문자 패턴 비교
#     IS NULL / IS NOT NULL    NULL 여부 비교
#     IN / NOT IN              비교 값 목록에 포함/미포함 되는지 여부 비교

# WHERE 논리 연산자
-- 여러 개의 제한 조건 결과를 하나의 논리결과로 만들어 줌 (&&,|| 사용불가)
-- AND &&    여러 조건이 동시에 TRUE일 경우에만 TRUE 값 반환
-- OR ||    여러 조건들 중에 어느 하나의 조건만 TRUE이면 TRUE값 반환
-- NOT !    조건에 대한 반대값으로 반환(NULL은 예외)
-- XOR        두 값이 같으면 거짓, 두 값이 다르면 참

-- 1. 비교연산자
SELECT
        menu_name
    ,   menu_price
    ,   orderable_status
  FROM
        tbl_menu
 WHERE
    orderable_status = 'Y' ;

/*
tbl_menu 테이블에서 메뉴 정보를 가져옴
menu_name(메뉴 이름), menu_price(가격), orderable_status(주문 가능 여부) 세 개의 열(컬럼)을 선택함
WHERE orderable_status = 'Y' → 주문 가능(Y)한 메뉴만 가져오도록 필터링
 */

-- tbl_menu 테이블에서 가격이 13000원인 메뉴 이름 가격 주문여부 컬럼 출력
SELECT
        menu_name
    ,   menu_price
    ,   orderable_status
  FROM  tbl_menu
 WHERE  menu_price = 13000
   AND  orderable_status <> 'Y';
#         orderable_status != 'Y';
#         orderable_status = 'n'
        orderable_status = 'N' -- MySQL은 비교나 검색을 수행할 때 기본적으로 대소문자 구분없이 비교 및 검색이 가능하다.

-- 대소비교 연산자와 함께 WHERE 절 사용
SELECT
    menu_name
     ,   menu_price
     ,   orderable_status
  FROM  tbl_menu
 WHERE  menu_price > 20000;

SELECT
    menu_name
     ,   menu_price
     ,   orderable_status
FROM  tbl_menu
WHERE  menu_price <= 20000;

### ✅ AND 연산자와 WHERE절 사용 시 중요한 개념 정리

# 1️⃣ **`0`은 `FALSE`로 간주됨**
#    - 숫자 `0` → **FALSE(거짓)**
#    - `0`이 아닌 숫자 → **TRUE(참)**
#
# 2️⃣ **문자열은 `0`으로 변환되므로 `FALSE`로 평가됨**
#    - 예를 들어, `WHERE 'Hello' AND 1` → `'Hello'`가 `0`으로 변환되므로 `0 AND 1`이 되고, 결과는 `FALSE`.
#
# 3️⃣ **NULL과의 연산 결과는 `NULL`이 됨**
#    - 예외: `0 AND NULL`은 `FALSE(0)`
#    - 그 외에는 `NULL AND 1` → `NULL`, `NULL AND NULL` → `NULL`

---

### 🔍 예제 코드로 이해해보자!


SELECT 1 AND 1;   -- 결과: 1 (TRUE)
SELECT 1 AND 0;   -- 결과: 0 (FALSE)
SELECT 0 AND 100; -- 결과: 0 (FALSE)
SELECT 'Hello' AND 1; -- 결과: 0 (FALSE, 'Hello'는 0으로 변환됨)
SELECT NULL AND 1; -- 결과: NULL (NULL과 연산하면 결과도 NULL)
SELECT 0 AND NULL; -- 결과: 0 (예외적으로 FALSE)
SELECT 1 + NULL, 1 - NULL, 1 * NULL, 1 / NULL;

📌 **정리:**
- `0`은 `FALSE`, `0 외 숫자`는 `TRUE`
- `문자열`은 `0`으로 변환되어 `FALSE`로 평가됨
- `NULL`과 연산하면 결과는 `NULL` (단, `0 AND NULL`은 `0`) 🚀

-- 메뉴테이블에서 주문 여부가 Y면서, 카테고리 코드가 10인 메뉴 목록을 조회
SELECT
        menu_code
    ,   menu_price
    ,   category_Code
    ,   orderable_status
  FROM tbl_menu

 WHERE
        orderable_status = 'Y'
   AND
        category_code = 10;

-- 메뉴테이블에서 메뉴가격이 5000원보다 크고, 카테고리 코드가10인 메뉴를 출력해주세요
-- 단, 컬럼의 출력은 메뉴코드, 메뉴이름, 메뉴가격, 카테고리코드, 주문가능여부만 출력
SELECT
        menu_name
    ,   menu_code
    ,   menu_price
    ,   category_code
    ,   orderable_status

  FROM tbl_menu
 WHERE menu_price > 5000
   AND category_code = 10;

-- 3. OR 연산자와 함께 WHERE절 사용! (둘 중 하나만 참이면 됨)
SELECT 1 OR 1, 1 OR 0, 0 or 1;
SELECT 0 OR 0;
SELECT 1 OR NULL, 0 OR NULL, NULL OR NULL;

-- 메뉴테이블에서 주문 여부가 Y이거나, 카테고리 코드가 10인 메뉴 목록을 조회
SELECT
        menu_name
    ,   orderable_status
    ,   category_code
  FROM tbl_menu
 WHERE orderable_status = 'Y'
    OR category_code = 10;

-- 우선순위
-- 나열한 AND OR 중에는 AND가 더 우선순위임!!
SELECT 1 OR 0 AND 0;
SELECT (1 OR 0) AND 0;

-- 카테고리번호가 4 또한 가격이 9000원이면서 메뉴번호가 10번보다 큰 메뉴를 조회하자.
-- 모든 컬럼을 조회

SELECT *
  FROM
        tbl_menu
 WHERE
        (
        category_code = 4
        OR menu_price = 9000
        )
   AND
        menu_code > 10;
