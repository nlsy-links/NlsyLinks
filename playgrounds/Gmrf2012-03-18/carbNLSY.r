rm(list=ls(all=TRUE))
library(NlsyLinks)  #?NlsyLinks
library(Matrix)
#library(rjags)
library(spdep)
#library(R2WinBUGS)
#library(coda)
#library(MplusAutomation)

# setwd("F:/Projects/RDev/NlsyLinksStaging/Content/Playgrounds/Gmrf")
# source(file.path(getwd(),"gmrfSimFuncs.R"))

dsSingleEntered <- subset(Links79PairExpanded, RelationshipPath=='Gen2Siblings' &
				!is.na(WeightStandardizedForAge19To25_1) & !is.na(WeightStandardizedForAge19To25_2))
#dsSingleEntered <- subset(Links79Pair, RelationshipPath=='Gen2Siblings')
#colMeans(dsSingleEntered[,c("WeightStandardizedForAge19To25_1","WeightStandardizedForAge19To25_2")])
#sum(is.na(dsSingleEntered[,c("WeightStandardizedForAge19To25_1","WeightStandardizedForAge19To25_2")]))
dsSingleEntered$MotherID <- floor(dsSingleEntered$Subject1Tag/100)
motherIDs <- sort(unique(dsSingleEntered$MotherID))
if( length(motherIDs) != 3749 ) stop("The number of mothers of Gen2 siblings should be correct.") #Implied is that she has to have MORE than one kid.
matReducedFamilies <- list()
dsIndicesForMatrix <- list()

# extIDs <- sort(unique(dsSingleEntered$ExtendedID))
# for(eID in extIDs){
# 	famMat <- subset(dsSingleEntered,ExtendedID==eID)
# 	if(any(famMat$R==1) & nrow(famMat)==1) print(famMat$ExtendedID)
# }

familiesToExcludeBecauseMzSingleton <- c(731, 3151, 3922, 6854, 9536)
dsSingleEntered <- subset(dsSingleEntered, !(ExtendedID %in% familiesToExcludeBecauseMzSingleton))
#dsSingleEntered[dsSingleEntered$R==1,]
#dsSingleEntered[dsSingleEntered$ExtendedID==774,]
#matDummy <- matrix(NA, ncol=2, nrow=2)

ExtractFullFamily <- function( dsFamilyPairs ) {
  subjectTags <- sort(unique(c(dsFamilyPairs$Subject1Tag, dsFamilyPairs$Subject2Tag)))
  subjectCount <- length(subjectTags)
  if( subjectCount <= 1 ) stop("Only families with at least two siblings should get here.")

  dsMZs <- subset(dsFamilyPairs, R==1) #If double entered: & Subject1Tag < Subject2Tag)
  #LINE ABOVE ASSUMES NO FAMILY HAS MORE THAN ONE SET OF MZs
  subjectTagsOfYoungerMZs <- sort(unique(dsMZs$Subject2Tag)) #This might include two kids in a triplet.
  dsFamilyWithoutYoungerMZs <- subset(dsFamilyPairs, !(Subject1Tag %in% subjectTagsOfYoungerMZs | Subject2Tag %in% subjectTagsOfYoungerMZs))

  subjectTagsWithoutYoungerMZs <- sort(unique(c(dsFamilyWithoutYoungerMZs$Subject1Tag, dsFamilyWithoutYoungerMZs$Subject2Tag)))
  subjectCountWithoutYoungerMZs <- length(subjectTagsWithoutYoungerMZs)

  matReduced <- matrix(NA, nrow=subjectCountWithoutYoungerMZs, ncol=subjectCountWithoutYoungerMZs)
  diag(matReduced) <- 1
  for( index1 in 1:(subjectCountWithoutYoungerMZs-1) ) {
    for( index2 in (index1+1):subjectCountWithoutYoungerMZs ) {
      subject1Tag <- subjectTagsWithoutYoungerMZs[index1]
      subject2Tag <- subjectTagsWithoutYoungerMZs[index2]
      dsPair <- subset(dsFamilyPairs, Subject1Tag==subject1Tag & Subject2Tag==subject2Tag)
      if( nrow(dsPair)!=1 ) stop("The subset should contain exactly one row.")
      matReduced[index1, index2] <- dsPair$R
      matReduced[index2, index1] <- dsPair$R
      if( !is.na(dsPair$R) && dsPair$R == 1 ) { #browser()
		  stop("MZ reached.  None should have gotten here.")
	  }
    }
  }

  dsIndex <- data.frame(SubjectTag=subjectTags, RowID=NA)
  runningIndex <- 1
  for( rowIndex in seq_len(nrow(dsIndex)) ) {
    subjectTag <- dsIndex$SubjectTag[rowIndex]
    if( subjectTag %in% subjectTagsWithoutYoungerMZs ) { #They're not in an MZ pair, or they're the oldest MZ
      dsIndex$RowID[rowIndex] <- runningIndex
      runningIndex <- runningIndex + 1
    }
    else {
      oldestSubjectTag <- max(subset(dsFamilyPairs, Subject2Tag==subjectTag)$Subject1Tag)
      indexOfOldest <- subset(dsIndex, SubjectTag==oldestSubjectTag)$RowID
      dsIndex$RowID[rowIndex] <- indexOfOldest
    }
  }
  if( length(unique(dsIndex$RowID)) != nrow(matReduced) ) stop("The number of uniqueAComponents should be consistent across matReduced and dsIndex")

  #if( max(dsFamilyPairs$R) >= .8 ) stop("MZ reached")
  return( list(MatReduced=matReduced, DsIndex=dsIndex) )
}

