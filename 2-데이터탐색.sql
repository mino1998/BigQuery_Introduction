SELECT
  *
FROM `bigquery-study-sonic.basic.pokemon`;
# 프로젝트 id는 꼭 명시할 필요는 없을 수도 있다.(프로젝트가 단일이라면)
# 프로젝트를 여러 개 사용한다면 명시하는게 좋음 (쿼리 실행 시 어떤 프로젝트인지 확인하는 방법)
# 데이터를 활용하고 싶은 목적이 있어야 어떤 컬럼을 선택할지 알 수 있게 된다.
# 컬럼 이름에는 따옴표를 넣으면 안된다. Alias에서 말이다.

# SQL은 FROM -> WHERE -> SELECT 순서로 실행된다.

-- 1. trainer 테이블에 있는 모든 데이터를 보여주는 쿼리를 작성해주세요.
--  1). trainer 테이블에는 어떤 데이터가 있는지 확인
--  2). trainer 테이블을 어디에 명시해야 할까? => FROM
--  3). 필터링 조건이 있는가?
--  4). 모든 데이터 => 모든 데이터는 모든 컬럼일 수 있겠다.(추측) 후 쿼리 작성
SELECT
  *
FROM `bigquery-study-sonic.basic.trainer`;

-- 2. trainer 테이블에 있는 트레이너의 name을 출력하는 쿼리를 작성해주세요.
--  1). trainer 테이블을 골라야 한다.
--  2). trainer 테이블에서 보고 싶은 컬럼은 name 컬럼이다.
--  3). trainer의 name을 "중복" 을 처리해야 하는가?
SELECT
  DISTINCT(name) AS name
FROM `bigquery-study-sonic.basic.trainer`;

SELECT
  name
FROM `bigquery-study-sonic.basic.trainer`;

-- 3. trainer 테이블에 있는 트레이너의 name, age를 출력하는 쿼리를 작성해 주세요.
SELECT
  DISTINCT(name) AS name,
  age
FROM `bigquery-study-sonic.basic.trainer`;

-- 4. trainer 테이블에서 id가 3인 트레이너의 name, age, hometown을 출력하는 쿼리를 작성해 주세요.
--  1) 조건이 생겼다. => id가 3이다. (WHERE 조건)
SELECT
  DISTINCT(name) AS name,
  age,
  hometown
FROM `bigquery-study-sonic.basic.trainer`
WHERE 
  id=3;

-- 5. pokemon 테이블에서 "피카츄"의 공격력과 체력을 확인할 수 있는 쿼리를 작성해 주세요
--  1) pokemon 테이블에서 레코드를 뽑아야 한다.
--  2) 공격력과 체력의 컬럼명을 확인해야한다.
--  3) 이름이 "피카츄"라는 조건이 걸려있다.
SELECT
  attack,
  hp
FROM `bigquery-study-sonic.basic.pokemon`
WHERE kor_name="피카츄";