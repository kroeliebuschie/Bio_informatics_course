#! /usr/bin/env RScript
 
## This script is for parsing the JSON info
## and making some usefull data out of it
##
## Author: Mehdi Nellen, 2014
 
 
#install.packages("R4CouchDB")
#install.packages("rjson")
library(R4CouchDB)
library(rjson)
 
#get the couchdb JSON, MAKE SURE YOU HAVE ACCESS!
json <- getURL('http://student:hello@umcu-bioinf.is-not-certified.com/test/_design/all/_view/all')
 
#parse json
parsedJSON <- fromJSON(json)
parsedJSON <- unlist(parsedJSON)
tumorValues <- parsedJSON[names(parsedJSON) == "value.tumor"]
tumorValues <- as.numeric(tumorValues)
 
#Bin the tumor data
bins <- seq(25,650,25)
leveledTumor <- cut(tumorValues, bins)
tabledTumor <- table(leveledTumor)
 
#make table
tumorMatrix <- cbind(tabledTumor, tabledTumor)
total <- sum(as.numeric(tumorMatrix[,2]))
tumorMatrix[,2] <- tapply(tumorMatrix[,2], 1:length(tumorMatrix[,2]), function(x) as.numeric(x)/total)
tumorMatrix[,1] <- tapply(bins, 1:length(bins), function(x) paste("<",x, sep=""))
colnames(tumorMatrix) <- c(letter", "frequency")
 
#write TSV
write.table(tumorMatrix, file='data.tsv', quote=FALSE, sep='\t', row.names= F)
 
## And its done! Now D3 can use the TSV file to plot something
