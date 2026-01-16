---
title: MCIT-595
---

- Module 1: History of Operating Systems and Setting Up A Local Virtual Machine
	 - Lesson 1: Welcome to MCIT 595
		 - Areas of CS: Theory, Computer Systems, AI

		 - Computer Systems is about the interaction between hardware and software through the stack.

	 - Lesson 2: History of Operating Systems

	 - Lesson 3: Setting up your Development Environment
		 - VirtualBox: HyperVisor

		 - Vagrant: Wrapper for VirtualBox to help with configuration.

	 - Lesson 4: Alumni Interviews

	 - Lesson 5 : C - Refresher

	 - Lesson 6: Key Takeaways from Module 1

	 - Week 1: Recitation and Open Office Hour Recordings

- Module 2: Operating Systems: What They Do and How They Manage Process
	 - Lesson 1: Module Introduction

	 - Lesson 2: Components of an Operating System and Course Road Map
		 - Operating system provides an interface between computer hardware and the end user applications. 

		 - OS abstracts away the hardware layer from app developers so that they can just make system calls (via API).

		 - OS components: process management, memory management, I/O.

	 - Lesson 3: How does an Operating System Manage Process?
		 - Process is an abstraction for application runs. Each process has its own virtual address space. OS has process control blocks (PCBs) to interface with hardware.

		 - Processes are trees with parent-child relationship. childpid variable distinguishes parent from child.

	 - Lesson 4: Introduction to Project 1

	 - Lesson 5: Alumni Interviews

	 - Lesson 6: Test Your Knowledge
		 - 1 A virtual machine allows us to run multiple operating systems on a single computer. Select the best answer. 1 point
			 - **True**

			 - **False**

		 - 2. Question 2
			 - In a Git version control system, local commits that are not pushed to the main code repository will be lost if the local machine crashes. Select the best answer. 1 point

			 - **True**

			 - **False**

		 - 3. Question 3 The static global variables that reside in the data segment of a process’s memory are generated at compile, not runtime. Select the best answer. 1 point
			 - **True**

			 - **False**

		 - 4. Question 4 Copy-on-write is a mechanism used to reduce the overhead of forking new processes. Select the best answer. 1 point
			 - **True**

			 - **False**

		 - 5. Question 5 The “Root” process, __init__, is created when the OS is booted. Select the best answer. 1 point
			 - **True**

			 - **False**

		 - 6. Question 6 After the **exec() **call, the child’s data segment is preserved and kept similar to that of its parent. Select the best answer. 1 point
			 - **True**

			 - **False**

		 - 7. Question 7 
			 - Consider the following program:
				 - #include <stdlib.h>

				 - #include <stdio.h>

				 - int sum(int varX, int varY)

				 - {

				 - }

				 - int main (int argc, char** argv)

				 - {

				 - }

				 - Which part of memory is used to store the content that cArray points to?

				 - Select the best answer.

				 - 1 point

			 - **Heap segment**

			 - **Stack segment**

			 - **Data segment**

		 - 8. Question 8 Which of the following statements is true if **free(cArray)** is left out? Select the best answer. 1 point
			 - **We will get a segmentation fault when running the program.**

			 - ****cArray** will be removed from the heap after the **sum** function call returns.**

			 - ****cArray** will be retained on the heap after the **sum** function call returns.**

		 - 9. Question 9 Where is the variable x stored in memory? Select the best answer. 1 point
			 - **Heap Segment**

			 - **Stack Segment**

			 - **Data Segment**

		 - 10. Question 10 If the variable **funcCounter **in the **sum **function is declared without the static keyword, what would be the output of variable y in the **printf() **of the **main** function? Select the best answer. 2 points
			 - **8**

			 - **9**

			 - **7**

	 - Lesson 7: Key Takeaways from Module 2

- Module 3: C Debugging and Process Management
	 - Lesson 1: Module Introduction

	 - Lesson 2: Debugging Demos
		 - GDB commands to debug parent vs. child
			 - -exec set follow-fork-mode child

			 - -exec set follow-fork-mode parent

		 - DONE Q: why does the parent command execute even in follow-child?

		 - Sanitizers are a better (or worse) alternative to valgrind.

	 - Lesson 3: Process Context
		 - Process Control Block PCB contents
			 - Execution context
				 - Stack pointer

				 - Program counter

				 - Registers

				 - Status (running, blocked, ready)

			 - Memory context
				 - Pointer to page table

			 - Open file descriptor table

		 - Context switching from one process to another is costly and has overhead (needs to transition from user mode to kernel mode)

		 - OS scheduler manages the process queue in an efficient manner. Typically process runs until blocked, then OS chooses another process from the ready Q.

	 - Lesson 4: System Calls and Process States

	 - Lesson 5: Key Takeaways from Module 3

