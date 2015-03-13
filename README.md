==================================================================
##Human Activity Recognition Using Smartphones **Processed Dataset**
==================================================================

This is a description of the procedure used to process the UCI HAR dataset into a tidy dataset containing the feature summaries. 

##The dataset includes the following files:
===========================================

- 'README.md'

- 'codeBook.md': Shows information about the variables used in the dataset.

- 'run_analysis.R': R script that processes the UCI HAR Dataset to the tidy dataset containing the means of all features for each combination of subject and activity.

- 'final_dataset.txt': The tidy dataset.


run_analysis.R: 
===============
- This script first reads the required files from the UCI HAR Dataset directory.
- Then, the subject ID, activity and features for the training and test sets are merged into one table. Only the features that correspond to mean() and std() are kept.
- The dataset is summarised by combinations of subject and activity and the activities are recoded using human radable tex according to activity_labels.txt.
- The final tidy dataset is written to file using write.table


