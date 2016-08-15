


sql <- "select ID, ISIN, BB, ric, live, count(isin) as Ci
from SOLACTIVE.T_CA_CHANGE  
where  live=1 
group by isin having Ci> 1"


DB <- as.matrix(dbGetQuery(con, sql))
dim(DB)                                                # 1223 found
head(DB, 10)





DB[, "ID"] <- gsub(" ", "", DB[, "ID"])

Erg <- matrix(NA, 1, 15)
for(i in 1:nrow(DB)){
  
  
  sql <- paste("select * from SOLACTIVE.T_CA_CHANGE where isin='", DB[i, "ISIN"], "'", sep="")
  sql
  
  temp <- as.matrix(dbGetQuery(con, sql))
  temp
  
  Erg <- rbind(Erg, temp)
  
  #print(i)
}
nrow(DB); i
head(Erg, 20)
dim(Erg)




### remove all entries with no ISIN at all:

tPosNoISIN <- which(Erg[, "Isin"]== "")
tPosNoISIN



Erg[tPosNoISIN, ] <- NA

Erg <- Erg[which(is.na(Erg[, "Isin"])== F), ]
head(Erg)
dim(Erg)




























