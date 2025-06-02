/*

### Task 2

Find Factorials up to $N$.

Expected output for $N = 10$:

Num	|Factorial
----|---------
1	|1
2	|2
3	|6
4	|24
5	|120
6	|720
7	|5040
8	|40320
9	|362880
10	|3628800

*/

declare @n Int = 10

;with factorialCte as (
    Select 1 as number, 1 as factorial
    UNION ALL
    SELECT number + 1, (number + 1)*factorial from factorialCte
    WHERE number < @n 
)
SELECT * from factorialCte

SELECT 1 as number 
union all
SELECT 2 as number
union ALL
select 1*2*3 as number 
union ALL
SELECT 1*2*3*4 as number 