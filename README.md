GettingAndCleaningDataProject
=============================

Project of the Coursera Course: Getting and Cleaning Data

The script run_analysis.R produces two data files, "data_tidy.txt"" and "data_average.txt".


We load the training data and the test data from the sub folders.
the counterparty ID is associated with the files subject_train.txt and subject_test.txt.

The activity is assigned according to the meta data file activity_labels.txt.

The column names of the measures are assigned according to the file features.txt.

We only provide the measures of the mean and standard deviation, by searching for the patterns "mean()" or "std()".

This gives us the data file "data_tidy.txt".

Next for each "ID" and "activity" we calculate the mean for each measurement. We assign as column name of the mean of each measurement the same column name as the measurment, but with the appendix "-average".

This gives us the data file "data-average.txt"
