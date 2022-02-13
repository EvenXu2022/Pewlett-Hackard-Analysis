--------------------------
--***Dedeliverable 1***--
--------------------------

-- retrieve from employees table
SELECT e.emp_no,
e.first_name,
e.last_name,
tl.title,
tl.from_date,
tl.to_date
INTO title_info
FROM employees2 as e
INNER JOIN titles as tl
ON (e.emp_no = tl.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

select * from title_info;


-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) 
emp_no, 
first_name,
last_name,
title
INTO retiretitle_info
FROM title_info
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

SELECT * from retiretitle_info;

-- employees who are about to retire with title
SELECT COUNT(emp_no),
title
INTO retiretile
FROM retiretitle_info
GROUP BY title
ORDER BY count(emp_no) DESC;

SELECT sum(count) FROM retiretile;

SELECT * FROM retiretile;

--------------------------
--***Dedeliverable 2****--
--------------------------

--create Mentorship Eligibility Table
SELECT DISTINCT ON (tl.emp_no) e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
tl.title
INTO mentor_emp
FROM employees2 as e
	INNER JOIN dept_emp as de
		ON (e.emp_no=de.emp_no)
	INNER JOIN titles as tl
		ON(e.emp_no=tl.emp_no)
WHERE birth_date BETWEEN '1965-01-01' AND '1965-12-31'
AND (de.to_date = '9999-01-01')
ORDER BY tl.emp_no;

select * from  mentor_emp;

------------------------------------
-------****Extra Analysis****-------
------------------------------------

---- number of mentorship employees-----
SELECT count(emp_no),title
from mentor_emp
GROUP BY title;

-----------retirement ratio in each department----------
SELECT agg.title,agg.r_count,agg.e_count,
agg.r_count * 100 / agg.e_count as r_ratio 
from
	(SELECT tl.title,
	r.count AS r_count,
	count(tl.emp_no) AS e_count
	FROM titles AS tl
	FULL OUTER JOIN retiretile as r
		ON (tl.title = r.title)
	WHERE tl.to_date = '9999-01-01'
	GROUP BY tl.title,r.count) AS agg;

----- Department need for new managers------
SELECT r.emp_no,
r.first_name,
r.last_name,
d.dept_name 
FROM departments AS d
INNER JOIN dept_manager as dm
 	ON (dm.dept_no = d.dept_no)
INNER JOIN retiretitle_info as r
	ON (dm.emp_no = r.emp_no)
WHERE r.title = 'Manager';

----- new position vs eligible mentorship employees--

SELECT r.title ,
r.count as n_retirement, 
mec.count as mentors,
r.count / mec.count as m_ratio
FROM (
	SELECT COUNT(emp_no),title
	 FROM mentor_emp
	 GROUP BY title
	) as mec
FULL OUTER JOIN retiretile as r
  	ON (mec.title = r.title)
ORDER BY r.count;

-- total current employee
SELECT COUNT(e.emp_no) FROM employees2 as e
INNER JOIN dept_emp as de
  	ON (e.emp_no= de.emp_no)
WHERE de.to_date = '9999-01-01'; --total current employee = 240124








