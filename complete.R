library(data.table)

readdata <- function(directory){
    # Read all csvs
    temp <- list.files(path = directory, pattern="*.csv")
    temp <- paste(directory, "/", temp, sep="")
    myfiles <- lapply(temp, read.csv)
    data <- rbindlist(myfiles)
    colnames(data) <- c("Date","sulfate","nitrate","ID")
    return(data)
}

complete <- function(directory, id = 1:332){
    data <- readdata(directory)
    # Create empty matrix
    mat <- matrix(NA, nrow=0, ncol=2)
    #For every id, remove incomplete data and add it to the solution matrix
    for (i in id){
        polldata <- data[data$ID %in% i,]
        polldata <- na.omit(polldata)
        mat <- rbind(mat, c(i,nrow(polldata)))
    }
    return(mat)
}

complete("specdata", 1)
complete("specdata", c(2, 4, 8, 10, 12))
complete("specdata", 30:25)
complete("specdata", 3)