- Module 4: Uncovering Services Provided by the Operating System
	 - Lesson 1: Module Introduction

	 - Lesson 2: Implementing System Calls and Hardware Interrupts
		 - Function calls vs. system calls: system calls like printf() switch to kernel mode for execution, whereas ordinary function calls do not.

	 - Lesson 3: Hardware and Software Interrupts
		 - Signal is a software interrupt. All signals from one process to another go through the kernel. 

		 - Most handlers can be over-written, but some signal handlers cannot for safety reasons (e.g. SIGKILL cannot be overwritten).

		 - Some signals have higher priority than others (e.g. SIGKILL has high priority). 

	 - Lesson 4: Test Your Knowledge
		 - Q1

		 - Interrupts are only initiated by currently running processes.

		 - 1 point

		 - **True**

		 - DONE **False**

		 - 2.

		 - Question 2

		 - During a system call, a TRAP instruction occurs and executing the correct system call requires a jump to a specific address in OS address space, as indexed by the system call number.

		 - 1 point

		 - DONE **True**

		 - **False**

		 - 3.

		 - Question 3

		 - Blocked signals are lost permanently.

		 - 1 point

		 - **True**

		 - DONE **False**

		 - 4.

		 - Question 4

		 - When executing a TRAP instruction during a system call, the CPU mode bit changes from __supervisor to user__.

		 - 1 point

		 - **True**

		 - DONE **False**

		 - 5.

		 - Question 5

		 - A regular function call requires fewer CPU cycles than a system call (assuming both have the same code).

		 - 1 point

		 - DONE **True**

		 - **False**

		 - 6.

		 - Question 6

		 - Consider the following piece of code where a parent creates a child, a child creates a grandchild, and a grandchild creates a great-grandchild process Assume that parent, child (**child_pid**), grandchild (**grandchild_pid**), and great-grandchild (**greatgrandchild_pid**) have PIDs 100, 200, 300, and 400, respectively.

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

		 - child_pid = fork();

		 - if (child_pid != 0) {

		 - }

		 - else {

		 - }

		 - Enter the value of the **child_pid** variable in the parent’s address space.

		 - DONE 200

		 - 2 points

		 - 7.

		 - Question 7

		 - Consider the following piece of code where a parent creates a child, a child creates a grandchild, and a grandchild creates a great-grandchild process Assume that parent, child (**child_pid**), grandchild (**grandchild_pid**), and great-grandchild (**greatgrandchild_pid**) have PIDs 100, 200, 300, and 400, respectively.

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

		 - child_pid = fork();

		 - if (child_pid != 0) {

		 - }

		 - else {

		 - }

		 - Enter the value of the **greatgrandchild_pid** variable in the grandchild’s address space.

		 - DONE 400

		 - 1 point

		 - 8.

		 - Question 8

		 - Consider the following piece of code where a parent creates a child, a child creates a grandchild, and a grandchild creates a great-grandchild process Assume that parent, child (**child_pid**), grandchild (**grandchild_pid**), and great-grandchild (**greatgrandchild_pid**) have PIDs 100, 200, 300, and 400, respectively.

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

		 - child_pid = fork();

		 - if (child_pid != 0) {

		 - }

		 - else {

		 - }

		 - Enter the value of the **greatgrandchild_pid** variable in the greatgrandchild’s address space.

		 - DONE 0

		 - 2 points

		 - 9.

		 - Question 9

		 - Consider the following piece of code where a parent creates a child, a child creates a grandchild, and a grandchild creates a great-grandchild process Assume that parent, child (**child_pid**), grandchild (**grandchild_pid**), and great-grandchild (**greatgrandchild_pid**) have PIDs 100, 200, 300, and 400, respectively.

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

		 - child_pid = fork();

		 - if (child_pid != 0) {

		 - }

		 - else {

		 - }

		 - Enter the value of the **grandchild_pid** variable in the grandchild’s address space. (Numeric answer question)

		 - DONE 0

		 - 2 points

		 - 10.

		 - Question 10

		 - Which of the following is not an example signal that originals from a hardware interrupt?

		 - 1 point

		 - **Clock pulse for updating system time**

		 - **Input from keyboard, network, or disk**

		 - **Illegal memory access**
			 - WRONG

		 - DONE **SIGINT signal from one process to another**

		 - **Honor Code Agreement**

		 - I understand that submitting work that isn’t my own may result in permanent failure of this course or deactivation of my Coursera account. Learn more about Coursera’s Honor Code

	 - Lesson 5: Project 1c: Evaluating Code for Readability and Maintenance

	 - Lesson 6: Key Takeaways from Module 4

- Module 5: Interacting with Processes: Managing Process Input and Output
	 - Lesson 1: Module Introduction

	 - Lesson 2: Modifying Pipe Inputs and Outputs
		 - You can redirect the output from stdout to somewhere else (e.g. a file).

		 - Use dup2() to redirect and pipe() to create pipes.

	 - Lesson 3: Job Control
		 - 

	 - Lesson 4: Project 2

	 - [Comic] Boon Competes in a Programming Competition

	 - Lesson 5: Key Takeaways from Module 5

