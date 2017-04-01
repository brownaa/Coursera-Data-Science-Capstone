
#load project setup
if (!require(pacman)) install.packages('pacman')
pacman::p_load('ProjectTemplate')
load.project()

getFiles = function(loc)
    return(list.files(path = loc, recursive = TRUE))

writeFile = function(x, filename) {
    con = files(filename)
    open(con, "w")
    writeLines(x, con)
    close(con)
}

splitFile = function(dat, filename, loc, trainfraction = 0.8) {
    set.seed(2312)
    
    #set training indexes (80% of dat)
    idx = sample(1:nrow(dat), size=0.2*nrow(dat))
    
    #split dataset
    train = dat[idx,]
    test = dat[-idx,]
    
    writeFile(train, paste0(loc, "/", filename, ".train.txt"))
    writeFile(test,  paste0(loc, "/", filename, ".test.txt"))
}

readData = function(loc) {
    files = getFiles(loc)
    
    for (i in 1:length(files)) {
        con = file(paste0(loc, "/", files[i]))
        open(con, "r")
        dat = readLines(con, encoding = "UTF-8")
        close(con)
        
        splitFile(dat, files[i], loc)
    }
    
}


loc = c("./data/de_DE", "./data/en_US", "./data/fi_FI", "./data/ru_ru")
readData(loc[1])
