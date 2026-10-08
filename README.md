# SQL Practice Project

Practice queries I wrote while learning SQL, using PostgreSQL 18 and pgAdmin 4.
The file contains 33 queries with a short comment above each one.

## Tables used
- employees (8 rows)
- departments (4 rows)
- staff (7 rows)
- emp_practice (copy of employees, used for INSERT, UPDATE and DELETE)
- dup_demo (6 rows, used to practise finding and removing duplicates)

## Topics covered
- SELECT, WHERE, ORDER BY, LIMIT, LIKE and ILIKE, IN, BETWEEN
- COUNT, SUM, AVG, MIN, MAX
- GROUP BY and HAVING
- INNER JOIN, LEFT JOIN, finding unmatched rows with IS NULL
- Subqueries (including second highest salary)
- Finding and deleting duplicate records, DISTINCT
- NULL handling with IS NULL, COALESCE, and COUNT(*) vs COUNT(column)
- INSERT, UPDATE, DELETE, primary key

## File structure
1. Table setup
2. Basic queries
3. GROUP BY and HAVING
4. Joins
5. INSERT, UPDATE, DELETE
6. Subqueries, duplicates and NULL handling

## How to use
1. Open sql_practice.sql in pgAdmin 4 (Query Tool).
2. Select the setup section and run it first to create the tables.
3. Select one query at a time and press F5 to run it.
4. Q31 deletes duplicates, so run it only once. To practise again, re-run the dup_demo setup.

## Author
Rahul Shah
