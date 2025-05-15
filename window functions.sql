-- Window Functions
-- like  GROUP BY but they don't row everyhing into one row when grouping
-- allows us to look at a partitiong or a group but they each keep their unic rows 
-- row numbers, rank and dense rank


-- take gender and compare it to salaries con GROUP BY

SELECT gender, AVG(salary) AS avg_salary
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender;

-- take gender and compare it to salaries con WINDOW F
-- no ocupas group by
-- si ocupas AVG
-- usando OVER dices quiero ver AVG sal OVER * o algo en específico, osea donde quieres que el AVG se aplique 
-- OVER (PARTITION BY)

SELECT dem.first_name, dem.last_name, gender, AVG(salary) OVER(PARTITION BY gender) 
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;

-- same pero sum
-- y rolling total. start at a specific value and add on values from subsequent rows based off the partition (cuando usas ORDER BY)

SELECT dem.employee_id, dem.first_name, dem.last_name, gender, salary,
SUM(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id) AS RUNNING_TOTAL
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;
    
-- ROW NUMBER , RANK y DENSE RANK (siempre ocupas usar OVER(PARTITION BY _ ORDER BY)
-- ROW NUM es el único que no puede tener duplicados
SELECT dem.employee_id, dem.first_name, dem.last_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num,
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) as rank_num,
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) as dense_rank_num
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;
