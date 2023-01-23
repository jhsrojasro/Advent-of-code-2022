# Advent Of Code 2022
#### Languages used: Haskell, C++.
## Day 1
Day one was pretty straightforward, i had some troubles reading the input file since it was my first time doing IO operations in Haskell. I learned to use <em> SplitOn</em> function from package Data.List.Split and to cast types using <em>read</em> function. I used list comprehension, some basic list functions like <em>take</em>, <em>initi</em>, <em>sum</em>, <em>maximum</em>, etc... I also figured out how to sort lists.

## Day 2
Day 2 was a bit challeging than day 1, at first, i tried to solve the problem using few larges lines, but i realized i was so much easier to reason about the solution if i write several functions, i learned to explicit the type of a Function and to utilise <strong>Guards</strong> with the <em>otherwise</em> clause.

## Day 3
Day 3 was easy but i struggled with <strong>Maybe</strong> types since i utilsed the function <em>elemIndexd</em> to search an element in a list. This function return a Maybe type, a Just (the index of the element) or a Nothing value if it not exists in the list. I did'nt knew how to get the just value so i learned to use <em>fromMaybe</em> function. This was my first approach to Maybe Monad. I also learned this day to use predicates in list comprehension.

## Day 4
Day 4 brought me to learn the where clause. Reading the input was a bit tricky.

## Day 5
Day 5 made me use the <strong>let</strong> statement, before i was able to read the input in one line of code. But due to the strange form of the stacks, i had to do it in several lines. The casting of integers, since i was using maps for spliting each string was also difficult. I used a lot the <em>!!</em> operator for accesing elements of lists.

## Day 6
Day 6 was easy, it was the first i got forced to use a complex Data Structure, i learned to use <em>Set</em> and import packages as <em>qualified</em> to avoid ambiguity. Also used ranges for the first time this day.

## Day 7
<p>
Definitively the first challenge, it was so difficult beacuso i had the idea to solve the proble immediately but i did not knew how to implement it in Haskell. I had do a lot of reading of the tutorial i was following. I learned a lot: 

<ul>
    <li><em>Type</em> to define a new type</li>
    <li><em>Data</em> to define a new algebraic data type</li>
    <li><em>Constructor</em> for this algebraic data types</li>
    <li><em>words</em> and <em>lines</em> to replace the splitOn "\n"/" "i was using all the time before</li>
    <li><em>Map</em> to use Hash Maps </li>
    <li>The <em>$</em> operator to pipeline output of one function to other </li>
    <li>The ternary operator in Haskell</li>
    <li><em>Type</em> to define a new type</li>
    <li>A lot of String procesing and new String functions</li>
    <li>Lambda functions</li>
</ul></p>
<p> With all this i was able to generate a Tree representing the file system where each node was identified by the complete path.</p>

## Day 8
The main takeaway from this day was the use of <em>Matrix</em> and <em>Vector</em> packages.

## Day 9
This day teached me to start by implementing the basic functions and build the complex ones on top of them. I learned to use lambda functions to deconstruct arrays too.

## Day 10
This was the first time i care about pattern matching, also, i used a lot where definitions to simplify the expressions.

## Day 14
I managed to solve the first part using Sets of coordinates for each sand unit. It was challenging reading the input and creating the rock structures. Then i made a recursive function to process sand units until the end.

## Day 15
I solved the first part, not a really god algorithm, it takes around 10 seconds to find the answer. The input was difficult to read. I 
learned to use update functions with <em>fold</em>.

## Day 17
I solved the first part using C++, a pretty strighforward implementation problem, i implemented each movement to the sides and down for each figure. Part two requires a O(1) or O(log) algorithm, it is necessary to find and pattern to predict the final result but i have not found it yet.

## Day 18
First part is trivial using a Set, second part was the real challenge, i took the limits of each axe (x,y,z) and iterated the empty blocks in this bounded space inserting them in a Set. I simulated a recursive function with a stack to find Air Pockets and count the number of surfaces to discount. If i found an Air Pocket i erase all the blocks of this pocker from the set of air blocks to process.