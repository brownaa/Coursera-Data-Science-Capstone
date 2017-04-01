if (!require(pacman)) install.packages('pacman')
pacman::p_load('ProjectTemplate')
load.project()

all_corpus = data.frame(corpus = c("./data/de_DE/", "./data/en_US/", 
                                   "./data/fi_FI/", "./data/ru_ru/"),
                        language = c("de-DE", "en-US", "fi-FI", "ru-RU"))

getCorpusStats = function(corp) {
    corp = Corpus(DirSource(as.character(corp$corpus)), 
                  readerControl = list(language = corp$language))
}

us_blog = Corpus(DirSource("./data/en_US/"))

us_blog = tm_map(us_blog, content_transformer(tolower)) 
us_blog = tm_map(us_blog, removeWords, stopwords("english")) 
us_blog = tm_map(us_blog, removePunctuation) 
us_blog = tm_map(us_blog, removeNumbers) 
us_blog = tm_map(us_blog, stripWhitespace) 
us_blog_stemmed = tm_map(us_blog, stemDocument) #stemmed
cntl = list(wordLengths = c(3, Inf))
dtm <- DocumentTermMatrix(us_blog, control = cntl)
# inspect(dtm)
dtm_sparse = removeSparseTerms(dtm, 0.1)

##plot #https://rstudio-pubs-static.s3.amazonaws.com/31867_8236987cf0a8444e962ccd2aec46d9c3.html
freq <- sort(colSums(as.matrix(dtm_sparse)), decreasing=TRUE)   
wf = data.frame(word=names(freq), freq=freq)  
p = ggplot(subset(wf, freq > 30000), aes(x = reorder(word, -freq), freq))
p = p + geom_bar(stat="identity")   
p = p + theme(axis.text.x=element_text(angle=45, hjust=1))   
p


##bi-gram tokenization
require(RWeka)
TrigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
tdm <- TermDocumentMatrix(a, control = list(tokenize = TrigramTokenizer))
tdm <- removeSparseTerms(tdm, 0.75)
inspect(tdm[1:5,1:5])
