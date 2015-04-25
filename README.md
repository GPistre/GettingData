#UCI Accelerometer Data Cleaning Script


##Script
This script takes the data gathered by the accelerometer installed on the Samsung Galaxy S phone while carried around by different subjects performing different activities and runs it through the following operations:

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

3. Appropriately labels the different variables: Subject IDs, activity names, and group names, as well as the names of the different type of measurements.


The variables names have been changed to remove any special character that might make them difficult to reference (namely: "(", ")", "-" and ","). No other changes have been made to preserve as best as possible the specifications of each measurement.