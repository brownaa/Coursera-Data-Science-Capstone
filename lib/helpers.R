all_corpus = data.frame(corpus = c("./data/de_DE/", 
                                   "./data/en_US/", 
                                   "./data/fi_FI/", 
                                   "./data/ru_ru/"),
                        language = c("de-DE", "en-US", "fi-FI", "ru-RU"))

#load saved corpus file
#must have completed the 02 - Make Train and Test Sets.R script which creates
#   the .Rdata files
load_corpus = function(x) {
    corp_file = x %>%
        as.character() %>%
        paste0("corpus.RData") #%>%
    load(corp_file)
    return(corp)
}

corpusTransform = function(x) {
    x = x %>%
        tm_map(removeWords, stopwords(language)) %>%
        tm_map(removePunctuation) %>%
        tm_map(removeNumbers) %>%
        tm_map(stripWhitespace)
    return(x)
}