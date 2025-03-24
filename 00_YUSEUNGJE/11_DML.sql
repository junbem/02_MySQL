-- ======================
-- DML
-- ======================
-- DML(Data Manipulation Language)
-- Data를 조작(삽입, 수정, 삭제, 조회)하기 위해 사용하는 언어
-- Data를 이용하려는 사용자와 DB사이의 인터페이스를 직접적으로 제공하는 언어로써 가장 많이 사용된다.
-- INSERT, UPDATE, DELETE, SELECT(DQL)


-- =====================================
-- INSERT
-- =====================================
-- 새로운 행을 추가하는 구문이다.
-- 테이블의 행의 수가 증가한다.

# 문법
-- 1. INSERT INTO <테이블명> VALUES(입력데이터1, 입력데이터2,.....);
-- 2. INSERT INTO <테이블명>(컬럼명1, 컬럼명2,...) VALUES(입력데이터1, 입력데이터2,...);
--     ㄴ> null을 허용하는 컬럼은 생략가능하다(생략되면 null값이 대입)
--     ㄴ> not null인 컬럼은 생략할 수 없다.(단, default값이 지정되면 생략가능)

-- 문법1. 테이블의 선언된 컬럼 순서 그대로 모두 값을 전달해야한다.
INSERT INTO tbl_menu VALUES (null, '바나나맛해장국', 8500, 4,'Y');
-- 문법2. NULL 허용 가능한(NULLABLE) 컬럼이나 AUTO_INCREMENT가 있는 컬럼을 제외하고
-- INSERT하고 싶은 데이터 컬럼을 지정해서 INSERT가능하다.
INSERT INTO tbl_menu(menu_name, menu_price, category_code, orderable_status)
VALUES ('초콜릿맛죽', 6500, 7, 'Y');

-- 컬럼을 명시하면 INSERT시 데이터의 순서를 바꾸는 것도 가능하다.
INSERT INTO tbl_menu(orderable_status, menu_price, menu_name, category_code)
VALUES ('Y', 25000, '매생이케익', 10);

-- ==============================================
-- UPDATE
-- ==============================================
SELECT
       menu_code
     , menu_name
     , category_code
  FROM tbl_menu;

UPDATE
       tbl_menu -- 수정할 대상테이블
   SET
       category_code = 10
     , menu_name = '매생이쉐이크'  -- 여러개의 값을 동시에 수정할 경우 콤마(,)를 사용한다.
 WHERE
       menu_code = 25;

-- SUBQUERY를 활용할 수 도 있다.
-- 다만 MySQL은 Oracle과 달리 update나 delete시 자기 자신 테이블의 데이터를 사용할 시 1093에러가 발생한다.
UPDATE
    tbl_menu
SET
    category_code = (SELECT menu_code
                     FROM tbl_menu
                     WHERE menu_name = '우럭스무디')
WHERE
    menu_code = 25;

-- 이때 SUBQUERY를 하나 더 사용하여 임시테이블로 사용하게하면 해결할 수 있다.
UPDATE
    tbl_menu
SET
    category_code = (SELECT tmp.menu_code
                     FROM (SELECT menu_code
                             FROM tbl_menu
                            WHERE menu_name = '우럭스무디') tmp
                    )
WHERE
    menu_code = 25;

SELECT * FROM tbl_menu WHERE menu_code = 25;

-- ==================================
-- DELETE
-- ==================================
-- 테이블의 행을 삭제하는 구문이다.
-- 테이블의 행의 갯수가 줄어든다.

DELETE
  FROM tbl_menu
 WHERE menu_code = 25;

-- LIMIT를 활용한 행삭제(offset 지정은안된다)
DELETE
  FROM tbl_menu
 ORDER BY menu_price
 LIMIT 2;

-- 테이블 전체 행 삭제
DELETE FROM tbl_menu;

-- TRUNCATE를 실행하면 ROLLBACK을 할 수없다.
# TRUNCATE table tb_escape_watch;

-- ==============================
-- REPLACE
-- ==============================
-- INSERT시 PRIMARY KEY 또는 UNIQUE KEY가 충돌이 발생할 수 있다면
-- REPLACE를 통해 중복된 데이터를 덮어쓸 수 있다.

INSERT INTO tbl_menu
VALUES (17, '참기름맛소주', 7000, 10, 'Y');

REPLACE INTO tbl_menu
VALUES (17, '참기름맛소주', 7000, 10, 'Y');

-- INTO는 생략 가능
REPLACE INTO tbl_menu
VALUES (17, '들기름맛소주', 7000, 10, 'Y');

SELECT * FROM tbl_menu WHERE menu_code = 17;