# Advent Of Code 2022
#### Languages used: Haskell, C++.
## Day 1
Day one was pretty straightforward, i had some troubles reading the input file since it was my first time doing IO operations in Haskell. I learned to use <em> SplitOn</em> function from package Data.List.Split and to cast types using <em>read</em> function. I used list comprehension, some basic list functions like <em>take</em>, <em>initi</em>, <em>sum</em>, <em>maximum</em>, etc... I also figured out how to sort lists.

## Day 2
Day 2 was a bit challeging than day 1, at first, i tried to solve the problem using few larges lines, but i realized i was so much easier to reason about the solution if i write several functions, i learned to explicit the type of a Function and to utilise <strong>Guards</strong> with the <em>otherwise</em> clause.

## Day 3
Day 3 was easy but i struggled with <strong>Maybe</strong> types since i utilsed the function <em>elemIndexd</em> to search an element in a list. This function return a Maybe type, a Just (the index of the element) or a Nothing value if it not exists in the list. I did'nt knew how to get the just value so i learned to use <em>fromMaybe</em> function. This was my first approach to Maybe Monad. I also learned this day to use predicates in list comprehension.

## Day 4
