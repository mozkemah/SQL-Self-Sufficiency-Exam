--1
SELECT *
FROM naep

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'naep';

--2
SELECT *
FROM naep
LIMIT 50

--3
SELECT state, 
COUNT(avg_math_4_score) AS avg_math_4_score_count,
ROUND(AVG(avg_math_4_score), 3) AS avg_math_4_score,
MAX(avg_math_4_score) AS avg_math_4_score_max,
MIN(avg_math_4_score) AS avg_math_4_score_min
FROM naep
GROUP BY state
ORDER BY state;

--4
SELECT state,
COUNT(avg_math_4_score) AS count_of_avg_math_4_score,
ROUND(AVG(avg_math_4_score), 3) AS avg_of_avg_math_4_score,
MAX(avg_math_4_score) AS max_of_avg_math_4_score, 
MIN(avg_math_4_score) AS min_of_avg_math_4_score, 
MAX(avg_math_4_score) - MIN(avg_math_4_score) AS difference 
FROM naep
GROUP BY state
HAVING MAX(avg_math_4_score) - MIN(avg_math_4_score) > 30
ORDER BY state

--5
SELECT state AS bottom_10_states, avg_math_4_score
FROM naep
WHERE year = 2000
ORDER BY avg_math_4_score
LIMIT 10

--6
SELECT state, ROUND(avg_math_4_score,2)
FROM naep
WHERE year = 2000
GROUP BY state, avg_math_4_score

--7
WITH avr_st AS
    (SELECT AVG(avg_math_4_score) AS avg_states
    FROM naep
    WHERE year = '2000')
SELECT state, avg_math_4_score AS below_average_states_y2000
FROM naep, avr_st
WHERE avg_math_4_score < avg_states AND year = 2000

--8
SELECT state AS scores_missing_y2000, avg_math_4_score
FROM naep
WHERE avg_math_4_score IS NULL
AND year = 2000

--9
SELECT naep.state, ROUND(naep.avg_math_4_score, 2) AS avg_math_4_score, finance.total_expenditure
FROM naep LEFT OUTER JOIN finance
ON naep.id = finance.id
WHERE naep.year = 2000 AND avg_math_4_score IS NOT NULL
ORDER BY finance.total_expenditure DESC