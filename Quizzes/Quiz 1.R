### Before runnint this script, you need to download the raw data from:
### https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip
### Unzip and move the files to the 'data' directory.

## Problem 1
## 200 megabytes

## Problem 2
con = file("./data/en_US/en_US.twitter.txt")
dat = readLines(con, encoding = "UTF-8")
length(dat)
close(con)
#Answer: over 2 million

## Problem 3
## max characters in any line
## ## US Blogs
con = file("./data/en_US/en_US.blogs.txt")
dat = readLines(con, encoding = "UTF-8")
len = sapply(dat, nchar)
print(max(len))
close(con)
## ## US News
con = file("./data/en_US/en_US.news.txt")
dat = readLines(con, encoding = "UTF-8")
len = sapply(dat, nchar)
print(max(len))
close(con)
## ## US Twitter
con = file("./data/en_US/en_US.twitter.txt")
dat = readLines(con, encoding = "UTF-8")
len = sapply(dat, nchar)
print(max(len))
close(con)
#Answer: Over 40 thousand in the blogs data

## Problem 4
length(grep("love", dat)) / length(grep("hate", dat))
#Answer: 4

## Problem 5
dat[grepl("biostats", dat)]
#Answer: They haven't studied for their biostats exam

## Problem 6
length(grep("A computer once beat me at chess, but it was no match for me at kickboxing", dat))
#Answer: 3