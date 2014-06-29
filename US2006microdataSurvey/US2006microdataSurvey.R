US2006microdataSurvey <- function(){
        rm(list=ls()) #clear environment 
        
        #load required librarys
        library(reshape2)
        library(Hmisc)
        
        
        #check if destination files exists. If not create them
        if(!file.exists("FGDP.csv") & !file.exists("FEDSTATS_Country.csv")){
                file.create("FGDP.csv")
                file.create("FEDSTATS_Country.csv")
        }
        
        #get data source urls  
        GDPUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
        EDUUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
        
        #download data from urls
        download.file(GDPUrl, destfile="FGDP.csv")
        download.file(EDUUrl, destfile="FEDSTATS_Country.csv")
        
        #Load downloaded raw data into R.
        gdp <- read.csv("FGDP.csv")
        edu <- read.csv("FEDSTATS_Country.csv")
        
        #subset to only required fields and coerse field fro computation to numeric
        #and empty cells to NA
        gdp = subset(gdp, select = c(X, Gross.domestic.product.2012, X.2, X.3))
        gdp <- gdp[5:330,]
        gdp$Gross.domestic.product.2012 <- as.numeric(levels
                                                      (gdp$Gross.domestic.product.2012)
        )[as.integer(gdp$Gross.domestic.product.2012)]
        
        #Eliminate NA from data set
        gdp <- gdp[!is.na(gdp[,2]),]
        gdp <- gdp[order(gdp$X),] 
        
        #merge dataset
        resultMerge = merge(gdp, edu, by.x = "X", by.y = "CountryCode",  all.x = TRUE,  sort = TRUE)
        
        # sort by GDP in descenting order
        resultMerge <- resultMerge[order(-resultMerge$Gross.domestic.product.2012),] 
        
        #reshape result set
        mergerMelt <- melt(resultMerge, id=c("Income.Group"), measure.vars=c("Gross.domestic.product.2012"))
        
        #take average of result by specified variable
        result <- dcast(mergerMelt, Income.Group ~ variable, mean)
        #resultCut <- cut2(mergerMelt$Gross.domestic.product.2012, g=5 )
        
        #take quatile of specified variable
        resultCut <- cut2(mergerMelt$value, g=5 )
        
        #preset result in relational table.
        table(resultCut, mergerMelt$Income.Group)
}