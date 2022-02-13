-- SELECT departments.dept_name,
-- dept_manager.emp_no,
-- dept_manager.from_date,
-- dept_manager.to_date
-- FROM departments
-- INNER JOIN dept_manager
-- on departments.dept_no=dept_manager.dept_no;

-- -- Joining retirement_info and dept_emp tables
-- SELECT retirement_info.emp_no,
-- 	retirement_info.emp_no,
-- 	retirement_info.last_name,
-- 	dept_emp.to_date
-- FROM retirement_info
-- LEFT JOIN dept_emp
-- ON retirement_info.emp_no = dept_emp.emp_no;

-- -- Joining retirement_info and dept_emp tables by using reference
-- SELECT ri.emp_no,
-- 	ri.emp_no,
-- 	ri.last_name,
-- 	de.to_date
-- FROM retirement_info AS ri
-- LEFT JOIN dept_emp AS de
-- ON ri.emp_no = de.emp_no;


-- -- Joining departments and dept_manager tables
-- SELECT de.dept_name,
-- 	dm.emp_no,
-- 	dm.from_date,
-- 	dm.to_date
-- FROM departments AS de
-- INNER JOIN dept_manager AS dm
-- ON de.dept_no = dm.dept_no;

-- -- left join for retirement info and dept emp

-- SELECT ri.emp_no,
-- 	ri.first_name,
-- 	ri.last_name,
-- 	de.to_date
-- INTO current_emp
-- FROM retirement_info as ri
-- LEFT JOIN dept_emp as de
-- ON ri.emp_no = de.emp_no
-- WHERE de.to_date = '9999-01-01'

-- SELECT * FROM current_emp;
-- employee count by department number

-- SELECT COUNT(ce.emp_no) as e_count, de.dept_no
-- FROM current_emp as ce
-- LEFT JOIN dept_emp as de
-- ON ce.emp_no = de.emp_no
-- GROUP BY de.dept_no
-- ORDER BY de.dept_no DESC;

-- Retirement employee information 1
-- SELECT emp_no,
-- first_name,
-- last_name,
-- gender
-- INTO emp_info
-- FROM employees2
-- WHERE (birth_date BETWEEN '1952-01-01' AND '1952-12-31')
-- AND (hire_date BETWEEN '1985-01-01'AND '1988-12-31');


-- Retirement employee information 2
select * from emp_info; -- 9687

DROP TABLE emp_info;

SELECT e.emp_no,
e.first_name,
e.last_name,
e.gender,
s.salar,
de.to_date
INTO emp_info
FROM employees2 as e
	INNER JOIN salaries as s
		ON (e.emp_no = s.emp_no)
	INNER JOIN dept_emp as de
		ON (e.emp_no = de.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1952-12-31')
	AND (hire_date BETWEEN '1985-01-01'AND '1988-12-31')
	AND (de.to_date = '9999-01-01');


--Managaer information Dep no, dep name, emp_no, last name, first name, start and end date.
SELECT dm.dept_no,
d.dept_name,
dm.emp_no,
ce.last_name,
ce.first_name,
dm.from_date,
dm.to_date
INTO manager_info
FROM dept_manager AS dm
	INNER JOIN departments as d
	 	ON (d.dept_no = dm.dept_no)
	INNER JOIN current_emp AS ce
		ON (dm.emp_no = ce.emp_no);

-- current retirement department info

SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp as de
ON (de.emp_no = ce.emp_no)
INNER JOIN departments as d
ON(de.dept_no = d.dept_no);

		
		






