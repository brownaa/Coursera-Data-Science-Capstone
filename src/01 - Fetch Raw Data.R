## Fetch raw data
if (!require(pacman)) install.packages('pacman')
pacman::p_load('RCurl')

dir.create("data")
Sys.chmod(file.path(getwd(),"data"), mode = "775", use_umask = FALSE) #modify directory permissions
download.file(url = "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip",
              destfile = "./data/Coursera-SwiftKey.zip")

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
file.remove(file.path(getwd(),"data/final"))  # delete 'final' directory
