-- Deliverable 1: The number of Retirees by Title
SELECT e.emp_no,
    e.first_name,
	e.last_name,
    ti.title,
	ti.from_date,
	ti.to_date
--INTO retirement_titles
FROM employees as e
INNER JOIN titles as ti ON (e.emp_no = ti.emp_no)
INNER JOIN dept_emp as de ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY emp_no ASC;

-- Remove Duplicates entries
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO Unique_titles
FROM retirement_titles AS rt
Order BY emp_no ASC, to_date DESC;

-- Count the number of each title
SELECT COUNT(ut.emp_no),ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY title 
ORDER BY COUNT(title) DESC;

-- Deliverable 2: The Employees Eligible for the Mentorship Program
SELECT DISTINCT ON(e.emp_no)e.emp_no,
    e.first_name,
    e.last_name,
    e.birth_date,
    de.from_date,
    de.to_date,
    ti.title
INTO mentor_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de ON (e.emp_no = de.emp_no)
INNER JOIN titles AS ti ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY emp_no;

-- Count eligable mentors
SELECT COUNT(me.emp_no),me.title
INTO mentor_titles
FROM mentor_eligibility as me
GROUP BY title 
ORDER BY COUNT(title) DESC;


