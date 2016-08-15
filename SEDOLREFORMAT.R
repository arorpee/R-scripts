
######################################################################################################################################################
######################################################################################################################################################
######################################################################################################################################################
### Program Name:         

### Version:               1

### This program does:   

### Manual steps needed:   

### Authors:               Arora

### Original Date:       

### Ideas/To do:          
######################################################################################################################################################
######################################################################################################################################################
######################################################################################################################################################

### Settings: ########################################################################################################################################

rm(list=ls()) 


### Libraries: #######################################################################################################################################


library(RMySQL)


### DB connection: ###################################################################################################################################


### Open database connection:

drv <- dbDriver("MySQL")


### set the database to run this script on: 

Database <- "SOLACTIVE"  


con <- dbConnect(drv, user="parora", dbname=Database, host="127.0.0.1", password ="acCvefayMLay", port=3308)  #if not working try 3306, 3307, 3308 or look at:  system("netstat -an")


DBData <- as.matrix(dbGetQuery(con, "select sedol, CHAR_LENGTH(sedol) from SOLACTIVE.T_MAPPING where sedol is not null and sedol <> 0
                               and CHAR_LENGTH(sedol) <> 7"))  
dim(DBData)
head(DBData)

### use only small subset fot testing:
#DBData <- DBData[1:30, ]



###############loading all and only sedols in the matrix###############################

sedol<- as.matrix(DBData[,"sedol"])
dim(sedol)
head(sedol)

test1<- c(DBData[,"sedol"])


### 1. replace all " " with "": ##############################

x1<- test1[nchar(test1)==6]

y1<-gsub(" ","",x1) 
nchar(y1)

x2<- test1[nchar(test1)==5]

y2<-gsub(" ","",x2) 
nchar(y2)


x3<- test1[nchar(test1)==4]

y3<-gsub(" ","",x3) 
nchar(y3)

### 2: determine how many 0's are missing: ####################
tNumberOf0Missing <- 7- nchar(sedol)
tNumberOf0Missing


### 3. add missing 0's in the front: ###########################

if(nchar(y1)=6){
  
  e1<- paste(0, y1)
  v1<-gsub(" ","",e1)
  print(v1)
}

if(nchar(y2)=5){
    
    e2<- paste(0, y2)
    e12<- paste(0,e2)
    v2<-gsub(" ","",e12)
    print(v2)
}
  
if(nchar(y3)=4){
  
  e3<- paste(0, y3)
  e13<- paste(0,e3)
  e113<- paste(0,e13)
  v3<-gsub(" ","",e113)
  print(v3)
}
####################################################################################################################################################
####################################################################################################################################################
### determine max missing 0's:
####################################################################################################################################################
####################################################################################################################################################
max(tNumberOf0Missing)



for(i in 1:max(tNumberOf0Missing)){
  
  ### determine Position in Matrix where i 0's are missing:  
  tPos <- which(tNumberOf0Missing==i)
  tPos
  
  sedol[tPos]
  
  sedol[tPos] <- paste(0, sedol[tPos])
}




#sedol<- as.matrix(DBData[,"sedol"])
#dim(sedol)
#head(sedol)


#test1<- c(DBData[,"sedol"])

#x<- test1[nchar(test1)==6]

#y<-gsub(" ","",x) 
#nchar(y)

#if(nchar(y)=6){
  
 # e<- paste(0, y)
  
  #v<-gsub(" ","",e)
  #print(v)
#}
