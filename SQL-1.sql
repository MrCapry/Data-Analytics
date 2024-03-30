
ALTER USER hr ACCOUNT UNLOCK;
ALTER USER hr IDENTIFIED BY hr;


-- HR tables
SELECT * FROM employees;
SELECT * FROM countries;
SELECT * FROM departments;
SELECT * FROM jobs;
SELECT * FROM job_history;
SELECT * FROM locations;
SELECT * FROM regions;
-- My table
SELECT * FROM sales;
SELECT * FROM customers;
SELECT * FROM territory;
SELECT * FROM games; 
SELECT * FROM money;


-- Desc(ribe) sales
-- info(rmation) sales
                  
-- Control + E

FROM dual;

SELECT 
Order_Date,
Sales_Units*2 AS "Saler 2", 
game_id "Game_Name", 
'My Name is Giorgi' as Sent, 
'my name is giorgi',
q'[I'm pretty strong dude]' as "output", -- '-ის გამოყენება თუ გინდა როგორც String-ში
q'(I'm pretty strong dudea)' as "output2", -- []-ის მაგივრად რამდენიმე სხვა Character-ის გამოყენებაც მოსულა, (), <>
sales_Units || '23'
FROM sales;


-- || concatenation operator
SELECT name,'Gender is: ' || gender FROM customers;
SELECT order_date || ' okey' as checking FROM sales; -- null is ignored

-- Unique and distinct are same
SELECT distinct * FROM sales;

--- +,-,*,/ paranthesis
SELECT 
round(salary,0), 
salary*12+133 as "annual salary",
hire_date+23 as "New Date",
trunc(sysdate)+2, 
salary,
commission_pct,
salary+commission_pct
FROM employees;

-- arithemtic operations with null returns nulls

SELECT distinct customer_id,game_id,order_date FROM sales
where Game_id = 'G_ID4';  -- NULL-ებსაც აღიქვამს უნიკალურში

-- only one distinct key word, before first column

-- Where Calause
   -- =,<,>, [<>,!=], <=,>=,Between, IN, Like, NULL, and, or, not

SELECT * FROM sales
where 1=1 -- for corecting Where statements easily
AND sales_units BETWEEN 100 AND 200
AND sales_Date BETWEEN '1-Jan-2014' AND '1-Jan-2040'
AND Customer_ID IN ('ID1','ID2','23',45); -- აქ არ მოსულა რიცხვის დაწერა, Invalid Number-ს ამოაგდებს


SELECT * FROM sales
WHERE sales_units IN ('132',1); -- ასეთ დროს რიცხვად აღიქვამს


SELECT  * FROM user_tab_columns
where table_name = 'SALES';

-- % any, _ only one character
SELECT * FROM sales
where 1=1
and game_ID LIKE '%1%';

-- strings are case-sensitive
SELECT * FROM customers
where gender LIKE 'F%';

-- Distinct values from table
SELECT distinct * FROM sales
where order_date IS NULL;

-- AND, OR, NOT
SELECT * FROM sales
where 1=1
AND order_date IS NOT NULL
AND (sales_units>180 OR customer_id LIKE '%9%');

SELECT * FROM sales
where 1=1
AND (order_date >'1-Jan-2020'
OR order_date <'1-Jan-2023')
AND order_date IS NOT NULL;


SELECT * FROM employees 
WHERE 
commission_pct<0
OR salary>20000;

SELECT sales_units,order_date,Sales_date FROM Sales
where order_date>'1-Jan-2045' OR sales_units>100;

-- ერთ-ერთში უნდა ემთხვეოდეს Order By-ის დროს
SELECT 
sales_date,
Order_date,
Sales_Units*2.3+100 AS "Bonus",
Sales_Units*0.7 AS Bons
 From sales
order by 
"Bonus" asc, -- can be sorted by alias
bons desc,
sales_units desc,
sales_date desc;


-- column_name, alias, or Column Number
-- asc is default setting
SELECT * FROM sales
order by 1,order_date;

-- null values are last in ascending order
-- not neccesary to SELECT sorder columns
SELECT customer_id, Game_id FROM sales
order by order_date DESC;

-- NULLS first, NULLS Last
 -- როგორც წესი NULL ყველაზე ბოლოშია Alphabet-ის მიხედვით
SELECT * FROM sales
order by order_date ASC;

SELECT * FROM sales
order by order_date ASC NULLS FIRST;

SELECT * FROM sales
order by order_date DESC NULLS FIRST;


-- Row Num, Row ID
-- Row ID -- unique identifier
-- Row ID never changes
-- Row Num changes every time

SELECT 
sales_date,
order_date,
rowid,
rownum FROM sales
where 1=1
AND customer_id LIKE 'ID3%'
AND rownum<=10; -- RowNum დგება Sort_მდე

SELECT sales_date,order_date,sales_units,rownum FROM sales
WHERE rownum<11
order by sales_units DESC;

-- rowNum is calculated before sorting, that's why we can't use it as a limit like mySQL
SELECT sales_date,customer_id,sales_units,rownum FROM sales;

SELECT sales_date,customer_id,sales_units,rownum FROM sales
order by sales_units desc;

-- LIMIT-ing rows with rowNum
SELECT sales_date,order_date,sales_units,rowid,rownum FROM
 (SELECT sales_date,order_date,sales_units,rowid -- rowNum-ორივეგან არ უნდა ეწეროს
 FROM sales
 order by sales_units desc)
 WHERE rownum<=11;

-- ასეთ შემთხვევაში ორჯერ Order by მოსულა (CTE-ს დროს ან JOIN-ების დროს კი ნაკლებად)
SELECT * FROM 
(SELECT * FROM sales order by sales_date)
order by order_date;

SELECT sales_date,order_date,sales_units,rownum FROM sales;

SELECT sales_date,order_date,sales_units,rowid,rownum FROM
  (SELECT sales_date,order_date,sales_units,rowid 
  FROM sales
  order by sales_units desc)
 WHERE rownum<=11;


-- ჩემთან რატომღაც არ მუშაობს, მაგრამ Fetch და Offset კარგი რაღაცაა რაც Oracle-ში გვხვდება
-- With Ties და ა.შ. არსებობს
SELECT sales_date,order_date,sales_units FROM sales
ORDER BY sales_units DESC;
-- OFFSET 1 ROW[s] FETCH FIRST 10 rows only[with ties];


-- ასე გამოიყურება იდეაში
SELECT *
FROM employees
ORDER BY employee_id
OFFSET 20 ROWS FETCH NEXT 10 ROWS ONLY;

























