create table letters
(letter char(1));

insert into letters
values ('a'), ('a'), ('a'), 
  ('b'), ('c'), ('d'), ('e'), ('f');


SELECT letter
FROM letters
ORDER BY 
  CASE WHEN letter = 'b' THEN 0 ELSE 1 END,
  letters;

SELECT letter
FROM letters
ORDER BY 
  CASE WHEN letter = 'b' THEN 1 ELSE 0 END,
  letter;


SELECT letter
FROM letters
ORDER BY 
  CASE 
    WHEN letter = 'b' THEN 2 
    WHEN letter < 'b' THEN  CASE WHEN letter = 'a' THEN 0 ELSE 1 END
    ELSE ASCII(letter)
  END,
  letter;

