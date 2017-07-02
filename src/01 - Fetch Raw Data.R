## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## This script only needs to be run once in order to download the dataset   ##
## and clean up the unzipped directories                                    ##
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

# if(file.exists(file.path(getwd(), "data/de_DE"))) #need to finish
    #writing this part of the script so that it does not execute 

if (!require(pacman)) install.packages('pacman')
pacman::p_load('ProjectTemplate')
load.project()

if(!dir.exists("data")) {
    dir.create("data")
    Sys.chmod(file.path(getwd(),"data"), 
              mode = "775", #modify permission of the folder to allow writing
              use_umask = FALSE)
}

swiftkey_file = "./data/Coursera-SwiftKey.zip"
if(!file.exists(swiftkey_file))
    download.file(url = "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip",
                  destfile = swiftkey_file)

unzip(zipfile = file.path(getwd(),"data/Coursera-SwiftKey.zip"),
      exdir = file.path(getwd(), "data"))

newloc = c("./data/de_DE/", "./data/en_US/", "./data/fi_FI/", "./data/ru_ru/")
oldloc = c("./data/final/de_DE/", "./data/final/en_US/", "./data/final/fi_FI/", "./data/final/ru_ru/")


######################################################################
## function source
## https://stackoverflow.com/revisions/10268255/2
my.file.rename <- function(from, to) {
    todir <- dirname(to)
    if (!isTRUE(file.info(todir)$isdir)) dir.create(todir, recursive=TRUE)
    file.rename(from = from,  to = to)
}

for (i in 1:length(newloc)) {
    my.file.rename(from = oldloc[i],
                   to = newloc[i])
}
######################################################################

Sys.chmod(file.path(getwd(),"data/final"), 
          mode = "777", #modify permission of the folder to allow writing
          use_umask = FALSE)
unlink(file.path(getwd(),"data/final/"), recursive = TRUE)

rm(list = c("i", "newloc", "oldloc", "swiftkey_file", "my.file.rename"))
