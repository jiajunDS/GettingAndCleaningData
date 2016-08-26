Project Code Book
=================

Original data source: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The attached R script (run_analysis.R) performs the following data cleansing process:

* Merge training & test datasets, resulting in creation of a single dataset stored @ train/X_train.txt and test/X_test.txt.

* Reading in features.txt data, extracting the mean and standard deviation info for each measurement entry. Collected measurements were all floating numbers falling within (-1, 1) range.

* Reading activity_labels.txt, providing activity names to various activities within the data set:
    - walking
    - walkingupstairs
    - walkingdownstairs
    - sitting
    - standing
    - laying

* Labeling of dataset by applying the following rules: 
    - Converting feature & activity to lower case, along with removal of whitespaces and eliminating other no-std naming conventions. 
    - Merging features dataset & activity dataset and storing resulting data as merged_clean_data.txt. Data is seperated by: subject IDs[1-30], activity names, followed by 66 columns of measurement data. 
    - Attribute naming:
        - tbodyacc-mean-x 
        - tbodyacc-mean-y 
        - tbodyacc-mean-z 
        - tbodyacc-std-x 
        - tbodyacc-std-y 
        - tbodyacc-std-z 
        - tgravityacc-mean-x 
        - tgravityacc-mean-y

* Creation of new dataset containing average for each activity & subject respectively, storing in data_set_with_the_averages.txt. Data is seperated by: subject IDs[1-30], activity names, followed by 66 columns of measurement data. 

* Resulting in a total of 30 subjects X 6 activities (180 rows of averages).
