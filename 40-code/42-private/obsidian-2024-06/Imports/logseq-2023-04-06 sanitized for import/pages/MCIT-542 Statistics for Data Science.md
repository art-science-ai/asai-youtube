---
title: MCIT-542 Statistics for Data Science
---

- Notes
	 - M1: Introduction and Probability Review
		 - Probability review

		 - Multivariate probability

	 - M2: Statistical learning
		 - Intro to statistical learning
			 - Regression is the function that optimizes Mean Squared Error

		 - Statistical models
			 - Training error will ALWAYS go down with more model parameters; look for the point where test error is minimized

			 - Reducible error can be minimized by our model, but there will always be some irreducible error which is due to unmeasurable factors.

		 - Prediction vs. inference
			 - Prediction just gives scores for a particular input, but inference is about understanding the relationships. There is usually a tradeoff between the two.

	 - M3: Linear Regression
		 - Linear regression

		 - Confidence interval and hypothesis testing
			 - Construct confidence interval around sample statistics - x-bar, B1, etc. 

			 - We reject null hypothesis when B1 lies outside the range of 2 SDs of the mean.

	 - M4: Extended Linear Regression
		 - Categorial variables - dummy variables

		 - Non-linear effects: Add powers of input variables

		 - Interaction terms: Add products of different variables

		 - DONE Python: statsmodels vs. scikitlearn 

	 - M5: Classification
		 - Logistic regression

		 - Interpretation of logit models is more complex than normal regression models - need to consider log odds

	 - M6: Linear discriminant analysis
		 - Bayes classifier
			 - Classifies as 1 when p > 0.5 and classifies as zero otherwise

		 - Confusion matrix and error measurements
			 - Error rate, false positive rate, false negative rate

		 - ROC / AUC
			 - How to choose classifier? Need to understand cost of false positives and false negatives.

			 - Instead of Bayes classification threshold of 0.5, we can choose a different threshold

			 - AUC is the area under the ROC curve. Better AUC = better classifier. As close to 1 as possible is ideal.

	 - M7: Cross validation and bootstrap
		 - Validation Set approach
			 - Randomly split train vs test

			 - Drawbacks: MSE varies depending on the split; MSE is overestimated

		 - K-fold cross-validation
			 - Divide dataset into k parts; train k different models with k-1 train / 1 test.

			 - Advantages: less volatile estimate of MSE; less overestimated MSE

		 - Bootstrap
			 - Generate ~ 1000 bootstrapped training datasets by sampling from the original training dataset (with replacement)

			 - Generate ~ 1000 estimates of the parameters and choose the central one

			 - Bootstrap gives a better estimate of std error

	 - M8: Model selection
		 - Subset selection
			 - Best subset selection: Loop through k = num features: (For each k, choose model with lowest training error). Then you have one best model for each k, now choose the model with lowest cv test error. 

			 - Forward stepwise selection: only add the next best feature at each step

			 - Backward stepwise selection: start with full model and remove one feature at each step 

		 - Ridge and lasso: results in a more rigid model

		 - 

	 - M9: Decision trees I
		 - Intro to decision trees
			 - Main idea: partition space into y=k constant rectangular regions; do in such a way to reduce RSS

		 - Ensemble methods - bootstrap, random foreests, boosting

		 - 

	 - M10: Decision trees II

	 - M11: Support vector machines I

	 - M12: Support Vector Machines II

	 - M13: Unsupervised learning I
		 - Goal of unsupervised learning is to is to group data into clusters

		 - PCA - Principal component analysis
			 - Goal is to maximize variance between the clusters

	 - M14: Unsupervised learning II
		 - K means clustering
			 - Goal is to minimize the sum of WCVs (within cluster variances)

			 - Actual k-means is computationally infeasible, so we use a heuristic algorithm, but it is sensitive to the random initialization

		 - Hierarchical clustering
			 - Results in a dendogram - tree representation of the hierarchy of clusters

	 - M15: Final Exam

- Tasks
	 - DONE M1 quiz #2021-W19

	 - DONE M2 quiz #2021-W20

	 - DONE Project 1 #2021-W19 #2021-W20 due [[May 24th, 2021]]

	 - DONE M3 quiz #2021-W21

	 - DONE Project 2 #2021-W21 due [[May 31st, 2021]]

	 - DONE M4 quiz #2021-W22

	 - DONE Schedule midterm (June 24 - 27) #2021-W23

	 - DONE Project 3 #2021-W22 due [[June 7th, 2021]]

	 - DONE M5 quiz #2021-W23

	 - DONE Project 4 #2021-W23 due [[June 14th, 2021]]

	 - DONE M6 quiz #2021-W24

	 - DONE M7 quiz #2021-W25

	 - DONE Project 5 #2021-W25 due [[June 30th, 2021]]

	 - DONE M8 quiz #2021-W26

	 - DONE Project 6 #2021-W26 due [[July 5th, 2021]]

	 - DONE M9 quiz OVERDUE #2021-W28

	 - DONE M10 quiz #2021-W28

	 - DONE Project 7 #2021-W28 due [[July 19th, 2021]]

	 - DONE M11 quiz #2021-W29

	 - DONE M12 quiz #2021-W30

	 - DONE Schedule final (August 19 - 22) #2021-W30

	 - DONE Project 8 #2021-W30 due [[August 2nd, 2021]]

	 - DONE M13 quiz #2021-W31

	 - DONE Project 9 #2021-W31 due [[August 9th, 2021]]

	 - DONE M14 quiz #2021-W32
