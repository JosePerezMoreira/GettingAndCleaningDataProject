setwd("C:\\RStudio\\Leek_Getting_and_Cleaning_Data_201406\\P\\GettingAndCleaningDataProject")

# Downloading zip file to analyse.
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile = "Dataset.zip",mode="wb")

# Extracting zip file.
unzip(zipfile = "Dataset.zip")

# Loading meta data for formats:
activity_labels <- read.table(file = "UCI HAR Dataset\\activity_labels.txt",header = FALSE)
colnames(activity_labels) <- c("activity_id","activity")

features <- read.table(file = "UCI HAR Dataset\\features.txt", header = FALSE) 
colnames(features) <- c("feature_id","feature")


# Loading raw data - train:
data_raw_train_subject <- read.table(file = "UCI HAR Dataset\\train\\subject_train.txt", header = FALSE)
colnames(data_raw_train_subject) <- "ID"

data_raw_train_X <- read.table(file = "UCI HAR Dataset\\train\\X_train.txt", header = FALSE)
colnames(data_raw_train_X) <- features$feature

data_raw_train_y <- read.table(file = "UCI HAR Dataset\\train\\y_train.txt", header = FALSE) 
colnames(data_raw_train_y) <- "activity"
data_raw_train_y <- factor(data_raw_train_y$activity, levels=activity_labels$activity_id ,labels = activity_labels$activity)
activity <- data_raw_train_y
data_raw_train <- cbind(data_raw_train_subject, data_raw_train_X,activity)

# data_raw_train_IS_body_acc_x <- read.table(file = "UCI HAR Dataset\\train\\Inertial Signals\\body_acc_x_train.txt", header = FALSE)
# data_raw_train_IS_body_acc_y <- read.table(file = "UCI HAR Dataset\\train\\Inertial Signals\\body_acc_y_train.txt", header = FALSE)
# data_raw_train_IS_body_acc_z <- read.table(file = "UCI HAR Dataset\\train\\Inertial Signals\\body_acc_z_train.txt", header = FALSE)
# data_raw_train_IS_body_gyro_x <- read.table(file = "UCI HAR Dataset\\train\\Inertial Signals\\body_gyro_x_train.txt", header = FALSE)
# data_raw_train_IS_body_gyro_y <- read.table(file = "UCI HAR Dataset\\train\\Inertial Signals\\body_gyro_y_train.txt", header = FALSE)
# data_raw_train_IS_body_gyro_z <- read.table(file = "UCI HAR Dataset\\train\\Inertial Signals\\body_gyro_z_train.txt", header = FALSE)
# data_raw_train_IS_total_acc_x <- read.table(file = "UCI HAR Dataset\\train\\Inertial Signals\\total_acc_x_train.txt", header = FALSE)
# data_raw_train_IS_total_acc_y <- read.table(file = "UCI HAR Dataset\\train\\Inertial Signals\\total_acc_y_train.txt", header = FALSE)
# data_raw_train_IS_total_acc_z <- read.table(file = "UCI HAR Dataset\\train\\Inertial Signals\\total_acc_z_train.txt", header = FALSE)

# Loading raw data - test:
data_raw_test_subject  <- read.table(file = "UCI HAR Dataset\\test\\subject_test.txt", header = FALSE)
colnames(data_raw_test_subject) <- "ID"

data_raw_test_X  <- read.table(file = "UCI HAR Dataset\\test\\X_test.txt", header = FALSE)
colnames(data_raw_test_X) <- features$feature

data_raw_test_y <- read.table(file = "UCI HAR Dataset\\test\\y_test.txt", header = FALSE)
colnames(data_raw_test_y) <- "activity"
data_raw_test_y <- factor(data_raw_test_y$activity, levels=activity_labels$activity_id ,labels = activity_labels$activity)
activity <- data_raw_test_y
data_raw_test <- cbind(data_raw_test_subject, data_raw_test_X,activity)


# data_raw_test_body_acc_x <- read.table(file = "UCI HAR Dataset\\test\\Inertial Signals\\body_acc_x_test.txt", header = FALSE)
# data_raw_test_body_acc_y <- read.table(file = "UCI HAR Dataset\\test\\Inertial Signals\\body_acc_y_test.txt", header = FALSE)
# data_raw_test_body_acc_z <- read.table(file = "UCI HAR Dataset\\test\\Inertial Signals\\body_acc_z_test.txt", header = FALSE)
# data_raw_test_body_gyro_x <- read.table(file = "UCI HAR Dataset\\test\\Inertial Signals\\body_gyro_x_test.txt", header = FALSE)
# data_raw_test_body_gyro_y <- read.table(file = "UCI HAR Dataset\\test\\Inertial Signals\\body_gyro_y_test.txt", header = FALSE)
# data_raw_test_body_gyro_z <- read.table(file = "UCI HAR Dataset\\test\\Inertial Signals\\body_gyro_z_test.txt", header = FALSE)
# data_raw_test_total_acc_x <- read.table(file = "UCI HAR Dataset\\test\\Inertial Signals\\total_acc_x_test.txt", header = FALSE)
# data_raw_test_total_acc_y <- read.table(file = "UCI HAR Dataset\\test\\Inertial Signals\\total_acc_y_test.txt", header = FALSE)
# data_raw_test_total_acc_z <- read.table(file = "UCI HAR Dataset\\test\\Inertial Signals\\total_acc_z_test.txt", header = FALSE)

data_raw_train$mode <- "train"
data_raw_test$mode <- "test"
data_raw <- rbind(data_raw_train, data_raw_test)

mean_std_cols <- grep(pattern = "mean\\(\\)|std\\(\\)", x = features$feature, value = TRUE)
data_tidy <- data_raw[,c("ID","activity",mean_std_cols)]
data_average <- unique(data_tidy[,c("ID","activity")])

for (i in 3:ncol(data_tidy)){
    data_average[,paste0(colnames(data_tidy)[i],"-average")] <- mapply(function(x,y){
        return(mean(data_tidy[data_tidy$ID == x & data_tidy$activity ==y, colnames(data_tidy)[i]]))
    },data_average$ID,data_average$activity)
}

write.table(x = data_tidy, file = "data_tidy.txt", sep = ",", row.names = FALSE, col.names = TRUE)
write.table(x = data_average, file = "data_average.txt", sep = ",", row.names = FALSE, col.names = TRUE)

