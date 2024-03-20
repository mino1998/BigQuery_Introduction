-- 1. 포켓몬 중에 type2가 없는 포켓몬의 수를 작성하는 쿼리를 작성해주세요

SELECT
  COUNT(ID) AS cnt
FROM `bigquery-study-sonic.basic.pokemon`
WHERE 
  type2 IS NULL;
-- NULL은 다른 값과 직접 비교할 수 없기 때문에 ?=NULL 이게 안된다.
-- ? IS NULL 이라고 해야 한다.


-- 2. type2가 없는 포켓몬의 type1과 type1의 포켓몬 수를 알려주는 쿼리를 작성해주세요.
-- 단, type1의 포켓몬 수가 큰 순으로 정렬해주세요.

SELECT
  type1,
  COUNT(id) AS pokemon_cnt
FROM `bigquery-study-sonic.basic.pokemon`
WHERE 
  type2 IS NULL
GROUP BY 
  type1
ORDER BY 
  pokemon_cnt DESC;

-- 3. type2 상관없이 type1의 포켓몬 수를 알 수 있는 쿼리를 작성해 주세요
-- 상관없이가 "조건" 인지 생각은 해봐야 한다. : 우선 조건은 아니니 pass

SELECT
  type1,
  COUNT(id) AS pokemon_cnt
FROM `bigquery-study-sonic.basic.pokemon`
GROUP BY 
  type1;

-- 4. 전설 여부에 따른 포켓몬 수를 알 수 있는 쿼리를 작성해주세요.
-- 참고로 GROUP BY, ORDER BY에 SELECT에 내가 넣은 컬럼을 순서대로 번호로 입력할 수 있다.
-- GROUP BY 1, 2 이렇게 말이다.
-- 하지만, COUNT 같은 집계함수로 했다면 GROUP BY 에는 적용할 수 없다.

SELECT
  is_legendary,
  COUNT(id) AS pokemon_cnt
FROM `bigquery-study-sonic.basic.pokemon`
GROUP BY
  is_legendary;

-- 5. 동명 이인이 있는 이름은 무엇일까요?
-- 동명이인이라면 사람의 정보이다. trainer 테이블로 넘어가자.

SELECT
  name
FROM `bigquery-study-sonic.basic.trainer`
GROUP BY 
  name
HAVING 
  COUNT(name)>1;

-- 6. trainer 테이블에서 "Iris" 트레이너의 정보를 알 수 있는 쿼리를 작성해주세요.

SELECT
  *
FROM `bigquery-study-sonic.basic.trainer`
WHERE 
  name="Iris";

-- 7. trainer 테이블에서 "Iris", "Whitney", "Cynthia" 트레이너의 정보를 알 수 있는 쿼리를 작성해주세요
-- ()or()or() 조건으로 가능하지만 IN()을 쓰는게 더 가독성이 좋아보여
SELECT
  *
FROM `bigquery-study-sonic.basic.trainer`
WHERE 
  name IN ("Iris", "Whitney", "Cynthia");

-- 8. 전체 포켓몬 수는 얼마나 되나요?

SELECT
  COUNT(id) AS pokemon_cnt
FROM `bigquery-study-sonic.basic.pokemon`;

-- 9. 세대 별로 포켓몬 수가 얼마나 되는지 알 수 있는 쿼리를 작성해주세요.

SELECT
  generation,
  COUNT(id) AS pokemon_cnt
FROM `bigquery-study-sonic.basic.pokemon`
GROUP BY
  generation;

-- 10. type2가 존재하는 포켓몬의 수는 얼마나 되나요?

SELECT
  COUNT(id) AS pokemon_cnt
FROM `bigquery-study-sonic.basic.pokemon`
WHERE
  type2 IS NOT NULL;

-- 11. type2가 있는 포켓몬 중에 제일 많은 type1은 무엇인가요?
-- 답에서도 서브쿼리보단 desc 후 limit을 걸어주셨다.
SELECT
  type1,
  COUNT(id) AS pokemon_cnt
FROM `bigquery-study-sonic.basic.pokemon`
WHERE 
  type2 IS NOT NULL
GROUP BY type1
ORDER BY pokemon_cnt DESC
LIMIT 1;

-- 서브쿼리
SELECT
  type1,
  COUNT(id) AS pokemon_cnt