# trueSingletonFamilyCount <- 0
# mzSingletonFamilyCount <- 0
# multipleKidFamilyCount <- 0
# for( motherID in motherIDs ) {
#   dsFamilyPairs <- subset(dsSingleEntered, MotherID==motherID & !is.na(R))
#   pairCount <- nrow(dsFamilyPairs)
# #   if( pairCount == 0 ) {
# #     trueSingletonFamilyCount <- trueSingletonFamilyCount + 1
# #   }
# #   else if( all(dsFamilyPairs$R==1) ) {
# #     mzSingletonFamilyCount <- mzSingletonFamilyCount + 1
# #   }
# #   else {
#   if( pairCount > 0 ) {
#     multipleKidFamilyCount <- multipleKidFamilyCount + 1
#     extract <- ExtractFullFamily(dsFamilyPairs)
#     matReducedFamilies[[multipleKidFamilyCount]] <- extract$MatReduced
#     dsIndicesForMatrix[[multipleKidFamilyCount]] <- extract$DsIndex
#   }
# }
#
# if( length(matReducedFamilies)!=1781 ) stop("The number of nuculear families with multiple siblings should be correct.")
multipleSibFamilyCount <- 1
for( motherID in motherIDs ) {
  dsFamilyPairs <- subset(dsSingleEntered, MotherID==motherID)
  pairCount <- nrow(dsFamilyPairs)
  if( pairCount > 0 ) {
    extract <- ExtractFullFamily(dsFamilyPairs)
    matReducedFamilies[[multipleSibFamilyCount]] <- extract$MatReduced
    dsIndicesForMatrix[[multipleSibFamilyCount]] <- extract$DsIndex
    multipleSibFamilyCount <- multipleSibFamilyCount + 1
  }
}
if( length(matReducedFamilies) != 3745 ) stop("The number of nuculear families with multiple siblings should be correct.")


#all(dsFamilyPairs$R==1)

#Drop any nuclear families with any missingness
#   TODO: revise this so it drops only the minimum number of members in a family.
#   Families will be dropped only if it contains zero nonmissing pairs
runningCompleteCount <- 0
matNonmissingFamilies <- list()
dsIndicesForMatrixForNonmissingFamilies <- list()
for( familyIndex in seq_along(matReducedFamilies) ) {
  #Check for NAs
  if( sum(is.na(matReducedFamilies[[familyIndex]])) <= 0 ) {
    runningCompleteCount <- runningCompleteCount + 1
    matNonmissingFamilies[[runningCompleteCount]] <- matReducedFamilies[[familyIndex]]
    dsIndicesForMatrixForNonmissingFamilies[[runningCompleteCount]] <- dsIndicesForMatrix[[familyIndex]]
  }
}
#if( length(matNonmissingFamilies) != 3489 ) stop("The number of nuculear families with NO missing pairs should be correct.")

