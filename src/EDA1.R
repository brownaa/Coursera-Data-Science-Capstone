options( java.parameters = "-Xmx4g" )

if (!require(pacman)) install.packages('pacman')
pacman::p_load('ProjectTemplate')
load.project()

us_blog = Corpus(DirSource("./data/en_US/", pattern = "blog"))

us_blog <- tm_map(us_blog, content_transformer(tolower)) 
us_blog <- tm_map(us_blog, removeWords, stopwords("english")) 
us_blog <- tm_map(us_blog, removePunctuation) 
us_blog <- tm_map(us_blog, removeNumbers) 
us_blog <- tm_map(us_blog, stripWhitespace) 
us_blog_stemmed <- tm_map(us_blog, stemDocument) #stemmed
cntl = cntr <- list(wordLengths = c(3, Inf))
dtm <- DocumentTermMatrix(us_blog, control = cntl)
