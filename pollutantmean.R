library(data.table)

readdata <- function(directory){
    # Read all csvs
    temp <- list.files(path = directory, pattern="*.csv")
    temp <- paste(directory, "/", temp, sep="")
    myfiles <- lapply(temp, read.csv)
    # Add them together to a list
    data <- rbindlist(myfiles)
    colnames(data) <- c("Date","sulfate","nitrate","ID")
    return(data)
}

pollutantmean <- function(directory, pollutant, id = 1:332){
    data <- readdata(directory)
    # Select the row of pollutant data, and take the mean
    polldata <- data[data$ID %in% id,]
    pollmean <- mean(polldata[[pollutant]], na.rm = TRUE)
    return (pollmean)
}

pollutantmean("specdata","sulfate", 1:10)
pollutantmean("specdata","nitrate", 70:72)
pollutantmean("specdata","nitrate", 23)