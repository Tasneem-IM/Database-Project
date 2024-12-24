-- Q: Add the constraint on `EMP_ID` column in `EMPLOYEES` to ensure that `EMP_ID` starts with the last three digits of your student ID.

ALTER TABLE EMPLOYEES
ADD CONSTRAINT EMP_IDCONS CHECK (TO_CHAR(EMP_ID) LIKE '465%');