FROM `bigquery-study-sonic.basic.pokemon`
WHERE 
  type2 IS NOT NULL
GROUP BY type1
HAVING 
  COUNT(id) = (
    SELECT MAX(pokemon_cnt)
    FROM (
      SELECT COUNT(id) AS pokemon_cnt
      FROM `bigquery-study-sonic.basic.pokemon`
      WHERE type2 IS NOT NULL
      GROUP BY type1
    )
  );

-- 12. 단일(하나의 타입만 있는) 타입 포켓몬 중 많은 type1은 무엇일까요?

SELECT
  type1,
  COUNT(id) AS pokemon_cnt
FROM `bigquery-study-sonic.basic.pokemon`
WHERE 
  type2 IS NULL
GROUP BY type1
ORDER BY pokemon_cnt DESC
LIMIT 1;

-- 서브쿼리
SELECT
  type1,
  COUNT(id) AS pokemon_cnt
FROM `bigquery-study-sonic.basic.pokemon`
WHERE 
  type2 IS NULL
GROUP BY type1
HAVING 
  COUNT(id) = (
    SELECT MAX(pokemon_cnt)
    FROM (
      SELECT COUNT(id) AS pokemon_cnt
      FROM `bigquery-study-sonic.basic.pokemon`
      WHERE type2 IS NULL
      GROUP BY type1
    )
  );

-- 13. 포켓몬의 이름에 "파"가 들어가는 포켓몬은 어떤 포켓몬이 있을까요?

SELECT 
  kor_name
FROM `bigquery-study-sonic.basic.pokemon`
WHERE
  kor_name LIKE "%파%";

-- 14. 뱃지가 6개 이상인 트레이너는 몇 명이 있나요?

SELECT
  COUNT(id) AS trainer_cnt
FROM `bigquery-study-sonic.basic.trainer`
WHERE
  badge_count >=6;

-- 15. 트레이너가 보유한 포켓몬이 제일 많은 트레이너는 누구일까요?

WITH cnt_table AS (
  SELECT
    trainer_id,
    COUNT(pokemon_id) AS trainer_pokemon_cnt
  FROM `bigquery-study-sonic.basic.trainer_pokemon`
  GROUP BY trainer_id
  ORDER BY trainer_pokemon_cnt DESC
  LIMIT 1
)
SELECT 
  trainer.name,
  ct.trainer_pokemon_cnt
FROM `bigquery-study-sonic.basic.trainer` AS trainer
JOIN cnt_table AS ct
ON trainer.id = ct.trainer_id;

-- 16. 포켓몬을 많이 풀어준 트레이너는 누구일까요?

WITH cnt_table AS (
  SELECT
    trainer_id,
    COUNT(pokemon_id) AS released_pokemon_cnt
  FROM `bigquery-study-sonic.basic.trainer_pokemon`
  WHERE status='Released'
  GROUP BY trainer_id
  ORDER BY released_pokemon_cnt DESC
  LIMIT 1
)
SELECT 
  trainer.name,
  ct.released_pokemon_cnt
FROM `bigquery-study-sonic.basic.trainer` AS trainer
JOIN cnt_table AS ct
ON trainer.id = ct.trainer_id;

-- 17. 트레이너 별로 풀어준 포켓몬의 비율이 20%가 넘는 포켓몬 트레이너는 누구일까요?
-- 풀어준 포켓몬의 비율 = (풀어준 포켓몬 수 / 전체 포켓몬의 수)
-- COUNTIF(조건)을 할 수 있으면 좋아용
-- COUNTIF(컬럼='3') 

WITH cnt_table AS (
  SELECT
    trainer_id,
    COUNTIF(status = 'Released') AS released_pokemon_cnt,
    COUNT(*) AS total_pokemon_cnt,
    COUNTIF(status = 'Released') / COUNT(*) * 100 AS released_ratio
  FROM `bigquery-study-sonic.basic.trainer_pokemon`
  GROUP BY trainer_id
  HAVING released_ratio > 20
  ORDER BY released_pokemon_cnt DESC
  LIMIT 1
)
SELECT 
  trainer.name,
  ct.released_ratio
FROM `bigquery-study-sonic.basic.trainer` AS trainer
JOIN cnt_table AS ct
ON trainer.id = ct.trainer_id;



