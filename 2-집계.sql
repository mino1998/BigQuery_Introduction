-- 집계관련 쿼리
-- SELECT
--   집계할 컬럼1,
--   집계함수(COUNT, MAX, MIN) 등..
-- FROM TABLE
-- GROUP BY 
--   집계할 컬럼1

-- 고유값을 알고 싶은 경우
-- DISTINCT, GROUP BY : unique한 것 만 보고 싶다.
-- 고유값, count에 많이 사용

-- 1. pokemon 테이블에 있는 포켓몬 수를 구하는 쿼리를 작성해 주세요.
--  1) 사용할 테이블 : pokemon
--  2) 조건 : x
--  3) 집계할 때 사용할 컬럼 : ?
--  4) 집계할 때 사용할 계산 : 수를 구한다 => COUNT

SELECT
  COUNT(id) AS cnt,
  COUNT(*) AS cnt2
FROM `bigquery-study-sonic.basic.pokemon`;

-- 2. 포켓몬의 수가 세대별로 얼마나 있는지 알 수 있는 쿼리를 작성해 주세요.
--  1) 사용할 테이블 : pokemon
--  2) 조건 : ?
--  3) 집계할 때 사용할 컬럼 : 세대
--  4) 집계할 때 사용할 계산 : 얼마나 있는지 => COUNT

SELECT
  COUNT(*) AS cnt,
  generation
FROM `bigquery-study-sonic.basic.pokemon`
GROUP BY generation;

-- 데이터 분석하다가 그룹화하는 경우
-- 1. 일자별 집계 (원본 데이터는 특정 시간에 어떤 유저가 한 행동이 기록됨, 일자별로 집계)
-- 2. 연령대별 집계 (특정 연령대에서 더 많이 구매했는가?)
-- 3. 특정 타입별 집계 (특정 제품 타임을 많이 구매했는가?)
-- 4. 앱 화면별 집계 (어떤 화면에 유저가 많이 접근했는가?) 등..

-- 조건을 설정하고 싶은 경우
-- WHERE
-- - TABLE에 바로 조건을 설정하고 싶은 경우에 사용한다.
-- RAW Data 인 테이블 데이터에 바로 조건 설정

-- HAVING
-- - Group BY 한 뒤 조건을 설정하고 싶은 경우에 사용한다.
-- - 집계 후 생성된 컬럼에 조건을 부여하고 싶을 때 사용

-- 3. 포켓몬의 수를 타입 별로 집계하고, 포켓몬의 수가 10 이상인 타입만 보는 쿼리를 작성해 주세요. 포켓몬 수가 많은 순서대로 정렬해주세요
--  1) pokemon 테이블
--  2) 조건(where) : 테이블 원본에는 없음
--  3) 집계 후 조건(having) : 포켓몬의 수가 10 이상
--  4) 정렬은 내림차순
--  5) 타입별 집계
-- 단계적으로 실행하면서 쿼리를 완성시켜도 된다.
SELECT 
  type1,
  type2,
  COUNT(*) AS cnt
FROM `bigquery-study-sonic.basic.pokemon`
GROUP BY type1, type2
HAVING cnt>=10
ORDER BY cnt DESC;