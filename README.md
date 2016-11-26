# Machine-Learning

[Homework 1]
Solve the following two tasks:

T1: Load the Olympic men’s 400m data (stored in the file olympics.mat). Fit 1st, 2nd, 3rd, and 4th order polynomial functions to this data. Use 10-fold cross-validation to choose the “best” polynomial order between 1 and 4 which has lowest error. What is the “best” model based on average cross-validation loss?

T2: Using 5-fold cross-validation, find the value of 𝜆 that gives the “best” predictive performance on the Olympic men’s 100m data (stored in the file olympics.mat) for (a) 1st order polynomial (i.e. the standard linear model) and (b) 4th order polynomial.

[Homework 2]
Solve the following tasks:

A new test for a disease is being developed. The test involves the measurement of the concentration of two chemicals in a urine sample. The test is less accurate than an existing blood test, but much faster and cheaper. In order to determine whether a test is “positive” or “negative”, a classifier is desired that can make this decision.

In order to train the classifier, measurements on 500 patients were taken and for each, both blood and urine tests were performed. The blood test was used to canonically determine the “actual” target class (i.e. ground truth) of these training data, and from this initial labelling, the classifier is to be trained on the urine data.

The data file cbt2data.mat contains the discriminated training data in variables ‘diseased’ and ‘healthy’, with one variable per row, one data point per column. Your task is to determine a classification rule on this data, and to use it to classify 2000 unclassified data points (in variable “newpts”), and thus “diagnose” the disease state of the individual from whom they came.
     
T1: Train the Bayesian classifier, with maximum likelihood estimate, on the training data with and without Naïve assumption

T2: Train the Bayesian classifier, with maximum a posteriori estimate, on the training data with and without Naïve assumption 

T3: Evaluate each classifier against the new data points and determine the class of each point (“diseased” or “healthy”). Compare and discuss the results. Note that you’ll have a total of 4 classifiers from above 2 steps. 

T4: Visualise the results by plotting:
  “Diseased” training points as red circles.
  “Healthy” training points as blue circles.
  “Diseased” new points as red x’s.
  “Healthy” new points as blue x’s.
