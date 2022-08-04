
-- Deliverable 1: The Number of Retiring Employees by Title
-- Table that holds title of all current employees born between 1/1/52 and 12/31/55 using DISTINCT ON for most current title
-- Then use COUNT() to make table that has number of retirement age employees by most recent job title
SELECT e.emp_no, 
	e.first_name, 
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN title AS t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

SELECT * FROM retirement_titles;
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (______) _____,
______,
______,
______

INTO nameyourtable
FROM _______
WHERE _______
ORDER BY _____, _____ DESC;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
    rt.first_name,
    rt.last_name,
    rt.title
INTO unique_titles
FROM retirement_titles AS rt
where rt.to_date = '9999-01-01'
ORDER BY rt.emp_no, rt.to_date DESC;

SELECT * FROM unique_titles;

--Table retrieve the number of employees by their most recent job title who are about to retire.
SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY COUNT(ut.emp_no) DESC;

select * from retiring_titles;

--Deliverable 2: The Employees Eligible for the Mentorship Program.
--Table that hold the employees eligible to participate in a mentorship program
SELECT DISTINCT ON (e.emp_no) e.emp_no, 
	e.first_name, 
	e.last_name, 
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibilty
FROM employees AS e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN title AS t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no, t.title ASC;

--query for retrieve the number of employees eligible for  mentorship program by title.
SELECT COUNT(me.emp_no), me.title
FROM mentorship_eligibilty AS me
GROUP BY me.title
ORDER BY COUNT(me.emp_no) DESC;
 
 ---------------------------------------------------------------------------------------------------------------------------
--Deliverable 3:
------------------------------------------------------------------------------------------------------------------------
--Table Retiring Employees by title and department: 

SELECT DISTINCT ON (ut.emp_no) 
	ut.emp_no,
	ut.first_name,
	ut.last_name,
	ut.title,
	d.dept_name
INTO unique_titles_department
FROM unique_titles as ut
INNER JOIN dept_emp as de
ON (ut.emp_no = de.emp_no)
INNER JOIN departments as d
ON (d.dept_no = de.dept_no)
INNER JOIN retirement_titles as rt
ON (ut.emp_no = rt.emp_no)
ORDER BY ut.emp_no, rt.to_date DESC;

select * from unique_titles_department;--72458

-- How many roles will need to be fill per title and department?

SELECT ut.dept_name, ut.title, COUNT(ut.title) 
INTO rolls_to_fill
FROM (SELECT title, dept_name from unique_titles_department) as ut
GROUP BY ut.dept_name, ut.title
ORDER BY ut.dept_name ASC;

select *from rolls_to_fill;

-- Qualified staff, retirement-ready to mentor next generation.
SELECT ut.dept_name, ut.title, COUNT(ut.title) 
INTO qualified_staff
FROM (SELECT title, dept_name from unique_titles_department) as ut
WHERE ut.title IN ('Senior Engineer', 'Senior Staff', 'Technique Leader', 'Manager')
GROUP BY ut.dept_name, ut.title
ORDER BY ut.dept_name DESC;



select *from qualified_staff;
 
 
