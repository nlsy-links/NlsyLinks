library(Matrix)
#system("R CMD INSTALL C:\\Users\\ElizBard\\David\\Rodgers\\GMRF\\NlsyLinks_0.14.tar.gz")
library(NlsyLinks)
library(spdep)
setwd("C:\\Users\\ElizBard\\David\\Rodgers\\GMRF\\")
# adjmatOK <- source("adjmatOK2.txt")
# numneighs <- adjmatOK$value$num
# fromVect <- numeric(0)
# for(i in 1:length(numneighs)){
#   fromVect <- c(fromVect,rep(i,numneighs[i]))
# }
# toVect <- as.numeric(adjmatOK$value$adj)
# weightVect <- rep(1,length(toVect))
# adjmatOKsn <- as.data.frame(cbind(fromVect,toVect,weightVect))
# colnames(adjmatOKsn) <- c("from","to","weight")
# class(adjmatOKsn) <- c("spatial.neighbour",class(adjmatOKsn))
# attr(adjmatOKsn, "region.id") <- unique(adjmatOKsn$from)
# attr(adjmatOKsn, "n") <- length(unique(adjmatOKsn$from))
# 
# chkWBwmat <- sn2listw(adjmatOKsn)
# str(chkWBwmat)
# chkWBwmat$style <- "B"
# summary(chkWBwmat)
# listw2mat(chkWBwmat)

data(Links79PairExpanded)
#this next segment of code tries to make things more managable; I will restrict my first analyses to small subsets of the data where
reduceLinks <- Links79PairExpanded[1:10,]
nrow(Links79PairExpanded)/2
#create a reduced linked pairs file that eliminates all rows with missing R values (spDep cannot handle missing distances)
  #this is actually not entirely sufficient; Would actually like to purge all family members who are MOST responsible
  #for missing R entries; that code was too complicated to write at the moment, so will leave that for a later date
  #reduceLinks creates a managable number of pairs so that I can visually monitor whether all pairwise combos have 
  #nonmissing R values
reduceLinks2 <- reduceLinks[!is.na(reduceLinks$R),c("Subject1Tag","Subject2Tag","R")]

#THIS CODE DOESN'T WORK YET
#linksPairsDoubleEntered <- CreatePairLinksDoubleEnteredWithNoOutcomes(linksPairDataset=reduceLinks2[,c("Subject1Tag","Subject2Tag","R")],
#                                                        linksNames = c("R"))

#spdep requires the "regions" (families in our case) to be coded 1 to N
  #this code attempts to recode Subject1Tag and Subject2Tag vars accordingly
reduceLinks4 <- reduceLinks2
STag1 <- reduceLinks4$Subject1Tag
STag2 <- reduceLinks4$Subject2Tag
reduceLinks4$Subject1Tag <- STag2
reduceLinks4$Subject2Tag <- STag1

reduceLinks5 <- as.data.frame(rbind(reduceLinks2,reduceLinks4))
reduceLinks5 <- reduceLinks5[order(reduceLinks5$Subject1Tag),]

reduceLinks3 <- reduceLinks5
unqSTags <- unique(c(reduceLinks5$Subject1Tag,reduceLinks5$Subject2Tag))
#recoding Subject1Tag
reduceLinks3$Subject1Tag <-  unlist(lapply(reduceLinks5$Subject1Tag, 
              function(x) c(1:length(unqSTags))[x==unqSTags]))
#recoding Subject2Tag
reduceLinks3$Subject2Tag <-  unlist(lapply(reduceLinks5$Subject2Tag, 
              function(x) c(1:length(unqSTags))[x==unqSTags]))

#Now this dataframe can get submitted to CreateSpatialNeighbours and produce a spatial neighbors object that spdep can handle
spN <- CreateSpatialNeighbours(reduceLinks3)

spList <- sn2listw(spN) #transform sn object to listw object
str(spList)

listw2mat(spList) #look at full N x N region matrix of distances

#spList$style <- "B"



#Okay, now need to work on code to create the proper GMRF (Gaussian Markov Random Field) distances for our BG exercise
  #these calculations need to occur one family matrix at a time

#insert code here that transforms the linkpairs file into an object with R matrix for each family
#...
#end family R matrix code

#for the time being, will move on with writing code for only a single hypothetical R matrix (named Rmat) instead of a full 
  #sample of family R matrices

#Rmat <- matrix(c(1,.5,.25,.5,1,.25,.25,.25,1),3,3,byrow=T)  # a simply fam R matrix

#Rmat <- matrix(c(1,1,.25,1,1,.25,.25,.25,1),3,3,byrow=T) #a somewhat tricky fam R matrix

Rmat <- matrix(c(1,1,.5,.5,.5,
                 1,1,.5,.5,.5,
                 .5,.5,1,.5,.5,
                 .5,.5,.5,1,1,
                 .5,.5,.5,1,1),5,5,byrow=T) #a really tricky fam R matrix with 2 sets of MZ twins

#proper distances/weights for GMRF will require a pos def matrix!!!
  #"A" matrices (A from ACE model) for Mz sibs will be semi-pos def b/c their broad heritable A effects will be perfectly correlated
  #Solution: Created reduced R matrices for each family that only keep in 1 MZ member per set (twins, triplets,...) of MZ sibs
diag(Rmat) <- 0 #change diagnol of matrix to zero to make the identification of MZ sets simple (now only need to find off-diagonal entries = 1)

storeSibMats <- list() #will store local MZ matches identifier "twins" and fam R matrices "condMat" 
                        #"condMat" will exclude columns and rows for one sib
                        
