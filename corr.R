library(data.table)

readdata <- function(directory){
    # Read all csvs
    temp <- list.files(path = directory, pattern="*.csv")
    temp <- paste(directory, "/", temp, sep="")
    myfiles <- lapply(temp, read.csv)
    return(myfiles)
}

threstest <- function(data, threshold){
    data <- na.omit(data)
    if (nrow(data)>threshold){
        return(data)
    } 
}

corr <- function(directory, threshold = 0){
    myfiles <- readdata(directory)
    # Creates empty vector to add cor to
    soln <- c()
    # Test if id > threshold
    # If yes, take cor and add to vector soln
    for (i in 1:length(myfiles)){
        data <- na.omit(myfiles[[i]])
        if (nrow(data)>threshold){
            sulf <- data[2]
            nitr <- data[3]
            soln <- c(soln, cor(sulf, nitr))
        }
    }
    if (length(soln)==0){
        soln <- numeric()
    }
    return(soln)
}

cr <- corr("specdata", 150)
head(cr)
summary(cr)
cr <- corr("specdata", 400)
head(cr)
summary(cr)
cr <- corr("specdata", 5000)
summary(cr)
length(cr)
cr <- corr("specdata")
summary(cr)
length(cr)