#Apparently, there aren't any families with only an MZ birth, and no other siblings.
#   (This may change when the families with missingness aren't entirely chunked out the window.)
for( familyIndex in seq_along(matNonmissingFamilies) ) {
  if( all(matNonmissingFamilies[[familyIndex]]==1) ) stop("MZ singleton family")
}

#If there are any non positive definite matrices, then force them to the nearest positive definite matrix
#   Apparently, there are none. (This may change when the families with missingness aren't entirely chunked out the window.)
nudgedNonPositiveDefiniteCount <- 0
for( familyIndex in seq_along(matNonmissingFamilies) ) {
  if( any(eigen(matNonmissingFamilies[[familyIndex]])$values<=0) ) {
    matNonmissingFamilies[[familyIndex]] <- as.matrix(nearPD(matNonmissingFamilies[[familyIndex]], corr=T)$mat)
    nudgedNonPositiveDefiniteCount <- nudgedNonPositiveDefiniteCount + 1
  }
}
if( nudgedNonPositiveDefiniteCount !=0 ) stop("The number of nudgedNonPositiveDefiniteCount should be correct.")

#Now create proper GMRF weights to be used in GMRF BG analysis
matBetaFamilies <- list()
matDogmaFamilies <- list() #What does 'D' stand for in 'Dmat'?
matPrecFamilies  <- list() #Prec stands for precision matrix
for( familyIndex in seq_along(matNonmissingFamilies) ) {
  Rmat <- matNonmissingFamilies[[familyIndex]]
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
  if( sum(abs(sigMVN - Rmat)) > 1e-12 ) stop("The recovered/checked matrix was not within the specified allowed error.")
  #if( sum(Bmat) != ???? ) stop("The elements of beta matrix should equal ????.")
  #if( sum(Dmat) != ???? ) stop("The elements of dogma matrix should equal ????.")
  #print(sum(Bmat))

  #cov2cor(sigMVN)
  matBetaFamilies[[familyIndex]] <- Bmat
  matDogmaFamilies[[familyIndex]] <- Dmat
  matPrecFamilies[[familyIndex]] <- solve(Dmat) %*% (Imat - Bmat)
}

#Transfer the beta weights back into the sparse matrix
startTime <- Sys.time()
dsDoubleEntered <- CreatePairLinksDoubleEnteredWithNoOutcomes(Links79Pair)
dsDoubleEntered$weight <- 99
dsDoubleEntered$precWeight <- 99
dsDoubleEntered$precDiag <- 99
dsDoubleEntered$dval <- 99
for( familyIndex in seq_along(matBetaFamilies) ) {
#for( familyIndex in 1 ) {
  #print(familyIndex)
  matBeta <- matBetaFamilies[[familyIndex]]
  matDogma <- matDogmaFamilies[[familyIndex]]
  matPrec <- matPrecFamilies[[familyIndex]]
  dsFamilyIndices <- dsIndicesForMatrixForNonmissingFamilies[[familyIndex]]
#  matBetaFamilies[[1]]
#  matDogmaFamilies[[1]]
#  dsIndicesForMatrixForNonmissingFamilies[[1]]
  if( length(unique(dsFamilyIndices$RowID)) != nrow(matBeta) ) stop("The number of uniqueAComponents should be consistent across matReduced and dsIndex")

  kidCount <- nrow(dsFamilyIndices)
  for( subject1Index in 1:kidCount ) {
    rowID1 <- dsFamilyIndices$RowID[subject1Index]
    subject1Tag <- dsFamilyIndices$SubjectTag[subject1Index]
    for( subject2Index in 1:kidCount ) {
      if( subject1Index != subject2Index ) {
        rowID2 <- dsFamilyIndices$RowID[subject2Index]
        subject2Tag <- dsFamilyIndices$SubjectTag[subject2Index]

        weight <- matBeta[rowID1, rowID2]
    		dval <- matDogma[rowID1,rowID1]
    		precWeight <- matPrec[rowID1,rowID2]
    		precDiag <- matPrec[rowID1,rowID1]
        selectedIndex <- which(dsDoubleEntered$Subject1Tag==subject1Tag & dsDoubleEntered$Subject2Tag==subject2Tag)
#         which(dsDoubleEntered$Subject1Tag==201 & dsDoubleEntered$Subject2Tag==202)
#         dsDoubleEntered[selectedIndex , 'weight'] <- weight
#     		dsDoubleEntered[selectedIndex , 'dval'] <- dval
#     		dsDoubleEntered[selectedIndex, 'precWeight'] <- precWeight
#     		dsDoubleEntered[selectedIndex, 'precDiag'] <- precDiag

        dsDoubleEntered[selectedIndex, c('weight','dval','precWeight','precDiag')] <- c(weight, dval, precWeight, precDiag)
      }
    }
  }
}
print(paste("Elapsed time for 'Transfer the beta weights back into the sparse matrix':", Sys.time() - startTime))
rm(startTime)


