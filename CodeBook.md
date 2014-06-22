Codebook for the project of the course Getting and Cleaning Data
================================================================

The file "data_tidy.txt" contains the main statistics of the different measured features.

The following are the main identification columns:
ID: The number of volunteer for wich the activities were measured.
activity: the activity that was measured.

Further there are many measurments whose name are extracted from the meta file "features.txt". The appendix "mean()" indicates that the mean of the feature is measured and the appendix "std()" indicates that the standard deviation of the feature is measured.

The file "data_average.txt" provide for each ID and activity the average of the features.

We have the same identification columns:
ID: The number of volunteer for wich the activities were measured.
activity: the activity that was measured.

Further for all feature column in the file data_tidy.txt we have a corresponding column with the appendix "-average".
