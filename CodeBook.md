The following variables are present in the run_analysis.R script:

Section 1 -- Raw Data:

*each of these also have an associated _date variable which is only a date stamp for the file import
subject_train = table of subject IDs from the training set
subject_test = table of subject IDs data from test set
training_data = table of training set numeric results for the various measurements
test_data = table of test set numeric results for the various measurements
training_labels = table of activity IDs for the training set
test_labels = table of activity IDs for the test set
activity_labels = a table matching actity IDs with the descriptive activity name
features = a table of the different features that were measured

Section 2 -- Data Cleaning:

all_subjects = a table combining Subject IDs from the training and test sets
monitor_data = a table combining the numeric test results from the training and test sets
labels = a table combining the Activity IDs from the training and test sets
features_names = a vector of the meaures features, drawn from the features table

monitor_data_mean = monitor data stripped of non-mean measurements
monitor_data_std = monitor data stripped of non-standard deviation measurements
combined_data = a data frame of mean and standard deviation monitor measurements, with Subject ID and Activity Type for each

cd = temporary shorthad for combined_data

measurement_means = a tidy data table shaped on SubjectID and ActivityType, providing the mean of the monitor data for each
