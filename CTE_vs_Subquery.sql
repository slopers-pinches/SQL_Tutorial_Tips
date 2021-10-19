#create schema bdm_final;
use employees;

# Extract the information about all department managers
# who were hired between the 1st of January 1990 and the 1st of January 1995.

# Subquery
SELECT *
	FROM dept_manager
    # Sub-select employees who were hired between the 1st of January 1990 and the 1st of January 1995
    WHERE emp_no IN (SELECT emp_no
                           FROM employees
						WHERE hire_date BETWEEN '1990-01-01' AND '1995-01-01');
                        
# CTE
# Create a temporary result of employees who were hired between the 1st of January 1990 and the 1st of January 1995 
WITH emp_90_91 AS (
	SELECT emp_no
		FROM employees
        WHERE hire_date BETWEEN '1990-01-01' AND '1995-01-01')

SELECT E.emp_no, D.dept_no, D.from_date, D.to_date 
	FROM emp_90_91 AS E
    INNER JOIN 
    dept_manager AS D
    ON E.emp_no = D.emp_no;
    
        