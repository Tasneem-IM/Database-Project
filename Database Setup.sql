-- Q: Create the following tables and relationships:
-- - `DEPARTMENTS` table
-- - `EMPLOYEES` table with a foreign key to `DEPARTMENTS`
-- - `PROJECTS` table with a foreign key to `EMPLOYEES`
-- - `TASKS` table with a foreign key to `PROJECTS`

CREATE TABLE DEPARTMENTS (
    DEPT_ID NUMBER(5) PRIMARY KEY,
    DEPT_NAME VARCHAR2(50) NOT NULL,
    LOCATION VARCHAR2(50)
);

CREATE TABLE EMPLOYEES (
    EMP_ID NUMBER(5) PRIMARY KEY,
    EMP_NAME VARCHAR2(50) NOT NULL,
    SALARY NUMBER(8, 2) CHECK (SALARY > 0),
    HIRE_DATE DATE,
    DEPT_ID NUMBER(5),
    FOREIGN KEY (DEPT_ID) REFERENCES DEPARTMENTS (DEPT_ID)
);

CREATE TABLE PROJECTS (
    PROJECT_ID NUMBER(5) PRIMARY KEY,
    PROJECT_NAME VARCHAR2(50) NOT NULL,
    START_DATE DATE,
    END_DATE DATE,
    EMP_ID NUMBER(5),
    FOREIGN KEY (EMP_ID) REFERENCES EMPLOYEES (EMP_ID)
);

CREATE TABLE TASKS (
    TASK_ID NUMBER(5) PRIMARY KEY,
    TASK_NAME VARCHAR2(50) NOT NULL,
    PROJECT_ID NUMBER(5),
    STATUS VARCHAR2(20) CHECK (STATUS IN ('Open', 'In Progress', 'Completed')),
    FOREIGN KEY (PROJECT_ID) REFERENCES PROJECTS (PROJECT_ID)
);