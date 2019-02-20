library(dplyr);library(readr);library(tidyr)
mydir<-
setwd(mydir)

cyto <- read.table("cytoBand.txt")
colnames(cyto) <- c("chr","start","end","cyto","gieStain")
cyto$Chromosome <- substr(cyto$chr, 4, 10000)
cyto$name <- paste0("cyto.",cyto$Chromosome, cyto$cyto)
p <- length(cyto$name)

#BC_32ea_k100,Normal_21ea_k100,BC_32ea_k15,Normal_21ea_k15
#

### -- load -- ###
# Disease data
disease <- read_delim("Data_20190215/PC_20ea_k15.txt", 
                        "\t", escape_double = FALSE, trim_ws = TRUE)
colnames(disease)[1] <- 'Chrom'
colnames(disease)[4:13]<-paste0('n_',colnames(disease)[4:13])

# Normal data
normal <- read_delim("Data_20190215/PC_20ea_k100.txt", 
                       "\t", escape_double = FALSE, trim_ws = TRUE)
colnames(normal)[1] <- 'Chrom'
colnames(normal)[4:13]<-paste0('n_',colnames(normal)[4:13])

#third
aa <- read_delim("Data_20190215/RC_20ea_k100.txt", 
                     "\t", escape_double = FALSE, trim_ws = TRUE)
colnames(aa)[1] <- 'Chrom'
colnames(aa)[4:11]<-paste0('n_',colnames(aa)[4:11])



### -- cyto band -- ###
######disease
n <- nrow(disease); n
disease$cyto <- NA; sum(is.na(disease$cyto))

for(i in 1:n){
  
  #chromosome
  temp.i <- cyto[cyto$chr == disease$Chrom[i],]
  #start, end
  where <- (temp.i$start <= disease$Start[i] & temp.i$end >= disease$End[i])
  
  if(sum(where) == 0) {print(paste0('cyto NA index :', i))}
  else {disease$cyto[i] <- temp.i$name[where]}
}

colSums(is.na(disease))

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

####third
n <- nrow(aa); n
aa$cyto <- NA; sum(is.na(aa$cyto))

for(i in 1:n){
  temp.i <- cyto[cyto$chr == aa$Chrom[i],]
  where <- (temp.i$start <= aa$Start[i] & temp.i$end >= aa$End[i])
  
  if(sum(where) == 0) {print(paste0('cyto NA index :', i))}
  else {aa$cyto[i] <- temp.i$name[where]}
}

colSums(is.na(aa))


##dataframe spread

##--disease--

colnames(disease)

disease2<-disease[,c(4:24)] %>% gather(id, Value,n_418,n_462,
                                n_468,n_472,n_475,n_483,n_496,
                                       n_497,n_515,n_541,P006,P011,
                                       P015,P017,P019,P020,UP008,
                                       UP017,UP018,UP025) %>% 
  group_by(cyto,id) %>% summarise(m = mean(Value,na.rm=T)) %>% spread(cyto,m)

##--normal--
normal[,4:24]
colnames(normal)

normal2<-normal[,c(4:24)] %>% gather(id, Value,
                                     n_418,n_462,
                                     n_468,n_472,n_475,n_483,n_496,
                                     n_497,n_515,n_541,P006,P011,
                                     P015,P017,P019,P020,UP008,
                                     UP017,UP018,UP025) %>% 
  group_by(cyto,id) %>% summarise(m = mean(Value,na.rm=T)) %>% spread(cyto,m)

aa[,4:24]
colnames(aa)

aa2<-aa[,c(4:25)] %>% gather(id, Value,
                             n_374, 
                           n_380,n_417,n_447,n_495, 
                           n_506,n_524,n_533,`Q5-P`,  
                            R003,UP002,UP002_1,UP004,
                          UP005,UP006,UP009,UP012,  
                          UP013,UP014,UP021,UP027) %>% 
  group_by(cyto,id) %>% summarise(m = mean(Value,na.rm=T)) %>% spread(cyto,m)


write.csv(disease2,'PC_20ea_k15_cyto.csv',row.names = T)
write.csv(normal2,'PC_20ea_k100_cyto.csv',row.names = T)
write.csv(aa2,'RC_20ea_k100_cyto.csv',row.names = T)