for(i in 1:nrow(Rmat)){  
  storeSibMats[[i]] <- list(twins=c(1:nrow(Rmat))[Rmat[i,]==1],
                            condMat=Rmat[-i,-i])
  if(length(storeSibMats[[i]]$twins)==0) storeSibMats[[i]]$twins <- 0
}

#compare conditional matrices among twin sets
compTwinResults <- list() #will find R matrices among MZ sib sets that do not agree
twinSetMatList <- mapply("[",storeSibMats,"condMat") #only condMat object of storeSibMats
twinSetList <- mapply("[",storeSibMats,"twins") #only "twins" object of storeSibMats
for(i in 1:length(storeSibMats)){
  #browser()
  if(twinSetList[[i]]==0) next #don't bother worrying about sibs that do not have MZ relations
  twinSetMat <- twinSetMatList[unlist(lapply(storeSibMats,function(x) x$twins %in% i))]
  compTwinResults[[i]] <- lapply(twinSetMat,function(x) identical(x,storeSibMats[[i]]$condMat)) #check to see if condMat matrices agree among the set of MZ sibs 
  if(sum(!unlist(compTwinResults[[i]]))>0) print(twinSetList[[i]][!unlist(compTwinResults[[i]])])#print any inconsistent condMat matrices among MZ sib sets
}

#write code here to resolve any twin matrix differences (e.g., average the matrices or choose the first matrix)
#.........
#end resolution code

#keep only 1 MZ sib per set
newRmat <- Rmat
colnames(newRmat) <- c(1:ncol(Rmat))
storeRowNames <- list() #will store the local IDs of MZ sets
twinSetList2 <- twinSetList
for(i in 1:nrow(newRmat)){
  #browser()
  storeRowNames[[i]] <- paste(c(colnames(newRmat)[i],colnames(newRmat)[newRmat[i,]>=1]))
  newRmat <- newRmat[!newRmat[,i]>=1,!newRmat[i,]>=1]
  if(i >= nrow(newRmat)) break
}

rownames(newRmat) <- storeRowNames #create rownames that store local IDs whose info (R relations) is conveyed by each row
                                      #MZ sibs will share a single row

aID <- unlist(lapply(c(1:5),function(x) c(1:nrow(newRmat))[grepl(x,storeRowNames)])) #this variable could be exported to new dataframe that describes Row and Column local IDs


oldRmat <- Rmat
Rmat <- newRmat
 
diag(Rmat) <- 1 #restore proper diagonal of R matrix

#check to see if new reduced R matrix is pos def (theoretically, this is possible if R relations are not accurate)
  #if R matrix is not pos def, use the nearPD function of Matrix library to create a pos def matrix
if(sum(eigen(Rmat)$values<=0)>0) Rmat <- as.matrix(nearPD(Rmat,corr=T)$mat) 

#IGNORE THE FOLLOWING COMMENTS!!! THIS WAS AN OLD ATTEMPT TO RESOLVE MZ SET SEMI-DEF PROBLEMS
  #Could try this approach which forces the offdiagnol corrs to be < 1
  #this would be similar to the technique of ridge regression which adds small fractions to the diagonal terms
  #see the Dong and Ball (1985) applied psych methods paper

#Now create proper GMRF weights to be used in GMRF BG analysis
Bmat <- matrix(0,nrow(Rmat),ncol(Rmat)) #stores conditional beta weights
Dmat <- matrix(0,nrow(Rmat),ncol(Rmat))#stores conditional residual variances
Imat <- diag(1,nrow(Rmat),ncol(Rmat))#create Identity matrix for later back translation to original Rmat (an error check method to be used in later unit testing)
for(i in 1:nrow(Rmat)){
  mymat <- Rmat[-i,-i] #create the matrix w/o the row/col for the individual
  invmat <- solve(mymat) #Inverse matrix of what's left over
  colCorr <- Rmat[-i,i] #Correlations of that guy with his family members
  betas <- invmat %*% colCorr #The OLS solution
  vare <- 1 - t(betas) %*% mymat %*% betas #What's left over.  We're working with standardized variables, so everything should add to one.
  Bmat[i,-i] <- betas #Using other family members to predict his A effect.
  Dmat[i,i] <- vare #What's left over
}
sigMVN <- solve(Imat - Bmat) %*% Dmat #sigMVN Should equal Rmat!!! will later use this for unit testing
sigMVN #Just a check that it equals original R matrix

if( sum(abs(sigMVN - Rmat)) > 1e-13 ) stop("The recovered/checked matrix was not within the specified allowed error.")
cov2cor(sigMVN)

#elements of Bmat now store the distance/weight information required for proper GMRF analysis
  #this matrix might benefit from a pass to spdep so that a full NxN weight matrix or a full weight matrix file for WinBUGS can be created
#elements of Dmat will also be required but I'm still working on how to store that information.  
  #For now, I wouldn't mind if Bmat and Dmat were passed to a list object with a slot for each family that includes 
  #objects for family-specific Bmat and Dmat matrices and an object for the local family IDs related to Bmat and Dmat rows/cols

#IGNORE THE REST OF THE CODE BELOW
# library(MASS)
# mu <- c(0,0,0)
# x <- mvrnorm(1000, mu, Rmat, empirical = TRUE)
# linPred <- lm(x[,1]~0+x[,2:3])
# summary(linPred)

# storeBetas1 <- rep((1/vare),2)*t(betas)
# storeBetas2 <- rep((1/vare),2)*t(betas)
# storeBetas3 <- rep((1/vare),2)*t(betas)
# 
# wtMat <- matrix(0,3,3)
# wtMat[1,-1] <- storeBetas1
# wtMat[2,-2] <- storeBetas2
# wtMat[3,-3] <- storeBetas3




