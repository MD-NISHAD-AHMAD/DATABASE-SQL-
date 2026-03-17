USE db;

SELECT * FROM naruto;

SELECT * FROM dragon_ball;

-- LEFT JOIN.

SELECT *
FROM naruto
LEFT JOIN dragon_ball
ON naruto.ranking = dragon_ball.ranking;

-- 2nd METHOD optimize is ALIAS .

SELECT *
FROM naruto AS N
LEFT JOIN dragon_ball AS D
ON N.ranking = D.ranking;

-- RIGHT JOIN.

SELECT * 
FROM naruto
RIGHT JOIN dragon_ball
ON naruto.ranking = dragon_ball.ranking;

-- 2nd METHOD USE IS ALIAS.

SELECT * 
FROM naruto AS N
RIGHT JOIN dragon_ball AS D
ON N.ranking = D.ranking;

-- INNER JOIN.

SELECT naruto.ranking, naruto.name,
dragon_ball.ninja_level
FROM naruto
INNER JOIN dragon_ball
ON naruto.ranking = dragon_ball.ranking;

-- 2nd METHOD USE IS ALIAS.

SELECT N.ranking, N.name,
 D.ninja_level
FROM naruto AS N
INNER JOIN dragon_ball AS D
ON N.ranking = D.ranking;

SELECT N.ranking, N.name,
D.ninja_level
FROM naruto AS N
JOIN dragon_ball AS D
ON N.ranking = D.ranking;

-- FULL OUTER JOIN.

SELECT *
FROM naruto AS N
LEFT JOIN dragon_ball AS D
ON N.ranking = D.ranking;

SELECT * 
FROM naruto AS N
RIGHT JOIN dragon_ball AS D
ON N.ranking = D.ranking;

-- SET OPERATION (UNION, UNION ALL, EXCEPT, INTERSECT).

-- UNION ALL

SELECT *
FROM naruto AS N
LEFT JOIN dragon_ball AS D
ON N.ranking = D.ranking
UNION ALL
SELECT *
FROM naruto AS N
RIGHT JOIN dragon_ball AS D
ON N.ranking = D.ranking;

-- UNION.

SELECT * 
FROM naruto AS N 
LEFT JOIN dragon_ball AS D
ON N.ranking = D.ranking
UNION
SELECT *
FROM naruto AS N
RIGHT JOIN dragon_ball AS D
ON N.ranking = D.ranking;

--  LEFT EXCLUSIVE JOIN.

SELECT *
FROM naruto AS N
LEFT JOIN dragon_ball AS D
ON N.ranking = D.ranking
WHERE D.ranking IS NULL;

-- RIGHT EXCLUSIVE JOIN.

SELECT *
FROM naruto AS N
RIGHT JOIN dragon_ball AS D
ON N.ranking = D.ranking
WHERE N.ranking IS NULL;

-- FULL OUTER EXCLUSIVE JOIN.

SELECT *
FROM naruto AS N
LEFT JOIN dragon_ball AS D
ON N.ranking = D.ranking
WHERE D.ranking IS NULL

UNION

SELECT * 
FROM naruto AS N
RIGHT JOIN dragon_ball AS D
ON N.ranking = D.ranking
WHERE N.ranking IS NULL;