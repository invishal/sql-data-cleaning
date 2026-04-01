-- Query 1 - Detect Duplicate Records

alter table orders_cleaned rename column customer_id to customer_name;

select customer_name, email, city , order_date, amount, count(*) as duplicates 
from orders_cleaned
group by customer_name, email, city , order_date, amount;

-- Query 2 - Remove Duplicate Records
delete from orders_cleaned
where order_id not in (
    select order_id from(
    select min(order_id) as order_id
    from orders_cleaned
    group by customer_name, email, city , order_date, amount
    ) as tempory
);

-- Query 3 - Null Email

select * from orders_cleaned
where email is null;

-- fill null email as unknownemails

-- Query 4 - Update Null Email to Unknown
update orders_cleaned
set email = 'unknow@gmail.com'
where email is null;

-- Query 5 - detect invalid email 

select * from orders_cleaned
where email not like '%@%.%';

-- Query 6 - update invalid email

update orders_cleaned
set email = 'rohit@gmail.com'
where order_id = 10;

-- Query 7 - Fix extra space in customer name
update orders_cleaned
set customer_name = trim(customer_name);

-- Query 8 - Fix city spelling mistakes
update orders_cleaned
set city = 'Mumbai'
where city  = 'Mum Bai';

-- Query 9 - Remove extra space in city
update orders_cleaned
set city = trim(city);

-- Query 10 - Fix date format (yyyy-dd-mm)
update orders_cleaned
set order_date = str_to_date(order_date, '%Y-%d-%m')
where order_date regexp'^[0-9]{4}-';

-- Query 11 - Fix date format (mm-dd-yyyy)
update orders_cleaned
set order_date = str_to_date(order_date, '%m-%d-%Y')
where order_date regexp'^[0-9]{2}-[1-3][0-9]-[0-9]{4}';

-- Query 12 - Fix date format (dd-mm-yyyy)

update orders_cleaned
set order_date = str_to_date(order_date, '%d-%m-%Y')
where order_date regexp'^[0-9]{2}-[0-9]{2}-[0-9]{4}';

-- Query 13 - Find the missing dates

select order_date from orders_cleaned
where order_date is null;

-- Query 14 - Update missing dates to a default value (e.g., '2024-01-01')

update orders_cleaned
set order_date = '2024-01-01'
where order_date is null;

-- Query 15 - Fix negative amount values

update orders_cleaned
set amount =abs(amount)
where amount < 0;

-- Query 16 - Fix null amount values with (e.g 0)

update orders_cleaned
set amount = 0
where amount is null;

describe orders_cleaned;

-- Query modify the data types

alter table orders_cleaned
modify order_id int,
modify customer_name varchar(50),
modify email varchar(50),
modify city varchar(30),
modify order_date date,
modify amount decimal(10,2);