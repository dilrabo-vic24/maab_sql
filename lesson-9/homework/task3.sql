/*
### Task 3
Find Fibonacci numbers up to $N$.

Expected output for $N = 10$:

n	|Fibonacci_Number
----|----------------
1	|1
2	|1
3	|2
4	|3
5	|5
6	|8
7	|13
8	|21
9	|34
10	|55
*/

;with fibonachi as (
    select 1 as n, 1 as Fibonacci_Number, 0 as Prev 
    union ALL
    select n + 1, Fibonacci_Number+ Prev,  Fibonacci_Number
    from fibonachi
    where n < 10
)
select 
    n,
    Fibonacci_Number
from fibonachi