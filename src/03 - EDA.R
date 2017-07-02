#load project setup
if (!require(pacman)) install.packages('pacman')
pacman::p_load('ProjectTemplate')
load.project()

get.basic.data = function(corpus_file) {
    force(corpus_file)
    corp = load_corpus(corpus_file)
    
    # size = sapply(corp, object.size)
    source =        sapply(corp, meta, tag = "id")
    language =      sapply(corp, meta, tag = "language")
    lines =         sapply(corp, function(x) length(content(x)))
    characters =    sapply(corp, function(x) sum(nchar(content(x))))
    
    return(data.table(source, language, lines, characters))
}

basic.data = rbindlist(lapply(as.vector(all_corpus[,1]), get.basic.data))

