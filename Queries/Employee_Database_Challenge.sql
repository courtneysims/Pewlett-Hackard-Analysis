--Challenge, SQL

--Deliverable 1: Table showing number of employees retiring by title
SELECT e.emp_no, 
e.first_name,
e.last_name,
ti.title,
ti.from_date,
ti.to_date
into retirement_titles
FROM employees as e
left join titles as ti
on e.emp_no = ti.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
order by ti.emp_no

--Remove duplicate entries for employees switched titles.
-- Use Dictinct with Orderby to remove duplicate rows 
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles 
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

--Retrieve the number of employees by most recent title about to reitre.
select count(title) as "count", title
INTO retiring_titles
from unique_titles
group by title
order by count DESC;

-- Deliverable 2: Mentorship Eligibility for employess in program
SELECT DISTINCT ON (emp_no) e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
ti.title
INTO mentorship_eligibility
FROM employees AS e
	INNER JOIN dept_emp AS de
		ON e.emp_no = de.emp_no
	INNER JOIN titles AS ti
		ON	e.emp_no = ti.emp_no
	WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01')
	ORDER BY emp_no;

--Query to remove duplicate to count total employees
SELECT DISTINCT ON (employees.emp_no) employees.emp_no,
    employees.first_name,
    employees.last_name,
    titles.title,
    titles.from_date,
    titles.to_date
INTO all_employees
FROM employees
LEFT JOIN titles
ON employees.emp_no = titles.emp_no
ORDER BY employees.emp_no, titles.to_date DESC

--mentorship-eligibiliy for 1 year prior by birth date
SELECT DISTINCT ON (emp_no) e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
ti.title
INTO mentorship_eligibility_one_year
FROM employees AS e
	INNER JOIN dept_emp AS de
		ON e.emp_no = de.emp_no
	INNER JOIN titles AS ti
		ON	e.emp_no = ti.emp_no
	WHERE (e.birth_date BETWEEN '1964-01-01' AND '1964-12-31')
	AND (de.to_date = '9999-01-01')
	ORDER BY emp_no;
	
--mentorship-eligibiliy for 1 year prior by birth date include dept.
SELECT DISTINCT ON (emp_no) e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
ti.title,
de.dept_no,
dp.dept_name
INTO mentorship_eligibility_one_year
FROM employees AS e
	INNER JOIN dept_emp AS de
		ON e.emp_no = de.emp_no
	INNER JOIN titles AS ti
		ON	e.emp_no = ti.emp_no
	INNER JOIN departments AS dp
		on de.dept_no = dp.dept_no
	WHERE (e.birth_date BETWEEN '1964-01-01' AND '1964-12-31')
	AND (de.to_date = '9999-01-01')
	ORDER BY emp_no;


Drop table mentorship_eligibility_one_year
select * from mentorship_eligibility_one_year

select count(emp_no) as "count"
from mentorship_eligibility_one_year






