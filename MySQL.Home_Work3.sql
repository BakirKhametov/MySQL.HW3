USE home_work3;
CREATE TABLE salespeople
(
snum INT PRIMARY KEY,
sname VARCHAR(10),
city VARCHAR(30),
comm VARCHAR(10)
);
 
 
 INSERT salespeople (snum, sname, city, comm) VALUES
 (1001, "Peel", "London", ".12"),
 (1002, "Serres", "San Jose", ".13"),
 (1004, "Motika", "London", ".11"),
 (1007, "Rifkin", "Barcelona", ".15"),
 (1003, "Axelrod", "New York", ".10");
 
 
 /* 1. Напишите запрос, который вывел бы таблицу со столбцами в следующем порядке: city, sname, snum, comm.
 (к первой или второй таблице, используя SELECT)
 */ 
 SELECT city, sname, snum, comm
 FROM salespeople;
 
 -- 2. Напишите команду SELECT, которая вывела бы оценку(rating), сопровождаемую именем каждого заказчика в городе San Jose. (“заказчики”)
 CREATE TABLE customers
 (
 cnum INT PRIMARY KEY,
 cname VARCHAR(10),
 city VARCHAR(30),
 rating INT,
 snum int,
 FOREIGN KEY (snum)
 REFERENCES salespeople(snum)
 );
 INSERT customers (cnum, cname, city, rating, snum) VALUES
 (2001, "Hoffman", "London", 100, 1001),
 (2002, "Giovanni", "Rome", 200, 1003),
 (2003, "Liu", "San Jose", 200, 1002),
 (2004, "Grass", "Berlin", 300, 1002),
 (2006, "Clemens", "London", 100, 1001),
 (2008, "Gisneros", "San Jose", 300, 1007),
 (2007, "Pereira", "Rome", 100, 1004)
 ;
 
SELECT *FROM customers;

SELECT rating, cname
 FROM customers
 WHERE city = "San Jose";
 
 /*
 3. Напишите запрос, который вывел бы значения snum всех продавцов из таблицы заказов без каких бы то ни было повторений. 
 (уникальные значения в “snum“ “Продавцы”)
 */
 SELECT DISTINCT snum FROM salespeople;
 
 /*
 4*. Напишите запрос, который бы выбирал заказчиков, чьи имена начинаются с буквы G. Используется оператор "LIKE": (“заказчики”)
 */
 SELECT cname FROM customers
 WHERE cname LIKE "G%";
 
 /*
 5. Напишите запрос, который может дать вам все заказы со значениями суммы выше чем $1,000. (“Заказы”, “amt” - сумма)
 */
 CREATE TABLE orders
(
onum INT PRIMARY KEY,
amt DOUBLE,
odate DATE,
cnum INT,
snum INT,
FOREIGN KEY (snum)
REFERENCES salespeople(snum),
FOREIGN KEY (cnum)
REFERENCES customers(cnum)
);


INSERT orders (onum, amt, odate, cnum, snum) VALUES
 (3001, 18.69, "1990-03-10", 2008, 1007),
 (3003, 767.19, "1990-03-10", 2001, 1001),
 (3002, 1900.10, "1990-03-10", 2007, 1004),
 (3005, 5160.45, "1990-03-10", 2003, 1002),
 (3006, 1098.16, "1990-03-10", 2008, 1007),
 (3009, 1713.23, "1990-04-10", 2002, 1003),
 (3007, 75.75, "1990-04-10", 2004, 1002),
 (3008, 4723.00, "1990-05-10", 2006, 1001),
 (3010, 1309.95, "1990-06-10", 2004, 1002),
 (3011, 9891.88, "1990-06-10", 2006, 1001);
 
 SELECT *FROM orders;
 
 SELECT onum, amt, odate, cnum, snum
 FROM orders
 WHERE amt > 1000;
 
 /*
6. Напишите запрос который выбрал бы наименьшую сумму заказа.
(Из поля “amt” - сумма в таблице “Заказы” выбрать наименьшее значение)
 */
 
 SELECT amt FROM orders
 ORDER BY amt
 LIMIT 1;
 
 /*
7. Напишите запрос к таблице “Заказчики”, который может показать всех заказчиков,
 у которых рейтинг больше 100 и они находятся не в Риме.
 */
 
SELECT cnum, cname, city, rating, snum 
FROM customers
WHERE rating > 100 AND city NOT IN('Rome');

-- 1. Отсортируйте поле “зарплата” в порядке убывания и возрастания

CREATE TABLE worklist
(
id_worker INT PRIMARY KEY AUTO_INCREMENT,
name_worker VARCHAR(20),
surname_worker VARCHAR(20),
specialty VARCHAR(30),
seniority INT,
salary INT,
age INT
);

INSERT worklist (name_worker, surname_worker, specialty, seniority, salary, age) VALUES
 ("Вася", "Васькин", "начальник", 40, 100000, 60),
 ("Петя", "Петькин", "начальник", 8, 70000, 30),
 ("Катя", "Каткина", "инженер", 2, 70000, 25),
 ("Саша", "Сашкин", "инженер", 12, 50000, 35),
 ("Иван", "Иванов", "рабочий", 40, 30000, 59),
 ("Петр", "Петров", "рабочий", 20, 25000, 40),
 ("Сидор", "Сидоров", "рабочий", 10, 20000, 35),
 ("Антон", "Антонов", "рабочий", 8, 19000, 28),
 ("Юра", "Юркин", "рабочий", 5, 15000, 25),
 ("Максим", "Воронин", "рабочий", 2, 11000, 22),
 ("Юра", "Галкин", "рабочий", 3, 12000, 24),
 ("Люся", "Люськина", "уборщик", 10, 10000, 49);
 
SELECT * FROM worklist;

-- сортировка в порядке возрастания зарплаты
SELECT * FROM worklist
ORDER BY salary;

-- сортировка в порядке убывания зарплаты
SELECT * FROM worklist
ORDER BY salary DESC;

/* 2. Отсортируйте по возрастанию поле “Зарплата” 
и выведите 5 строк с наибольшей заработной платой (возможен подзапрос)
*/
SELECT * FROM
(SELECT * FROM worklist
ORDER BY salary DESC LIMIT 5
)  AS T  ORDER BY salary;

/*
3. Выполните группировку всех сотрудников по специальности , суммарная зарплата которых превышает 100000
*/

SELECT specialty,sum(salary) FROM worklist
GROUP BY specialty
HAVING sum(salary) > 100000;