colnames(dsDoubleEntered)
dsDoubleEntered[1:10,]
matBetaFamilies[[2]]
matDogmaFamilies[[2]]
dsIndicesForMatrixForNonmissingFamilies[[2]]

dsDoubleEntered[dsDoubleEntered$weight>90,]

dsDoubleEntered[1:10,]
dsFamilyIndices[1:10,]


#Inspect the sparse matrix and the relationship between R & weight
summary(dsDoubleEntered)
hist(dsDoubleEntered$weight)
plot(jitter(dsDoubleEntered$R), dsDoubleEntered$weight)

abline(a=0, b=1)
if( sum(!is.na(dsDoubleEntered$weight)) != 22150 ) stop("The count of nonmissing neighbor weights should be correct.")

#Create a spatial.neighbors object from the sparse matrix
#dsNeighbors <- dsDoubleEntered
dsNeighbors <- subset(dsDoubleEntered,subset= weight!=99 | dval!=99 | precWeight!=99)# & Subject1Tag < 400)

#subset(dsNeighbors, precWeight==99)

nrow(dsNeighbors)/2
dsNeighbors$MotherID <- floor(dsNeighbors$Subject1Tag/100)
#dsDoubleEntered[11085:11096,]
#unique(dsDoubleEntered$Subject1Tag)[1:10]
#head(cbind(dsNeighbors$Subject1Tag, order(dsNeighbors$Subject1Tag)), 100)

#within each family, assign the same "from" id to each Mz twin

MzIDs <- dsNeighbors$Subject1Tag[dsNeighbors$R==1]

unique(dsNeighbors$MotherID[dsNeighbors$Subject1Tag %in% MzIDs])

MzIDlist <- list()
dsNeighbors$tempS1Tag <- dsNeighbors$Subject1Tag
dsNeighbors$tempS2Tag <- dsNeighbors$Subject2Tag
mzCount <- 0
for(unqMID in unique(dsNeighbors$MotherID)){
	#unqMID <- 731
	famBlock <- subset(dsNeighbors,subset=MotherID==unqMID)
	#nrow(famBlock)
	famBlock <- famBlock[order(famBlock$Subject1Tag,famBlock$Subject2Tag),]
	storeMZids <- subset(famBlock,subset=R==1,select=Subject1Tag)
	if(nrow(storeMZids)>0){
		mzCount <- mzCount+1
		MzIDlist[[mzCount]] <- unname(unlist(storeMZids))
		dsNeighbors$tempS1Tag <- ifelse(dsNeighbors$tempS1Tag %in% storeMZids[2,],rep(storeMZids[1,],nrow(dsNeighbors)),dsNeighbors$tempS1Tag)
		dsNeighbors$tempS2Tag <- ifelse(dsNeighbors$tempS2Tag %in% storeMZids[2,],rep(storeMZids[1,],nrow(dsNeighbors)),dsNeighbors$tempS2Tag)
	}
}

dsNeighbors2 <- subset(dsNeighbors,subset= tempS1Tag != tempS2Tag)

dsNeighbors2$from <- as.integer(ordered(dsNeighbors2$tempS1Tag))
dsNeighbors2$to <- as.integer(ordered(dsNeighbors2$tempS2Tag))
summary(dsNeighbors2)
unique(dsNeighbors$MotherID[dsNeighbors$R==1])
dsNeighbors[dsNeighbors$MotherID==365,]
dsNeighbors2[dsNeighbors2$MotherID==365,]
dsNeighbors3 <- dsNeighbors2[!duplicated(dsNeighbors2[,c("from","to")]),]
dsNeighbors3 <- dsNeighbors3[order(dsNeighbors3$from,dsNeighbors3$to),]

