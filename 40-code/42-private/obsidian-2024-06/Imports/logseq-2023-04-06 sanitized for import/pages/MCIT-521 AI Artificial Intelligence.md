---
title: MCIT-521 AI Artificial Intelligence
---

- === LECTURE NOTES ===
	 - M1: Course Introduction & Rational Agents

	 - M2: Python Review / HW1
		 - Quiz
			 - Question 1

			 - Which of the following lines of code does NOT have the same result as the others?

			 - 1 point

			 - **"%s%s%s" %('a', 'b', 'c')**

			 - DONE **[x for x in ‘abc’]**

			 - **"".join(['a', 'b', 'c'])**

			 - **“a” + “b” + “c”**

			 - 2.

			 - Question 2

			 - What is called when a function is defined inside a class?

			 - 1 point

			 - **Module**

			 - **Class**

			 - DONE **Method**

			 - **Subfunction**

			 - 3.

			 - Question 3

			 - Select all of the valid Python (version 3) lists from the options below.

			 - __(_add_, _sub_, _mult_, and _div_ are functions that have been defined elsewhere.)__

			 - 1 point

			 - DONE **[1, 2, “hello”]**

			 - DONE **[None, None, [“AI”]]**

			 - **[add, sub, mult, div].**

			 - **[_ for _ in 1, 2, 3, 4, 5]**

			 - 4.

			 - Question 4

			 - The following is valid Python code.

			 - >>> my_tuple = (4, 1, 2)

			 - >>> my_tuple[0] = 3

			 - 1 point

			 - DONE **False**

			 - **True**

			 - 5.

			 - Question 5

			 - A hash function takes a message of fixed length and generates a code of variable length.

			 - 1 point

			 - DONE **False**

			 - **True**

			 - 6.

			 - Question 6

			 - Some mathematical operations can be performed on a string.

			 - 1 point

			 - DONE **True**

			 - **False**

			 - 7.

			 - Question 7

			 - A Python tuple can also be created without using parentheses.

			 - 1 point

			 - DONE **True**

			 - **False**

			 - 8.

			 - Question 8

			 - Which of the following statement is correct?

			 - 1 point

			 - **A Python function can return only a single value. **

			 - DONE **A function can take an unlimited number of arguments. **

			 - **Python function does not return unless you add a return statement.**

			 - **Python does not support nested function.**

			 - ****

			 - I understand that submitting another’s work as

	 - M3: Uninformed Search / HW2
		 - Uninformed = don't use any additional information, only use information from problem definition

		 - Formulate search problem as a set of states and transitions in a tree / graph; search strategy is the order of tree expansion

		 - Quiz
			 - What is the process of looking for a sequence of actions that reaches the goal called?

			 - 1 point

			 - DONE **The search problem.**

			 - **The shortest path.**

			 - **The agent program.**

			 - **The agent function.**

			 - 2.

			 - Question 2

			 - Which of the following are necessary to formally define a problem for a problem-solving agent?

			 - 1 point

			 - DONE **Specifying the outcome of each action that the agent could take.**

			 - DONE **Whether the agent has reached its goal.**

			 - **The list of all goals that the agent could potentially attempt. **

			 - DONE **The initial state that the agent starts in.**

			 - 3.

			 - Question 3

			 - Which of the following is a reason to use depth-first search (DFS) over breadth-first search (BFS)?

			 - 1 point

			 - **Depth-first search can be used to solve a larger set of problems. **

			 - DONE **Depth-first search has a lower space complexity  than BFS in the worst case.**

			 - **Depth-first search has a lower time complexity than BFS in the worst case.**

			 - **Depth-first search can find paths that breadth-first search would not be able to.**

			 - 4.

			 - Question 4 (SELECT MORE)

			 - Which of the following about tree search and graph search is correct?

			 - 1 point

			 - **Graph search is the same as tree search, just a different name of the same search algorithm.**

			 - DONE **If a state is reachable via multiple paths, tree search will create two separate nodes corresponding to each path.**

			 - DONE **Graph search checks if a node has been visited before adding it to the search queue. **

			 - **Tree search checks if a node has been visited before adding it to the search queue.**

			 - 5.

			 - Question 5 (SELECT MORE)

			 - Which of the following is a reason to use breadth-first search (BFS) over depth-first search (DFS)?

			 - 1 point

			 - DONE **BFS is complete even for infinite-depth search space. **

			 - **BFS is optimal for problems with unit costs (all actions have the same cost).**

			 - **Breadth-first search has lower asymptotic space complexity than DFS in the worst case.**

			 - **BFS always finds the solution faster than DFS when the search space is small.**

			 - 6.

			 - Question 6

			 - Depth-first search has, in general, much lower space complexity than iterative deepening.

			 - 1 point

			 - **True**

			 - DONE **False**

			 - 7.

			 - Question 7

			 - If you are working with restricted memory, it would be preferable to use:

			 - 1 point

			 - DONE **DFS**

			 - **BFS**

			 - ****

			 - I understand that submitting another’s work as my own can result in zero credit for this assignment. Repeated violations of the Coursera Honor Code may result in removal from this course or deactivation of my Coursera account. Learn more about Coursera’s Honor Code

	 - M4: Informed Search / HW3
		 - Quiz
			 - Which of the following algorithms search algorithms utilize a priority queue?

			 - **1 point**

			 - DONE **Greedy Best-First Search**

			 - DONE **Uniform Cost Search**

			 - DONE **A* Search**

			 - **Breadth-First Search**

			 - 2.
				 - Question 2

				 - Which of the following is true about greedy best-first search?

				 - **1 point**

				 - **It is complete and always returns a solution.**

				 - **It expands nodes farthest from the goal first to reach the solution quickly.**

				 - DONE **At each step, the node with the minimal value as computed by the heuristic function is expanded.**

				 - **It always produces the most optimal solution when a solution is returned.**

			 - 3.
				 - Question 3

				 - Which of the following is true about A* search?

				 - **1 point**

				 - **The heuristic can have negative values.**

				 - **Every consistent heuristic is also admissible.**

				 - DONE **If for two admissible heuristics, we always have h2(n)>=h1(n), h2(n) is more accurate than h1.**

				 - **The graph-search of A* is optimal as long as the heuristic is admissible.**

			 - 4.
				 - Question 4

				 - A* search uses heuristics to prune the search space so that the use of space is effectively O(bd).

				 - **1 point**

				 - **( ) True**

				 - DONE **(X) False**

			 - 5.
				 - Question 5

				 - Consider two consistent and admissible heuristics, h1 and h2, in an A∗ search seeking to minimize path costs in a graph. Assume ties don’t occur in the priority queue. If h1(d) ≤ h2(d) for all d, then

				 - **1 point**

				 - **A∗ search using h2 will find a lower-cost path than A∗ search using h1.**

				 - **A∗ search using h1 will not expand more nodes than A∗ search using h2.**

				 - **A∗ search using h1 will find a lower-cost path than A∗ search using h2.**

				 - DONE **A∗ search using h2 will not expand more nodes than A∗ search using h1.**

			 - 6.
				 - Question 6

				 - It is always better to use a heuristic function with high values.

				 - **1 point**

				 - **True**

				 - DONE **False**

			 - 7.
				 - Question 7

				 - A well-designed heuristic would have a value of branching factor close to 1.

				 - **1 point**

				 - **False**

				 - DONE **True**

				 - **Coursera Honor Code**  [Learn more](https://learner.coursera.help/hc/articles/209818863)

				 - ****

				 - I understand that submitting work that isn’t my own may result in permanent failure of this course or deactivation of my Coursera account.

	 - M5: Game and Adversarial Search / HW4
		 - Represent games as a search tree

		 - Quiz
			 - Select a component NOT present in the minimum set of components required to define a game as a search problem:

			 - **1 point**

			 - DONE **the amount of time each player has to make a move**

			 - **utility function**

			 - **the initial state**

			 - **terminal states**

			 - **set of legal moves that a player can make**

			 - 2.
				 - Question 2

				 - In a game search problem involving two players MAX and MIN, why can’t MAX just search for a single sequence of events from an initial state to a winning terminal state before the game starts?

				 - **1 point**

				 - DONE **Because the best possible move made by MAX at any point in time will depend on the previous move made by MIN**

				 - **Because games have large branching factors, this results in an intractably large search space, making this inefficient.**

				 - **Both A and B **

			 - 3.
				 - Question 3

				 - The minimax decision maximizes the utility under the assumption that the opponent will play perfectly to minimize it. If min does not play optimally, is it possible that max may be able to reach a higher score if it does not follow the minimax strategy?

				 - **1 point**

				 - **No**

				 - DONE **Yes**

			 - 4.
				 - Question 4

				 - Given a game in a non-terminal state, what does the evaluation function return?

				 - **1 point**

				 - **the true value of the utility of the game from a given position. **

				 - **the  true value of the expected utility of the game from a given position.**

				 - DONE **an estimate of the expected utility of the game from a given position.**

				 - **an estimate of the utility of the game from a given position.**

			 - 5.
				 - Question 5

				 - Given two different games BIG (with a very large branching factor and therefore an incredibly large search space) and SMALL (with a very small branching factor and therefore a really small search space), select the following statements that are true:

				 - **1 point**

				 - **All of the above.**
					 - WRONG

				 - **For the BIG game, Alpha Beta pruning has a larger effect on reducing space requirements than the time requirements of the Minimax algorithm (consider asymptotic behavior).**
					 - WRONG

				 - DONE **A Minimax algorithm with Alpha Beta Pruning will take approximately the same amount of time for finding solutions on the SMALL game as that without Alpha Beta pruning.**

			 - 6.
				 - Question 6

				 - Pick the following statements that are TRUE:

				 - **1 point**

				 - **Alpha-Beta pruning linearly reduces the number of nodes that need to be examined.**

				 - DONE **A limitation of Alpha-Beta pruning is the assumption that the leaf evaluations are randomly distributed across the last layer of the tree.**

				 - **The effectiveness of Alpha-Beta pruning does not depend on the ordering in which successors are examined. **
					 - WRONG

			 - 7.
				 - Question 7

				 - Given a game where the outcome of a player making a move is deterministic, Minimax and Expectiminimax will always produce the same solutions:

				 - **1 point**

				 - DONE **True**

				 - **False**
					 - WRONG

				 - **Not enough information.**

				 - **Coursera Honor Code**  [Learn more](https://learner.coursera.help/hc/articles/209818863)

				 - ****

	 - M6: Constraint Satisfaction Problem / HW5
		 - CSP consists of
			 - Variabes

			 - Possible values

			 - Constraints

		 - Quiz
			 - Which of the following is true?

			 - **1 point**

			 - **Constraint satisfaction approaches are only decidable on discrete domains.**

			 - **Constraint satisfaction approaches are only decidable on finite domains.**

			 - **None of the above.**
				 - WRONG: Constraint satisfaction is widely applicable in domains including real numbered-values and integer values with no upper bounds - however, there is not always a known sub-exponential algorithm to find the correct solution.

			 - DONE **Constraint satisfaction approaches cannot be solved in polynomial time on certain domains according to current theory.**

			 - 2.
				 - Question 2

				 - Which of the following problems would be best solvable using a CSP algorithm:

				 - **1 point**

				 - **Solving a puzzle in the fewest number of moves.**

				 - DONE **Determining the assembly order for a manufacturing line.**

				 - **Playing chess against a rational opponent.**

				 - **Navigating across a continent while minimizing fuel costs.**

			 - 3.
				 - Question 3

				 - If we have a problem that has a solution, and where each variable assignment has an associated cost, and the permissible assignments of each variable depend on the assignment of at least one other variable, a valid CSP algorithm will return:

				 - **1 point**

				 - **A solution which maximizes the total cost of the assignments.**

				 - **A solution which violates at least one of the constraints.**

				 - **A solution which minimizes the total cost of the assignments.**

				 - DONE **An arbitrary-cost solution satisfying the variable constraints.**

			 - 4.
				 - Question 4

				 - AC-3 is an example of an algorithm that processes

				 - **1 point**

				 - DONE **Binary constraints**

				 - **Unary constraints**

				 - **Higher-order constraints **

			 - 5.
				 - Question 5

				 - Which of the following is true?

				 - **1 point**

				 - DONE **AC3 can solve all sudoku puzzles in O(n^n+1) time, where n is the number of cells.**

				 - **AC3 can solve all sudoku puzzles in O(n^2) time, where n is the number of columns.**

				 - **AC3 can solve all sudoku puzzles in O(n^3) time, where n is the number of columns.**

				 - **There are sudoku problems which AC3 could never solve in a finite amount of time.** ****

			 - 6.
				 - Question 6

				 - What does “inference” mean in CSPs?

				 - **1 point**

				 - **Expanding the number of choices by seeing which domain variables are not yet used.**

				 - **Heuristically picking the next node to expand by looking for the one with the minimum conflicts.**

				 - DONE **Using problem constraints to reduce the number of legal values on variables.**

				 - **Generating successors by randomly choosing a new variable and assigning a value to it.**

			 - 7.
				 - Question 7

				 - Representing a problem formally (without regards to implementation) as a constraint satisfaction problem is an instance of __.

				 - **1 point**

				 - DONE **declarative programming**

				 - **reactive programming**

				 - **functional programming**

				 - **imperative programming**

			 - 8.
				 - Question 8

				 - In arc consistency checks we have a pair of nodes, X (in the tail of the arc) and Y (at the head of the arc).  In order to make X arc-consistent with Y, which of the following is true (assuming only inequality constraints):

				 - **1 point**

				 - **We remove values in Y that are present in X.**

				 - **We must check all values in Y.**

				 - DONE **We remove values from X that are present in Y.**

				 - DONE **We must check all values in X.**

				 - **Coursera Honor Code**  [Learn more](https://learner.coursera.help/hc/articles/209818863)

				 - ****

	 - M7: Logical Agents
		 - Knowledge based agents use knowledge and inference to reason about the world

		 - Quiz
			 - Which of the following terms appear in the CNF of (A ∧ B) ⇔ (C ∨ D)?

			 - **1 point**

			 - **A ∨ B ∨ ¬ C ∨ ¬ D**
				 - WRONG

			 - DONE **¬ C ∨ B**

			 - **A ∧ B**

			 - **D ∨ ¬ A**

			 - 2.
				 - Question 2

				 - Which of the following reduction rules is NOT used in the construction of the CNF of (A ∧ B) ⇔ (C ⋁ D)?

				 - **1 point**

				 - **Implication Elimination**
					 - WRONG

				 - **DeMorgan**

				 - **Biconditional Elimination**

				 - DONE **Distributivity of ∧ over ⋁**

			 - 3.
				 - Question 3

				 - Which of the following are true for a knowledge-based agent?

				 - **1 point**

				 - **The procedural approach to build a knowledge-based agent is to tell the sentences one by one to the agent.**
					 - NOT SELECT

				 - **The central component of a knowledge-based agent is its knowledge level.**

				 - DONE **The agent needs to tell the knowledge base what it perceives at the beginning of programming calls.**

				 - DONE **The agent may initialize a knowledge base with some background knowledge.**

			 - 4.
				 - Question 4

				 - Which of the following are desirable properties of an inference algorithm?

				 - **1 point**

				 - DONE **sound**

				 - **absolute**

				 - **non-monotonic **

				 - DONE **complete**

			 - 5.
				 - Question 5

				 - No logical agent can behave rationally in a partially observable environment.

				 - **1 point**

				 - **True**

				 - DONE **False**

			 - 6.
				 - Question 6

				 - Which of the following are true of the Wampas World task environment?

				 - **1 point**

				 - DONE **The environment is partially observable.**

				 - **The transition function is non-deterministic.**

				 - **It is a multi-agent environment with R2D2 and the Wampa.**

				 - **The agent has a smell sensor, a wind sensor, and a vision sensor.**

			 - 7.
				 - Question 7

				 - The CNF can be ___ larger than the simplest representation of a logical formula.

				 - **1 point**

				 - **polynomially longer **
					 - WRONG

				 - DONE **exponentially longer**

				 - **twice as long**
					 - WRONG

				 - **the same size always**
					 - WRONG

				 - **Coursera Honor Code**  [Learn more](https://learner.coursera.help/hc/articles/209818863)

				 - ****

	 - M8: Markov Decision Process / HW6
		 - MDP is like search, but it gives a policy rather than a specific set of moves; we want the optimal policy

		 - quiz
			 - Which of the following statements is true of a Markov decision process or MDP?

			 - **1 point**

			 - DONE **An MDP is defined for a fully observable, stochastic environment.**

			 - **An MDP has to have a reward function with discounted rewards, since current rewards are always more valuable to the agent than future rewards.**

			 - **A proper policy always exists for an MDP.**

			 - DONE **A solution or policy must specify what the agent should do for all states that it can reach.**

			 - 2.
				 - Question 2

				 - Select all the following components that the policy iteration algorithm equation takes into account.

				 - **1 point**

				 - DONE **All of the actions A that an agent can take.**

				 - DONE **The probability of entering a state S’ from state S after performing action A.**

				 - **The maximum reward that can be obtained after being in state S. **

				 - DONE **The utility associated with a state S.**

			 - 3.
				 - Question 3

				 - Policy is implicitly updated in value iteration.

				 - **1 point**

				 - DONE **True**

				 - **False**

			 - 4.
				 - Question 4

				 - Compared to value iteration, policy iteration often converges in fewer iterations but is more costly (i.e. greater time complexity) per iteration.

				 - **1 point**

				 - **False**

				 - DONE **True**

			 - 5.
				 - Question 5

				 - The utility function estimate must be completely accurate in order to get an optimal policy.?

				 - **1 point**

				 - DONE **False**

				 - **True**

			 - 6.
				 - Question 6

				 - Policy is explicitly updated in value iteration.

				 - **1 point**

				 - DONE **False**

				 - **True**

			 - 7.
				 - Question 7

				 - What is the principle of MEU?

				 - **1 point**

				 - **An agent should maximize their utilities.**

				 - DONE **An agent should maximize the weighted average of their utilities.**

				 - **An agent should do what feels good for me and you.**

				 - **Coursera Honor Code**  [Learn more](https://learner.coursera.help/hc/articles/209818863)

				 - ****

				 - I understand that submitting work that isn’t my own may result in permanent failure of this course or deactivation of my Coursera account.

		 - hw
			 - util.py
				 - important methods - argMax, totalcount

			 - 

	 - M9: Reinforcement Learning / HW7
		 - Passive learning: It's like MDP, but we're just inferring the transitional probs and rewards based on training in advance

		 - Active learning: Training on the flym 

		 - quiz
			 - Which of the following is given to the agent when using passive reinforcement learning? Check all that apply.

			 - **1 point**

			 - **The transition model P(s’ | s, a).**

			 - DONE **The agent’s policy π.**

			 - DONE **All of the states that can be reached by the agent.**

			 - **The reward function R(s) that specifies the reward for each state.**

			 - 2.
				 - Question 2

				 - Direct utility estimation computes a Utility function U by considering the connection between the utility of a state and the utility of its successor states.

				 - **1 point**

				 - DONE **False**

				 - **True**

			 - 3.
				 - Question 3

				 - Which of the following is true of both adaptive dynamic programming (ADP) learning and temporal-difference (TD) learning?

				 - **1 point**

				 - **A transition model is used in the calculation of the utility of a given state.**

				 - DONE **The utility of a state is adjusted locally to agree with the utility of at least one successor state.**

				 - **Multiple adjustments are made to utilities for each observed transition.**
					 - WRONG

				 - **A heuristic, such as the prioritized sweeping heuristic, can be used to make adjustments efficiently.**

			 - 4.
				 - Question 4

				 - Which of the following equations are updates for TD Q-learning?  Check all that apply.

				 - **1 point**

				 - **Q(s,a)←Q(s,a)+α(R(s)+γQ(s′,a′)−Q(s,a))**

				 - DONE **Q(s,a)←Q(s,a)+α(R(s)+γmaxa′Q(s′,a′)−Q(s,a))**

			 - 5.
				 - Question 5

				 - What is this equation $$

				 - U(s)=R(s)+\gamma \max _{a} \sum_{s^{\prime}} P\left(s^{\prime} \mid s, a\right) U\left(s^{\prime}\right)$$ ?

				 - **1 point**

				 - **Temporal difference learning**

				 - DONE **The Bellman equation**

				 - **Policy Iteration**

				 - **Policy extraction**

			 - 6.
				 - Question 6

				 - Q-learning with linear function approximation (weighted linear function of a set of features) will always converge to the optimal policy.

				 - **1 point**

				 - DONE **False**

				 - **True**

			 - 7.
				 - Question 7

				 - In reinforcement learning, a deterministic policy is

				 - **1 point**

				 - **A mapping from action to states**

				 - **A mapping from state-action pairs to states**

				 - DONE **A mapping from states to actions**

				 - ****

			 - **Coursera Honor Code**  [Learn more](https://learner.coursera.help/hc/articles/209818863)

	 - M10: Probabilities and Language Models / HW8
		 - quiz
			 - Which of the following must be true of the probabilities of two events, A and B, if A is independent of B?

			 - **1 point**

			 - DONE **P(A ∧ B) = P(A) P(B)**

			 - DONE **P(A | B) = P(A)**

			 - DONE **P(A ∨ B) = P(A) + P(B) - P(A ∧ B)**

			 - DONE **P(B | A) = P(B)**

			 - 2.
				 - Question 2

				 - Which of the following are equivalent to the joint probability P(X1,X2,X3,X4)? Check all that apply.

				 - **1 point**

				 - DONE ****P(X1)P(X2|X1)P(X3|X2,X1)P(X4|X3,X2,X1)****

				 - DONE **P(X1|X2,X3,X4)P(X4)P(X3|X4)P(X2|X3,X4)**

				 - DONE ****P(X2,X1)P(X3|X2,X1)P(X4|X3,X2,X1)****

				 - **P(X1)P(X2|X1)P(X3|X2)P(X4|X3)**

			 - 3.
				 - Question 3

				 - In a bigram model, one assumes that words w{i} and w{i - 2} are independent for i > 2.

				 - **1 point**

				 - DONE **True**

				 - **False**

			 - 4.
				 - Question 4

				 - When we compute a tri-gram, we normalize the following to add up to 1:

				 - **1 point**

				 - **the probabilities of all three-length sequences**

				 - DONE **the probabilities of all words w given w{i - 1}, w{i - 2}**

				 - **the prior probabilities of all words w**

			 - 5.
				 - Question 5

				 - How can we estimate the probability of a sentence P(w1, w2, …, wN)?

				 - **1 point**

				 - DONE **By applying the chain rule.**

				 - **Using alpha-beta pruning.**

				 - **By applying Bayes’ Rule.**

				 - **Using a Markov decision process.**

			 - 6.
				 - Question 6

				 - What is the effect of the Markov assumption in n-gram language models?

				 - **1 point**

				 - **Long distance relationships, like subject-verb agreement, are taken into account.**

				 - **The probability of a word is determined only by a single preceding word.**

				 - DONE **It makes it possible to estimate the probabilities from data.**

				 - **The probability of a word is determined by all previous words in the sentence.**

				 - **Coursera Honor Code**  [Learn more](https://learner.coursera.help/hc/articles/209818863)

				 - ****

	 - M11: Probabilistic Reasoning and Bayes' Nets
		 - Quiz
			 - The conditional probability distribution of a variable in a Bayesian network should be specified based on the probability distributions of all of the other variables (nodes).

			 - **1 point**

			 - DONE **False**

			 - **True**

			 - 2.
				 - Question 2

				 - Every variable in a Bayes net is independent of all of its descendants given its children.

				 - **1 point**

				 - DONE **False**

				 - **True**

			 - 3.
				 - Question 3

				 - Consider the Bayes Net image by following this link:

				 - https://artificial-intelligence-class.org/assets/img/quiz9bayes.png

				 - Write the joint probability for the Bayes’ Net given above, encoding its independence assumptions into your equation.

				 - **1 point**

				 - **P(A) * P(B)* P(C) * P(D) * P(E)**
					 - WRONG

				 - **P(A | D, C) * P(B | E)* P(C | D, E) * P(E) * P(D)**
					 - WRONG

				 - **P(A) * P(B)* P(C | A) * P(E | B) * P(D | A)**

				 - **P(A) * P(B)* P(C | A) * P(E | B, C) * P(D | A, C)**

			 - 4.
				 - Question 4

				 - Which of the following is true of locally structured (sparse) systems? Select all that apply.

				 - **1 point**

				 - **Every variable cannot be influenced by all of the others.**
					 - WRONG

				 - **Each subcomponent must interact directly with all the other components.**

				 - **All such systems are compact.**

				 - DONE **The structure grows linearly in complexity (rather than exponentially).**

			 - 5.
				 - Question 5

				 - More than one Bayesian network can be used to represent the same joint distribution.

				 - **1 point**

				 - **False**

				 - DONE **True**

			 - 6.
				 - Question 6

				 - If two variables (nodes) X and Y in a Bayesian network do not share a path, which of the following must be true?

				 - **1 point**

				 - **X and Y can never be true at the same time.**
					 - WRONG

				 - **X has a direct influence on Y.**

				 - DONE **X and Y are conditionally independent.**

				 - **There exists a causal relationship between X and Y.**

				 - **Coursera Honor Code**  [Learn more](https://learner.coursera.help/hc/articles/209818863)

				 - ****

	 - M12: Naive Bayes and Perceptrons / HW9
		 - Quiz
			 - The Naive Bayes model is “naive” because it assumes that the features are conditionally independent of each other, given the class.

			 - **1 point**

			 - DONE **True**

			 - **False**

			 - 2.
				 - Question 2

				 - Write down the form of the joint probability model P(X1,X2,X3,Y) for this data using the Naive Bayes assumption. (Y is the class)

				 - **1 point**

				 - **P(Y)P(X_1)P(X_2)P(X_3)**

				 - **P(Y)P(X_1 | Y)P(X_2 | X_1)P(X_3 | X_2)**

				 - **P(Y)P(X_1 | Y)P(X_2 | X_1, Y)P(X_3 | X_1, X_2, Y)**

				 - DONE **P(Y)P(X_1|Y)P(X_2|Y)P(X_3|Y)**

			 - 3.
				 - Question 3

				 - In the perceptron training algorithm, weights are updated after every training instance.

				 - **1 point**

				 - DONE **False**

				 - **True**

			 - 4.
				 - Question 4

				 - Consider a two-dimensional data distribution where points belonging to class A are arranged around the origin in a circle with radius ra, and points belonging to class B are arranged around the origin in a circle with radius rb, where ra<rb

				 - When applied to this classification problem, the perceptron algorithm

				 - **1 point**

				 - DONE **can separate the two classes if we use feature augmentation.**

				 - **cannot be used to separate the two classes.**

				 - **can separate the two classes if we decay the learning rate throughout training. **

				 - **can separate the two classes if we iterate through the instances in a suitable order.**

			 - 5.
				 - Question 5

				 - For which of the following datasets would a single perceptron be unable to find a separating boundary (assuming we do not add additional features to the data):

				 - **1 point**

				 - **Class A: {(0,0), (0,1), (1,0)}; Class B: {(1,1)}**

				 - **Class A: {(0,0), (0,1), (1,0), (1,1)}; Class B: {}**

				 - **Class A: {(0,0)}; Class B: {(0,1), (1,0), (1,1)}**

				 - DONE **Class A: {(0,0), (1,1)}; Class B: {(0,1), (1,0)}**

			 - 6.
				 - Question 6

				 - Given a non-random dataset, the perceptron algorithm guarantees that the weight vector will converge after a finite number of training iterations.

				 - **1 point**

				 - DONE **False**

				 - **True**

			 - 7.
				 - Question 7

				 - The inference procedure for the perceptron classification algorithm is best summarized as:

				 - **1 point**

				 - **Add a bias value to each feature, then compute a weighted sum.**

				 - **Try to do linear algebra, give up, and cast a "datum separatus" charm.**

				 - **Apply a threshold, and then compute a weighted sum.**

				 - **Compute the magnitude of the weight vector, then of the input vector, and then threshold their sum.**

				 - DONE **Compute a weighted sum, then apply a threshold.**

				 - **Coursera Honor Code**  [Learn more](https://learner.coursera.help/hc/articles/209818863)

				 - ****

	 - M13: Neural Networks / HW10
		 - Quiz
			 - Which of the following are true about linear classifiers? Please check all that apply.

			 - **1 point**

			 - DONE **They can be used for both regression and classification.**

			 - DONE **When using the perceptron learning rule, the weights are updated when the actual output does not match the hypothesis output.**

			 - **All sets of data points are linearly separable.**

			 - **The learning rule must be applied to one example at a time.**

			 - 2.
				 - Question 2

				 - Which of the following best characterizes the difference between parametric and nonparametric models?

				 - **1 point**

				 - **Instance-based learning and memory-based learning use parametric models.**

				 - **Parametric models cannot summarize data with a large number of training examples.**
					 - WRONG

				 - **Parametric models can be used if each hypothesis considers all of the other training examples to make the next prediction.**
					 - WRONG

				 - **A parametric model has a fixed size on the number of parameters.**

			 - 3.
				 - Question 3

				 - When performing k-means clustering, each observation always starts in its own cluster, and then pairs of clusters are merged in each iteration.

				 - **1 point**

				 - DONE **False**

				 - **True**

			 - 4.
				 - Question 4

				 - For linearly separable data, there exists only one decision boundary that separates the classes.

				 - **1 point**

				 - DONE **False**

				 - **True**

			 - 5.
				 - Question 5

				 - Is it possible that the assignment of observations to clusters do not change between successive iterations in K-Means?

				 - **1 point**

				 - DONE **Yes**

				 - **No**

			 - 6.
				 - Question 6

				 - Relative to single-layer perceptrons, neural networks gain their power from

				 - **1 point**

				 - **smooth activation function**

				 - **convolution**

				 - DONE **stacking of layers**

			 - 7.
				 - Question 7

				 - In neural networks, nonlinear activation functions: Please check all that apply.

				 - **1 point**

				 - **Are applied only to the output units.**

				 - DONE **Make it possible to do the gradient calculation in backpropagation, as opposed to using step function which isn't differentiable.**

				 - DONE **Help to learn nonlinear decision boundaries.**

				 - **Always output values between 0 and 1.**

				 - **Coursera Honor Code**  [Learn more](https://learner.coursera.help/hc/articles/209818863)

				 - ****

	 - M14: Natural Language Processing
		 - Quiz
			 - Which of the following is not a common benefit of using log probabilities instead of probabilities with a Categorical distribution?

			 - **1 point**

			 - **Underflow results from dealing with small floating point numbers, which is avoided using log probabilities.**

			 - DONE **A log probability representation of a categorical distribution is more efficient to sample.**

			 - **In certain instances, it’s easier to optimize over sums than products.**

			 - 2.
				 - Question 2

				 - Markov models are stationary because probabilities assigned to a sequence are invariant with respect to shifts in data [train, validation, test, etc.]

				 - **1 point**

				 - **True**

				 - DONE **False**

			 - 3.
				 - Question 3

				 - Cross Entropy:

				 - **1 point**

				 - DONE **is an upper bound on the entropy. The more accurate a model is, the lower the cross entropy.**

				 - **is a lower bound on the entropy. The more accurate a model is, the lower the cross entropy.**

				 - **is an upper bound on the entropy. The more accurate a model is, the higher the cross entropy.**

				 - **is a lower bound on the entropy. The more accurate a model is, the higher the cross entropy.**

			 - 4.
				 - Question 4

				 - Vector representations of words using term-document matrices and word-word matrices can account for polysemy.

				 - **1 point**

				 - **Not enough information.**

				 - DONE **False**

				 - **True**

			 - 5.
				 - Question 5

				 - How many tokens would the following sentence be broken into:

				 - ENIAC's construction was financed by the United States Army, Ordnance Corps, led by Major General Gladeon M. Barnes.

				 - **1 point**

				 - **22**

				 - **21**
					 - WRONG

				 - **24**

				 - **23**
					 - WRONG

			 - 6.
				 - Question 6

				 - Suppose you are building an n-gram model for a corpus with a vocabulary of size V and a total of T tokens. The running time to build this model depends on

				 - **1 point**

				 - **T**

				 - **n, T, and V**
					 - WRONG

				 - **n and T**

				 - **n and V**
					 - WRONG

			 - 7.
				 - Question 7

				 - What is the purpose of Laplace smoothing?

				 - **1 point**

				 - **to make generated sentences sound more realistic. **

				 - DONE **to account for unseen words.**

				 - **to avoid underflow.**

				 - **to improve running time.**

			 - 8.
				 - Question 8

				 - When generating random text, given some context C, an n-gram model cannot generate a next token T if the model never saw the context-token pair (C, T) during training.

				 - **1 point**

				 - DONE **True**

				 - **False**

				 - **Coursera Honor Code**  [Learn more](https://learner.coursera.help/hc/articles/209818863)

				 - ****

- === ASSIGNMENTS ===
	 - DONE M1 quiz due [[September 6th, 2021]] #2021-W36

	 - DONE M2 quiz due [[September 13th, 2021]] #2021-W36

	 - DONE HW1 due [[September 13th, 2021]] #2021-W36

	 - DONE M3 quiz due [[September 20th, 2021]] #2021-W37

	 - DONE HW2 due [[September 20th, 2021]] #2021-W37

	 - DONE Schedule midterm exam

	 - DONE M4 quiz due [[September 27th, 2021]] #2021-W38

	 - DONE HW3 due [[September 27th, 2021]] #2021-W38

	 - DONE M5 quiz due [[October 4th, 2021]] #2021-W39

	 - DONE HW4 due [[October 4th, 2021]] #2021-W39

	 - DONE M6 quiz due [[October 11th, 2021]] #2021-W40 #2021-W41

	 - DONE HW5 due [[October 11th, 2021]] #2021-W40 #2021-W41 

	 - DONE M7 quiz due [[October 18th, 2021]] #2021-W41

	 - DONE M8 quiz due [[November 1st, 2021]] #2021-W43

	 - DONE M9 quiz due [[November 8th, 2021]] #2021-W45 [[November 8th, 2021]]

	 - DONE HW6 due [[November 1st, 2021]] #2021-W43

	 - DONE M10 quiz due [[November 8th, 2021]] #2021-W45 [[November 8th, 2021]]

	 - DONE HW7 due [[November 8th, 2021]] #2021-W45

	 - DONE M11 quiz due [[November 29th, 2021]] #2021-W46 #2021-W47 #2021-W48

	 - DONE HW8 due [[November 15th, 2021]] #2021-W45

	 - DONE Schedule final exam / post about skipping final #2021-W46

	 - DONE M12 quiz due [[November 29th, 2021]] #2021-W47 #2021-W48

	 - DONE M13 quiz due [[December 6th, 2021]] #2021-W48 #2021-W48

	 - DONE HW9 due [[December 6th, 2021]] #2021-W48

	 - DONE M14 quiz due [[December 6th, 2021]] #2021-W48 #2021-W49 #2021-W50

	 - DONE HW10 due [[December 13th, 2021]] #2021-W49 #2021-W50
