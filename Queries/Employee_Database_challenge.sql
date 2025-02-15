Select e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY emp_no, to_date;
	
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

SELECT COUNT (title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT DESC;

Select SUM (emp_no) from employees;

SELECT DISTINCT ON (emp_no)e.emp_no, 
	e.first_name, 
	e.last_name, 
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_employees as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY emp_no;

select * from mentorship_eligibilty;

--mentors by title
SELECT COUNT (title), title
FROM mentorship_eligibilty
GROUP BY title
ORDER BY COUNT DESC;

select * from titles ;

--current by dept
SELECT d.dept_name, cd.count
FROM departments as d
INNER JOIN current_dept as cd
ON (d.dept_no = cd.dept_no)
ORDER BY COUNT ;

--current by titles
SELECT COUNT (title), title
FROM titles
GROUP BY title
ORDER BY COUNT DESC;

--silver tsunami survivors
SELECT DISTINCT ON (emp_no)e.emp_no, 
	e.first_name, 
	e.last_name, 
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO not_retiring
FROM employees as e
INNER JOIN dept_employees as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE birth_date <= DATE '1965-12-31'
ORDER BY emp_no;

SELECT COUNT (emp_no) FROM not_retiring;

--survivors by title
SELECT COUNT (title), title
FROM not_retiring
GROUP BY title
ORDER BY COUNT DESC;
