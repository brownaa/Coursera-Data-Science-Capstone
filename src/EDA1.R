if (!require(pacman)) install.packages('pacman')
pacman::p_load('ProjectTemplate')
load.project()

##load US blogs
con = file(description = "./data/en_US/en_us.blogs.txt")
us.blogs = readLines(con = con)
close(con)

words = WordTokenizer(us.blogs)
