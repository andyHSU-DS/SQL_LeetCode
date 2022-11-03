# Question 1
Employee 表：
+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id 是这个表的主键。
表的每一行包含员工的工资信息。

编写一个 SQL 查询，获取并返回 Employee 表中第二高的薪水 。
如果不存在第二高的薪水，查询应该返回 null 。

# Ans 1
SELECT ifNull(
    (SELECT DISTINCT salary FROM Employee
    ORDER BY salary DESC 
    LIMIT 1,1), null
) AS SecondHighestSalary;

#########################################################################################################

# Question 2
表：Logs

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
id 是这个表的主键。
 

编写一个 SQL 查询，查找所有至少连续出现三次的数字。

返回的结果表中的数据可以按 任意顺序 排列。

# Ans2
WITH S AS(
    SELECT Num, LAG(Num,1) OVER(ORDER BY Id) LAG, LEAD(Num,1) OVER(ORDER BY Id) LEAD,
        CASE WHEN Num = LAG(Num,1) OVER(ORDER BY Id) AND Num = LEAD(Num,1) OVER(ORDER BY Id) THEN 1 ELSE 0 END AS Same
    FROM Logs
)

SELECT DISTINCT(Num) AS ConsecutiveNums FROM S
WHERE Same = 1;

#########################################################################################################

# Question 3
表: Scores

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| score       | decimal |
+-------------+---------+
Id是该表的主键。
该表的每一行都包含了一场比赛的分数。Score是一个有两位小数点的浮点值。
 

编写 SQL 查询对分数进行排序。排名按以下规则计算:

分数应按从高到低排列。
如果两个分数相等，那么两个分数的排名应该相同。
在排名相同的分数后，排名数应该是下一个连续的整数。换句话说，排名之间不应该有空缺的数字。
按 score 降序返回结果表。

# Ans 3
SELECT score, Dense_RANK() OVER(ORDER BY score DESC) AS rank
FROM Scores;

#########################################################################################################

# Question 4

Employee 表：
+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id 是这个表的主键。
表的每一行包含员工的工资信息。
 

编写一个 SQL 查询，获取并返回 Employee 表中第二高的薪水 。如果不存在第二高的薪水，查询应该返回 null 。

# Ans 4
SELECT ifNull(
    (SELECT DISTINCT salary FROM Employee
    ORDER BY salary DESC 
    LIMIT 1,1), null
) AS SecondHighestSalary;

#########################################################################################################

# Question 5

表： Employee

+--------------+---------+
| 列名          | 类型    |
+--------------+---------+
| id           | int     |
| name         | varchar |
| salary       | int     |
| departmentId | int     |
+--------------+---------+
id是此表的主键列。
departmentId是Department表中ID的外键。
此表的每一行都表示员工的ID、姓名和工资。它还包含他们所在部门的ID。
 

表： Department

+-------------+---------+
| 列名         | 类型    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id是此表的主键列。
此表的每一行都表示一个部门的ID及其名称。
 

编写SQL查询以查找每个部门中薪资最高的员工。
按 任意顺序 返回结果表。

# Ans 5
WITH X AS (
    SELECT D.name AS Department, E.name AS Employee, E.salary AS Salary 
    FROM Employee AS E LEFT JOIN Department AS D ON E.departmentId = D.id 
)

SELECT * FROM X AS xx
    WHERE Salary = (SELECT MAX(Salary) FROM X WHERE Department = xx.Department);

#########################################################################################################

# Question 6

表： Weather

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id 是这个表的主键
该表包含特定日期的温度信息
 

编写一个 SQL 查询，来查找与之前（昨天的）日期相比温度更高的所有日期的 id 。

返回结果 不要求顺序 。

# Ans 6
SELECT w1.id FROM Weather AS w1 
JOIN Weather AS w2
ON w1.Temperature > w2.Temperature AND dateDiff(d, w1.recordDate, w2.recordDate) = -1;;



