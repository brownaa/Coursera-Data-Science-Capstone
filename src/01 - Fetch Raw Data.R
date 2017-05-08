## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## This script only needs to be run once in order to download the dataset   ##
## and clean up the unzipped directories                                    ##
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

# if(file.exists(file.path(getwd(), "data/de_DE"))) #need to finish
    #writing this part of the script so that it does not execute 

if (!require(pacman)) install.packages('pacman')
pacman::p_load('ProjectTemplate')
load.project()

dir.create("data")
Sys.chmod(file.path(getwd(),"data"), 
          mode = "775", #modify permission of the folder to allow writing
          use_umask = FALSE)

swiftkey_file = "./data/Coursera-SwiftKey.zip"
if(file.exists(swiftkey_file))
    file.remove(swiftkey_file)
download.file(url = "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip",
              destfile = swiftkey_file)

unzip(zipfile = file.path(getwd(),"data/Coursera-SwiftKey.zip"),
      exdir = file.path(getwd(), "data"))

# move files out of the "final" directory into the "data" directory
file.rename(from = file.path(getwd(), "data/final/de_DE"),
            to   = file.path(getwd(), "data/de_DE"))
file.rename(from = file.path(getwd(), "data/final/en_US"),
            to   = file.path(getwd(), "data/en_US"))
file.rename(from = file.path(getwd(), "data/final/fi_FI"),
            to   = file.path(getwd(), "data/fi_FI"))
file.rename(from = file.path(getwd(), "data/final/ru_RU"),
            to   = file.path(getwd(), "data/ru_RU"))
# file.remove(file.path(getwd(),"data/final"))  # delete 'final' directory
