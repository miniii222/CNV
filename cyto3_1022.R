library(dplyr);library(readr);library(tidyr)
mydir<-"C:/Users/wjssm/Desktop/cnv"
setwd(mydir)

### -- load -- ###
# cyto
cyto <- read.table("cytoBand.txt")
colnames(cyto) <- c("chr","start","end","cyto","gieStain")
cyto$Chromosome <- substr(cyto$chr, 4, 10000)
cyto$name <- paste0("cyto.",cyto$Chromosome, cyto$cyto)
p <- length(cyto$name)

# BC data
BC <- read_delim("Data_20190215/BC_32ea_k15.txt", 
                      "\t", escape_double = FALSE, trim_ws = TRUE)
colnames(BC)[1] <- 'Chrom'
colnames(BC)[4:17]<-paste0('n_',colnames(BC)[4:17])

# PC data
PC <- read_delim("Data_20190215/PC_20ea_k15.txt", 
                      "\t", escape_double = FALSE, trim_ws = TRUE)
colnames(PC)[1] <- 'Chrom'
colnames(PC)[4:17]<-paste0('n_',colnames(PC)[4:17])

# Normal data
normal <- read_delim("Data_20190215/Normal_21ea_k15.txt", 
                     "\t", escape_double = FALSE, trim_ws = TRUE)
colnames(normal)[1] <- 'Chrom'
colnames(normal)[4:17]<-paste0('n_',colnames(normal)[4:17])


### -- cyto band -- ###
######BC
n <- nrow(BC); n
BC$cyto <- NA; sum(is.na(BC$cyto))

for(i in 1:n){
  
  #chromosome
  temp.i <- cyto[cyto$chr == BC$Chrom[i],]
  #start, end
  where <- (temp.i$start <= BC$Start[i] & temp.i$end >= BC$End[i])
  
  if(sum(where) == 0) {print(paste0('cyto NA index :', i))}
  else {BC$cyto[i] <- temp.i$name[where]}
}

colSums(is.na(BC))


######PC
n <- nrow(PC); n
PC$cyto <- NA; sum(is.na(PC$cyto))

for(i in 1:n){
  
  #chromosome
  temp.i <- cyto[cyto$chr == PC$Chrom[i],]
  #start, end
  where <- (temp.i$start <= PC$Start[i] & temp.i$end >= PC$End[i])
  
  if(sum(where) == 0) {print(paste0('cyto NA index :', i))}
  else {PC$cyto[i] <- temp.i$name[where]}
}

colSums(is.na(PC))


#####normal
n <- nrow(normal); n
normal$cyto <- NA; sum(is.na(normal$cyto))

for(i in 1:n){
  temp.i <- cyto[cyto$chr == normal$Chrom[i],]
  where <- (temp.i$start <= normal$Start[i] & temp.i$end >= normal$End[i])
  
  if(sum(where) == 0) {print(paste0('cyto NA index :', i))}
  else {normal$cyto[i] <- temp.i$name[where]}
}

colSums(is.na(normal))



##dataframe spread
na_replace <- function(x) { replace(x, is.na(x), -1022) }


##--disease--
#BC
colSums(is.na(BC)) %>% sum()
BC2 <- sapply(BC[-36], na_replace)
colSums(BC2 == -1022) %>% sum()
colSums(is.na(BC2)) %>% sum()


BC2<-as.data.frame(BC2)
colnames(BC2)
BC2<- as.tbl(BC2)
BC2$cyto <- BC$cyto

BC2[,2:35] <- sapply(BC2[,2:35], as.numeric)

BC2 <- BC2[,c(4:36)] %>% gather(id, Value,n_351,n_399,
                                       n_409,n_433,n_438,n_463,n_491,
                                       n_502,n_510,n_516,n_531,n_535,
                                       n_538,n_545,B001,B002,B003,
                                       B004,B006,`Q6-U`,`Q7-U`,UP001,
                                       UP003,UP007,UP011,UP019,UP020,
                                       UP022,UP028,UP029,UP030,UP033
) %>% group_by(cyto,id) %>% summarise(m = mean(Value,na.rm=T)) %>% spread(cyto,m)


#normal
colSums(is.na(PC)) %>% sum()
dim(PC)
PC2 <- sapply(PC[-24], na_replace)
colSums(PC2 == -1022) %>% sum()
colSums(is.na(PC2)) %>% sum()


PC2<-as.data.frame(PC2)
colnames(PC2)
PC2<- as.tbl(PC2)
PC2$cyto <- PC$cyto

PC2[,2:23] <- sapply(PC2[,2:23], as.numeric)

PC2 <- PC2[,c(4:24)] %>% gather(id, Value,n_418,n_462,
                                n_468,n_472,n_475,n_483,n_496,
                                n_497,n_515,n_541,n_P006,n_P011,
                                n_P015,n_P017,P019,P020,UP008,
                                UP017,UP018,UP025
) %>% group_by(cyto,id) %>% summarise(m = mean(Value,na.rm=T)) %>% spread(cyto,m)




##--normal--
colSums(is.na(normal)) %>% sum()
dim(normal)
normal2 <- sapply(normal[-25], na_replace)
colSums(normal2 == -1022) %>% sum()
colSums(is.na(normal2)) %>% sum()


normal2<-as.data.frame(normal2)
colnames(normal2)
normal2<- as.tbl(normal2)
normal2$cyto <- normal$cyto

normal2[,2:24] <- sapply(normal2[,2:24], as.numeric)


normal2<-normal2[,c(4:25)] %>% gather(id, Value,
                                     n_416,n_482,
                                     n_500,n_508,n_509,n_512,n_513,
                                     n_519,n_521,n_527,n_530,n_N001,
                                     n_N003,n_N005,UP015,UP016,UP023,
                                     UP024,UP026,UP031,UP032) %>% 
  group_by(cyto,id) %>% summarise(m = mean(Value,na.rm=T)) %>% spread(cyto,m)

write.csv(BC2, 'BC_1022.csv', row.names = F)
write.csv(PC2, 'PC_1022.csv', row.names = F)
write.csv(normal2, 'normal_1022.csv', row.names = F)
