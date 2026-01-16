---
title: MCIT-596
---

- Lecture notes
	 - DONE Module 1: Introduction to Algorithms
		 - Counting steps 
			 - Define the basic step; in this course - one java instruction is a basic step

		 - Big Oh: upper bound
			 - f(n) is O(g(n)) means g(n) is an upper bound beyond some constant

		 - Big Omega: lower bound

		 - Bit Theta: both upper and lower bound

		 - Quiz
			 - Is the following statement true or false?

			 - If \textit{f(n) $\in$ O(g(n))}__f(n) __∈__ O(g(n))__ and \textit{g(n) $\in$ O(h(n))}__g(n) __∈__ O(h(n))__, then \textit{f(n) $\in$ O(h(n))}__f(n) __∈__ O(h(n))__.

			 - 1 point

			 - DONE **True**

			 - **False**

			 - 2.

			 - Question 2

			 - Is the following statement true or false?

			 - If {f(n) \in O(h(n))}__f__(__n__)∈__O__(__h__(__n__)) and {g(n) \in O(h(n))}__g__(__n__)∈__O__(__h__(__n__)), then {f(n) \in \Theta(g(n))}__f__(__n__)∈Θ(__g__(__n__)).

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 3.

			 - Question 3

			 - Is the following statement true or false?

			 - If {f(n) \in O(g(n))}__f__(__n__)∈__O__(__g__(__n__)), then {g(n) \in \Omega (f(n))}__g__(__n__)∈Ω(__f__(__n__)).

			 - 1 point

			 - DONE **True**

			 - **False**

			 - 4.

			 - Question 4

			 - Is the following statement true or false?

			 - The problem of finding the subinterval of maximum sum has a lower bound of {\Omega (n^3)}Ω(__n__3) because one of the algorithms for this problem takes {\Theta (n^3)}Θ(__n__3) time.

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 5.

			 - Question 5

			 - In the array below, what is the maximum sub-interval sum?

			 - [ -3, 2, -1, 3, -5, 4, -2, 7, -5, 3, -8, 3, 5, -3, 2 ][−3,2,−1,3,−5,4,−2,7,−5,3,−8,3,5,−3,2]

			 - 1 point

			 - **16**

			 - **7**

			 - DONE **9**

			 - **8**

			 - 6.

			 - Question 6

			 - Assuming the array is indexed starting at 0, what is the index of the starting point of the sub-interval of maximum sum?

			 - 1 point

			 - **7**

			 - DONE **5**

			 - **1**

			 - **11**

			 - 7.

			 - Question 7

			 - You have convinced the 7 dwarves— Sneezy, Sleepy, Happy, Doc, Grumpy, Dopey, and Bashful— to help with your holiday party. There are many tasks to be done, each by one person (or dwarf): sending invitations, picking up the food, setting up the food, buying flowers, greeting people at the door, and clean-up. You know which tasks each dwarf is capable of performing and you want to assign as many tasks as possible to each of them, since you have to do the rest yourself.

			 - Based on the interview with Prof. Khanna, how might we formulate and solve this problem in this course?

			 - 1 point

			 - **Consider every possible assignment of tasks to dwarves. Among the assignments where every dwarf is capable of performing the task assigned to him, take the one that maximizes the number of tasks performed.**
				 - WRONG

			 - **Make a graph with 7 nodes for the dwarves and 6 nodes for the tasks. An edge from a dwarf node to a task node indicates that that dwarf is capable of performing that task. Choose the largest set of edges you can that corresponds to an assignment of at most one task to each dwarf and at most one dwarf per task.**

			 - **Imagine that the assignment of tasks to dwarves could be arbitrary... so solve the above problem given any graph between the 7 dwarves and the 6 tasks.**
				 - WRONG

			 - **Allow the problem to be even more general. Assume any number of people and any number of tasks, and any graph indicating which people can perform which tasks. Find the best assignment of people to tasks in this graph.**

			 - **Given any set of people and tasks, give the first person a task they can do, then give the second person any remaining task they can do, and so on, until you run out of people or tasks.**

			 - **Honor Code Agreement**

			 - I understand that submitting work that isn’t my own may result in permanent failure of this course or deactivation of my Coursera account. Learn more about Coursera’s Honor Code

	 - DONE Module 2: Designing Algorithms Inductively and Recursively
		 - Solve the recursion by telescoping

		 - Quiz
			 - Is the following statement true or false?

			 - If {f(n) = 123n - 21}__f__(__n__)=123__n__−21 then {f(n) = \Theta (n)}__f__(__n__)=Θ(__n__).

			 - 1 point

			 - DONE **True**

			 - **False**

			 - 2.

			 - Question 2

			 - Is the following statement true or false?

			 - If {f(n) = 34n^2 + n + 1}__f__(__n__)=34__n__2+__n__+1 then {f(n) = \Omega(n)}__f__(__n__)=Ω(__n__).

			 - 1 point

			 - DONE **True**

			 - **False**

			 - 3.

			 - Question 3

			 - Is the following statement true or false?

			 - If {f(n) = 34n^2 + n + 1}__f__(__n__)=34__n__2+__n__+1 then {f(n) = O(n \log n)}__f__(__n__)=__O__(__n__log__n__).

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 4.

			 - Question 4

			 - The exact time complexity of the code below is:

			 - 1

			 - 2

			 - 3

			 - 4

			 - 5

			 - 6

			 - int k = 0;

			 - k = k + n / 2;

			 - }

			 - }

			 - 1 point

			 - **{\Theta (n2^n)}Θ(__n__2__n__)**

			 - DONE **{\Theta (n \log n)}Θ(__n__log__n__)**

			 - **{\Theta (n^2) }Θ(__n__2)**

			 - **{\Theta (n/2)}Θ(__n__/2)**

			 - **Impossible to determine from the information given.**

			 - 5.

			 - Question 5

			 - The input that causes insertion sort to take the most number of steps is:

			 - 1 point

			 - DONE **An array that is sorted in reverse order.**

			 - **A completely sorted array.**

			 - **An originally sorted array where the upper half has been exchanged with the lower half.**

			 - **An array where the elements at odd indices are all smaller than the elements at even indices.**

	 - DONE Module 3: Divide-and-Conquer Algorithms
		 - D&C method
			 - Divide: split into equal subproblems

			 - Conquer: solve subproblem

			 - Combine recursively

		 - Merge sort
			 - Divide: Break into two sorted arrays: 0 steps

			 - Conquer: sort 2 arrays of length n/2 each: <= 2*T(n/2) steps

			 - Combine: merge two sorted lists of length n/2 each <= n steps

			 - Solve recurrence relation

			 - Iterative method: two-way merge sort

			 - Recursive method: merge sort

		 - Binary search
			 - Sorted elements

			 - Compare to mid value and break list in half

			 - Recurrence: T(n) = T(n/2) + 1

		 - Recurrence relations 
			 - Decreasing functions - master theorem
				 - ![](https://firebasestorage.googleapis.com/v0/b/firescript-577a2.appspot.com/o/imgs%2Fapp%2Fnikhil-maddirala%2FGq20aLG5aK.png?alt=media&token=3e3391f4-6473-46f1-8ad6-aad41f84a2c4)

			 - Dividing functions - master theorem
				 - ![](https://firebasestorage.googleapis.com/v0/b/firescript-577a2.appspot.com/o/imgs%2Fapp%2Fnikhil-maddirala%2FrhdZYpRoUS.png?alt=media&token=233a60d8-4f41-42a8-a254-d38ccd85383f)

				 - EXAMPLES:

				 - ![](https://firebasestorage.googleapis.com/v0/b/firescript-577a2.appspot.com/o/imgs%2Fapp%2Fnikhil-maddirala%2FpTAsNv5eWY.png?alt=media&token=fb13815a-2d42-4004-adfa-d50dcf233bc1)

				 - ![](https://firebasestorage.googleapis.com/v0/b/firescript-577a2.appspot.com/o/imgs%2Fapp%2Fnikhil-maddirala%2F5ZXByqwPgS.png?alt=media&token=0c033311-c613-488f-84a5-306233107665)

				 - ![](https://firebasestorage.googleapis.com/v0/b/firescript-577a2.appspot.com/o/imgs%2Fapp%2Fnikhil-maddirala%2FZUO30d478K.png?alt=media&token=17cdaefa-7f5d-4f14-a593-02a893b09425)

				 - 

		 - Quiz
			 - The last digit of {3^{10}}310 is:

			 - 1 point

			 - **1**

			 - **3**

			 - **7**

			 - DONE **9**

			 - 2.

			 - Question 2

			 - Assuming {T(1) = 1}__T__(1)=1, the solution to the recurrence {T(n) = 3T(n/2) + n}__T__(__n__)=3__T__(__n__/2)+__n__ is:

			 - 1 point

			 - **{T(n) = \Theta(n)}__T__(__n__)=Θ(__n__)**

			 - DONE **{T(n) = \Theta (n^{\log_2 3})}__T__(__n__)=Θ(__n__log2​3)**

			 - **{T(n) = \Theta (n^{\log_3 2})}__T__(__n__)=Θ(__n__log3​2)**

			 - **{T(n) = \Theta (n \log n)}__T__(__n__)=Θ(__n__log__n__)**

			 - 3.

			 - Question 3

			 - Assuming {T(1) = 1}__T__(1)=1, the solution to the recurrence {T(n) = T(n/2) + \sqrt{3}{n}}__T__(__n__)=__T__(__n__/2)+3​__n__ is:

			 - 1 point

			 - **{T(n) = \Theta(\sqrt{3}{n})}__T__(__n__)=Θ(3​__n__)**

			 - DONE **{T(n) = \Theta (n)}__T__(__n__)=Θ(__n__)**

			 - **{T(n) = \Theta (n\log n)}__T__(__n__)=Θ(__n__log__n__)**

			 - **{T(n) = \Theta (\sqrt{n})}__T__(__n__)=Θ(__n__​)**

			 - 4.

			 - Question 4

			 - The recurrence relation for the following function (using {n}__n__ to denote the size of the array) is:

			 - 1

			 - 2

			 - 3

			 - 4

			 - 5

			 - 6

			 - 7

			 - 8

			 - 9

			 - 10

			 - 11

			 - 12

			 - 13

			 - 14

			 - 15

			 - 16

			 - int magic(int[] A) {

			 - }

			 - }

			 - 1 point

			 - **{T(n) = ( T(n/3) )^ 3}__T__(__n__)=(__T__(__n__/3))3**

			 - **{T(n) = T (n) + O(n)}__T__(__n__)=__T__(__n__)+__O__(__n__)**

			 - **{T(n) = 3 T(n/3) + O(n^3)}__T__(__n__)=3__T__(__n__/3)+__O__(__n__3)**

			 - DONE **{T(n) = 3 T(n/3) + O(n)}__T__(__n__)=3__T__(__n__/3)+__O__(__n__)**

			 - 5.

			 - Question 5

			 - For which of these recurrence relations can the Master Theorem be applied?

			 - 1 point

			 - **{T(n) = 2T(n/2) + 2^n}__T__(__n__)=2__T__(__n__/2)+2__n__**
				 - WRONG

			 - **{T(n) = T(n-2) + n + 1}__T__(__n__)=__T__(__n__−2)+__n__+1**

			 - **{T(n) = 2T(n/2) + \sin(n)}__T__(__n__)=2__T__(__n__/2)+sin(__n__)**

			 - DONE **None of the above**

			 - 6.

			 - Question 6

			 - In the chip testing problem, suppose you are given n≥3 chips with the promise that at most one chip among the n chips is bad.

			 - Then there is an algorithm that can always find a good chip using a single pairwise test?

			 - 1 point

			 - DONE **True**

			 - **False**

			 - **Honor Code Agreement**

			 - I understand that submitting work that isn’t my own may result in permanent failure of this course or deactivation of my Coursera account. Learn more about Coursera’s Honor Code

	 - DONE Module 4: Randomized Algorithms: Sorting and Selection 
		 - Quicksort
			 - Pivot around randomly chosen element

		 - Quickselect

		 - Deterministic linear time selection

		 - Quiz
			 - How long does it take to search for an element in an array?

			 - 1 point

			 - **{\Theta (1)}Θ(1)**

			 - **{\Theta (\log n)}Θ(log__n__)**

			 - DONE **{\Theta (n)}Θ(__n__)**

			 - **{\Theta (n^2)}Θ(__n__2)**

			 - 2.

			 - Question 2

			 - What is the recurrence relation for the binary search algorithm?

			 - 1 point

			 - DONE **{T(n) = T(n / 2) + 1}__T__(__n__)=__T__(__n__/2)+1**

			 - **{T(n) = T(n/2) + \log n}__T__(__n__)=__T__(__n__/2)+log__n__**

			 - **{T(n) = 2T(n/2) + 1}__T__(__n__)=2__T__(__n__/2)+1**

			 - **{T(n) = 2T(n/2) + n}__T__(__n__)=2__T__(__n__/2)+__n__**

			 - 3.

			 - Question 3

			 - What is the expected runtime of quicksort?

			 - 1 point

			 - **{\Theta(n)}Θ(__n__)**

			 - DONE **{\Theta(n\log n)}Θ(__n__log__n__)**

			 - **{\Theta(n^2)}Θ(__n__2)**

			 - **It can vary from run to run.**

			 - **It depends on the input.**

			 - 4.

			 - Question 4

			 - What is the worst-case runtime of quicksort?

			 - 1 point

			 - **{\Theta(n)}Θ(__n__)**

			 - **{\Theta(n\log n)}Θ(__n__log__n__)**

			 - DONE **{\Theta(n^2)}Θ(__n__2)**

			 - **It can vary from run to run.**

			 - **It depends on the input.**

			 - 5.

			 - Question 5

			 - What is the expected runtime of quickselect?

			 - 1 point

			 - DONE **{\Theta(n)}Θ(__n__)**

			 - **{\Theta(n\log n)}Θ(__n__log__n__)**

			 - **{\Theta(n^2)}Θ(__n__2)**

			 - **It can vary from run to run.**

			 - **It depends on the input.**

			 - 6.

			 - Question 6

			 - What is the worst-case runtime of quickselect?

			 - 1 point

			 - **{\Theta(n)}Θ(__n__)**

			 - **{\Theta(n\log n)}Θ(__n__log__n__)**

			 - DONE **{\Theta(n^2)}Θ(__n__2)**

			 - **It can vary from run to run.**

			 - **It depends on the input.**

			 - 7.

			 - Question 7

			 - How many potential answers are there in the general problem (i.e. not a specific instance of the problem) of sorting {n}__n__ distinct numbers?

			 - 1 point

			 - **{n}__n__**

			 - **{n \log n}__n__log__n__**

			 - **{n^2}__n__2**

			 - **{2^n}2__n__**

			 - DONE **{n!}__n__!**

			 - 8.

			 - Question 8

			 - How many possible answers are there for the problem of finding the largest and second largest in a list of {n}__n__ numbers?

			 - 1 point

			 - **{n}__n__**

			 - **{n \choose 2}(2__n__​)**

			 - **{n^2}__n__2**

			 - DONE **{n(n-1)}__n__(__n__−1)**

			 - 9.

			 - Question 9

			 - Suppose you roll three (fair, 6-sided) dice. What is the expected sum of the numbers on the dice?

			 - 1 point

			 - **8.5**

			 - **18**

			 - DONE **10.5**

			 - **12**

			 - **Honor Code Agreement**

			 - I understand that submitting work that isn’t my own may result in permanent failure of this course or deactivation of my Coursera account. Learn more about Coursera’s Honor Code

	 - DONE Module 5: Data Structures
		 - Min-Heap
			 - Heap is an almost complete binary tree that is complete up to the last level

			 - Insertion of elements: Insert at the right order (only one option); then percolate up.

			 - Extract min: Extract the root element and then percolate down (swap with smaller of the children).

			 - Heapify(array): Insert all elements, then order them by percolating down whenever possible; interestingly Heapify is only O(n) whereas inserting one by one is O(n*logn)

		 - Dictionary using BST
			 - Dictionary operations: insert, find

		 - Dictionary using Hashing
			 - Hash function divides entire domain of m items into n random buckets

			 - How many collisions? Birthday paradox
				 - P(24 people have distinct birthdays, i.e. zero collisions) = number of ways of choosing 24 distinct dates out of 365 / number of ways of choosing 24 dates out of 365 
					 - num = n*n-1*n-2*...n-r = n! / (n-r)!

					 - den = n^r

					 - P = num/den

				 - P(at least 1 collision) = 1-P(zero collisions)

				 - E(num collisions) = m^2/2n

		 - Quiz
			 - Is the following statement true or false?

			 - Because of the structure property it takes {O(\log n)}__O__(log__n__) time to search for an element in a heap.

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 2.

			 - Question 2

			 - Is the following statement true or false?

			 - In a balanced search tree we can find the minimum element in {O(\log n)}__O__(log__n__) time.

			 - 1 point

			 - DONE **True**

			 - **False**

			 - 3.

			 - Question 3

			 - Is the following statement true or false?

			 - Using hashing rather than balanced search trees gives us better worst-case running time for the Find operation.

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 4.

			 - Question 4

			 - Is the following statement true or false?

			 - A balanced search tree with {n}__n__ elements has height {\Theta(\log_2 n)}Θ(log2​__n__).

			 - 1 point

			 - DONE **True**

			 - **False**

			 - 5.

			 - Question 5

			 - Is the following statement true or false?

			 - Just like a heap, a binary search tree can also be efficiently implemented using an array.

			 - 1 point

			 - **True**
				 - WRONG

			 - DONE **False**

			 - 6.

			 - Question 6

			 - The running time to find the minimum element in a min-heap is:

			 - 1 point

			 - DONE **{O(1)}__O__(1)**

			 - **{O(\log n)}__O__(log__n__)**

			 - **{O(n)}__O__(__n__)**

			 - **{O(n \log n)}__O__(__n__log__n__)**

			 - 7.

			 - Question 7

			 - The running time for inserting an element in a min-heap is

			 - 1 point

			 - **{O(1)}__O__(1)**

			 - DONE **{O(\log n)}__O__(log__n__)**

			 - **{O(n)}__O__(__n__)**

			 - **{O(n \log n)}__O__(__n__log__n__)**

			 - 8.

			 - Question 8

			 - The (worst-case) runtime for searching for an element in a binary search tree is:

			 - 1 point

			 - **{O(1)}__O__(1)**

			 - **{O(\log n)}__O__(log__n__)**

			 - DONE **{O(n)}__O__(__n__)**

			 - **{O(n \log n)}__O__(__n__log__n__)**
				 - WRONG

			 - 9.

			 - Question 9

			 - Given a balanced binary search tree on {n}__n__ elements where the nodes do not store any extra information, and given an element {x}__x__, finding the rank of {x}__x__ among the {n}__n__ elements takes:

			 - 1 point

			 - **{O(1)}__O__(1)**

			 - **{O(\log n)}__O__(log__n__)**

			 - DONE **{O(n)}__O__(__n__)**

			 - **{O(n \log n)}__O__(__n__log__n__)**

			 - 10.

			 - Question 10

			 - If we store the correct auxiliary information at the nodes of a balanced binary search tree, we can implement the rank function in time:

			 - 1 point

			 - **{O(1)}__O__(1)**

			 - DONE **{O(\log n)}__O__(log__n__)**

			 - **{O(n)}__O__(__n__)**

			 - **{O(n \log n)}__O__(__n__log__n__)**

			 - 11.

			 - Question 11

			 - Suppose we implement a priority queue using a linked list.

			 - **INSERT** is done by simply adding new values to the head of the list; **FIND-MIN** is done by scanning through the list to find the minimum value; **EXTRACT-MIN** is done by using the **FIND-MIN** function and then deleting the value.

			 - The worst case runtimes of the most expensive operation among **INSERT**, **FIND-MIN**, **EXTRACT-MIN** is:

			 - 1 point

			 - **{O(1)}__O__(1)**

			 - **{O(\log n)}__O__(log__n__)**

			 - DONE **{O(n)}__O__(__n__)**

			 - **{O(n \log n)}__O__(__n__log__n__)**

			 - 12.

			 - Question 12

			 - Suppose we implement a priority queue using a balanced binary search tree (balanced BST).

			 - **INSERT** is done in the same way as it's done in a balanced BST; **FIND-MIN** is done by repeatedly traversing down the left branches starting from the root; **EXTRACT-MIN** is done by using the **FIND-MIN** function and then deleting the found value.

			 - The worst case runtime for the most expensive of the following operations: **INSERT**, **FIND-MIN**, **EXTRACT-MIN** is:

			 - 1 point

			 - **{O(1)}__O__(1)**

			 - DONE **{O(\log n)}__O__(log__n__)**

			 - **{O(n)}__O__(__n__)**

			 - **{O(n \log n)}__O__(__n__log__n__)**

			 - 13.

			 - Question 13

			 - Consider a dictionary implemented with a hash table that uses chaining (with linked lists) to resolve collisions where no duplicate keys are allowed in the dictionary.

			 - What is the worst case runtimes of the cheapest of these three operations: **INSERT, FIND**, and **DELETE**?

			 - 1 point

			 - **{O(1)}__O__(1)**

			 - **{O(\log n)}__O__(log__n__)**

			 - DONE **{O(n)}__O__(__n__)**

			 - **{O(n \log n)}__O__(__n__log__n__)**

			 - 14.

			 - Question 14

			 - What is the expected runtime of the most expensive of **INSERT, FIND**, and **DELETE **for a dictionary implemented with a hash table that uses chaining (with linked lists) to resolve collisions?

			 - No duplicate keys are allowed in the dictionary, and you can assume that the hash table has more cells than the number of elements being hashed.

			 - 1 point

			 - DONE **{O(1)}__O__(1)**

			 - **{O(\log n)}__O__(log__n__)**

			 - **{O(n)}__O__(__n__)**

			 - **{O(n \log n)}__O__(__n__log__n__)**

			 - **Honor Code Agreement**

			 - I understand that submitting work that isn’t my own may result in permanent failure of this course or deactivation of my Coursera account. Learn more about Coursera’s Honor Code

	 - Midterm study
		 - Recurrence relations

		 - Summing series

		 - Common algorithms
			 - Sorting algorithms
				 - Mergesort - nlogn

				 - Heapsort - nlogn

			 - Searching
				 - Binary search - logn

	 - DONE Module 6: Graphs and Graph Traversals
		 - Graph basics
			 - Path: Consecutive edges

			 - Cycle: Path that ends where it started

			 - Connected: two vertices are connected if there exists a path between them (equivalence relation)

			 - Connected components: equivalence classes of connected vertices

			 - Tree: connected, acyclic graph 

			 - Tree properties
				 - ...

		 - Graph representations
			 - Adjacency matrix
				 - Vertex x vertex matrix; 1 if edge exists, 0 otherwise

			 - Adjacency list
				 - Array of linked lists starting from each vertex; each linked list shows the neighbors of the starting vertex

			 - Complexity
				 - ![Image result for graph representations time complexity](https://i.stack.imgur.com/P8UiR.png)

		 - DFS: Depth first search
			 - Undirected graphs
				 - DFS(v) will visit all vertices in the connected component of v.

				 - DFS divides edges into tree edges (edges on which new vertices are discovered) and back edges (other edges)

				 - DFS(v) defines a tree rooted at v

			 - Directed graphs

		 - DFS applications: topological sort and SCC
			 - All DAGs have sources and sinks

			 - DFS can sort directed graph

			 - SCC: every vertex in SCC can reach every other vertex

			 - DFS can find SCC(G)

		 - BFS: Breadth first search
			 - BFS defines a BFS spanning tree: identifies levels of graph.

		 - Quiz
			 - Is the following statement true or false?

			 - When performing dfs on an undirected {n}__n__-node graph starting at node {v}__v__, the finish time of  {v}__v__ will be {2n}2__n__.

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 2.

			 - Question 2

			 - Is the following statement true or false?

			 - When performing dfs on a connected undirected {n}__n__-node graph starting at node {v}__v__, the finish time of  {v}__v__ will be {2n}2__n__.

			 - 1 point

			 - DONE **True**

			 - **False**

			 - 3.

			 - Question 3

			 - Is the following statement true or false?

			 - When performing dfs on a directed {n}__n__-node graph starting at node {v}__v__, the finish time of  {v}__v__ will be {2n}2__n__.

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 4.

			 - Question 4

			 - Is the following statement true or false?

			 - Suppose {G}__G__ is an {n}__n__-node directed graph such that for each pair of nodes {(x,y)}(__x__,__y__) there is either a path from {x}__x__ to {y}__y__ or a path from {y}__y__ to {x}__x__ or both. Then, when dfs is started at node {v}__v__, the finish time of {v}__v__ will be {2n}2__n__.

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 5.

			 - Question 5

			 - Is the following statement true or false?

			 - There are graphs for which bfs will be asymptotically faster than dfs.

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 6.

			 - Question 6

			 - Is the following statement true or false?

			 - Determining whether there is an edge between two vertices {u}__u__ and {v}__v__ can be performed faster in the adjacency list representation than in the adjacency matrix representation.

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 7.

			 - Question 7

			 - Is the following statement true or false?

			 - In any directed graph {G}__G__, if there exists a path from {u}__u__ to {v}__v__, then any DFS traversal will find that the discovery time of {v}__v__ is less than the finish time of {u}__u__.

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 8.

			 - Question 8

			 - Is the following statement true or false?

			 - BFS correctly computes shortest paths on weighted graphs when all edges have equal (positive) weights.

			 - 1 point

			 - DONE **True**

			 - **False**

			 - 9.

			 - Question 9

			 - BFS correctly computes shortest paths on weighted graphs that are trees.

			 - 1 point

			 - DONE **True**

			 - **False**

			 - 10.

			 - Question 10

			 - Run DFS on the directed graph {G = (V, E)}__G__=(__V__,__E__) starting at node {1}1 to compute the resulting discovery and finish times of each node. The discovery and finish times of node {1}1 should be {1}1 and {2n}2__n__, respectively.

			 - Whenever multiple arbitrary neighbors are considered to discover, select the neighbor with a lower label. Remember that time only advances when you discover a new node or finish the dfs at a node. If you discover a node {v}__v__ and there is nothing to discover from there, then the finish time of {v}__v__ is 1 more than the discovery time of {v}__v__.

			 - The discovery time of node {4}4 is:

			 - 1 point

			 - **2**

			 - DONE **3**

			 - **4**

			 - **7**

			 - 11.

			 - Question 11

			 - For the same example, the finish time of node {4}4 is:

			 - 1 point

			 - **4**

			 - **6**

			 - **7**

			 - DONE **8**

			 - 12.

			 - Question 12

			 - Consider all directed graphs with {k}__k__ strongly connected components.

			 - If you add one edge to such graphs, what is the maximum number of strongly connected components that (at least) one of the graphs can attain?

			 - 1 point

			 - **{k-2}__k__−2**

			 - **{k-1}__k__−1**

			 - DONE **{k}__k__**

			 - **{k+1}__k__+1**

			 - 13.

			 - Question 13

			 - Consider all directed graphs with {k}__k__ strongly connected components.

			 - If you add one edge to such graphs, what is the minimum number of strongly connected components that (at least) one of the graphs can attain?

			 - 1 point

			 - DONE **1**

			 - **2**

			 - **{k-2}__k__−2**

			 - **{k-1}__k__−1**

			 - **Honor Code Agreement**

			 - I understand that submitting work that isn’t my own may result in permanent failure of this course or deactivation of my Coursera account. Learn more about Coursera’s Honor Code

	 - DONE Module 7: Greedy Algorithms
		 - Optimization
			 - Constraints and objective function

			 - Feasible set: all solutions that satisfy constraint

			 - Approaches: brute force (try all feasible); heuristic (look for a good enough solution rather than optimal)

		 - Greedy algorithms
			 - Definition: make each decision without regard to next decisions in future

			 - Greedy algorithm example - select max number of jobs

			 - Proof
				 - Exchange argument: construct an alternate solution and exchange elements with the greedy solution, showing that greedy is better.

		 - Compression algorithms
			 - Huffman coding for symbols and frequencies

		 - Quiz
			 - Is the following statement true or false?

			 - For problems where correct greedy algorithms exist, there is only one optimal solution, and a greedy algorithm finds that optimal solution.

			 - 1 point

			 - **True **

			 - DONE **False**

			 - 2.

			 - Question 2

			 - Is the following statement true or false?

			 - To find the global minimum of any function {f(x)}__f__(__x__) defined on the integers, we can start at any value of {x}__x__ and move greedily in the direction where {f(x)}__f__(__x__) decreases.

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 3.

			 - Question 3

			 - Is the following statement true or false?

			 - To find the shortest path from vertex {u}__u__ to vertex {v}__v__ in a weighted, directed graph, start with the empty graph and repeatedly include the lightest edge that has not yet been included, until there is a path from {u}__u__ to {v}__v__.

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 4.

			 - Question 4

			 - Is the following statement true or false?

			 - To make change for a total amount of {n}__n__ with the fewest coins in some (not necessarily real) country's currency, find the maximum value coin that has value {y}__y__ less than or equal to {n}__n__, use this coin, and recursively make change for {n-y}__n__−__y__ with the fewest coins.

			 - 1 point

			 - DONE **True**

			 - **False**

			 - 5.

			 - Question 5

			 - Is the following statement true or false?

			 - The following encoding is a prefix code.
    A \rightarrow 0, B \rightarrow 11, C \rightarrow 110, D \rightarrow 111__A__→0,__B__→11,__C__→110,__D__→111

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 6.

			 - Question 6

			 - Is the following statement true or false?

			 - In any instance of the activity selection problem, if the duration of activity {a_1}__a__1​ properly contains the duration of activity {a_2}__a__2​, then there is always an optimal solution that does not contain {a_1}__a__1​.

			 - 1 point

			 - DONE **True**

			 - **False**

			 - 7.

			 - Question 7

			 - The durations of a set of activities are as follows:

			 - a_1: [0,5), a_2: [1,9), a_3: [4,6), a_4: [6, 11), a_5: [7,12), a_6: [8,13)__a__1​:[0,5),__a__2​:[1,9),__a__3​:[4,6),__a__4​:[6,11),__a__5​:[7,12),__a__6​:[8,13)

			 - Note the notation here, which is standard in mathematics. The square bracket at the beginning of an interval indicates that the beginning time is included in the interval, while the parenthesis at the end indicates that the endpoint is not included... So it is okay to schedule both {[4,6)}[4,6) and {[6,11)}[6,11) for example.

			 - The maximum number of activities that can be scheduled is:

			 - 1 point

			 - **1**

			 - DONE **2**

			 - **3**

			 - **4**

			 - 8.

			 - Question 8

			 - In the above example the set of activities that will be chosen by the greedy algorithm is:

			 - 1 point

			 - **{\{a_1 , a_6 \}}{__a__1​,__a__6​}**

			 - **{\{a_1 , a_3,a_5 \}}{__a__1​,__a__3​,__a__5​}**

			 - DONE **{\{a_1 , a_4 \}}{__a__1​,__a__4​}**

			 - **{\{a_3 , a_4 \}}{__a__3​,__a__4​}**

			 - 9.

			 - Question 9

			 - Construct the Huffman Coding tree for the following input frequencies:

			 - f(a) = .15, f(b) = .05, f(c) = .1, f(d) = .1, f(e) = .2, f(f) = .1, f(g) = .15, f(h) = .15__f__(__a__)=.15,__f__(__b__)=.05,__f__(__c__)=.1,__f__(__d__)=.1,__f__(__e__)=.2,__f__(__f__)=.1,__f__(__g__)=.15,__f__(__h__)=.15

			 - The height of the tree is:

			 - 1 point

			 - **2**

			 - **3**

			 - DONE **4**

			 - **5**

			 - 10.

			 - Question 10

			 - For the same example, the number of leaves at the next to deepest level is:

			 - 1 point

			 - **3**

			 - **4**

			 - DONE **5**

			 - **6**

			 - ****

	 - DONE Module 8: Spanning Trees and Shortest Paths—Greedy Algorithms
		 - Minimum Spanning Tree - MST
			 - Spanning tree = tree sub-graph with all vertices

			 - MST = spanning tree with min cost.

			 - Cut property: Every cut edge is in the MST

			 - Kruskal's algorithm
				 - Spec: Sort edges by increasing weight. Loop through edges and keep adding as long as it doesn't create cycles.

				 - Time: m*logn

				 - Time requires some tricks in data structures

			 - Prim's algorithm
				 - Build a Source set starting with some random vertex, and keep adding cheapest edge that connects source side to other side. Keep doing this until all vertices are added to the Source side S.

		 - Dijkstra's algorithm - shortest path

		 - Greedy algos don't always work! Then try dynamic programming. 

		 - Quiz
			 - Is the following statement true or false?

			 - Both Kruskal's algorithm and Prim's algorithm always produce optimal minimum spanning trees for graphs with negative edge weights.

			 - 1 point

			 - DONE **True**

			 - **False.**
				 - WRONG

			 - 2.

			 - Question 2

			 - Is the following statement true or false?

			 - Dijkstra’s algorithm always produces the correct output for graphs with negative weight edges.

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 3.

			 - Question 3

			 - Consider a graph, {G = (V, E)}__G__=(__V__,__E__), that is connected and has {n}__n__ vertices, {m}__m__ edges, and positive distinct edge weights. For a spanning tree {T}__T__ of {G}__G__, let {M(T)}__M__(__T__) be the weight of the maximum-weight edge in that tree.  Let {T^*}__T__∗ be a spanning tree that is {argmin_T M(T)}__a____r____g____m____i____n____T__​__M__(__T__). Note that {T^*}__T__∗ might not be unique, so let {OPT(T)}__O____P____T__(__T__) denote all spanning trees that are argmins of {M(T)}__M__(__T__).

			 - Is the following statement true or false?

			 - Any such {T^*}__T__∗ is a minimum spanning tree.

			 - 1 point

			 - **True**

			 - DONE **False.**

			 - 4.

			 - Question 4

			 - Is the following statement true or false?

			 - Using the same notation and set up as in the previous problem, any minimum spanning tree must be in {OPT(T)}__O____P____T__(__T__).

			 - 1 point

			 - DONE **True**

			 - **False**
				 - WRONG

			 - 5.

			 - Question 5

			 - Is the following statement true or false?

			 - Consider the problem of computing a maximum spanning tree, namely the spanning tree that maximizes the sum of edge costs. Prim's and Kruskal’s algorithms (with small modifications) work for this problem with the same running time.

			 - 1 point

			 - DONE **True**

			 - **False.**

			 - 6.

			 - Question 6

			 - Is the following statement true or false?

			 - If a directed graph has negative-weight edges but not negative-weight cycles, we can compute single-source shortest paths in the graph by first adding a large positive constant to each edge weight and then invoking Dijkstra's algorithm.

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 7.

			 - Question 7

			 - Is the following statement true or false?

			 - Consider a spanning tree {T}__T__ of graph {G}__G__, such that every edge {e \in T}__e__∈__T__ belongs to some MST of {G}__G__. Then, {T}__T__ itself is an MST.

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 8.

			 - Question 8

			 - Which of the following changes will not change the output edges from Kruskal's and Prim's algorithms? (Assume positive weights).

			 - Select all correct answers.

			 - 1 point

			 - DONE **Changing the weight of each edge from {w(e)}__w__(__e__) to {w(e) + 17}__w__(__e__)+17. **

			 - DONE **Changing the weight of each edge from {w(e)}__w__(__e__) to {17*w(e)}17∗__w__(__e__).**

			 - DONE **Changing the weight of each edge from {w(e)}__w__(__e__) to {w(e)*w(e)}__w__(__e__)∗__w__(__e__). **

			 - **None of the above.**

			 - 9.

			 - Question 9

			 - Let {G}__G__ be a weighted undirected graph and let {T}__T__ be an MST in {G}__G__.

			 - After which of these operations will {T}__T__ still be an MST?

			 - 1 point

			 - **Raising the weight of some edge {e}__e__ that is not in {T}__T__.**

			 - **Lowering the weight of some edge {e}__e__ that is not in {T}__T__.**

			 - **Raising the weight of some edge {e}__e__ that is in {T}__T__.**

			 - **Lowering the weight of some edge {e}__e__ that is in {T}__T__.**

			 - **Both options 2 and 4.**

			 - DONE **Both options 1 and 4.**

			 - **Both options 2 and 3.**

			 - 10.

			 - Question 10

			 - If we remove a constraint from a minimization problem, the value of the optimal solution will definitely...

			 - 1 point

			 - DONE **not increase**

			 - **not decrease**

			 - **increase**

			 - **decrease**

			 - 11.

			 - Question 11

			 - Given a weighted, undirected graph we can convert it to a directed graph by replacing each undirected edge {(u,v)}(__u__,__v__) with a pair of oppositely directed edges {(u,v)}(__u__,__v__) and {(v,u)}(__v__,__u__) of the same weight. With this understanding, we can see how Dijkstra's algorithm works on a weighted, undirected graph.

			 - Let {G}__G__ be such a graph with all distinct edge weights. Let {T}__T__ be a minimum spanning tree in {G}__G__. Let {S}__S__ be the shortest path tree produced by Dijkstra's algorithm with some source vertex {v}__v__.

			 - Identify the strongest relationship that is true between {T}__T__ and {S}__S__.

			 - 1 point

			 - **{T = S}__T__=__S__**

			 - **{w(T) = w(S)}__w__(__T__)=__w__(__S__)**

			 - **{w(T) \ge w(S)}__w__(__T__)≥__w__(__S__)**

			 - DONE **{w(T) \le w(S)}__w__(__T__)≤__w__(__S__)**

			 - ****

			 - I understand that submitting another’s work as my own can result in zero credit for this assignment. Repeated violations of the Coursera Honor Code may result in removal from this course or deactivation of my Coursera account. Learn more about Coursera’s Honor Code

	 - DONE Module 9: Dynamic Programming
		 - Key idea: notice overlapping sub-problems and solve those sub-problems only once; compute only the relevant sub-problems, not the full set of sub-problems

		 - Memo-ization: store values of previous calls so you don't have to call again; e.g. fib.

		 - Weighted activity selection

		 - Station placement

		 - Quiz
			 - Is the following statement true or false?

			 - In a top-down approach to dynamic programming, the larger subproblems are solved before the smaller ones.

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 2.

			 - Question 2

			 - Is the following statement true or false?

			 - Any problem that can be solved with a greedy algorithm can also be solved with dynamic programming.

			 - 1 point

			 - DONE **True**

			 - **False**

			 - 3.

			 - Question 3

			 - Is the following statement true or false?

			 - If a dynamic programming algorithm has {n}__n__ subproblems, then its running time is {O(n)}__O__(__n__).

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 4.

			 - Question 4

			 - Is the following statement true or false?

			 - Any problem whose solution is a simple combination of solutions to subproblems can be solved efficiently using dynamic programming.

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 5.

			 - Question 5

			 - Consider the station placement problem where town {t_i}__t____i__​ has a population {p_i}__p____i__​. Let {d_i}__d____i__​ be the distance from {t_i}__t____i__​ to its nearest station in a proposed solution. Then if we change the objective function and seek to minimize {\sum_{i} d_i p_i}∑__i__​__d____i__​__p____i__​, so as to minimize the __total__ distance traveled by all the people:

			 - 1 point

			 - **The resulting problem cannot be solved by dynamic programming.**

			 - **The resulting problem can be solved by dynamic programming and the station locations will always be at the midpoint of two towns.**

			 - **The resulting problem can be solved by a dynamic programming algorithm that has the same structure and the same running time as the algorithm given in the lecture video.**

			 - DONE **The resulting problem can be solved by a dynamic programming algorithm that has the same structure but a greater running time than the algorithm given in the lecture video.**

			 - 6.

			 - Question 6

			 - In the sequence alignment problem where one sequence has length {m}__m__ and the other has length {n}__n__, the cost of the best alignment is at most:

			 - (Give the tightest bound you can.)

			 - 1 point

			 - **{m+n}__m__+__n__**

			 - **{\min (m,n)}min(__m__,__n__)**

			 - DONE **{\max (m,n)}max(__m__,__n__)**

			 - **{mn}__m____n__**

			 - 7.

			 - Question 7

			 - If given two identical sequences each of length {n}__n__, the dynamic programming algorithm for sequence alignment will run in time:

			 - (Give the tightest bound you can.)

			 - 1 point

			 - **{O(1)}__O__(1)**

			 - **{O(n)}__O__(__n__)**

			 - **{O(n \log n)}__O__(__n__log__n__)**

			 - DONE **{O(n^2)}__O__(__n__2)**

			 - 8.

			 - Question 8

			 - While the dynamic programming algorithm in the lecture video only finds the cost of the best alignment, if we modify the algorithm to compute the actual alignment, the asymptotic running time will:

			 - (Give the tightest bound you can.)

			 - 1 point

			 - DONE **Remain the same**

			 - **Increase by a factor of {\min (m,n)}min(__m__,__n__)**

			 - **Increase by a factor of {\max (m,n)}max(__m__,__n__)**

			 - **Increase by a factor equal to the length of the alignment**

			 - 9.

			 - Question 9

			 - Comparing the weighted activity selection problem and the corresponding unweighted problem, where we simply erase the weights of the proposed activities:

			 - 1 point

			 - **The optimal solution for the weighted problem will always choose fewer activities than the optimal solution for the unweighted problem.**

			 - **The optimal solution for the weighted problem will always choose more activities than the optimal solution for the unweighted problem.**

			 - **The two problems will choose exactly the same number of activities.**

			 - DONE **The optimal solution for the weighted problem will always choose no more activities than the optimal solution for the unweighted problem.**

			 - ****

			 - I understand that submitting another’s work as my own can result in zero credit for this assignment. Repeated violations of the Coursera Honor Code may result in removal from this course or deactivation of my Coursera account. Learn more about Coursera’s Honor Code

	 - DONE Module 10: More Dynamic Programming
		 - Optimal static binary search trees

		 - Floyd-Warshall - All Pairs Shortest Path

		 - Bellman Ford Algorithm - Single Source Shortest Path - Dynamic Programming
			 - Perform relaxation n-1 times

			 - Fails if there is a negative cycle (because you can keep going on this cycle again and again to reduce total); but it finds negative cycles

		 - Complexity
			 - Graph algorithms complexity

			 - ![The time complexity of shortest path algorithms Algorithm Running time |  Download Table](https://www.researchgate.net/profile/Monireh-Mahmoudi/publication/282135528/figure/tbl1/AS:670437935706115@1536856268170/The-time-complexity-of-shortest-path-algorithms-Algorithm-Running-time.png)

		 - Segmented Regression
			 - Maybe single regression line is not the best fit... lines keep changing ; regularization penalty so that you don't use too many lines

			 - Need to find the number of segments K, break points indices, and the lines

			 - Solution: OPT(n) = min(i<j) OPT(i) + C + REG(i,n)
				 - OPT(j) = Optimal cost up to j

		 - Quiz
			 - Module 10 Quick Quiz
				 - **TOTAL POINTS 13**

				 - 1.

				 - Question 1

				 - Is the following statement true or false?

				 - Increasing the weight of every edge by 1 in a directed weighted graph does not change the shortest path between 2 given vertices.

				 - 1 point

				 - **True**

				 - DONE **False**

				 - 2.

				 - Question 2

				 - Is the following statement true or false?

				 - Doubling the weight of every edge in a directed weighted graph does not change the shortest path between 2 given vertices

				 - 1 point

				 - DONE **True**

				 - **False**

				 - 3.

				 - Question 3

				 - Is the following statement true or false?

				 - If a graph contains no negative-weight cycles, there exists an ordering of edges such that Bellman-Ford computes shortest paths by relaxing each edge at most once.

				 - 1 point

				 - DONE **True**

				 - **False**

				 - 4.

				 - Question 4

				 - Is the following statement true or false?

				 - Recall that the Floyd-Warshall algorithm involves three nested for loops, iterating through intermediate, start, and destination vertices, respectively. If we remove the middle loop and just use a fixed start vertex, then we obtain an {O(n^2}__O__(__n__2)-time single-source shortest-paths algorithm.

				 - 1 point

				 - **True**

				 - DONE **False**

				 - 5.

				 - Question 5

				 - Is the following statement true or false?

				 - Implementing Floyd-Warshall to loop through the intermediate, destination, and then start vertices instead of looping through intermediate, start, and then destination vertices still produces the correct all-pairs shortest paths.

				 - 1 point

				 - DONE **True**

				 - **False**

				 - 6.

				 - Question 6

				 - Is the following statement true or false?

				 - The union of a shortest path from {s}__s__ to {u}__u__ and a shortest path from {u}__u__ to {t}__t__ must also be a shortest path from {s}__s__ to {t}__t__.

				 - 1 point

				 - **True**

				 - DONE **False**

				 - 7.

				 - Question 7

				 - Is the following statement true or false?

				 - Let {G}__G__ be a weighted, directed, {n}__n__-node graph, and let {A}__A__ be its weighted adjacency matrix. Recall the modified matrix multiplication we defined for finding shortest paths, where instead of multiplying corresponding elements in a row and column, we add them, and instead of adding the results, we take the minimum of the results.

				 - Assume that for this question and the next, when we talk about a power of {A}__A__, we are using multiplication in this sense. If {G}__G__ has no negative weight cycles, then {A^{n-1} = A^{n}}__A____n__−1=__A____n__

				 - 1 point

				 - DONE **True**

				 - **False**

				 - 8.

				 - Question 8

				 - Is the following statement true or false?

				 - If for some matrix {A}__A__, {A^{n-1} = A^n}__A____n__−1=__A____n__, then {A^{n-1} = A^k,\ \forall k \geq n-1}__A____n__−1=__A____k__, ∀__k__≥__n__−1.

				 - 1 point

				 - DONE **True**

				 - **False**

				 - 9.

				 - Question 9

				 - Pick the asymptotically fastest option among the following options for computing all-pairs shortest paths in a directed graph with non-negative weights, when {m = \Theta(n^2)}__m__=Θ(__n__2).

				 - 1 point

				 - **Running Dijkstra's algorithm (binary-heap implementation) from every vertex.**

				 - **Modified matrix multiplication all-pairs shortest path.**

				 - DONE **Floyd-Warshall's all-pairs shortest path algorithm.**

				 - **Running Bellman-Ford's algorithm from every vertex.**

				 - 10.

				 - Question 10

				 - Pick the asymptotically fastest option among the following options for computing all-pairs shortest paths in a directed graph with non-negative weights, when {m = \Theta(n)}__m__=Θ(__n__)

				 - 1 point

				 - DONE **Running Dijkstra's algorithm (binary-heap implementation) from every vertex.**

				 - **Modified matrix multiplication all-pairs shortest path.**

				 - **Floyd-Warshall's all-pairs shortest path algorithm.**

				 - **Running Bellman-Ford's algorithm from every vertex.**
					 - WRONG

				 - 11.

				 - Question 11

				 - Which of the following statements are true for optimal static binary search trees? Check all that apply.

				 - 1 point

				 - **These trees are called static because the frequencies of the elements do not change.**

				 - **We can delete elements from an optimal static binary search tree without destroying optimality, but we cannot insert elements.**
					 - WRONG

				 - **An algorithm similar to Huffman Coding can be used to find optimal binary search trees by combining the two lowest frequency symbols and recursing on {n-1}__n__−1 symbols.**
					 - WRONG

				 - DONE **An optimal binary search tree need not be a balanced binary search tree.**

				 - 12.

				 - Question 12

				 - Which of the following statements are true for the standard regression problem defined in the lectures, where the goal is to find one line that has the best least squares fit with the given set of points.

				 - Check all answers that are true.

				 - 1 point

				 - DONE **For any set of points on the plane, there is always a solution to this problem.**

				 - **If there are at least two points in the input, the best line must pass through at least two of the given points.**

				 - **There can be several optimal regression lines for a given set of points.**

				 - DONE **Shifting the {y}__y__-value of each of the input points by 1, only changes the intercept of the regression line, and not its slope.**

				 - 13.

				 - Question 13

				 - Which of the following statements are true for the segmented regression problem for which we gave a dynamic programming algorithm?

				 - Check all answers that are true.

				 - 1 point

				 - DONE **For any set of points on the plane, and a $k \in \mathbb{Z}^+$, there is always a solution to this problem.**

				 - DONE **The best solution using at most $k$ segments, may actually end up using fewer than $k$ segments. Here, if two adjacent segments can be joined together to form a single segment, we consider them to be one segment.**

				 - **Every segment in the optimal solution must pass through at least two of the input points.**

				 - **The slopes of successive segments in the optimal solution must be increasing.**

				 - ****

				 - I understand that submitting another’s work as my own can result in zero credit for this assignment. Repeated violations of the Coursera Honor Code may result in removal from this course or deactivation of my Coursera account. Learn more about Coursera’s Honor Code

	 - Midterm 2 study
		 - 

	 - Module 11: Network Flows
		 - Smallest capacity s-t cut gives us max flow

		 - FF algo finds the min cut flow

		 - Quiz
			 - Is the following statement true or false?

			 - In any flow network, there is always some edge such that increasing its capacity increases the value of the maximum flow.

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 2.

			 - Question 2

			 - Is the following statement true or false?

			 - If all edges in the graph have integer capacities, then there is a maximum flow in which all flows on the edges are integers.

			 - 1 point

			 - DONE **True**

			 - **False**

			 - 3.

			 - Question 3

			 - Is the following statement true or false?

			 - If there is at least one edge with a fractional capacity, there is no maximum flow in which all flows on the edges are integers.

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 4.

			 - Question 4

			 - Is the following statement true or false?

			 - Let {G}__G__ be a flow network.  Let {(A,B)}(__A__,__B__) be a minimum {(s,t)}(__s__,__t__)-cut in {G}__G__. Let {H}__H__ be the weighted directed graph obtained by adding 1 to the weight of each edge in {G}__G__. Then {(A,B)}(__A__,__B__) must still be a minimum cut in {H}__H__.

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 5.

			 - Question 5

			 - Is the following statement true or false?

			 - The maximum matching problem in any graph can be solved by finding a maximum flow in a flow network easily constructed from the graph.

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 6.

			 - Question 6

			 - Is the following statement true or false?

			 - If all edges in a flow network have capacity 1, the Ford-Fulkerson method runs in time {O(mn)}__O__(__m____n__).

			 - 1 point

			 - DONE **True**

			 - **False**

			 - 7.

			 - Question 7

			 - Is the following statement true or false?

			 - If {G}__G__ is a bipartite graph with {n}__n__ nodes on each side, which has a perfect matching, then the flow network constructed from {G}__G__ has min-cut capacity {2n}2__n__.

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 8.

			 - Question 8

			 - Consider an algorithm that tries to find a maximum flow by repeatedly finding a path with leftover capacity in a given flow network {G}__G__, and augmenting the current flow by sending as much flow as it can along this path. The algorithm terminates when it cannot find any further paths from {s}__s__ to {t}__t__. Such an algorithm will...

			 - 1 point

			 - **Find the maximum flow, but may run for a number of iterations that depends on {|f|}∣__f__∣, the value of the maximum flow.**

			 - **Find the maximum flow efficiently, i.e., in a number of iterations that doesn't depend on {|f|}∣__f__∣.**

			 - DONE **Will not always find the maximum flow, but will run efficiently.**

			 - **Will not always find the maximum flow, and may run for a number of iterations that depends on {|f|}∣__f__∣.**
				 - WRONG

			 - 9.

			 - Question 9

			 - Select all the correct answers.

			 - Let {G =( (L \cup R), E)}__G__=((__L__∪__R__),__E__) be a bipartite graph and {N}__N__ be the corresponding flow network. If {u \in L}__u__∈__L__ and {v \in R}__v__∈__R__ and {(u,v) \in E}(__u__,__v__)∈__E__, and {(S,T)}(__S__,__T__) is a min-cut in {N}__N__, then:

			 - 1 point

			 - **{u}__u__ could be in {T}__T__ and {v}__v__ could be in {S}__S__.**

			 - DONE **{u}__u__ and {v}__v__ could be in {T}__T__.**

			 - DONE **{u}__u__ and {v}__v__ could be in {S}__S__.**

			 - **{u}__u__ could be in {S}__S__ and {v}__v__ could be in {T}__T__.**

			 - ****

			 - I understand that submitting another’s work as my own can result in zero credit for this assignment. Repeated violations of the Coursera Honor Code may result in removal from this course or deactivation of my Coursera account. Learn more about Coursera’s Honor Code

	 - Module 12: Introduction to Computational Complexity—P, NP, NP-Complete
		 - Efficiency classes
			 - Efficient = polynomial time; e.g. n^c

			 - Inefficient = more than polynomial time; eg. 2^n, n!

		 - Decision problems
			 - If we can solve the decision problem in p time then we can solve the search problem

		 - NP
			 - Verifier defn: A problem is in NP if there exists a verifier V such that for an yes-instance x of the problem, there is some y that V will accept. For a no-instance x of the problem, V will always reject.

			 - TM defn: non-deterministically guess all certificates and check.

		 - Reduction - maps yes to yes and no to no

		 - NP-hard - B is NP-hard if it is at least as hard as any NP problem

		 - NP-complete - NP-hard problems that are also in NP

		 - Quiz
			 - Is the following statement true or false?

			 - Polynomial time algorithms include algorithms  with running times {\Theta(n)}Θ(__n__) and {\Theta(n^3)}Θ(__n__3), but not ones with running time {\Theta (n \log n)}Θ(__n__log__n__) and {\Theta ( 2^n) }Θ(2__n__).

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 2.

			 - Question 2

			 - Is the following statement true or false?

			 - If a problem is in NP__N____P__, then its complement is in P__P__.

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 3.

			 - Question 3

			 - Is the following statement true or false?

			 - If there is a poly-time reduction from A__A__ to B__B__ and if A__A__ is not solvable in polynomial time, then neither is B__B__.

			 - 1 point

			 - DONE **True**

			 - **False**

			 - 4.

			 - Question 4

			 - Is the following statement true or false?

			 - A circuit of polynomial size can simulate the computation of a polynomial-time algorithm, but only on inputs of one particular length.

			 - 1 point

			 - DONE **True**

			 - **False**

			 - 5.

			 - Question 5

			 - Is the following statement true or false?

			 - For a circuit to efficiently simulate an algorithm, it needs to have feedback loops; in other words, the underlying graph of the circuit must be allowed to have cycles.

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 6.

			 - Question 6

			 - Is the following statement true or false?

			 - If P = NP__P__=__N____P__, all non-trivial problems in P__P__ are NP__N____P__-complete.

			 - 1 point

			 - DONE **True**

			 - **False**

			 - 7.

			 - Question 7

			 - Is the following statement true or false?

			 - If a problem in NP__N____P__ is not in P__P__, then it is NP__N____P__-complete.

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 8.

			 - Question 8

			 - Which of these relationship(s) between the classes P__P__ and NP__N____P__ is known to be true?

			 - 1 point

			 - **{P \subsetneq NP}__P__⊊__N____P__**

			 - DONE **{P \subseteq NP}__P__⊆__N____P__**

			 - **{P = NP}__P__=__N____P__**

			 - **{P \supseteq NP}__P__⊇__N____P__**

			 - 9.

			 - Question 9

			 - If P{\neq} NP__P__​=__N____P__, which of the following is true?

			 - 1 point

			 - **NP__N____P__-complete = NP=__N____P__**

			 - DONE **NP__N____P__-complete {\cap}∩ P = {\emptyset}∅**

			 - **NP__N____P__-hard = NP=__N____P__**

			 - **P = NP__P__=__N____P__-complete**

			 - 10.

			 - Question 10

			 - Suppose problem A__A__ reduces to problem B__B__ in polynomial time and B__B__ is shown to be NP__N____P__-complete. What does this say about A__A__?

			 - 1 point

			 - **A__A__ is also NP__N____P__-complete.**
				 - WRONG

			 - **A__A__ is in P__P__**

			 - **A__A__ is in NP__N____P__**

			 - **A is NP-hard**

			 - 11.

			 - Question 11

			 - Which statements below __characterize__ problems in NP__N____P__? This means that a problem is in NP__N____P__ if and only if it satisfies the statement.

			 - Select all such statements.

			 - 1 point

			 - **If A__A__ is a problem in NP__N____P__, then there is a polynomial-time verifier {V_A}__V____A__​ that takes two arguments. If {x}__x__ is an input to {A}__A__, then there exists some {y}__y__, where the length of {y}__y__ is polynomial in the length of {x}__x__, such that {V_A (x,y)}__V____A__​(__x__,__y__) gives the right answer - i.e., {V_A (x,y) =}__V____A__​(__x__,__y__)= YES if {x}__x__ is a YES-instance of {A}__A__ and {V_A (x,y) =}__V____A__​(__x__,__y__)= NO if {x}__x__ is a NO-instance.**

			 - DONE **If A is a problem in NP, then there is a polynomial-time verifier {V_A}__V____A__​ that takes two arguments. If {x}__x__ is a YES-instance of {A}__A__, then there exists some {y}__y__, where the length of {y}__y__ is polynomial in the length of {x}__x__, such that {V_A (x,y)}__V____A__​(__x__,__y__) = YES. If {x}__x__ is a NO-instance, {V_A (x,y) =}__V____A__​(__x__,__y__)= NO, for all {y}__y__.**

			 - **If A__A__ is a problem in NP__N____P__, then there is a polynomial-time verifier {V_A}__V____A__​ that takes two arguments. If {x}__x__ is a YES-instance of {A}__A__, then {V_A (x,y)}__V____A__​(__x__,__y__) accepts for all {y}__y__, and if {x}__x__ is a NO-instance, then {V_A (x,y)}__V____A__​(__x__,__y__) rejects for all {y}__y__.**

			 - **If A__A__ is a problem in NP__N____P__, then for each YES-instance {x}__x__, there is a polynomial-time verifier {V_{A,x}}__V____A__,__x__​ that takes two arguments. If {x}__x__ is a YES-instance of {A}__A__, then there exists some {y}__y__, where the length of {y}__y__ is polynomial in the length of {x}__x__, such that {V_{A,x} (x,y)}__V____A__,__x__​(__x__,__y__) = YES. If {x}__x__ is a NO-instance, {V_{A,x} (x,y) =}__V____A__,__x__​(__x__,__y__)= NO, for all {y}__y__.  **

			 - ****

			 - I understand that submitting another’s work as my own can result in zero credit for this assignment. Repeated violations of the Coursera Honor Code may result in removal from this course or deactivation of my Coursera account. Learn more about Coursera’s Honor Code

		 - Assignment
			 - v1
				 - Generate the residual graph after the ford-fulkerson algorithm is run. Consider each edge (source, sink) in the residual graph where source, sink ∈ V . If s is reachable from source and t is reachable from sink then (source, sink) is a bottleneck edge. Reachability property proves the correctness of the algorithm since if s and t are not reachable from source and sink it is not possible to augment more flow on the path from s to t and then increasing the capacity of edge (source, sink) doesn’t increase the maximum flow.

			 - v2
				 - You could still use the Ford-Fulkerson algorithm for this problem. Basically, finish iterating over the graph until you're left with the final (disconnected) residual graph. Now, there will be a set of nodes which are reachable from the source S. And there will be a separate set of nodes which are reachable from the sink T.

				 - Any edges that connect the first set of nodes to the second set of nodes, will be bottleneck edges.

				 - Why is this correct? Just imagine if you increased the capacity of one of these edges, then the final residual graph you got in step 1 would no longer be the final residual graph, and there would still be one more possible iteration of the ford-fulkerson algorithm.

	 - Module 13: Cook-Levin Theorem and First NP-Complete Problems
		 - Cook Levin theorem: C-SAT and SAT is NP-complete
			 - All problems in NP reduce to C-SAT - therefore C-SAT is NP complete

			 - C-SAT reduces to SAT

			 - All problems in NP reduce to SAT

		 - Independent set is NP complete
			 - 3-SAT reduces to Independent Set 

		 - DNF and CNF
			 - CNF: standard form of propositional logic statements 

		 - Quiz
			 - Is the following statement true or false? Assume P {\ne} NP__P__​=__N____P__.

			 - HAM CYCLE  {\leq_P}≤__P__​  3-SAT

			 - 1 point

			 - DONE **True**

			 - **False**

			 - 2.

			 - Question 2

			 - Is the following statement true or false? Assume P {\ne} NP__P__​=__N____P__.

			 - A formula in Conjunctive Normal Form (CNF) is an AND, OR and NOT of clauses.

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 3.

			 - Question 3

			 - Is the following statement true or false? Assume P {\ne} NP__P__​=__N____P__.

			 - A decision problem one could associate with the sorting problem is the following: SORT-ARRAY takes as input an array {A}__A__ and two indices {i \le j}__i__≤__j__ and returns YES, if the entries in {A[i], A[i+1], \ldots , A[j]}__A__[__i__],__A__[__i__+1],…,__A__[__j__] form a sorted list, and NO otherwise.

			 - With this definition, SORT-ARRAY {\leq_ P}≤__P__​ INDEPENDENT-SET.

			 - 1 point

			 - DONE **True**

			 - **False**

			 - 4.

			 - Question 4

			 - Is the following statement true or false? Assume P {\ne} NP__P__​=__N____P__.

			 - INDEPENDENT-SET  {\leq_ P}≤__P__​  SORT-ARRAY

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 5.

			 - Question 5

			 - Is the following statement true or false? Assume P {\ne} NP__P__​=__N____P__.

			 - The composition of two polynomials is always a polynomial.

			 - 1 point

			 - DONE **True**

			 - **False**

			 - 6.

			 - Question 6

			 - Is the following statement true or false? Assume P {\ne} NP__P__​=__N____P__.

			 - If for a problem L__L__, there is another problem L'__L__′ which satisfies:  L'__L__′ {\leq_p}≤__p__​ L__L__ and L'__L__′ is in NP__N____P__-complete, then L__L__ is NP__N____P__ complete.

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 7.

			 - Question 7

			 - Is the following statement true or false? Assume P {\ne} NP__P__​=__N____P__.

			 - The circuit satisfiability problem without NOT gates, i.e., where the only gates used are AND and OR gates is NP__N____P__-complete.

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 8.

			 - Question 8

			 - Is the following statement true or false? Assume P {\ne} NP__P__​=__N____P__.

			 - 3-SAT  {\leq_P}≤__P__​  4-SAT

			 - 1 point

			 - DONE **True**

			 - **False**

			 - 9.

			 - Question 9

			 - Is the following statement true or false? Assume P {\ne} NP__P__​=__N____P__.

			 - 3-SAT  {\leq_P}≤__P__​  2-SAT

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 10.

			 - Question 10

			 - Is the following statement true or false? Assume P {\ne} NP__P__​=__N____P__.

			 - If a problem in NP__N____P__ reduces to 3-SAT, then it is NP__N____P__-complete.

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 11.

			 - Question 11

			 - Suppose {f}__f__ is a polynomial time reduction from problem A to problem B. Select all the statements that are true about {f}__f__.

			 - (Recall the definitions of terms like "domain", "codomain", and "range" from CIT 592.)

			 - 1 point

			 - **{f}__f__ is one-to-one.**

			 - DONE **The domain of {f}__f__ is all instances of A.**

			 - DONE **The codomain  of {f}__f__ is the set of all instances of B.**

			 - **The range of {f}__f__ is the set of all instances of B.**

			 - **{f}__f__ is one-to-one on the YES-instances of A.**

			 - **For any YES-instance {y}__y__ of B, there is an instance {x}__x__ of A such that {f(x) = y}__f__(__x__)=__y__.**

			 - **{f}__f__ maps YES-instances of A to YES-instances of B, but NO-instances of A can map to any instance of B.**

			 - **{f^{-1}}__f__−1 is a function mapping instances of B to instances of A.**

			 - ****

			 - I understand that submitting another’s work as my own can result in zero credit for this assignment. Repeated violations of the Coursera Honor Code may result in removal from this course or deactivation of my Coursera account. Learn more about Coursera’s Honor Code

	 - Module 14: Reductions to Show NP-Completeness; Wrapping Up
		 - Quiz
			 - Is the following statement true or false?

			 - The problem of 2-coloring reduces to the problem of 3-coloring.

			 - __Note: __the problem of 2-coloring is known to be in P__P__.

			 - 1 point

			 - DONE **True**

			 - **False**

			 - 2.

			 - Question 2

			 - Is the following statement true or false?

			 - The problem of 3-coloring is known to reduce to the problem of 2-coloring.

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 3.

			 - Question 3

			 - Is the following statement true or false?

			 - Say that a decision problem is considered non-trivial if we know of at least 1 input for which the answer is YES, and at least 1 input for which the answer is NO.

			 - Any problem in P__P__ can be reduced to any non-trivial problem in NP__N____P__.

			 - 1 point

			 - DONE **True**

			 - **False**

			 - 4.

			 - Question 4

			 - Is the following statement true or false?

			 - If we can approximate the vertex cover problem to within a factor of {(1 + \frac{1}{n^2})}(1+__n__21​) then P = NP__P__=__N____P__.

			 - 1 point

			 - DONE **True**

			 - **False**

			 - 5.

			 - Question 5

			 - Is the following statement true or false?

			 - Recall that if an {n}__n__-vertex graph has a vertex cover of size {k}__k__, then it has an independent set of size {n-k}__n__−__k__ and __vice versa__.

			 - An efficient approximation algorithm for vertex cover that approximates the size of a minimum vertex cover to within a factor of {c}__c__, implies an efficient approximation algorithm for independent set that also approximates the size of a maximum independent set to within a factor of {c}__c__.

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 6.

			 - Question 6

			 - Is the following statement true or false?

			 - Being able to solve the subset sum decision problem in polynomial time allows us to find a subset
 that sums to the target in polynomial time, if such a subset exists.

			 - 1 point

			 - DONE **True**

			 - **False**

			 - 7.

			 - Question 7

			 - Which of the following statements about polynomial-time reductions is correct?

			 - 1 point

			 - **To reduce problem A__A__ to problem B__B__, first determine if the given instance of A__A__ is a YES-instance or a NO-instance and then map it to the same type of instance of problem B__B__.**

			 - **A reduction from problem A__A__ to problem B__B__ can be modified to give a reduction in the other direction -- from problem B__B__ to problem A__A__.**

			 - **If two problems A__A__ and B__B__ reduce to the same problem C__C__, then A__A__ and B__B__ are of equivalent difficulty.**

			 - **If a problem A__A__ reduces to two different problems B__B__ and C__C__, then B__B__ and C__C__ are of equivalent difficulty.**

			 - DONE **None of the above.**

			 - 8.

			 - Question 8

			 - Which of the following is a YES-instance of subset sum?

			 - In each case, the set of numbers is listed first, followed by the target.

			 - 1 point

			 - **{\{7, 13, 17, 23, 29, 31 \} , \ 64}{7,13,17,23,29,31}, 64.**

			 - DONE **{\{ 1, 2, 4, 8, 16, 32, 64 \}, \ 107}{1,2,4,8,16,32,64}, 107.**

			 - **{\{ 20, 21, 22, 23, 24, 25, 26, 27, 28, 29\}, \ 61}{20,21,22,23,24,25,26,27,28,29}, 61.**

			 - 9.

			 - Question 9

			 - A __dominating __set in a graph {G = (V,E)}__G__=(__V__,__E__) is a set of vertices {S}__S__ such that for every vertex {v \in V}__v__∈__V__, either {v \in S}__v__∈__S__ or at least one neighbor {u}__u__ of {v}__v__ is in {S}__S__.

			 - The definition sounds a lot like the definition of vertex cover. Which of the following statements relating the two are true?

			 - 1 point

			 - **In any graph the size of the minimum vertex cover is at most the size of the minimum dominating set.**

			 - **In any graph the size of the minimum dominating set is at most the size of the minimum vertex cover.**

			 - DONE **There are graphs in which the size of the minimum dominating set is 1, but the size of the minimum vertex cover is {\Omega (n)}Ω(__n__).**

			 - DONE **There are graphs in which the size of the minimum vertex cover is 0, but the size of the minimum dominating set is {\Omega (n)}Ω(__n__).**

			 - ****

			 - I understand that submitting another’s work as my own can result in zero credit for this assignment. Repeated violations of the Coursera Honor Code may result in removal from this course or deactivation of my Coursera account. Learn more about Coursera’s Honor Code

	 - Module 15: Final Exam

- Assignments
	 - DONE M1 Quiz, due [[January 17th, 2021]] #2021-W2

	 - DONE M2 Quiz, due [[January 24th, 2021]] #2021-W3

	 - DONE M1-2 HW, due [[January 26th, 2021]]  #2021-W4
		 - 1 
			 - c = k

			 - d

			 - a

		 - 1 - tracker
			 - DONE a

			 - b

			 - DONE c

			 - DONE d

			 - e

			 - f

			 - g

			 - h

			 - i

			 - j

			 - DONE k

			 - l

			 - m

			 - n

			 - o

			 - p

			 - q

		 - 1 - graph: https://gist.github.com/nikhilmaddirala/b375b4b23138190932c9cafd2c506248

	 - DONE M3 Quiz, due [[January 31st, 2021]] #2021-W4

	 - DONE Schedule Midterm 1 #2021-W5

	 - DONE M4 Quiz, due [[February 7th, 2021]] #2021-W5

	 - DONE M3-4 HW, due [[February 9th, 2021]] #2021-W4 #2021-W5
		 - 3
			 - Let T = t1, t2, t3, ... 

			 - Let X = x1, x2, x3 ...

			 - Let Y = y1, y2, y3 ...

			 - Let X' = sorted X

			 - Let Y' = sorted Y

			 - Brute force method
				 - Loop X'
					 - For all elements to the right of X'[i]
						 - Check if dominated

			 - Alt 1
				 - Let T_X = T sorted in descending X order (n logn)

				 - Let U = Undominated set

				 - Set High = T_X[0] and add high to U

				 - Loop T_X index i:
					 - If T_X[i] < High: continue

					 - else: 

		 - 4
			 - Negative binomial distribution?

		 - 5
			 - Let R = empty array of size r

			 - BF method
				 - Sort first r elements

				 - For every next element, add to list (if it's smaller than the largest R) then sort again

	 - DONE M5 Quiz, due [[February 14th, 2021]] #2021-W6

	 - DONE M6 Quiz, due [[February 21st, 2021]] #2021-W7

	 - DONE M5-6 HW, due [[February 24th, 2021]] #2021-W7 #2021-W8

	 - DONE M7 Quiz, due [[February 28th, 2021]] #2021-W8

	 - DONE Schedule Midterm 2 #2021-W12
		 - Monday of Austin week

	 - DONE M8 Quiz, due [[March 7th, 2021]] #2021-W9 #2021-W10

	 - DONE M7-8 HW, due [[March 16th, 2021]] #2021-W9 #2021-W10

	 - DONE M9 Quiz, due [[March 21st, 2021]] #2021-W11

	 - DONE M10 Quiz, due [[March 28th, 2021]] #2021-W12

	 - DONE M9-10 HW, due [[March 31st, 2021]] #2021-W14

	 - DONE Schedule Final #2021-W15

	 - DONE M11 Quiz, due [[April 4th, 2021]] but do one day late on #[[April 5th, 2021]] #2021-W14

	 - DONE M12 Quiz, due [[April 11th, 2021]] #2021-W14

	 - DONE M11-12 HW, due [[April 13th, 2021]] #2021-W14 #2021-W15

	 - DONE M13 Quiz, due [[April 18th, 2021]] #2021-W16

	 - DONE M14 Quiz, due [[April 25th, 2021]] #2021-W16

	 - DONE M13-14 HW, due [[April 27th, 2021]] #2021-W16 #2021-W17

- References
	 - Abdul Bari YouTube Algorithms course
