#load project setup
if (!require(pacman)) install.packages('pacman')
pacman::p_load('ProjectTemplate')
load.project()

## approach adapted from:
## http://stackoverflow.com/questions/14822333/split-sample-of-r-tm-corpus-objects


## Split into training and test sets
split_tsets = function(corp, trainfrac = 0.8) {
    corp_length = length(corp)
    
    # to_newline <- content_transformer(function (x) unlist(strsplit(x, "\n")))
    # contents = unlist(strsplit(corp[[i]]$content, "\n"))
    
    # corp = tm_map(corp, to_newline)
    
    for(i in 1:corp_length){
        # corp[[i]]$content = contents
        len = length(corp[[i]]$content)
        tset = as.character(rbinom(len, 1, trainfrac))
        tset[tset == "1"] = "train"
        tset[tset == "0"] = "test"
        meta(corp[[i]], tag = "tset") = as.factor(tset)
    }
    return(corp)
}

for(i in 1:nrow(all_corpus)) {
    dr = as.character(all_corpus[i,1])
    save_filename = paste0(dr, "corpus.RData")

    if(!file.exists(save_filename)) {
        language = as.character(all_corpus[i,2])
        corp = VCorpus(DirSource(dr), 
                      readerControl = list(language = language))
        corp = split_tsets(corp = corp)
        
        save(corp, file = save_filename)
    }
}

rm(list = "split_tsets", "dr", "i", "language", "save_filename", "corp")