- Module 6: Threads and Concurrency Control - Managing Multiple Tasks at the Same Time
	 - Lesson 1: Module Introduction

	 - Lesson 2: Threads
		 - Thread is a "lite" version of a process. Process has more isolation than threads. 

		 - Threads within the same process can communicate directly with each other, whereas process communication involves the kernel.

		 - Different applications should run different processes, but within an application you can use threads.

		 - **Thread pools** are a less expensive way of running multiple threads.

		 - User level threads are maintained in user space whereas kernel level threads are maintained in OS space.

	 - Lesson 3: Concurrency Control and Synchronization
		 - Problems can arise when multiple threads are modifying the same variables in parallel. This is known as "race conditions".

		 - Mutual exclusion: techniques for avoiding the above problem; i.e. preventing simultaenous accesses to a critical section.
			 - Disable interrupts: overkill solution; makes the threads run in series rather than parallel. Overkill because we are also preventing important OS interrupts (e.g. clock interrrupts)

			 - Busy waiting: Peterson's solution
				 - Approach 1 (naive): Each thread keeps checking the critical part before executing. Wastes CPU cycles.

				 - Approach 2: Use shared variables to check for critical part. Software solution.

				 - Approach 3: 

				 - Approach 4 (Peterson solution): 

				 - Peterson's solution does not generalize beyond two threads.

			 - Busy waiting: TSL

			 - Blocking system calls

	 - Lesson 4: Project 2b Submission

	 - Lesson 5: Test Your Knowledge
		 - When a process makes a system call, after the call completes, it may not get to run immediately.

		 - 1 point

		 - DONE **True**

		 - **False**

		 - 2.

		 - Question 2

		 - During a system call, the system call number corresponding to the system call function is pushed onto the stack initially.

		 - 1 point

		 - DONE **True**

		 - **False**
			 - WRONG

		 - 3.

		 - Question 3

		 - During a system call, the system call function caller’s current register values are first stored in the heap and then copied to the PCB.

		 - 1 point

		 - **True**

		 - DONE **False**

		 - 4.

		 - Question 4

		 - Is the following statement true or false?

		 - System calls are more expensive (i.e. require more instructions to run) than regular function calls.

		 - 1 point

		 - DONE **True**

		 - **False**

		 - 5.

		 - Question 5

		 - A **SIGKILL **signal can be caught or ignored.

		 - 1 point

		 - **True**

		 - DONE **False**

		 - 6.

		 - Question 6

		 - One can overwrite a SIGINT default handler with a custom handler.

		 - 1 point

		 - DONE **True**

		 - **False**

		 - 7.

		 - Question 7

		 - Is the following statement true or false?

		 - Blocked signals are lost because the kernel drops these signals.

		 - 1 point

		 - **True**
			 - WRONG

		 - DONE **False**

		 - 8.

		 - Question 8

		 - Is the following statement true or false?

		 - The more advanced **sigaction()** function provides the means to query for the most recent action associated with the signal, prior to any new actions being taken.

		 - 1 point

		 - DONE **True**

		 - **False**

		 - 9.

		 - Question 9

		 - Consider a scenario where we have the following function that returns the round trip time to a server.

		 - ping google.com

		 - PING google.com (172.217.6.206): 56 data bytes

		 - 64 bytes from 172.217.6.206: icmp_seq=0 ttl=57 time=17.343 ms

		 - 64 bytes from 172.217.6.206: icmp_seq=1 ttl=57 time=17.436 ms

		 - 64 bytes from 172.217.6.206: icmp_seq=2 ttl=57 time=33.575 ms

		 - Suppose we run the above program in the background, which of the following methods allows us to terminate the ping process right after starting this process? Select all that apply.

		 - 2 points

		 - **Press ctrl-C**

		 - DONE **Send a SIGKILL to the ping process based on its process ID**

		 - DONE **Type in 'kill %1'**

		 - 10.

		 - Question 10

		 - Consider the pipelined process

		 - sleep 10 | sleep 15

		 - What is the number of seconds for which the above process group will block? Enter your answer as a number in the space provided below. Do not enter any spaces or punctuation.
			 - DONE 15

		 - 1 point

		 - **Honor Code Agreement**

		 - I understand that submitting work that isn’t my own may result in permanent failure of this course or deactivation of my Coursera account. Learn more about Coursera’s Honor Code

	 - Lesson 6: Key Takeaways from Module 6

- Module 7: Concurrency Control and Synchronization
	 - Lesson 1: Module Introduction

	 - Lesson 2: Test and Set Lock
		 - TSL is an alternative busy waiting solution for concurrency control (alternative to Peterson problem).

		 - TSL is a special hardware instruction that combines getting and setting a memory value (so that nothing messes with it in between)

		 - But it still has all the disadvantages of busy waiting, i.e., wasting CPU cycles.

	 - Lesson 3: Blocking Solutions for Mutual Exclusions
		 - Instead of a process busily checking critical section, it goes to sleep and is woken up by the OS when ready.

		 - Lost wakeup problem: bad solution

		 - Semaphores: Kernel object with an integer value. Binary semaphore is like TSL without busy waiting.

	 - Lesson 4: Higher-Level Abstraction for Mutual Exclusion
		 - Problems in synchronization
			 - Dining philosophers problem

			 - Bounded buffer problem

			 - Readers-writers problem

		 - Solutions should be deadlock free, starvation free.

	 - Lesson 5: Key Takeaways from Module 7

