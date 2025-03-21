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
       LOCATE('딸기', '사과딸기바나나');

-- FORMAT(숫자, 소수점 자릿수)
-- FORMAT: 1000단위마다 콤마(,) 표시를 해 주며 소수점 아래 자릿수(반올림)까지 표현한다.
-- FORMAT(number, decimal_places)

SELECT FORMAT(123413241321321.5164465,3);
SELECT menu_code, FORMAT(menu_price, 0) "단위" FROM tbl_menu;

-- INSERT(기준 문자열, 위치, 길이, 삽입할 문자열)
-- INSERT: 기준 문자열의 위치부터 길이만큼을 지우고 삽입할 문자열을 끼워 넣는다.
SELECT INSERT('내 이름은 아무개 입니다.', 7, 3, '홍길동');

SELECT
       INSERT(menu_name, INSTR(menu_name, '쥬스'), 2, 'JUICE')
  FROM
       tbl_menu
 WHERE
       menu_name LIKE '%쥬스%';

-- LEFT(문자열, 길이), RIGHT(문자열, 길이)
-- LEFT: 왼쪽에서 문자열의 길이만큼을 반환
-- RIGHT: 오른쪽에서 문자열의 길이만큼을 반환
SELECT LEFT('Hello World', 4), RIGHT('Hello World', 5);

-- UPPER(문자열), LOWER(문자열)
-- UPPER: 소문자를 대문자로 변경
-- LOWER: 대문자를 소문자로 변경
SELECT LOWER('Hello World'), UPPER('Hello World');

-- LPAD(문자열, 길이, 채울 문자열), RPAD(문자열, 길이, 채울 문자열)
-- LPAD: 문자열을 길이만큼 왼쪽으로 늘린 후에 빈 곳을 문자열로 채운다.
-- RPAD: 문자열을 길이만큼 오른쪽으로 늘린 후에 빈 곳을 문자열로 채운다.
-- 881122-1******
SELECT LPAD('왼쪽', 6, '@'), RPAD('오른쪽', '6', '@'), RPAD('881122-1', 14, '*');

-- LTRIM(문자열), RTRIM(문자열)
-- LTRIM: 왼쪽 공백 제거
-- RTRIM: 오른쪽 공백 제거
SELECT LTRIM('     왼쪽'), RTRIM('오른쪽     ')

-- TRIM(문자열), TRIM(방향 자를_문자열 FROM 문자열)
-- TRIM은 기본적으로 앞뒤 공백을 제거하지만
-- 방향(LEADING(앞), BOTH(양쪽), TRAILING(뒤))이 있으면
-- 해당 방향에 지정한 문자열을 제거할 수 있다.

SELECT TRIM('    MYSQL    '), TRIM(BOTH '@' FROM '@@@@MYSQL@@@@');


-- REPEAT(문자열, 횟수)
-- REPEAT: 문자열을 횟수만큼 반복
SELECT REPEAT('🤣', 100);

-- REPLACE(문자열, 찾을 문자열, 바꿀 문자열)
-- REPLACE: 문자열에서 문자열을 찾아 치환
SELECT REPLACE('마이SQL', '마이', 'My');

-- REVERSE(문자열)
-- REVERSE: 문자열의 순서를 거꾸로 뒤집는다.
SELECT REVERSE('stressed');

-- SPACE(길이)
-- SPACE: 길이만큼의 공백을 반환
SELECT CONCAT('제 이름은', SPACE(5), '이고, 나이는 ', SPACE(3), '세입니다. ') 나이소개;

-- SUBSTRING(문자열, 시작위치, 길이)
-- SUBSTRING: 시작 위치부터 길이만큼의 문자를 반환(길이를 생략하면 시작 위치부터 끝까지 반환)
SELECT
       SUBSTRING('안녕하세요 반갑습니다.', 7, 6)
     , RPAD(SUBSTRING('881122-1234567',1, 8), 14, '*')
     , SUBSTRING('안녕하세요 반갑습니다.', 7);

-- =================================
-- 숫자처리함수
-- =================================
-- ABS(숫자)
-- ABS: 절대값 반환
SELECT ABS(-123), ABS(123)

-- CEILING(숫자), FLOOR(숫자), ROUND(숫자)
-- CEILING: 올림값 반환
-- FLOOR: 내림값(현재수보다 작은 최대정수) 반환
-- TRUNCATE(숫자, 소수점이하 자리수): 버림값 반환. 소수점이하 자리수는 필수이다.
-- ROUND: 반올림값 반환
SELECT CEILING(1234.56), FLOOR(1234.56), FLOOR(-0.65);