#create a file that links (via "from" field) the data to the spatial neighbors object
tempDat <- subset(Links79PairExpanded, RelationshipPath=='Gen2Siblings')
tempDat2 <- ExtraOutcomes79
tempDat2$SubjectTag <- tempDat2$SubjectID
dsSingleEntered2 <- subset(CreatePairLinksDoubleEntered(outcomeDataset=tempDat2,linksPairDataset=tempDat,
		outcomeNames=c("WeightStandardizedForAge19To25"),validateOutcomeDataset=TRUE),
		!is.na(WeightStandardizedForAge19To25_1) & !is.na(WeightStandardizedForAge19To25_2))
dsSingleEntered3 <- dsSingleEntered2[!duplicated(dsSingleEntered2$Subject1Tag),]
nrow(dsSingleEntered3)
dsNLink <- dsNeighbors2[!duplicated(dsNeighbors2$Subject1Tag),c("Subject1Tag","from")]
nrow(dsNLink)

NlsyCarb <- merge(dsSingleEntered3,dsNLink,by.x="Subject1Tag",by.y="Subject1Tag")
NlsyCarb <- NlsyCarb[order(NlsyCarb$from),]
nrow(NlsyCarb) #should match nrow(dsNLink)
head(NlsyCarb,200)
NlsyCarb[is.na(NlsyCarb$WeightStandardizedForAge19To25_2),c("Subject1Tag","Subject2Tag","WeightStandardizedForAge19To25_2")]

#create a bona fide spatial neighbor object that can be passed to spdep

dsNeighbors4 <- subset(dsNeighbors3,select=c(from,to,weight)) #bona fide sn object must only have these 3 variables
colnames(dsNeighbors4) <- c("from","to","weight")

dsNeighbors5 <- subset(dsNeighbors3,select=c(from,to,precWeight)) #bona fide sn object must only have these 3 variables
colnames(dsNeighbors4) <- c("from","to","weight")


wbWMats <- createWBmat(dsNeighbors4=dsNeighbors4)
wbWMat <- wbWMats$wbWMat
#will use this following object for R-INLA analyses
	#this neighborhood object actual contains the contents of the joint density precision matrix in the weights slot
wbPWMats <- createWBmat(dsNeighbors4=dsNeighbors5)
wbPWMat <- wbPWMats$wbWMat

#prepare the CARB BUGS model
NlsyCarb <- NlsyCarb[order(NlsyCarb$from),]
NlsyCarb$MotherID <- floor(NlsyCarb$Subject1Tag/100)
NlsyCarb$cID <- as.integer(ordered(NlsyCarb$MotherID))
Na <- length(unique(NlsyCarb$from)) #should equal length(wbWMat$num)
Nc <- length(unique(NlsyCarb$cID))
NN <- length(wbWMat$weights)
aID <- NlsyCarb$from
cID <- NlsyCarb$cID
wgts <- wbWMat$weights
adj <- wbWMat$adj
loc <- wbWMat$nbLocator
y <- NlsyCarb$WeightStandardizedForAge19To25_1
d <- dsNeighbors3$d[!duplicated(dsNeighbors3$from)]
#d2 <- simDatLinked$d[!duplicated(simDatLinked$from)][order(simDatLinked$from[!duplicated(simDatLinked$from)])]
Ns <- nrow(NlsyCarb)

CARB.data <- list("Ns","Na","Nc","NN","aID","cID","wgts","adj","loc","y","d")

CARB.data.jags <- list("Ns"=Ns,"Na"=Na,"Nc"=Nc,"NN"=NN,"aID"=aID,"cID"=cID,"wgts"=wgts,"adj"=adj,"loc"=loc,"y"=y,"d"=d)