- Module 8: Deadlocks
	 - Lesson 1: Module Introduction

	 - Lesson 2: Introduction to Deadlocks
		 - Deadlock is when two (or more) processes are each waiting for something that is being held by the other process.

		 - Deadlocks are often solved by ad-hoc solutions (problem specific) rather than general solutions.

		 - Deadlock prevention via hierarchical allocation: classify low priority vs high priority processes.

		 - Deadlock detection: there are methods to analyze programs and find deadlocks.

	 - Lesson 3: Banker's Algorithm
		 - Banker's algorithm (a.k.a. Dijkstra's algorithm) is a method for deadlock avoidance.

	 - Lesson 4: Test Your Knowledge
		 - Is the following statement true or false? Select the best answer.

		 - Conditional variables and semaphores are functionally equivalent.

		 - 1 point

		 - **True**

		 - DONE **False**

		 - 2.

		 - Question 2

		 - Is the following statement true or false? Select the best answer.

		 - A binary semaphore can only have a value of either 0 or 1.

		 - 1 point

		 - DONE **True**

		 - **False**

		 - 3.

		 - Question 3

		 - Is the following statement true or false? Select the best answer.

		 - TSL (Test-and-Set) is a software-based solution for mutual exclusion.

		 - 1 point

		 - **True**

		 - DONE **False**

		 - 4.

		 - Question 4

		 - Is the following statement true or false? Select the best answer.

		 - The Test-and-Set (TSL) is superior to the Peterson’s solution because it does not result in busy waiting.

		 - 1 point

		 - **True**

		 - DONE **False**

		 - 5.

		 - Question 5

		 - Is the following statement true or false? Select the best answer.

		 - Two threads within the same process can write to the same memory.

		 - 1 point

		 - DONE **True**

		 - **False**

		 - 6.

		 - Question 6

		 - Is the following statement true or false? Select the best answer.

		 - “Starvation freedom” means that if a thread/process wants to enter a critical section, it will eventually be granted permission to enter.

		 - 1 point

		 - DONE **True**

		 - **False**

		 - 7.

		 - Question 7

		 - Is the following statement true or false? Select the best answer.

		 - In the context of semaphore implementations, “P” and “V” calls have to be **atomic** actions.

		 - 1 point

		 - DONE **True**

		 - **False**

		 - 8.

		 - Question 8

		 - Is the following statement true or false? Select the best answer.

		 - The Peterson’s solution does** not** require simple assignments and tests since the shared variables do not have to be __atomic__.

		 - 1 point

		 - **True**
			 - WRONG

		 - DONE **False**

		 - 9.

		 - Question 9

		 - P1 has resource R1, and is requesting for R2 and R3.

		 - P2 has resource R3, and is requesting for R4

		 - P3 has resource R4, and is requesting for R1

		 - P4 has resource R5 and is requesting for resource R6

		 - P5 has resource R6 and is requesting for resource R3

		 - For the situation listed above, which of the following **processes** that are involved in the deadlock? Select all that apply

		 - 2 points

		 - DONE **P1**

		 - DONE **P2**

		 - DONE **P3**

		 - **P4**
			 - WRONG

		 - **P5**
			 - WRONG

		 - 10.

		 - Question 10

		 - P1 has resource R1, and is requesting for R2 and R3.

		 - P2 has resource R3, and is requesting for R4

		 - P3 has resource R4, and is requesting for R1

		 - P4 has resource R5 and is requesting for resource R6

		 - P5 has resource R6 and is requesting for resource R3

		 - For the situation listed above, which of the following **resources** that are involved in the deadlock? Select all that apply

		 - 2 points

		 - DONE **R1**

		 - **R2**
			 - WRONG

		 - DONE **R3**

		 - DONE **R4**

		 - **R5**
			 - WRONG

		 - **R6**
			 - WRONG

		 - 11.

		 - Question 11

		 - Which of the following solutions to the deadlock in the Dining Philosophers problem always allow close to half the philosophers to eat simultaneously? Select the best answer.

		 - 2 points

		 - **Make get **chopstick[i] **and get **chopstick[i+1 mod N] **atomic by surrounding with a global binary (“mutex”) semaphore**

		 - DONE **Reverse the order of get **chopstick[i]** and get **chopstick[i+1 mod N]** for every other philosopher**

		 - **After taking the left fork, the program checks if the right fork is available. If not, put down left fork, wait for some time, and retry**

		 - **Token ring. Each philosopher gets to eat once in a round robin fashion.**

		 - 12.

		 - Question 12

		 - Suppose that Alice and Bob are customers in a bank. Alice currently has a balance of $300 and Bob has a balance of $700. They make the following transactions: Alice transfers $200 to Bob and Bob transfers $600 to Alice, using two different processes that uses the following code:

		 - Process for Alice:
			 - B = Balance (Bob)

			 - A = Balance (Alice)

			 - SetBalance(Bob, B + $200)

			 - SetBalance(Alice, A - $200)

		 - Process for Bob:
			 - A = Balance (Alice)

			 - B = Balance (Bob)

			 - SetBalance(Alice, A + $600)

			 - SetBalance(Bob, B - $600)

		 - If there is no mutual exclusion and all steps can be interleaved, what is the minimum amount that Alice can end up with in her bank account after both processes are executed? You can assume that the balances of Alice and Bob are in shared memory and can be modified by either process.

		 - 2 points

		 - **$900**
			 - WRONG

		 - **$700** (other possible answer other than 900)

		 - DONE **$100**

		 - **$300**

		 - 13.

		 - Question 13

		 - Suppose that Alice and Bob are customers in a bank. Alice currently has a balance of $300 and Bob has a balance of $700. They make the following transactions: Alice transfers $200 to Bob and Bob transfers $600 to Alice, using two different processes that uses the following code:

		 - Process for Alice:
			 - B = Balance (Bob)

			 - A = Balance (Alice)

			 - SetBalance(Bob, B + $200)

			 - SetBalance(Alice, A - $200)

		 - Process for Bob:
			 - A = Balance (Alice)

			 - B = Balance (Bob)

			 - SetBalance(Alice, A + $600)

			 - SetBalance(Bob, B - $600)

		 - Using the same scenario as in the question above, consider the following execution sequence:

		 - **Time****Process 1****Process 2**

		 - 01. B = Balance (Bob)1. A = Balance (Alice)

		 - 13. SetBalance (Bob, B + $200)3. SetBalance (Alice, A + $600)

		 - 22. A = Balance (Alice)2. B = Balance (Bob)

		 - 34. SetBalance (Alice, A - $200)4. Set Balance (Bob, B - $600

		 - At each time X, process 1 and 2 execute each action concurrently (whether process 1 or process 2’s statement runs first may be different every time, however, time 1 happens after time 0, and time 2 happens after time 1, etc.)

		 - What is the balance of Alice and Bob, respectively at the end of time X = 3?

		 - Enter your answer for the balance of Alice first, followed by your answer for the balance of Bob.

		 - DONE Enter your answer for Alice and then Bob separated by commas.
			 - 700, 300

		 - For example, you would enter 100, 500 if the output for Alice is 100 and the output for Bob is 500.

		 - 2 points

		 - **Honor Code Agreement**

		 - I understand that submitting work that isn’t my own may result in permanent failure of this course or deactivation of my Coursera account. Learn more about Coursera’s Honor Code

	 - Lesson 5: Key Takeaways from Module 8

- INTERLUDE: Modules 1- 8: Review for exam 1
	 - Concurrency issues
		 - Starvation: threads are unable to access critical section (i.e. piece of code where only one process can run at a time).

		 - Deadlock: multiple threads blocking each other from critical section

		 - Violation of mutual exclusion: multiple threads are overwriting each other's work

	 - Concurrency solutions for mutual exclusion
		 - 1. Disable interrupts - 
			 - overkill solution; makes the threads run in series rather than parallel. Overkill because we are also preventing important OS interrupts (e.g. clock interrrupts)

		 - 2. Software or hadware busy waiting
			 - 2.a. Peterson's solution - atomic statements
				 - Multiple lines of code map to single assembly instruction to force entire critical section to occur at once.

				 - Three shared boolean variables
					 - turn, flag[2]

					 - flag means thread wants to enter critical section; turn means thread has priority to enter critical section

					 - Code to enter CS
						 - flag[me] = TRUE

						 - turn = me

						 - while (turn==ME) && (flag[1-ME]==TRUE)
							 - ; /*busy wait*/

					 - Code to exit CS
						 - flag[me] = FALSE

				 - Pros
					 - Ensures mutual exclusion and protects critical section

					 - Straightforward implementation for 2 threads

				 - Cons
					 - Involves busy waiting: each thread / process is constantly using CPU cycles to check whether or not it can enter the critical section.

					 - Does not generalize well for > 2 threads

			 - 2.b. TSL - test and set lock
				 - TSL is a special hardware instruction that combines getting and setting a memory value (so that nothing interferes with it in between)

				 - Example
					 - Int lock = 0;

					 - While(TestAndSet(&lock) == 1); //busy wait
						 - //critical section

						 - lock = 0;  //indicate done with CS

				 - Pros
					 - Simpler than Peterson's

					 - Works on multiple threads

				 - Cons
					 - Involves busy waiting!

					 - Needs ISA / hardware support

		 - 3. Blocking system calls
			 - 3a. Process sleep and wakeup
				 - Busy waiting can be avoided but incurs the overhead associated with putting a process to sleep and having to wake it up when the appropriate program state is reached.

				 - Each process goes to sleep when blocked and is woken up by the other process.

				 - Bad solution: the wakeup call might be lost due to race condition.

			 - 3b. Semaphores and Mutexes
				 - Semaphore: like TSL without busy waiting. General abstraction for busy waiting.

				 - Two operations: 
					 - P (wait / try to block)  - if value is greater than zero, decrement; place process in the waiting Q

					 - V (signal / wakeup) - increase the value; place process in ready Q

				 - Example
					 - BinarySemaphore s(1); // semaphore, initial value: 1

					 - void doSomething() {
						 - s.P();

						 - // critical section; do something important...

						 - s.V();

						 - }

				 - Mutex is a binary semaphore.

		 - 4. Monitors
			 - High level OS solution using a queue system to control critical section access

			 - Conditional variable: Like semaphore. Used in monitor. Two operations on condition varaiable
				 - x.wait() - block

				 - x.signal() - resume

	 - Famous problems
		 - Dining philosophers
			 - Num philosophers (threads) = Num chopsticks (resources)

			 - Solutions
				 - Semaphores
					 - + Ensures mutual exclusion

					 - - Could result in deadlock: everyone first picks up the left chopstick, and then everyone tries to pick up the right chopstick which is where they all block each other.

				 - Add another mutex (like Peterson's)
					 - + Ensures mutual exclusion

					 - - Busy waiting; possible deadlock

				 - Change the order
					 - E.g. reverse the order of chopstick[i] and chopstick[i+1 mod N] for every other philosopher. Even philosophers follow first order, odd philosophers follow second order.

					 - + Ensures mutual exclusion

					 - - Waiting may cause deadlock or starvation

				 - Token ring
					 - + Ensures mutual exclusion; no deadlocks or starvation.

					 - - Sacrifices concurrency; only one eats at a time.

		 - Bounded buffer problem / producer - consumer problem
			 - N buffers, each holds 1 item

			 - Three semaphores
				 - Mutex = 1 (ensure only one process can update buffer)

				 - Full = 0 (available resources in buffer)

				 - Empty = N (empty space in buffer)

			 - Code
				 - 
```javascript
/*
* Structure for the Producer Process
*/
do {
  //produce an item in nextp
  wait (empty);
  wait (mutex);
  //add the item nextp to the buffer
  signal (mutex);
  signal (full);
} while (TRUE);

/*
* Structure for the Consumer Process
*/
do {
  wait (full);
  wait (mutex);
  //remove an item from buffer to nextc
  signal (mutex);
  signal (empty);
  //consume the item in nextc
} while (TRUE);
```

				 - 

		 - Readers and writers problem
			 - Shared Data
				 - • Data Set

				 - • Semaphore mutex initialized to 1

				 - • Semaphore wrt initialized to 1

				 - • Integer readcount initialized to 0

			 - 
```javascript
/*
* Structure for the Writer Process
*/
do {
wait (wrt) ;
//writing is performed
signal (wrt) ;
} while (TRUE);

/*
* Structure for the Reader Process
*/
do {
wait (mutex) ;
readcount ++ ;
if (readcount == 1)
wait (wrt) ;
signal (mutex)
// reading is performed
wait (mutex) ;
readcount-- ;
if (readcount == 0)
signal (wrt) ;
signal (mutex) ;
} while (TRUE);
```

			 - Solution suffers from starvation

	 - Thread and process management
		 - Threads are lite version of process.

		 - Issues
			 - Zombie: Child has completed, but still listed in OS process table, because parent hasn't called wait().

			 - Orphan: Child is running, but parent has terminated. Orphan will be reclaimed by init process.

			 - Daemon: Helpful background process that is owned by init.

	 - Deadlocks
		 - Preconditions for deadlock
			 - 1. Mutual exclusion

			 - 2. No resource pre-emption

			 - 3. Hold and wait

			 - 4. Circular waiting

		 - Prevention
			 - Ad-hoc approach
				 - E.g reversing order of philosophers chopsticks

			 - Exhaustive search approach: Banker's / Dijkstra's algorithm
				 - Checking all possible combinations to ensure no deadlocks

				 - Pros
					 - Safe

				 - Cons
					 - Inefficient

- Module 9: Introduction to Memory Management
	 - Lesson 1: Module Introduction

	 - Lesson 2: Introduction to Memory Management
		 - Memory allocation approaches
			 - Fixed partitions (must decide partition boundaries in advance)

			 - Base and limit register (requires hardware support) - can use malloc

		 - Linux uses buddy algorithm to allocate memory

	 - Lesson 3: [Comic] Boon's First Computer

	 - Lesson 4: Alumni Interviews

	 - Lesson 5: Key Takeaways from Module 9

- Module 10: Memory Management Architecture
	 - Lesson 1: Module Introduction

	 - Lesson 2: Virtual Memory Architecture
		 - Mapping from virtual memory (used by processes) to physical addresses; uses page tables.

	 - Lesson 3: Page Table Architecture
		 - Paging: divide physical memory into chunks called page-frames.

		 - Page table translates page to frame.

	 - Lesson 4: Advanced Page Tables

	 - Lesson 5: Page Replacement Policies

	 - Lesson 6: Test Your Knowledge
		 - Is the following statement true or false?

		 - Consider a page **p** stored in physical frame** f**. When accessing page p, the corresponding TLB will only get updated in the event of a TLB miss for **p**.

		 - 1 point

		 - **True**

		 - DONE **False**

		 - 2.

		 - Question 2

		 - Is the following statement true or false?

		 - The best-fit memory allocation scheme always results in less fragmentation and satisfies more block requests compared to the first-fit scheme.

		 - 1 point

		 - **True**

		 - DONE **False**

		 - 3.

		 - Question 3

		 - Is the following statement true or false?

		 - The TLB is motivated by the fact that accessing the disk is much slower than accessing main memory.

		 - 1 point

		 - **True**

		 - DONE **False**

		 - 4.

		 - Question 4

		 - Is the following statement true or false?

		 - The LRU page replacement policy is a stack algorithm.

		 - 1 point

		 - DONE **True**

		 - **False**

		 - 5.

		 - Question 5

		 - Is the following statement true or false?

		 - When the degree of multiprogramming increases, the CPU utilization will always increase and eventually saturate at 100%.

		 - 1 point

		 - **True**

		 - DONE **False**

		 - 6.

		 - Question 6

		 - Which is the following correctly reflects the maximum number of entries in an inverted page table?

		 - 1 point

		 - **Total number of virtual pages of all processes (blocked, ready, running).**

		 - **Number of virtual pages of the currently running processes**

		 - DONE **Number of page frames in physical memory**

		 - 7.

		 - Question 7

		 - In a 64-bit machine that has 4 KB page size, how many entries are there in the page table?
			 - DONE 2^64 / 2^12 = 2^52

		 - Please enter your answer as an exponent of the number 2.

		 - For example: if your answer is 1048576, enter 2^20 as your answer in the space provided below. Do not use spaces or punctuation.

		 - 1 point

		 - **Honor Code Agreement**

		 - I understand that submitting work that isn’t my own may result in permanent failure of this course or deactivation of my Coursera account. Learn more about Coursera’s Honor Code

	 - Lesson 7: Key Takeaways from Module 10

- Module 11: External I/O (Input / Output) Devices
	 - Lesson 1: Module Introduction

	 - Lesson 2: I/O Architecture

	 - Lesson 3: Device Drivers

	 - Lesson 4: Network Programming
		 - Socket is an OS abstraction for communication between endpoints. Two types of sockets: Stream, datagram
			 - Stream socket (aka TCP) - connection oriented; all messages are ordered together

			 - Datagram socket (aka UDP) - conectionless; messages are separate

	 - Lesson 5: Introduction to Project 3

	 - Lesson 6: Key Takeaways from Module 11

- Module 12: Network Programming Design: Efficiency Techniques and Internet Architecture
	 - Lesson 1: Module Introduction

	 - Lesson 2: Multi-threaded Network Programming
		 - Networking involves blocking system calls: accept, read, write

		 - Multi-threading is a method of avoiding blocking

		 - Right after the server accepts a client connection, we spin up a new thread using pthread.

		 - Downsides of multi-threading include OS overhead for context-switching and concurrency

	 - Lesson 3: Event-driven Asynchronous Network Programming
		 - We use the blocking calls (like read) asynchronously using callbacks. Downside is that we need to explicitly maintain __state__.

	 - Lesson 4: Project 3, Part b, and Part c

	 - Lesson 5: Internet Architecture
		 - Layers: application, transport, network, data

	 - Lesson 6: Test Your Knowledge
		 - In Socket programming, the **listen(…)** call issued by the server is a blocking call.

		 - 1 point

		 - **True**

		 - DONE **False**

		 - 2.

		 - Question 2

		 - Is the following statement true or false?

		 - **HTTP** usually runs over **UDP**.

		 - 1 point

		 - **True**

		 - DONE **False**

		 - 3.

		 - Question 3

		 - Is the following Statement true or false?

		 - In event-driven programming, the event handlers are usually short-lived.

		 - 1 point

		 - DONE **True**

		 - **False**

		 - 4.

		 - Question 4

		 - Is the following statement true or false?

		 - Threads within a process share the same memory space.

		 - 1 point

		 - DONE **True**

		 - **False**

		 - 5.

		 - Question 5

		 - Is the following statement true or false?

		 - Ephemeral port numbers range from 0 to 1023.

		 - 1 point

		 - **True**

		 - DONE **False**

		 - 6.

		 - Question 6

		 - Which of the following correctly differentiates TCP and UDP? Select all that apply.

		 - 2 points

		 - DONE **TCP is reliable but UDP is not.**

		 - DONE **TCP ensures in-order delivery of messages but messages in UDP can be reordered.**

		 - DONE **TCP presents a byte-oriented abstraction to applications while UDP presents a packet abstraction.**

		 - 7.

		 - Question 7

		 - Consider an application which sends data periodically across the network to another application on the other side of the world. The message delivery is unreliable because of the long-distance and message losses along the way. The application sends messages at regular fixed intervals, (M1, M2, M3…) and it is acceptable if some messages are dropped but not acceptable if messages are delayed and delivered at irregular time intervals.

		 - For example, if M1, M2, and M3 are sent at 5-second intervals, it is acceptable for the receiver to get M1, lose M2, and then receive M3 around ten seconds later. However, it is not acceptable to get M2 twenty seconds after M1.

		 - Which of the following should we use in this scenario? Select the best answer.

		 - 2 points

		 - DONE **UDP**

		 - **TCP**

		 - **Honor Code Agreement**

		 - I understand that submitting work that isn’t my own may result in permanent failure of this course or deactivation of my Coursera account. Learn more about Coursera’s Honor Code

	 - Lesson 7: Key Takeaways from Module 12

- Module 13: The OS File System
	 - Lesson 1: Module Introduction

	 - Lesson 2: File System from the OS Perspective

	 - Lesson 3: The File System on the Disk

	 - Lesson 4: I-Nodes

	 - Lesson 5: File System Features for Performance and Robustness

	 - Project 3, Part c Submission

	 - [Comic] Boon's Internship at IBM

	 - Lesson 6: Key Takeaways from Module 13

- Module 14: Virtualization
	 - Lesson 1: Module Introduction

	 - Lesson 2: Introduction to Virtualization

	 - Lesson 3: Virtualization Implementation

	 - Lesson 4: Alternative Virtualization Technologies

	 - Lesson 5: Test Your Knowledge
		 - Is the following statement true or false?

		 - The CD-ROM uses contiguous allocation scheme for storing files.

		 - 1 point

		 - DONE **True**

		 - **False**

		 - 2.

		 - Question 2

		 - Is the following statement true or false?

		 - In a Type 1 hypervisor, the VMM is simply another user-level process, run and managed by the host operating system.

		 - 1 point

		 - **True**

		 - DONE **False**

		 - 3.

		 - Question 3

		 - Is the following statement true or false?

		 - In containers/zones, every container must run a unique operating system.

		 - 1 point

		 - **True**

		 - DONE **False**

		 - 4.

		 - Question 4

		 - Is the following statement true or false?

		 - In virtual machines, guest physical memory may sometimes be absent from host physical memory and is instead stored somewhere on disk in the swap file.

		 - 1 point

		 - DONE **True**

		 - **False**

		 - 5.

		 - Question 5

		 - Is the following statement true or false?

		 - The linked-list file allocation scheme results in no external fragmentation.

		 - 1 point

		 - DONE **True**

		 - **False**

		 - 6.

		 - Question 6

		 - Is the following statement true or false?

		 - A logical dump always dumps all directories even if they are unmodified.

		 - 1 point

		 - **True**

		 - DONE **False**

		 - 7.

		 - Question 7

		 - Is the following statement true or false?

		 - In UNIX, cached i-node blocks are updated using write-through caching techniques.

		 - 1 point

		 - DONE **True**

		 - **False**

		 - 8.

		 - Question 8

		 - Is the following statement true or false?

		 - In virtual machines, there is always a one-to-one mapping between a vCPU and actual physical CPU.

		 - 1 point

		 - **True**

		 - DONE **False**

		 - 9.

		 - Question 9

		 - Is the following statement true or false?

		 - DMA provides direct access between memory and an I/O device.

		 - 1 point

		 - DONE **True**

		 - **False**

		 - 10.

		 - Question 10

		 - Is the following statement true or false?

		 - Directory entries are stored in i-nodes.

		 - 1 point

		 - **True**

		 - DONE **False**

		 - 11.

		 - Question 11

		 - Is the following statement true or false?

		 - The boot block is used to load the OS into kernel space.

		 - 1 point

		 - DONE **True**

		 - **False**

		 - **Honor Code Agreement**

		 - I understand that submitting work that isn’t my own may result in permanent failure of this course or deactivation of my Coursera account. Learn more about Coursera’s Honor Code

	 - [Comic] Boon and Students' Virtualization Start-Up

	 - Lesson 6: Alumni Interviews

	 - Lesson 7: Key Takeaways from Module 14

- Module 15: Course Conclusion

- FINAL EXAM study
	 - Memory
		 - Memory allocation
			 - Naive idea 1: Fixed partitions
				 - Allocate fixed partition boundaries for OS and programs in advance

			 - Naive idea 2: Base and limit registers
				 - Each program gets a base register (lower bound) and limit register (upper bound). Hardware support needed.

			 - Managing free space: bitmaps
				 - Vector of 1s and 0s to specify availability. Not efficient to search for k consecutive 0s.

			 - Managing free space: linked lists
				 - Doubly linked list of tuples: <label, first address, size>

			 - Memory allocation strategies
				 - First fit: find the first hole large enough

				 - Best fit: find the tightest hole

				 - Worst fit: find the largest hole

			 - Fragmentation
				 - Internal fragmentation: OS allocates more space for a program than the program actually uses.

				 - External fragmentation: Excess space that is too small to fit new programs.

			 - Buddy algo: linux memory allocator
				 - Allocation: Memory is allocated in fixed "pages" and requests are rounded up to power of 2 number of pages. Memory chunks are repeatedly halved until the request can be satisfied.

				 - Lookup: table with page sizes pointing to the addresses (offsets) of free tables.

				 - Problem: internal fragmentation due to rounding up. (dealt with by slab allocation).

		 - Virtual memory
			 - Paging: mapping from virtual memory (used by processes) to physical addresses

			 - 32-bit address = 2^32 bytes of virtual memory

		 - Page table architecture
			 - Physical memory divided into page __frames__ (4kb default); Virtual memory divided into __pages__ of same size.

			 - 32-bit address (Byte addressable) machine example
				 - Address space = 2^32 Bytes = 4GB

				 - Page size = 4kb = 2^12 Bytes

				 - Number of pages = address space / page size = 2^32 / 2^12  = 2^20

			 - Paging
				 - 

			 - 10-bit
				 - 2^30 / 2^12 = 

			 - Page = page p + offset o; in 16-bit computer, first 6 bits are p, last 10 bits are offset

			 - Page size = 2^n Bytes, then number of offset bits =  n

		 - MMU translates from virtual address (p, o) to physical address (f, o)
			 - Offset o is copied directly

			 - Page p is mapped to f using the first n bits of the virtual address

		 - Swap file
			 - Starts empty; created on demand as pages spill to disk

			 - Each page being swapped gets a block number in swap file

			 - Pages are freed -> holes in swap

			 - Bitmap used to find holes
