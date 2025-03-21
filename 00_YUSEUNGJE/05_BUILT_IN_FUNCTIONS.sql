-- =================================
-- BUILT IN FUNCTIONS
-- =================================
-- 하나의 큰 프로그램에서 반복적으로 사용되는 부분들을 분리하여 작성해 놓은 작은 서브 프로그램으로, 호출하며 값을 전달하면
-- 수행결과를 리턴하는 방식으로 사용된다.
-- 호출(값 전달) -> 작업 수행 -> 결과값 리턴

# API Doc
-- https://dev.mysql.com/doc/refman/8.0/en/built-in-function-reference.html
-- https://www.w3schools.com/mysql/mysql_ref_functions.asp

# 함수의 유형
-- 단일행처리 함수 : 각 행마다 반복 호출되어서 호출된 수만큼 결과를 리턴한다.
-- 1. 문자처리 함수
-- 2. 숫자처리 함수
-- 3. 날짜시간처리 함수
-- 4. 기타함수
-- 그룹함수 : 여러행들이 그룹으로 형성되어 적용된다. 그룹당 1개의 결과를 리턴한다.

-- =====================================
-- 문자처리함수
-- =====================================

-- ASCII(아스키 코드), CHAR(숫자)
-- ASCII: 아스키 코드값 추출
-- CHAR : 아스키 코드로 문자 추출
SELECT ASCII('A'), CHAR(65);

-- BIT_LENGTH(문자열), CHAR_LENGTH(문자열), LENGTH(문자열)
-- BIT_LENGTH: 할당된 비트 크기 반환
-- CHAR_LENGTH: 문자열의 길이 반환
-- LENGTH : 할당된 BYTE크기
SELECT menu_name, BIT_LENGTH(menu_name), CHAR_LENGTH(menu_name), LENGTH(menu_name) FROM tbl_menu;

-- CONCAT(문자열1, 문자열2, ...), CONCAT_WS(구분자, 문자열1, 문자열2, ...)
-- CONCAT: 문자열을 이어붙임
-- CONCAT_WS: 구분자와 함께 문자열을 이어붙임
SELECT CONCAT('호랑이', '기린', '원숭이');
SELECT CONCAT_WS(',', '호랑이', '기린', '원숭이');
SELECT CONCAT_WS('-', '2025', '03', '21');

-- ELT(위치, 문자열1, 문자열2, ...), FIELD(찾을 문자열, 문자열1, 문자열2, ...)
-- FIELD: 찾을 문자열 위치 반환
-- ELT: 해당 위치의 문자열 반환

SELECT
       ELT(2, '사과', '딸기', '바나나'),
       FIELD('딸기', '사과', '딸기', '바나나');

-- FIND_IN_SET(찾을 문자열, 문자열 리스트)
-- FIND_IN_SET: 찾을 문자열의 위치 반환, 문자열 리스트의 구분자는 반드시 ,여야 한다.
SELECT FIND_IN_SET('바나나', '사과,딸기,바나나');

-- ORDER BY에서 특정 레코드를 끌어올리기 위한 용도로 사용할 수 있다.
SELECT * FROM tbl_menu ORDER BY FIND_IN_SET(menu_code, 12) DESC, FIND_IN_SET(menu_code, 16) DESC;

-- INSTR(기준 문자열, 부분 문자열)
-- INSTR: 기준 문자열에서 부분 문자열의 시작 위치 반환

-- LOCATE(부분 문자열, 기준 문자열)
-- LOCATE: INSTR과 동일하고 순서는 반대

SELECT
       INSTR('사과딸기바나나', '딸기'),
       LOCATE('딸기', '사과딸기바나나')

-- FORMAT(숫자, 소수점 자릿수)
-- FORMAT: 1000단위마다 콤마(,) 표시를 해 주며 소수점 아래 자릿수(반올림)까지 표현한다.
-- FORMAT(number, decimal_places)

SELECT FORMAT(123413241321321.5164465,3);
SELECT menu_code, FORMAT(menu_price, 0) "단위" FROM tbl_menu;