CARB.inits <- function(){list(#mu=rnorm(n=Ns),
			#y=ifelse(is.na(y),rnorm(n=Ns,mean(y,na.rm=T),sd(y,na.rm=T)),NA),
			#tau.e=runif(n=1,.01,100),
			std.e=runif(n=1,.01,100),s=rnorm(n=Na),
			c=rnorm(n=Nc),#S=rnorm(n=Na),#tau.s=runif(n=1,.01,100),#Ws=rnorm(n=NN),
			std.a=runif(n=1,.01,100),#tau.a=runif(n=1,.01,100),
			alpha=rnorm(n=1),
			std.c=rnorm(n=1,0,100)
			#std.c=runif(n=1,.01,100)#tau.c=runif(n=1,.01,100)
			)}

CARB.parameters <- c("var.a","var.c","var.e","alpha")#,"mu[]") #"s[]","c[]","S[]",

#DO NOT USE JAGS FOR THESE MODELS!!!  From the 3.1 Jags manual, p. 34:
#	7.0.5 Directed cycles
#	Directed cycles are forbidden in JAGS. There are two important instances where directed
#	cycles are used in BUGS.
#	 Defining autoregressive priors
#	 Defining ordered priors
#	For the first case, the GeoBUGS extension to OpenBUGS provides some convenient ways of
#	defining autoregressive priors. These should be available in a future version of JAGS.

#carb.nlsy2 <- jags.model("P:\\SAS\\Rodgers\\GMRF\\GMRF\\carBG2.jag", data=CARB.data.jags,init=CARB.inits,n.chains = 2,n.adapt = 100)
#update(carb.nlsy2, 100)
#gbResult <- coda.samples(carb.nlsy,CARB.parameters,n.iter=1000,thin=10) #names(CARB.inits())
#summary(gbResult)
#plot(gbResult)
#gelman.diag(gbResult)

start.time1 <- Sys.time()
carb.nlsy <- bugs(data=CARB.data, inits=CARB.inits, parameters.to.save=CARB.parameters,
		model.file="P:\\SAS\\Rodgers\\GMRF\\carBG2.odc", n.chains=2, n.iter=50000,n.thin=10,
		n.burnin=25000, debug=F, bugs.directory="C:\\Program Files\\winbugs14\\WinBUGS14\\", codaPkg=F,save.history=F)
#you COULD use the following code to essentially get new updates on the initial bugs object, BUT you would have
	#to track all parameters in the initial object run (ugh!)  Looks like openBUGS and BRugs is a better option.
#lv <- carb.nlsy$last.values
#carb.nlsy2 <- bugs(data=CARB.data, inits=lv, parameters.to.save=CARB.parameters,
#		model.file="P:\\SAS\\Rodgers\\GMRF\\GMRF\\carBG2.odc", n.chains=2, n.iter=1000,n.thin=10,
#		n.burnin=10, debug=F, bugs.directory="C:\\Program Files\\winbugs14\\WinBUGS14\\", codaPkg=F)
stop.time1 <- Sys.time()
diff.time1 <- stop.time1 - start.time1
print(carb.nlsy, digits=4)
print(diff.time1)
save(list=c("carb.nlsy","diff.time1"),file="CARBnlsyResults.RData")

keepvar <- rownames(carb.nlsy$summary)[grepl("var.|alpha",rownames(carb.nlsy$summary))]
bcoda <- as.mcmc.list(carb.nlsy)[,keepvar,drop=F]
#bcoda2 <- window(bcoda,start=91,end=100) #distributions didn't really converge until 15000ish iteration
wbResults <- summary(bcoda)
#graphics.off()
#windows(record=TRUE)
#.SavedPlots <- NULL
windows(record=TRUE)
plot(bcoda)
gelman.diag(bcoda)

#WinBUGS results from CARB model
wbResults$statistics[,1:2]

totVarWB <- sum(wbResults$statistics[1:3,1])
h2 <- wbResults$statistics[1,1]/totVarWB
c2 <- wbResults$statistics[2,1]/totVarWB
e2 <- wbResults$statistics[3,1]/totVarWB
cat(paste("H^2 =", round(h2,2),"\nC^2 =",round(c2,2),"\nE^2 =",round(e2,2)),"\n")


