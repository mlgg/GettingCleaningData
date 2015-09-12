#1. MERGE TRAINING AND TEST SETS INTO ONE DATA SET ("accel_data")

#Read in Subject IDs from test and train and combine to a single dataframe
subject_train <- read.table("~/GitHub/datasciencecoursera/UCI HAR Dataset/train/subject_train.txt", col.names = c("SubjectID"))
subject_train_date <- date()

subject_test <- read.table("~/GitHub/datasciencecoursera/UCI Har Dataset/test/subject_test.txt", col.names = c("SubjectID"))
subject_test_date <- date()

all_subjects <- rbind(subject_train, subject_test)

#Read in the training set results and test set results, combine to a single monitor_data data frame
training_data <- read.table("~/GitHub/datasciencecoursera/UCI HAR Dataset/train/X_train.txt")
training_data_date <- date()

test_data <- read.table("~/GitHub/datasciencecoursera/UCI HAR Dataset/test/X_test.txt")
test_data_date <- date()

monitor_data <- rbind(training_data, test_data)

#Read in the training and test labels, combine to a single labels data frame
training_labels <- read.table("~/GitHub/datasciencecoursera/UCI HAR Dataset/train/y_train.txt", col.names = c("ActivityType"))
training_labels_date<- date()

test_labels <- read.table("~/GitHub/datasciencecoursera/UCI HAR Dataset/test/y_test.txt", col.names = "ActivityType")
test_labels_date <- date()

labels <- rbind(training_labels, test_labels)

#read in key for activity_labels
activity_labels <- read.table("~/GitHub/datasciencecoursera/UCI HAR Dataset/activity_labels.txt", col.names = c("ActivityID", "ActivityType"))
activity_labels_date <- date()

#Read in the list of features 
features <- read.table("~/GitHub/datasciencecoursera/UCI HAR Dataset/features.txt")
features_date <- date()

#Convert features to vector feature_names
features_names <- as.vector(features$V2)

#add features vector to create column labels for monitor_data
colnames(monitor_data) <- features_names


#2. EXTRACT ONLY MEAN AND STD DEV MEASUREMENTS

#isolate monitor_data entries to mean and standard deviation
monitor_data_mean <- monitor_data[, grep("mean", colnames(monitor_data))]
monitor_data_mean <- monitor_data_mean[, -grep("meanFreq", colnames(monitor_data_mean))]
monitor_data_std <- monitor_data[, grep("std", colnames(monitor_data))]

#combine all_subjects, labels, and accel_data into a master dataframe called combined_data
combined_data <- cbind(all_subjects, labels, monitor_data_mean, monitor_data_std)


#3. USE DESCRIPTIVE ACTIVITY NAMES TO NAME ACTIVITIES IN DATA SET

#change ActivityType id numbers to descriptive terms
combined_data[["ActivityType"]]<- activity_labels[ match(combined_data[["ActivityType"]], activity_labels[["ActivityID"]]), "ActivityType"]

#4. LABEL DATA SET WITH DESCRIPTIVE VARIABLE NAMES
#rename combined_data as "cd" for ease of typing
cd <- combined_data
names(cd) <- gsub("^t", "time", names(cd))
names(cd) <- gsub("^f", "frequency", names(cd))
names(cd) <- gsub("Acc", "Accelerator", names(cd))
names(cd) <- gsub("Gyro", "Gyroscope", names(cd))
names(cd) <- gsub("Mag", "Magnitude", names(cd))
#now back to combined_data from cd
combined_data <- cd


#5. CREATE A TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT

#melt the data to isolate ids and labels from measurements
cd<- melt(combined_data, id = c("SubjectID", "ActivityType"))

#mean of measurements, grouped by measurement type and organized as SubjectID and ActivityType
measurement_means <- cast(cd, SubjectID + ActivityType ~ variable, mean)


#WRITE TABLE FOR SUBMISSION
write.table(measurement_means, "tidydata.txt", row.names = FALSE)








