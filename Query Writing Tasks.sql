-- Q1: Retrieve a list of all employees and their department names. Include employees without departments (OUTER JOIN).
SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_NAME
FROM EMPLOYEES E LEFT OUTER JOIN DEPARTMENTS D
ON E.DEPT_ID = D.DEPT_ID;

-- Q2: Write a query to find employees who are assigned to more than one project.
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEES
WHERE EMP_ID IN ( 
    SELECT EMP_ID
    FROM PROJECTS
    GROUP BY EMP_ID
    HAVING COUNT(DISTINCT PROJECT_ID) > 1
);

-- Q3: Retrieve all departments where the average salary of employees exceeds 5000.
SELECT D.DEPT_NAME, AVG(E.SALARY) AS avg_salary
FROM DEPARTMENTS D JOIN EMPLOYEES E
ON D.DEPT_ID = E.DEPT_ID
GROUP BY D.DEPT_NAME
HAVING AVG(E.SALARY) > 5000;

-- Q4: Display the following details for each project: Project name, number of tasks, number of tasks in "Completed" status.
SELECT
    P.PROJECT_NAME, 
    COUNT(T.TASK_ID) AS num_tasks, 
    (SELECT COUNT(*)
     FROM TASKS AS T2
     WHERE T2.PROJECT_ID = P.PROJECT_ID
     AND T2.STATUS = 'Completed') AS num_ofcompleted_tasks
FROM PROJECTS P LEFT JOIN TASKS T
ON P.PROJECT_ID = T.PROJECT_ID
GROUP BY P.PROJECT_NAME;

-- Q5: Use a SELF-JOIN to find pairs of employees in the same department but with different salaries.
SELECT
    E1.EMP_NAME AS Employee1, 
    E2.EMP_NAME AS Employee2, 
    E1.SALARY AS Salary1, 
    E2.SALARY AS Salary2, 
    E1.DEPT_ID
FROM EMPLOYEES E1 
JOIN EMPLOYEES E2 
ON E1.DEPT_ID = E2.DEPT_ID 
AND E1.EMP_ID != E2.EMP_ID 
AND E1.SALARY != E2.SALARY;


-- Q6: Use SET OPERATORS to retrieve employees who either have no tasks assigned or are working on a project starting after January 1, 2023.
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEES
WHERE EMP_ID NOT IN (
    SELECT DISTINCT EMP_ID
    FROM PROJECTS P
    JOIN TASKS T ON P.PROJECT_ID = T.PROJECT_ID
)
UNION
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEES
WHERE EMP_ID IN (
    SELECT EMP_ID
    FROM PROJECTS
    WHERE START_DATE > TO_DATE('2023-01-01', 'YYYY-MM-DD')
);