#install R-INLA package
library("INLA")
#inla.doc("generic")
NlsyCarb <- NlsyCarb[order(NlsyCarb$from),]
NlsyCarb$MotherID <- floor(NlsyCarb$Subject1Tag/100)
NlsyCarb$cID <- as.integer(ordered(NlsyCarb$MotherID))
Na <- length(unique(NlsyCarb$from)) #should equal length(wbWMat$num)
Nc <- length(unique(NlsyCarb$cID))
NN <- length(wbWMat$weights)
aID <- NlsyCarb$from
cID <- NlsyCarb$cID
wgts <- wbWMat$weights
adj <- wbWMat$adj
loc <- wbWMat$nbLocator
y <- NlsyCarb$WeightStandardizedForAge19To25_1
d <- dsNeighbors3$d[!duplicated(dsNeighbors3$from)]
#d2 <- simDatLinked$d[!duplicated(simDatLinked$from)][order(simDatLinked$from[!duplicated(simDatLinked$from)])]
Ns <- nrow(NlsyCarb)
Ns==length(cID)
length(cID)==length(aID)
NlsyCarb$uID <- 1:Ns

#Q will store the precision matrix which contains 1/tau.i * b.ij in offdiagonal, and 1/tau.i in diagonal
Q <- wbPWMats$wmatrix #assign offdiagonal elements
precDiagonal <- dsNeighbors3[!duplicated(dsNeighbors3$from),"precDiag"]
length(diag(Q))==length(precDiagonal) #make sure these agree
diag(Q) <- precDiagonal #have to replace the spatial weight matrix diagonal with the precision matrix weights
Q[1:10,1:10]
#make Q a sparse matrix to optimize space and computation (requires library(Matrix))
Q <- as(Q, "dgTMatrix")
Q[1:10,1:10]

formula1 <- y ~ f(cID, model="iid") + f(from, model="generic0",Cmatrix=Q,constr=TRUE, diagonal=1e-05)
inlaResult <- inla(formula1,data=NlsyCarb,family="gaussian")
summary(inlaResult)

totvar <- sum(1/inlaResult$summary.hyperpar[,"mean"])
varComps <- as.data.frame(t(1/inlaResult$summary.hyperpar[,"mean"]/totvar))
colnames(varComps) <- c("e2","c2","a2")
round(varComps,2)

#BUGS model does not want to converge.  Check out the Mplus model for possible clues of why.
mpDat <- subset(Links79PairExpanded, RelationshipPath=='Gen2Siblings')
colnames(mpDat) <- c("s1tag","s2tag","eid","rpath","R","mbirths","ismz","s1last","s2last","Rimp1","Rimp","Rimp04",
		"Rexp","Rexp1","Rpass1","RexpOSV","RexpYSV","gens1","gens2","s1id","s2id","math1","wgt1","math2","wgt2")
unique(mpDat$R)
#nrow(mpDat)
#nrow(mpDat[!duplicated(mpDat[,c("Subject1Tag","Subject2Tag")]),])	#verfiy this is single entered

#export simDat to M+ to run M&P analysis
#write.table(simDat,"C:\\Users\\ElizBard\\David\\Rodgers\\GMRF\\simDat.dat",sep=",",na=".",row.names=F)
prepareMplusData(mpDat,file.path(getwd(),"NLSYwgtMplus.dat"))
#colnames(simDat)
runModels(file.path(getwd()))
cat("MPlus is Done","\n")
mpMod <- extractModelParameters(file.path(getwd(),"NLSYwgtMplus.out"))
resultsMP <- mpMod$unstandardized  #shows results of ACE model
resultsMP

A <- resultsMP[resultsMP$paramHeader=="A1.BY" & resultsMP$param=="VAR1" & resultsMP$Group=="HSIB",c("est","se")]
C <- resultsMP[resultsMP$paramHeader=="C.BY" & resultsMP$param=="VAR1" & resultsMP$Group=="HSIB",c("est","se")]
E <- resultsMP[resultsMP$paramHeader=="E1.BY" & resultsMP$param=="VAR1" & resultsMP$Group=="HSIB",c("est","se")]

totVar <- A[1]**2+C[1]**2+E[1]**2
h2 <- A[1]**2/totVar
c2 <- C[1]**2/totVar
e2 <- E[1]**2/totVar
cat(paste("H^2 =", round(h2,2),"\nC^2 =",round(c2,2),"\nE^2 =",round(e2,2)),"\n")
