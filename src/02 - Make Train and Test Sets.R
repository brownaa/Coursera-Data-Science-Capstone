#load project setup
if (!require(pacman)) install.packages('pacman')
pacman::p_load('ProjectTemplate')
load.project()

## approach adapted from:
## http://stackoverflow.com/questions/14822333/split-sample-of-r-tm-corpus-objects


## Split into training and test sets
split_tsets = function(corp, trainfrac = 0.8) {
    corpnew = VCorpus(VectorSource(""))
    while(length(corp) > 0) {
        len = length(corp[[1]]$content)
        tset = rbinom(len, 1, trainfrac)
        # tset: 1 = train, 0 = test
        # tset[tset == "1"] = "train"
        # tset[tset == "0"] = "test"
        # meta(corp[[i]], tag = "tset") = as.factor(tset)
        
        training = which(tset %in% 1)
        test     = which(tset %in% 0)
        content_training = corp[[1]]$content[training]
        content_testing  = corp[[1]]$content[test]
        
        len = length(corp)
        if(len >= 2) {
            corp_testing = corp[-c(2:len)]
            corp_training = corp[-c(2:len)]
            print(1)
        } else {
            corp_testing = corp
            corp_training = corp
            print(2)
        }
        
        meta(corp_training[[1]], tag = "tset") = "training"
        meta(corp_testing[[1]], tag = "tset") = "testing"
        
        corpnew = c(corpnew, corp_training, corp_testing)
        corp = corp[-1]
    }
    corpnew = corpnew[-1]
    return(corpnew)
}

for(i in 1:nrow(all_corpus)) {
    dr = as.character(all_corpus[i,1])
    save_filename = paste0(dr, "corpus.RData")

    if(!file.exists(save_filename)) {
        language = as.character(all_corpus[i,2])
        corp = VCorpus(DirSource(dr), 
                      readerControl = list(language = language))
        corp = split_tsets(corp = corp)
        
        contents = lapply()
        corp_train = 
        corp_test  = 
        
        save(corp, file = save_filename)
    }
}

rm(list = "split_tsets", "dr", "i", "language", "save_filename", "corp")
