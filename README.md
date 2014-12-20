The R script run_analysis download the data necessary to do the analysis from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

and creates a tidy data set with the desired variables (see Codebook.md).


#Requiriments#

R version 3.1.1 (2014-07-10) or later (the script has been tested in MacOSX 10.10.1. 
Problems may arise in other platforms).

Packages: downloader, dplyr

#Use#

Do `source run_analysis` in your working directory (the output files will all be put in the same
folder)

The script creates the following dataframes:

*`data_raw` (the raw data)
*`data_tidy` (tidy data) 
* `VariableMeans` (means of the variables in the tidy data for each subject and activity)

and saves in the working directory the file `VariableMeans.txt` with the contents of 
`VariableMeans`.
