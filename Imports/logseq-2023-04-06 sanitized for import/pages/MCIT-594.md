---
title: MCIT-594
---

- Class notes
	 - DONE Module 1: Introduction to Data Structures
		 - Lesson 1: Software Quality
			 - High quality software is measured externally (how well does the program run / execute) and internally (how readable and maintainable is the code).

		 - Lesson 2: Java/JUnit Refresher
			 - Goal of testing is to find bugs.

			 - Testing is not perfect and may have false positives and false negatives.

			 - Principles of good tests: cover the specification, explore the input and output spaces, try to force exceptions, check for common errors.

		 - Lesson 3: Implementing Data Structures
			 - Example of ArrayList implementation using generics to write an implementation that covers several different classes.

			 - We write an implementation for Strings. Now do we re-write the same implementation for Integers and other classes?
				 - Naive solution: Write an implementation for the "Object" class.

				 - But we want to enforce the SAME object throughout the class.

				 - Better solution: use generics

		 - Misc
			 - What's the relationship between data structures and software quality? I'm just wondering why both of these topics are combined in this course.

			 - {DONE}} Slides are incomplete / missing
				 - Resources > Module 1 Key Takeaways and Slides > Module1-slides.zip

				 - Includes only 1.3, 1.4, but it seems that 1.1, 1.2 are missing.

				 - Also, it would be great if you could upload in PDF format instead of PPT.

			 - {DONE}} Unable to download .java files from Coursera
				 - CIT 594 > Week 1 > Module 1 Programming Assignment Submission

				 - Click "MyArrayList.java"

				 - Expected result: File will download

				 - Actual result: Browser renders text of the .java file

				 - Workaround: Maybe the course staff could upload a zip folder containing the java file instead of uploading the java file directly? 

		 - Quiz
			 - Based on this course's definition of software quality, which of the following are true regarding external quality? Select all that apply.
				 - ~~ALL~~

				 - External 2

			 - What's the relationship between data structures and software quality? I'm just wondering why both of these topics are combined in this course.
				 - New, copied, added

			 - Which of the following describes the benefits of using Java Generics? Select all that apply.
				 - ALL except creating without knowing type

			 - Which of the following correctly defines a class to hold a pair of values using Java Generics? Select the best option.
				 - public class Pair<T> {
					 - private T one, two;

					 - public Pair(T t1, T t2) {
						 - one = t1;

						 - two = t2;

					 - }

					 - public T getOne() { return one; }

					 - public T getTwo() { return two; }

				 - }

	 - DONE Module 2: LinkedLists
		 - Lesson 1: Module Introduction
			 - We will discuss LinkedLists, stacks, and queues. Latter two are abstract data structures, because they don't care about the implementation.

		 - Lesson 2: Introduction to LinkedLists
			 - Limitations of ArrayList: fixed number of elements, can't insert element between elements, searching is slow 

			 - Linkedlist avoids the first two limitations, but searching is still slow!

		 - Lesson 3: Modifying a LinkedList
			 - To add an element we just need to update the next pointers.

			 - To remove an element, similar to above, and we free the node.

		 - Lesson 4: Finding an Element in a LinkedList
			 - We need to traverse the entire list to find an elements.

		 - Lesson 5: LinkedLists in the Java API
			 - List is an abstract datatype; it's an interface.

		 - Lesson 6: Variations of LinkedLists
			 - Stack: Last In First Out (LIFO) implementation of linked list. Push and pop methods. Stack is a class in Java API.

			 - Queue: First In First Out (FIFO) implementation of linked list. Add and remove methods. Queue is an interface in Java API; instantiated via linkedlist.

		 - Lesson 7: Test Your Knowledge
			 - 1.

			 - Question 1

			 - For a linked list that contains 3 or more elements, if **head** is a reference to the first node of a LinkedList, what happens when you run the operation **head = tail;**? Select the best answer.

			 - 1 point

			 - **Removes only the first node of the LinkedList**

			 - **Copies the node at tail and adds it to the front of the LinkedList**

			 - DONE **Removes all nodes from the LinkedList except the last element**

			 - **Removes all nodes from the LinkedList**

			 - 2.

			 - Question 2

			 - Which of the following nodes is **__unnecessary__** when inserting a new node at a specified index of a standard LinkedList, given the implementation we saw in this module? Select all that apply

			 - 1 point

			 - DONE **Node at the index**

			 - DONE **Node after the index**

			 - **Node before the index**

			 - DONE **Tail**
				 - You didn’t select all the correct answers

			 - 3.

			 - Question 3

			 - The implementation of **removeFirst** which removes the first node in a LinkedList if possible is shown below. What would be an equivalent implementation of this function? Select the best answer.

			 - 1

			 - 2

			 - 3

			 - 4

			 - 5

			 - 6

			 - 7

			 - 8

			 - public void removeFirst() {

			 - }

			 - }

			 - }

			 - 1 point

			 - **1234567public void removeFirst() {    head = head.next;        if (head == null) {        tail = null;    }}**

			 - DONE **12345678public void removeFirst() {    if (head == tail) {        head = null;        tail = null;    } else {        head = head.next;    }}**

			 - **1234567public void removeFirst() {    if (head != null) {        head = head.next;        return;    }    tail = null;}**

			 - **1234567public void removeFirst() {    if (head != null) {        head = head.next;    } else {        tail = null;    }}**
				 - **Incorrect** This code will set the tail to null regardless of whether the head and tail are the same node or not. So, in a list of more than one node, this implementation would incorrectly set the tail to null even if the node has not been deleted.

			 - 4.

			 - Question 4

			 - In which of the following cases is a LinkedList slower than an ArrayList? Select all that apply.

			 - 1 point

			 - **Adding an element to the front.**

			 - **Searching for an element.**

			 - DONE **Retrieving an element by its index.**

			 - 5.

			 - Question 5

			 - A doubly LinkedList is one where each node has a link to both the **previous** node and the **next** node. When removing a node at a specified index in the middle of a doubly LinkedList containing at least 3 nodes, which of the following steps would be **necessary** to complete this task? Assume **current** refers to the node being removed. Select all that apply.

			 - 1 point

			 - **Set **current.next = current.next.next;****

			 - **Set **current.prev.next = current.next.next;****

			 - DONE **Set **current.next.prev = current.prev;****

			 - DONE **Set **current.prev.next = current.next;****

			 - 6.

			 - Question 6

			 - The implementations of a Stack and Queue based on a LinkedList structure are very similar. Which of the following statements about the corresponding functions is true? Select all that apply.

			 - 1 point

			 - DONE ****Stack.pop()** and **Queue.remove()** are implemented using the same underlying LinkedList functions where the node at the head of the LinkedList is removed, and its value returned.**

			 - DONE ****Stack.push(E element)** and **Queue.add(E element)** insert a new node at opposite ends of the underlying LinkedList.**

			 - DONE ****Stack.peek()** and **Queue.peek()** both return the element at the head of the underlying LinkedList.**

			 - ****Stack.push(E element)** and **Queue.add(E element)** are implemented using the same underlying LinkedList functions where a new node is added at the tail of the LinkedList.**

			 - 7.

			 - Question 7

			 - The LinkedList based implementation of a Stack is shown below. What would be an equivalent implementation of this Stack? Select the best answer.

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

			 - import java.util.LinkedList;

			 - public class Stack {

			 - }

			 - }

			 - }

			 - 1 point

			 - DONE **1234567891011121314151617import java.util.LinkedList; public class Stack {        protected LinkedList list = new LinkedList();        public void push(E value) {        list.addFirst(value);    }        public E pop() {        if (list.isEmpty())            return null;         return list.removeLast();      }}**

			 - **1234567891011121314151617import java.util.LinkedList; public class Stack {        protected LinkedList list = new LinkedList();        public void push(E value) {        list.addLast(value);    }        public E pop() {        if (list.isEmpty())            return null;         return list.removeFirst();      }}**

			 - **1234567891011121314151617import java.util.LinkedList; public class Stack {        protected LinkedList list = new LinkedList();        public void push(E value) {        list.addLast(value);    }        public E pop() {        if (list.isEmpty())            return null;         return list.removeLast();      }}**

			 - **1234567891011121314151617import java.util.LinkedList; public class Stack {        protected LinkedList list = new LinkedList();        public void pop(E value) {        list.addFirst(value);    }        public E push() {        if (list.isEmpty())            return null;         return list.removeFirst();      }}**
				 - **Incorrect** In this implementation the pop and push operations are reversed, violating their definitions.

			 - 8.

			 - Question 8

			 - Which of the following applications are more likely to utilize a Queue data structure to hold its data than a Stack? Select all that apply.

			 - 1 point

			 - **A notification display manager that displays notifications from most to least recently arrived.**

			 - DONE **A drive-thru ordering system that relays the orders to the employees preparing the orders.**

			 - DONE **A waitlist for standby passengers at an airport.**

			 - DONE **A CPU that is shared among different jobs based on job arrival time.**

			 - **Honor Code Agreement**

			 - I understand that submitting work that isn’t my own may result in permanent failure of this course or deactivation of my Coursera account. Learn more about Coursera’s Honor Code

		 - Lesson 8: Programming Assignment

		 - Lesson 9: Recitation Activities

	 - DONE Module 3: Analyzing Data Structures
		 - Lesson 1: Module Introduction

		 - Lesson 2: Big-Oh Notation
			 - Big-O is a measure of complexity.

			 - Time complexity applies to algorithms, not data structures. E.g. getting element by index from ArrayList is an algorithm.

			 - O(1) - constant time complexity

			 - O(n) - linear time comlexity

			 - Asymptotic notation: f(n) is O(g(n)) if exists c,n_0 s.t. f(n) <= c*g(n) for all n >= n_0

		 - Lesson 3: Measuring Big-Oh Complexity
			 - Sequential operations: add 

			 - Amortized analysis: instead of measuring cost of single operation, we measure the average cost of several operations. 
				 - Cost of adding element to ArrayList = O(n)

				 - Amortized cost of adding element to ArrayList = O(1) - because the O(n) cost occurs only once every n times.

		 - Lesson 4: Comparing Data Structures
			 - Comparing data structures will have tradeoffs - some operations are more efficient in one structure vs. other.

		 - Lesson 5: Test Your Knowledge
			 - Suppose we have an algorithm that is made of two methods J and K, where we know that complexity of J is O(n^33) and the complexity of K is O(n). Given that this algorithm is executed as running function J three times in a row, followed by running the function K once, and finally running function J one last time. What is the overall complexity of this algorithm? Select the best answer.

			 - 1 point

			 - DONE **O(n^33)**

			 - **O(4n^33 + n)**

			 - **O(n)**

			 - **O(n^33 + n)**

			 - 2.

			 - Question 2

			 - Suppose a method A that has a complexity of O(n^33). Given that A just calls another function C __n__ times. What must the big-oh complexity of the method C be? Select the best answer.

			 - 1 point

			 - **O(n^44)**

			 - **O(n)**

			 - **O(n^33)**

			 - DONE **O(n^22)**

			 - 3.

			 - Question 3

			 - Given what you know of big-oh arithmetic, which of the following complexities is equivalent to O(5n^22 + 2m)? Select the best answer.

			 - 1 point

			 - **None of these options**

			 - DONE **O(n^22 + m)**

			 - **O(n^22)**
				 - WRONG

			 - **O(m)**

			 - 4.

			 - Question 4

			 - What is the complexity of the following function?  Select the best answer.

			 - 1

			 - 2

			 - 3

			 - 4

			 - 5

			 - 6

			 - int temp = 0;

			 - for (i = 0; i < n; i++) {

			 - }

			 - }

			 - 1 point

			 - DONE **O(n^22)**

			 - **O(n)**

			 - **None of these options**

			 - **O(2n)**

			 - 5.

			 - Question 5

			 - Which of the following is the reason that the function with complexity f(n) = (n^22)/10 is **not** equivalent to O(n)? Select all that apply.

			 - 1 point

			 - **There is no value c, such that cn ≤ (n^22)/10 for all values n ≥ n_00​**

			 - DONE **There is no value c, such that (n^22)/10 ≤ cn for all values n ≥ n_00​**

			 - **Honor Code Agreement**

			 - I understand that submitting work that isn’t my own may result in permanent failure of this course

		 - Lesson 6: Recitation Activity

	 - DONE Module 4: HashSets
		 - Lesson 1: Module Introduction

		 - Lesson 2: Introduction to HashSets
			 - Limitation of both ArrayLists and LinkedLists: difficult to determine whether a list contains an element or not. O(n) operation in both cases. Hashset provides O(1) solution for checking.

			 - Naive solution: Use an array with 1/0 values such that a[i] = 1 indicates that i is in the list. This requires you to know the size before hand.

			 - Better solution: Hash function to convert strings to integers, and use hash as index.

		 - Lesson 3: Hashset Collision Handling
			 - Open addressing: store the value at the next available open address. Problem is that this make searching expensive. O(n).

			 - Separate chaining: each element of the array is a bucket (linked list).

		 - Lesson 4: HashSet Efficiency
			 - In the worst case hashset devolves into linkedlist (if all elements go to same bucket) and complexity of search will be O(n). To avoid this problem we need to ensure uniform hashing, i.e., approximately equal distribution of elements.

			 - Auto-adjusting hashset: double the number of buckets when the "load factor" increases, and re-hash the elements. 

		 - Lesson 5: HashSets in the Java API
			 - HashSet is a mathematical set.

			 - HashMap is for key value pairs (like a dictionary in Python)

		 - Lesson 6: Test Your Knowledge
			 - When does a “Collision” in a HashSet occur? Select the best answer.

			 - 1 point

			 - DONE **When two elements get mapped to the same index of the underlying array that makes up the HashSet.**

			 - **When there are more buckets than elements in the HashSet.**

			 - **When someone attempts to insert a duplicate element into the set.**

			 - **When the hashcode of an element is greater than the number of buckets in the HashSet.**

			 - 2.

			 - Question 2

			 - In this module, we explored some approaches to handle Collisions, what were they? Select all that apply.

			 - 1 point

			 - **Throwing an error to inform the user that the index is already occupied and not adding the new element to the HashSet.**

			 - **Placing the new element with a duplicate hashcode into any random available (i.e. empty) array index.**

			 - DONE **Using an array of LinkedLists, so that at each index of the array, elements with the same hashcode get placed into a LinkedList together.**

			 - DONE **Placing the new element with a duplicate hashcode into the first available (i.e. empty) array index after its own.**

			 - 3.

			 - Question 3

			 - Suppose we have a HashSet with 8 buckets, and a corresponding hashFunction that returns the number of letters in a given string. Assuming an open-addressing approach to handling collisions, and an initially empty HashSet, what does the array look like after adding the elements "Cat" 3, "Dog" 4, "CatDog" 6, "Moose" 5, "Squirrel" 0, and "MooseSquirrel" 7 in that order. Select the best answer.

			 - 1 point

			 - **["Cat", "Dog", "CatDog", "Moose", "Squirrel", "MooseSquirell", null, null]**

			 - DONE **["Squirrel", null, null, "Cat", "Dog", "Moose", "CatDog", "MooseSquirrel"]**

			 - **[null, null, "Cat", "Dog", "Moose", "CatDog", "MooseSquirrel", "Squirrel"]**

			 - **["Squirrel", null, "Dog", "Cat", null,  "Moose", "CatDog", "MooseSquirrel"]**

			 - 4.

			 - Question 4

			 - Given a hash set of n buckets that utilizes separate chaining to handle collisions, if there are **k** elements in a bucket **b**, and you are searching for an element with hash code **b**, what is the time complexity of that specific operation? Select the best answer.

			 - 1 point

			 - **O(nk)**

			 - **O(1)**

			 - DONE **O(k)**

			 - **O(n)**

			 - 5.

			 - Question 5

			 - If a HashSet is initialized to have a load factor of 0.85, and an initial number of buckets of 10, at which of the following points, would you need to resize the HashSet? Select the best answer.

			 - 1 point

			 - **When adding the 10th element.**

			 - **When adding the 8th element.**

			 - DONE **When adding the 9th element.**

			 - **When adding the 1st element.**

			 - 6.

			 - Question 6

			 - Consider an implementation of **reinsertAll()** where the number of buckets in the underlying array is doubled and the LinkedLists from the old buckets are copied over as they are. What, if anything, is wrong with this implementation? Select the best answer.

			 - 1 point

			 - **The new number of buckets should be loadFactor*(old number of buckets) instead of 2*(old number of buckets)**

			 - **The LinkedLists should not need to be copied over.**

			 - DONE **The hashcode of each element has to be recomputed before adding them back to the LinkedList array because the hashcode may have changed when the number of buckets changed.**

			 - **Nothing, it is correct.**

			 - 7.

			 - Question 7

			 - In which of the following situations would a HashMap be an appropriate data structure to use? Select all that apply.

			 - 1 point

			 - DONE **Storing the usernames, without duplication, of people who have made a certain request, and the number of times they have made this request.**

			 - **Checking whether or not a user has visited a webpage before.**

			 - DONE **Storing the usernames, without duplication, of people and their login passwords to a specific service.**

			 - **Storing the usernames, without duplication, of people who have made a certain request.**

			 - **Honor Code Agreement**

			 - I understand that submitting work that isn’t my own may result in permanent failure of this course or deactivation of my Coursera account. Learn more about Coursera’s Honor Code

		 - Lesson 7: Programming Assignment

		 - Lesson 8: Recitation Activities

	 - DONE Module 5: Binary Search Trees
		 - Lesson 1: Module Introduction

		 - Lesson 2: Introduction to Binary Search Trees
			 - Arraylists, LinkedLists, and HashSets are good for: adding elements, removing elements, retrieving elements. But not good for: sorting elements, and determining largest/smallest.

			 - Binary search tree is a tree where each node has two children (left is smaller than node and right is larger than node). Good for keeping elements sorted.

		 - Lesson 3: Modifying and Traversing Binary Search Trees
			 - Adding element: look for a null node where the new element would go, and put it there.

			 - Traverse recursively by traversing left and right trees of each node.

		 - Lesson 4: Binary Search Trees in the Java API

		 - Lesson 5: Test Your Knowledge
			 - What is the problem with maintaining a sorted linked list? Select the best answer.

			 - 1 point

			 - **Deleting from a sorted linked list will require re-sorting every time.**

			 - DONE **Adding to a sorted linked list is an O(n) operation.**

			 - **Traversing a sorted linked list is an O(n) operation.**

			 - **None of the above**

			 - 2.

			 - Question 2

			 - Which of the following is **NOT** specific to a binary search tree? Select the best answer.

			 - 1 point

			 - DONE **Each node has exactly two non-null child nodes.**

			 - **Every node in the tree is greater than each element in its left subtree**

			 - **Every node in the tree is less than each element in its right subtree**

			 - **All of these are properties specific to a binary search tree.**

			 - 3.

			 - Question 3

			 - An inorder traversal of a binary search tree... (Select the best answer.)

			 - 1 point

			 - **Requires that we know what the leftmost node in the binary search tree is.**

			 - DONE **Returns the node values in sorted order.**

			 - **Visits the root node, then the leftmost subtree, and then the rightmost subtree.**

			 - **Visits the leftmost subtree, the rightmost subtree, and then the root.**

			 - 4.

			 - Question 4

			 - What sequence of add operations results in the following binary search tree? Select the best answer.

			 - ![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/0lMTfVzVEemSphKEUWYCag_1090f29c230223e9e1c73c728f769aea_7.4.png?expiry=1602201600000&hmac=w8aYLjapcR-dRiqRpORciwsY62Y3gsY0ujHGnqglW20)

			 - 1 point

			 - **1234Node root = new Node(20);add(root, 14);add(root, 11);add(root, 10);**

			 - DONE **1234Node root = new Node(10);add(root, 11);add(root, 14);add(root, 20); **

			 - **Not possible**

			 - **1234Node root = new Node(11);add(root, 14);add(root, 10);add(root, 20);**

			 - 5.

			 - Question 5

			 - What is a benefit of using a TreeSet over a HashSet? Select the best answer.

			 - 1 point

			 - **TreeSet’s add() function has a better average case scenario than HashSet**
				 - WRONG

			 - **TreeSet’s contains() function has a better worst case scenario than HashSet**

			 - **TreeSet’s contains() function has a better average case scenario than HashSet**
				 - WRONG: Incorrect TreeSet’s contains() function is O(log n) while HashSet’s add() is O(1)

			 - **TreeSet’s add() function has a better worst case scenario than HashSet**

			 - 6.

			 - Question 6

			 - What is the output of the following snippet of code? Select the best answer.

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

			 - TreeSet<String> fruits = new TreeSet<String>();

			 - fruits.add(“peach”);

			 - fruits.add(“apple”);

			 - fruits.add(“banana”);

			 - fruits.add(“watermelon”);

			 - Iterator<String> iter = fruits.iterator();

			 - while (iter.hasNext()) {

			 - }

			 - 1 point

			 - **peach apple banana watermelon**
				 - WRONG: Incorrect The elements will not necessarily be stored in the order they were added to the TreeSet.

			 - DONE **apple banana peach watermelon**

			 - **banana apple watermelon peach**

			 - **banana apple peach watermelon**

			 - ****

		 - Lesson 6: Recitation Activity

	 - DONE Module 6: Self-Balancing Binary Search Trees
		 - Lesson 1: Module Introduction

		 - Lesson 2: Red-Black Trees
			 - BST (Binary Search Tree) needs to be balanced (small height) to be efficient.

			 - Red-Black system is one way of ensuring that tree remains balanced. It is __self-balancing__.

			 - Red-Black system requires moving branches around via rotations when new elements are added to maintain balance.

		 - Lesson 3: AVL Trees
			 - AVL is an alternative implementation of BST. Like RB system, AVL also uses rotations to maintain balance, but the system is different. 

		 - Lesson 4: Test Your Knowledge
			 - What is the goal of a balanced binary search tree? Select the best answer.

			 - 1 point

			 - **To have the same number of nodes in the left subtree and right subtree**

			 - **To color the nodes so that it is easy to visually distinguish different categories of nodes**

			 - **To make sure all levels of the tree that can be filled are filled**

			 - DONE **To minimize the height of the tree**

			 - 2.

			 - Question 2

			 - Which of the following are true of Red Black Trees? Select all that apply.

			 - 1 point

			 - **Every null node has the same depth.**

			 - DONE **Each node is colored red or black.**

			 - DONE **Every red node has two black child nodes.**

			 - DONE **All null nodes are black.**

			 - DONE **Every path from any node to any of its null node descendents must have the same number of black nodes.**

			 - 3.

			 - Question 3

			 - Which of the following are valid Red Black Trees? Select all that apply.

			 - 1 point

			 - **![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/SZMdJlzYEemYoA6JRCzeXg_f99950fdb8b3c0c00f8312e4e67c25c3_8.3d.png?expiry=1602201600000&hmac=Yx5cgcHcDbaUitVpluIFVFa0TMpHYAPYL_LrJAGm0ks)**

			 - **![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/Rhn79FzYEemYoA6JRCzeXg_52df36ade18449cc7c149dd7751e8f07_8.3c.png?expiry=1602201600000&hmac=dzlI2bZ4ZvgkFa8oTzmfwcFPPPlOCkOYv3yjJi56WJk)**

			 - **![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/PGIJjVzYEemp_gr2ZL5kng_c64ef2d4f94366fd7eaae7cbd81ee1bb_8.3a.png?expiry=1602201600000&hmac=kqRHCLBkrKhFrZKccIKD4htVfks1Q51CrCCoRzeP7VQ)**

			 - **![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/QPT_E1zYEemSphKEUWYCag_2da18ace208373a19b9074cf55d83dce_8.3b.png?expiry=1602201600000&hmac=MLQpVQNoCUJy_MzhYkqFYGSjgxu_w8zWjoDEsFAhSd4)**

			 - 4.

			 - Question 4

			 - Which of the following are valid AVL Trees? Select all that apply.

			 - 1 point

			 - **![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/_UMRiN9BEemG2RJMf3w20g_efdf7ea9812618d2ccd89b847eba23e6_avl1a.png?expiry=1602201600000&hmac=Bta7cEBVjMUarr4EJYV2TgGsTIVptjnlqCqahraydWc)**

			 - **![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/BYazHN9CEemG2RJMf3w20g_cd2ea5cc0057f3b07bf40331cceb6755_avl1b.png?expiry=1602201600000&hmac=qJls0Y6iWqL9BSlIoqQXH5_-B2-XmltB7Himg8qWgx0)**

			 - **![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/QE3Z799CEem8dgodg98Z5g_4492414f69c642e652ad553197b2435c_avl1c.png?expiry=1602201600000&hmac=JGzC5EL6pMdiEoSgULc6xZr0YzgnPhG2-PT8DCKSipc)**

			 - **![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/SQb5cN9CEem5DAqvNtDQ2g_67a614808efddc84543d2f5ae2dd5d8b_avl1d.png?expiry=1602201600000&hmac=uOZqq4ZVm3v4fU6k3iO6cDuISJRHcGll32trvhYaoI8)**

			 - 5.

			 - Question 5

			 - Which of the follow are true of AVL Trees? Select all that apply.

			 - 1 point

			 - **The absolute value of of the balance factor of each node is never more than 1.**

			 - **To restore balance after each insert or delete operation, at most one rotation is required.**

			 - **The insert and delete operations are log(n).**

			 - **The find operation is O(1)**

			 - 6.

			 - Question 6

			 - Consider the following AVL tree. What will the tree look like after the insertion of “P”?

			 - ![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/Pksj2N9FEemWcw6JrBJ66g_b5bd086974dbfeec1a8704cdc8b9c2a1_avl2.png?expiry=1602201600000&hmac=LNEw3o7hPRoyHD1jSMvlPlVqC0CxRWA9LBrGcmtIWeU)

			 - 1 point

			 - **![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/SA46JN9FEemG2RJMf3w20g_05b4dcc57356495d0d1c7f242ab07294_avl2a.png?expiry=1602201600000&hmac=xuR2LtifUAI7eT9dnP3E--9np4WQUCiTT1hpncwWs90)**

			 - **![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/VoeazN-GEem8dgodg98Z5g_ed91a858f974eac8d27c2617db06913c_avl2b.png?expiry=1602201600000&hmac=wtWqs231y91DAr82o73zEv1VpXrZpeTwUH9YA-OupO8)**

			 - **![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/Yagdld-GEemVnw4DAZYo1g_074298c83ecc5507ec8e6f2e82ba76b6_avl2c.png?expiry=1602201600000&hmac=K8uYVGgXVYBDOQ0gdSSUzSHsgATLrM8jQ4siBdr87k0)**

			 - **Honor Code Agreement**

			 - I understand that submitting work that isn’t my own may result in permanent failure of this course or deactivation of my Coursera account. Learn more about Coursera’s Honor Code

		 - Lesson 5: Programming Assignment

		 - Lesson 6: Recitation Activities

	 - DONE Module 7: Tree Variations
		 - Lesson 1: Module Introduction

		 - Lesson 2: Introduction to Heaps
			 - Want to find maximum and insert elements easily.

			 - Max heap is a complete binary tree with the largest element on top.

		 - Lesson 3: Modifying and Using Heaps

		 - Lesson 4: Tries
			 - Data structure specialized for strings, because string comparisons are expensive (char by char).

			 - It's a tree of chars where the path from root to leaf spells the word.

		 - Lesson 5: Test Your Knowledge
			 - How many elements are in the bottom level of the following Max-Heap when represented in array form?

			 - **18  14  16  13  9  12  10  11  4  6  7  8**

			 - 1 point

			 - **4**

			 - DONE **5**

			 - **6**

			 - **7**

			 - 2.

			 - Question 2

			 - Which of the following are true of a standard trie containing n strings of m maximum length using an s sized alphabet? Assume that all strings are null-terminated.

			 - 1 point

			 - **Each node is labeled with a character from the alphabet**
				 - WRONG

			 - **The height of the tree is n**

			 - DONE **The maximum number of children of each internal node is at most s+1**

			 - DONE **The number of leaves of the tree is equal to n**

			 - DONE **The find, insert, and delete operations can be optimized to O(m)**

			 - 3.

			 - Question 3

			 - Which of the words are stored in the following Trie? Assume that all words are null-terminated.

			 - ![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/0xiAh9-KEem8dgodg98Z5g_9d0e0ca3fe78e0235419a607f688930c_trie2.png?expiry=1603065600000&hmac=HtnFlFxg09LddgfUewEHDCoXSRmJw4V-41wMPfFSLzI)

			 - 1 point

			 - DONE **Cat**

			 - **Coats**

			 - DONE **Cow**

			 - **Sea**

			 - DONE **See**

			 - **Honor Code Agreement**

			 - I understand that submitting work that isn’t my own may result in permanent failure of this course or deactivation of my Coursera account. Learn more about Coursera’s Honor Code

		 - Lesson 6: Recitation Activities

	 - DONE Module 8: Graphs
		 - Lesson 1: Module Introduction

		 - Lesson 2: Introduction to Graphs
			 - Graphs represent nodes and relationships between nodes (e.g. distances between elements).

			 - Path connects nodes. Path can be cyclical if it contains a cycle.

			 - Connected vs. disconnected graphs.

			 - Edges can be weighted and/or directed.

		 - Lesson 3: Exploring a Graph
			 - Graph can be explored from root by depth first search (DFS) or breadth first search (BFS)

			 - BFS: Add all the neighbors of an element to queue, explore all those elements, and then add their neigbors to the queue.

			 - BFS will always find the shortest path, unlike DFS.

		 - Lesson 4: Test Your Knowledge
			 - Which of the following is necessarily true of a valid cycle C in a graph? Select all that apply.

			 - 1 point

			 - DONE **C is also a valid path in G**

			 - DONE **C can be directed or undirected**

			 - **All nodes in C are directly connected to all other nodes via an edge**

			 - DONE **C has the same node as its first and last node**

			 - 2.

			 - Question 2

			 - Given an undirected graph G with n nodes, what is the minimum number of edges necessary for G to be connected? Select the best answer.

			 - 1 point

			 - **2n**

			 - DONE **n-1**

			 - **n+1**

			 - **n**

			 - 3.

			 - Question 3

			 - Given an undirected graph G with n nodes, what is the maximum number of edges possible for G if no nodes have self-loops (edges that connect a node to itself)? Select the best answer.

			 - 1 point

			 - DONE **n(n-1)/2**

			 - **n(n-1)**

			 - **n^2**

			 - **2n**

			 - 4.

			 - Question 4

			 - In order to implement BFS, what data structure is typically used to keep track of the nodes that have been marked to be visited later? Select the best answer.

			 - 1 point

			 - **Set**

			 - **Map**

			 - DONE **Queue**

			 - **Stack**

			 - 5.

			 - Question 5

			 - Given the below graph, which of the following is a correct order in which nodes will be explored if DFS traversal is used to find a path from node A to node K? Select all that apply.

			 - ![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/kRm-n1zaEemSphKEUWYCag_7a12a42b2cb9663f00614a68505b9e9b_9.5.png?expiry=1604188800000&hmac=eyi0oHpNgHuRS-B9Guzcbl0m4LK6rmvV2H8PUMyX1as)

			 - 1 point

			 - DONE **A,C,G,B,E,K**

			 - DONE **A,B,E,K**

			 - DONE **A,B,F,L,P,E,K**

			 - **A,B,C,D,E,F,G,H,I,K**

			 - 6.

			 - Question 6

			 - Which of the following situations can be represented using a graph? Select all that apply.

			 - 1 point

			 - DONE **A social network**

			 - DONE **How Wikipedia pages are related**

			 - DONE **The airports that a particular airline flies to/from**

			 - DONE **A Thesaurus**

			 - **Honor Code Agreement**

			 - I understand that submitting work that isn’t my own may result in permanent failure of this course or deactivation of my Coursera account. Learn more about Coursera’s Honor Code

		 - Lesson 5: Programming Assignment

		 - Lesson 6: Recitation Activity

	 - DONE Module 9: Introduction to Software Design
		 - Lesson 1: Software Quality Revisited

		 - Lesson 2: Domain Modeling
			 - Grammatical parsing: Convert sentences to classes and methods by looking for nouns and verbs.

			 - UML diagrams are a way to model relationships between entities in more detail.

		 - Lesson 3: Test Your Knowledge
			 - What is domain modeling (in the context of designing software)? Select the best answer.

			 - 1 point

			 - **Refactoring architecture as necessary**

			 - DONE **Identifying concepts and their relationships.**

			 - **Identifying design patterns and their relationships**

			 - **Identifying design patterns and their data structures**

			 - 2.

			 - Question 2

			 - In grammatical parsing, which of the following is a valid role assignment? Select all that apply.

			 - 1 point

			 - **Verb: attribute**

			 - DONE **Adjective: subclass**

			 - DONE **Noun: attribute**

			 - DONE **Noun: class**

			 - 3.

			 - Question 3

			 - A composition is a “has-a” relationship. Which of the following best describes a composition? Select the best answer.

			 - 1 point

			 - **One class is a specialized form of the other and provides additional behavior/attributes**

			 - **One class is part of another and can exist independently**
				 - WRONG: This is aggregation

			 - DONE **One class is part of another but cannot exist independently**

			 - **One class is a generalized form of the other and provides additional behavior/attributes**

			 - 4.

			 - Question 4

			 - Looking at the following UML diagram, which of the following statements are correct with respect to the multiplicities? Select all that apply.

			 - ![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/f3nNj1zcEemp_gr2ZL5kng_927b930ae21accc19d0a47b5acb2a75c_10.5.png?expiry=1604793600000&hmac=y9I9Q-t45U8cVcn8JzrsnqPIsKfFz7G5s5K6MePoxRc)

			 - 1 point

			 - **A single Pet can be associated with no ChewToys**

			 - DONE **A single ChewToy can be associated with only one Pet**

			 - DONE **A single Pet can be associated with 1 or more ChewToys**

			 - **A single ChewToy can be associated with more than a single Pet**

			 - 5.

			 - Question 5

			 - In Java, which of the following best describes a Realization relationship? Select the best answer.

			 - 1 point

			 - **A Realization implements an abstract class**
				 - WRONG: Incorrect In Java, an abstract class is generally "extended" and not "implemented"

			 - DONE **A Realization implements an interface**

			 - **A Realization extends a concrete class**

			 - **A Realization extends an interface**
				 - Incorrect In Java, an interface is "implemented" and not "extended"

			 - **Honor Code Agreement**

			 - I understand that submitting work that isn’t my own may result in permanent failure of this course or deactivation of my Coursera account. Learn more about Coursera’s Honor Code

		 - Lesson 4: Recitation Activity

	 - DONE Module 10: Software Design Principles
		 - Lesson 1: Module Introduction

		 - Lesson 2: Software Architecture
			 - Measures of software quality
				 - External quality: How well the software runs

				 - Internal quality: How easy it is to read and understand code

			 - Three tier architecture: Data, Logic, Presentation (like MVC)

			 - Monolithic architecture is bad; prefer modularity

		 - Lesson 3: Software Design Principles

		 - Lesson 4: Test Your Knowledge
			 - In grammatical parsing, which of the following are valid role assignments? Select all that apply.

			 - 1 point

			 - DONE **Adjective: subclass**

			 - **Verb: attribute**

			 - DONE **Noun: attribute**

			 - DONE **Noun: class**

			 - 2.

			 - Question 2

			 - A professor gives 30 lectures in a semester. Her students attend one or more lectures, and attendance is taken at the start and end (for latecomers) of every lecture. Each lecture focuses on one topic and has a corresponding reading assignment. Using grammatical parsing, should the noun **lecture** be a class or attribute? Select the best answer.

			 - 1 point

			 - **Attribute implemented as a list of lectures (Strings) that a student attended**

			 - DONE **Class with attributes such as topic, reading assignment, list of students attended and operations like updating attendance**

			 - **Class with subclasses such as LectureTopic, LectureAssignment, LectureAttendance**

			 - **Attribute implemented as a Map from lecture topics (Strings) for the Professor class to attendance lists**

			 - 3.

			 - Question 3

			 - Which of the following best describes the software design concept of modularity?

			 - 1 point

			 - **The ability for a piece of code to perform its responsibilities with limited dependence on other pieces of code**

			 - **The ease with which a piece of code can be reused**

			 - DONE **Decomposing a software system into subsystems that have separate responsibilities**

			 - **Developing code in such a way that other code can use it without needing to know its implementation details**

			 - 4.

			 - Question 4

			 - If Dog is a specialization of Pet with an attribute __breed__, and the Pet UML specifies some methods and the attributes __owner__ and __name__, how do you translate this relationship into Java?  Select the best answer.

			 - 1 point

			 - **Dog extends Pet, which is an interface.**

			 - **Dog has a field of type Pet.**

			 - **Pet extends Dog, which is an abstract class.**

			 - DONE **Dog extends Pet, which is an abstract class.**

			 - 5.

			 - Question 5

			 - A class called CourseEnrollment maintains a list of all students who are enrolled in a course. A Student class consists of the student’s name, date of birth, and grade point average. When applying the design concept of functional independence, what should CourseEnrollment return if another class wants to get the students’ names to include in a report? Select the best answer.

			 - 1 point

			 - **Make the list of Student objects public**

			 - **Have a method that returns all of the Student objects**

			 - DONE **Have a method that returns only the names of the students**

			 - **Have a method that returns a Student object, given the Student’s name**

			 - 6.

			 - Question 6

			 - You are creating a class to keep track of all the books in a library, and are defining a method to return the titles of all the books. The caller of this method does not care about the order in which the books are stored, and each book title is distinct. From an abstraction standpoint, what should the return type be for this method? Select the best answer.

			 - 1 point

			 - **HashSet**
				 - Incorrect Although returning a Set makes sense, from an abstraction standpoint, the caller of the method should not need to know or care about which implementation is being used.

			 - **TreeSet**

			 - DONE **Set**

			 - **LinkedList**

			 - **Honor Code Agreement**

			 - I understand that submitting work that isn’t my own may result in permanent failure of this course or deactivation of my Coursera account. Learn more about Coursera’s Honor Code

		 - Lesson 5: Programming Assignment

	 - DONE Module 11: Software Design Patterns
		 - Lesson 1: Module Introduction

		 - Lesson 2: Creational Design Patterns
			 - Creational Design Patterns are about how objects are __created__.

			 - Singleton pattern
				 - Goal: ensure only one instance of a certain class and it is accessed statically.

				 - Private constructor with private static instance; Public accessor method

			 - Factory method pattern
				 - Goal: Suppose A has dependency on B; we want to use different types of B without altering A.

				 - We create sub-classes of A that call sub-classes of B.

		 - Lesson 3: Structural and Behavioral Design Patterns
			 - Bridge pattern
				 - Goal: decouple abstractions and implementer

			 - Strategy pattern
				 - Decouple the algorithm and the strategy for the algorithm

			 - Observer pattern
				 - Behavioral pattern to notify other objects that something happened.

		 - Lesson 4: Test Your Knowledge
			 - Which of the following are considered Creational design patterns? Choose all that apply.

			 - 1 point

			 - **Observer**

			 - **Bridge**

			 - DONE **Factory Method**

			 - DONE **Singleton**

			 - **Strategy**

			 - 2.

			 - Question 2

			 - Which of the following is an example of the use of the Strategy pattern in the Java API? Choose the best answer.

			 - 1 point

			 - **The Iterator.hasNext method returns a boolean to indicate whether there are more elements to iterate over.**

			 - DONE **The Collections.sort method takes a Comparator to determine how to compare elements.**

			 - **The List interface defines a "clear" method that removes all elements from the List.**

			 - **The Stack class uses Java Generics to indicate the type of object stored on the Stack.**

			 - **The Map.keySet method returns a Set of all the keys.**

			 - 3.

			 - Question 3

			 - What do the Singleton and Factory Method patterns have in common? Choose the best answer.

			 - 1 point

			 - **They both involve a class creating objects of its own type.**

			 - DONE **They both separate the code that creates an object from the code that uses it.**

			 - **They both limit the number of objects of a class that can be created.**

			 - **They both require that classes have private constructors.**

			 - **They both depend on a subclass of a class to create the objects that the parent class wants to use.**

			 - 4.

			 - Question 4

			 - Consider a system with the following design:
				 - Classes **Dog** and **Cat** both extend abstract class **Animal**

				 - Classes **Piano **and **Guitar** both implement interface **Instrument**

			 - The Animal class is implemented as follows

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

			 - public abstract class Animal {

			 - }

			 - }

			 - }

			 - Which design pattern is reflected here? Choose the best answer.

			 - 1 point

			 - **Factory Method**

			 - DONE **Bridge**

			 - **Strategy**

			 - **Singleton**

			 - **Observer**

			 - ****

		 - Lesson 5: Programming Assignment

		 - Lesson 6: Recitation Activity

	 - DONE Module 12: Writing Good Code
		 - Lesson 1: Module Introduction

		 - Lesson 2: Code Readability and Understandability
			 - Use whitespace between delimiters

			 - Use meaningful and short variable names

		 - Lesson 3: Refactoring

		 - Lesson 4: Test Your Knowledge
			 - 1.

			 - Question 1

			 - Making code easier to read also makes it easier to.. (Select the best answer.)

			 - 1 point

			 - **understand**

			 - **change**

			 - **test and debug**

			 - DONE **All of the above**

			 - 2.

			 - Question 2

			 - I have a variable of type List which I am using to represent the items that a user has purchased. From an understandability perspective, the best name for this variable is: (Select the best answer.)

			 - 1 point

			 - **allItems**

			 - DONE **purchasedItems**

			 - **list**

			 - **items**

			 - 3.

			 - Question 3

			 - The goal of refactoring is to... (Select the best answer)

			 - 1 point

			 - **make code easier to understand**

			 - **make code easier to change**

			 - **make code easier to test and debug**

			 - DONE **all of the above**

			 - 4.

			 - Question 4

			 - Suppose I have a public method named “read” that reads the contents of a file, and decide to change it to “readFile” in order to make it more descriptive. What is a negative side effect of this refactoring? Select the best answer.

			 - 1 point

			 - DONE **Any code that uses that method now has to be changed**

			 - **The modularity of my code has decreased**

			 - **The functional independence of my code has decreased**

			 - **{:tag :h3}All of the above**

			 - 5.

			 - Question 5

			 - The “duplicate code” code smell is a problem because: (Select the best answer)

			 - 1 point

			 - **A change in one part of the code necessitates change elsewhere**
				 - WRONG

			 - DONE **There are more places to modify the code if it needs to be changed**

			 - **It makes the code slower**

			 - **It hurts abstraction**

			 - 6.

			 - Question 6

			 - Suppose I have a design in which duplicate code is found in classes A and B. Using the Extract Superclass refactoring pattern, I would: (Select the best answer.)

			 - 1 point

			 - DONE **Have A and B extend a new class C and then move the common code to C**

			 - **Have A extend B and put the common code in B**

			 - **Put the common code in a new class C and make C a field in both classes A and B**

			 - **Put the common code in B and have it be a field in class A**

			 - **Honor Code Agreement**

			 - I understand that submitting work that isn’t my own may result in permanent failure of this course or deactivation of my Coursera account. Learn more about Coursera’s Honor Code

		 - Lesson 5: Group Project

		 - Lesson 6: Recitation Activity

	 - Module 13: Software Efficiency
		 - Lesson 1: Module Introduction

		 - Lesson 2: Efficiency Fundamentals
			 - Use the right data structure 

			 - Measure execution time
				 - Wall clock time = total time including program execution and OS steps

		 - Lesson 3: Improving Efficiency
			 - Lazy evaluation - evaluate only when necessary

			 - Lazy initialization - initialize only when necessary

			 - If optimization is really important, you can remove the overhead of loops and methods (but this makes code harder to read)

			 - 

		 - Lesson 4: Test Your Knowledge

		 - Lesson 5: Recitation Activity

	 - Module 14: Special Topic: Concurrency
		 - Lesson 1: Module Introduction

		 - Lesson 2: Introduction to Threads
			 - Threads can be used to solve parallelizable problems.

		 - Lesson 3: Thread-Related Problems
			 - Issues around concurrency, race conditions, etc. - be careful!

		 - Lesson 4: Test Your Knowledge
			 - Suppose I have a class MyRunnable that implements the Runnable interface and want to start executing it in a new thread. The code that will do this is: (Select best answer.)

			 - 1 point

			 - ****new MyRunnable().run();****

			 - ****Thread.start(new MyRunnable());****
				 - **Incorrect** This is not the correct way to call start with a thread. start() does not take any arguments.

			 - ****new MyRunnable().start();****

			 - DONE ****new Thread(new MyRunnable()).start();****

			 - 2.

			 - Question 2

			 - Suppose I have a class **AdderThread** that extends Thread, and its "run" method finds the sum of the elements of an array; the sum can then be retrieved by the "getSum" method. The following code tries to use the AdderThread class but always returns 0. How can I fix the problem so that I still take advantage of threads? (Select the best answer)

			 - 1

			 - 2

			 - 3

			 - 4

			 - 5

			 - 6

			 - 7

			 - public int add(int[] A1, int[] A2) {

			 - }

			 - 1 point

			 - **Change lines 4 and 5 to t1.run() and t2.run()**
				 - **Incorrect** This would make the code work, but would make the code sequential; it waits for t1 to finish before proceeding to t2.

			 - **Put t1.join() between lines 4 and 5, and t2.join()between lines 5 and 6**
				 - **Incorrect** This would make the code work, but would make the code sequential; it waits for t1 to finish before proceeding to t2.

			 - **Put t1.join() and t2.join() between lines 5 and 6**

			 - **Omit lines 4 and 5**
				 - **Incorrect** Not running the threads does not execute the method that finds the sum of the elements of the array.

			 - 3.

			 - Question 3

			 - In the code below, which of the following might lead to a race condition if Threads A and B are sharing the same instance of MyClass? Select the best answer.

			 - 1

			 - 2

			 - 3

			 - 4

			 - 5

			 - 6

			 - 7

			 - 8

			 - 9

			 - public class MyClass {

			 - }

			 - }

			 - 1 point

			 - **Thread A executes line 5 while thread B executes line 6**
				 - **Incorrect** This does not lead to a race condition because "local" is a local variable and "param" is a method parameter, each thread has its own copy so it’s not possible for the threads to affect each other.

			 - **Thread A executes line 6 while thread B executes line 6**

			 - **Thread A executes line 4 while thread B executes line 5**

			 - DONE **None of the above**

			 - 4.

			 - Question 4

			 - Suppose I have a class that extends Thread defined as follows:

			 - 1

			 - 2

			 - 3

			 - 4

			 - 5

			 - 6

			 - 7

			 - public class MyThread extends Thread {

			 - }

			 - }

			 - and I am then using it in this code:

			 - 1

			 - 2

			 - 3

			 - 4

			 - 5

			 - 6

			 - 7

			 - MyThread t1 = new MyThread();

			 - MyThread t2 = new MyThread();

			 - t1.start();

			 - t2.start();

			 - t1.join();

			 - t2.join();

			 - System.out.println(MyThread.value);

			 - What might be printed on the last line of the above code? Select best answer.

			 - 1 point

			 - **2 only**

			 - **0, 1, or 2**
				 - **Incorrect** The code will definitely not print 0, since at least one of the threads will successfully increment the value before join is called.

			 - DONE **1 or 2 only**

			 - **0 or 1 only**

			 - 5.

			 - Question 5

			 - Suppose I have the following class and am worried about race conditions:

			 - 1

			 - 2

			 - 3

			 - 4

			 - 5

			 - 6

			 - 7

			 - 8

			 - 9

			 - public class BankAccount {

			 - }

			 - }

			 - }

			 - In order to avoid race conditions, I should: (Select the best answer.)

			 - 1 point

			 - DONE **Make "deposit" a synchronized method**

			 - **Make “getBalance” a synchronized method**

			 - **Make "balance" a synchronized field**

			 - **All of the above**
				 - **Incorrect** One of the above is correct.

			 - 6.

			 - Question 6

			 - How could a race condition exist in the following code, assuming the method calls are on the same object? (Select the best answer.)

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

			 - 17

			 - 18

			 - 19

			 - 20

			 - 21

			 - 22

			 - 23

			 - 24

			 - public class Values {

			 - }

			 - }

			 - }

			 - }

			 - }

			 - }

			 - }

			 - 1 point

			 - **One thread calls updateValue1 while another calls updateValue1**
				 - **Incorrect** This does not lead to a race condition because the updateValue1 method is synchronized.

			 - **One thread calls updateValue2 while another calls updateBoth**
				 - **Incorrect** This does not lead to a race condition because updateBoth requires access to "this" object’s lock and the lines where value2 is updated are protected by the "lock" object’s lock.

			 - **One thread calls updateBoth while another calls updateBoth**

			 - DONE **None of the above**

			 - **Honor Code Agreement**

			 - I understand that submitting work that isn’t my own may result in permanent failure of this course or deactivation of my Coursera account. Learn more about Coursera’s Honor Code

		 - Lesson 5: Recitation Activities

	 - Module 15: Closing and Final Exam
		 - Lesson 1: Course Conclusion

		 - Lesson 2: Group Project

		 - Lesson 3: Final Exam
