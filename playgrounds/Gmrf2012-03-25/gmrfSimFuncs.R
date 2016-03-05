# TODO: Store functions for ACE sample generation
# 
# Author: David E Bard 3/9/12
###############################################################################

library(MASS)
library(lme4)
library(MplusAutomation)

#test relationship between scalar variance and CAR decomposition
practMat <- matrix(c(1, .5, .25,
				.5, 1, .25,
				.25, .25, 1), nrow=3)
practMat <- practMat*2
cov2cor(practMat)
createCARdecomp <- function(practMat=practMat){
	Bmatrix <- matrix(0,nrow(practMat),ncol(practMat)) #stores conditional beta weights
	Dmatrix <- matrix(0,nrow(practMat),ncol(practMat))#stores conditional residual variances
	Imatrix <- diag(1,nrow(practMat),ncol(practMat))
	for(i in 1:nrow(practMat)){
		mymat <- practMat[-i,-i] 
		invmat <- solve(mymat) #Inverse matrix of what's left over
		colCorr <- practMat[-i,i] #Correlations of that guy with his family members
		betas <- invmat %*% colCorr #The OLS solution
		vare <- practMat[1,1] - t(betas) %*% mymat %*% betas
		Bmatrix[i,-i] <- betas
		Dmatrix[i,i] <- vare 
	}
	sigMVN <- solve(Imatrix - Bmatrix) %*% Dmatrix
	if( sum(abs(sigMVN - practMat)) > 1e-12 ) stop("The recovered/checked matrix was not within the specified allowed error.")
	return(list(Bmatrix=Bmatrix,Dmatrix=Dmatrix,Imatrix=Imatrix))
}
carMats <- createCARdecomp(practMat)

sigMVN <- solve(carMats$Imatrix - carMats$Bmatrix) %*% carMats$Dmatrix

#Take home message: the variace along the diagnol of the sigma matrix can simply be specified as a scalar multiplier of the Dmatrix


#function for simulating ACE phenotypes for one family pedigree

simACE <- function(mu,famMat=mat1,vara,varc){
	MzF <- ifelse(any(famMat[1,-1]==1),1,0)
	if(MzF==1) famMatr <- famMat[-1,-1]
	if(MzF==0) famMatr <- famMat
	aMat <- famMatr*vara
	c <- rnorm(n=1,0,sqrt(varc))
	a <- mvrnorm(1, rep(0,nrow(t(aMat))), aMat, empirical = FALSE)
	if(MzF==1) a <- c(a[1],a)
	vare <- 1 - sum(vara,varc)
	e <- rnorm(n=nrow(famMat), 0, sqrt(vare))
	y <- numeric(0)
	for(i in 1:nrow(famMat)){
		y[i] <- mu + c + a[i] + e[i]
	}
	return(as.data.frame(list(mu=mu,MzF=MzF,a=a,c=c,e=e,y=y,famSz=nrow(famMat))))
}


#simulate sample of complex pedigrees

simPedSample <- function(famID,mu,vara,varc){
	matSel <- sample(c(1:7),1)
	matDim <- nrow(cmplxPeds[[matSel]])
	matSeq <- 1:matDim
	tempSimDat <- simACE(mu=mu,famMat=cmplxPeds[[matSel]],vara=vara,varc=varc)
	tempSimDat[,c("sib1","sib2","sib3")] <- NA
	tempSimDat[,matSeq+ncol(tempSimDat)-3] <- cmplxPeds[[matSel]]
	tempSimDat$uID <- famID*10 + matSeq
	tempSimDat$cID <- famID
	tempSimDat$ID <- matSeq 
	tempSimDat$aID <- ifelse(tempSimDat$MzF==1,c(1,matSeq[-matDim]),matSeq)	
	tempSimDat$matSel <- rep(matSel,matDim)
	return(as.data.frame(tempSimDat))
}

genSample <- function(numFam=1000,mu,vara,varc){
	simDat <- simPedSample(famID=1,mu=mu,vara=vara,varc=varc)
	for(i in 2:numFam){
		simDat <- rbind(simDat,simPedSample(famID=i,mu=mu,vara=vara,varc=varc))
	}
	simDat$rowID <- 1:nrow(simDat)
	
	#verify/recover the intended ACE structure using McArdle&Prescott/Rabe-Hesketh&Skrondal mixed effects model 
	simDat$MzT <- (simDat$MzF==1 & simDat$ID %in% c(1,2))
	simDat$minR <- apply(simDat[,c("sib1","sib2","sib3")],1,min,na.rm=T)
	simDat$maxR <- apply(simDat[,c("sib1","sib2","sib3")],1,function(x) sort(x,na.last=F)[2])
	
	#This is not very robust code and this would need to be fixed for more complex pedigrees than those currently simulated
	simDat$wAC <- sqrt(simDat$minR) 
	simDat$wAM <- ifelse(simDat$minR==simDat$maxR,rep(0,nrow(simDat)),sqrt(simDat$maxR-simDat$minR))
	#sqrt(.75)
	#sqrt(.5)
	#simDat[simDat$minR!=simDat$maxR,]
	simDat$wAU1 <- ifelse(simDat$ID==1,1 - simDat$wAC**2 - simDat$wAM**2,rep(0,nrow(simDat)))
	simDat$wAU1 <- sqrt(simDat$wAU1*(simDat$wAU1>0.0001))
	simDat$wAU2 <- ifelse(simDat$ID==2,1 - simDat$wAC**2 - simDat$wAM**2,rep(0,nrow(simDat))) 
	simDat$wAU2 <- sqrt(simDat$wAU2*(simDat$wAU2>0.0001))
	simDat$wAU3 <- ifelse(simDat$ID==3,1 - simDat$wAC**2 - simDat$wAM**2,rep(0,nrow(simDat)))
	simDat$wAU3 <- sqrt(simDat$wAU3*(simDat$wAU3>0.0001))
	return(simDat)	
}

#Function for decomposing A matrix into CAR Bmatrix weights and Dmatrix errors (exactly the same code as above in the practice example)

createCARdecomp <- function(practMat=practMat){
	Bmatrix <- matrix(0,nrow(practMat),ncol(practMat)) #stores conditional beta weights
	Dmatrix <- matrix(0,nrow(practMat),ncol(practMat))#stores conditional residual variances
	Imatrix <- diag(1,nrow(practMat),ncol(practMat))
	for(i in 1:nrow(practMat)){
		mymat <- practMat[-i,-i] 
		invmat <- solve(mymat) #Inverse matrix of what's left over
		colCorr <- practMat[-i,i] #Correlations of that guy with his family members
		betas <- invmat %*% colCorr #The OLS solution
		vare <- practMat[1,1] - t(betas) %*% mymat %*% betas
		Bmatrix[i,-i] <- betas
		Dmatrix[i,i] <- vare 
	}
	sigMVN <- solve(Imatrix - Bmatrix) %*% Dmatrix 
	Pmatrix <- solve(Dmatrix) %*% (Imatrix - Bmatrix)
	if( sum(abs(sigMVN - practMat)) > 1e-12 ) stop("The recovered/checked matrix was not within the specified allowed error.")
	return(list(Bmatrix=Bmatrix,Dmatrix=Dmatrix,Imatrix=Imatrix,Pmatrix=Pmatrix))
}


#prepare simulated data for the conditionally autoregressive biometric (CARB) mixed model

sampleCarDecomp <- function(famIDs=1){
	singletonCount <- 0
	singletonList <- list()
	sibshipCount <- 0
	sibshipList <- list()
	
	for(k in famIDs){
		Rmat <- subset(x=simDat,subset=cID==k,select=c(sib1,sib2,sib3))
		newRmat <- as.matrix(Rmat[,1:nrow(Rmat)])
		storeDiagNR <- diag(newRmat)
		diag(newRmat) <- 0
		colnames(newRmat) <- c(1:nrow(Rmat))
		singleton <- 0
		for(i in 1:nrow(newRmat)){
			#browser()
			newRmat <- newRmat[!newRmat[,i]>=1,!newRmat[i,]>=1]	
			if(length(newRmat)<=1) { singleton <- 1
				break }
			if(i >= nrow(newRmat)) break
		}	
		
		if(singleton==0){
			diag(newRmat) <- storeDiagNR[1:nrow(newRmat)]  #the createCARdecomp expects a pos def matrix, so restore 1's in diagonal
			sibshipCount <- sibshipCount+1
			sibshipList[[sibshipCount]] <- list(carMats=createCARdecomp(newRmat),famID=k)
		}
		
		if(singleton==1){
			singletonCount <- singletonCount+1
			singletonList[[singletonCount]] <- list(famID=k)
		}
	}
	return(list(singletonList=singletonList,sibshipList=sibshipList))
}

#put humpty dumpty singletons back together into an arbitrary family structure
fixHumpty <- function(carParts=carParts) {
	totSingletons <- length(carParts$singletonList)
	
	fakeSingFams <- list()
	fakeSingCount <- 0
	Bmatrix <- diag(0,2,2)
	Dmatrix <- diag(1,2,2)
	Imatrix <- diag(1,2,2)
	Pmatrix <- Dmatrix
	Bmatrix2 <- diag(0,3,3)
	Dmatrix2 <- diag(1,3,3)
	Imatrix2 <- diag(1,3,3)
	Pmatrix2 <- Dmatrix2
	for(i in seq(1,totSingletons,2)){ #combine odd numbered singleton fam with next highest even numbered singleton fam
		fakeSingCount <- fakeSingCount+1
		if(i<totSingletons){
			fakeSingFams[[fakeSingCount]] <- list(carMats=list(Bmatrix=Bmatrix,Dmatrix=Dmatrix,Imatrix=Imatrix,Pmatrix=Pmatrix),
					famID=unname(unlist(carParts$singletonList[i:(i+1)])))
		}
		if(i==totSingletons){ #if odd total number of singleton fams, force the last fake family size to equal 3
			fakeSingFams[[fakeSingCount-1]] <- list(carMats=list(Bmatrix=Bmatrix2,Dmatrix=Dmatrix2,Imatrix=Imatrix2,Pmatrix=Pmatrix2),
					famID=unname(unlist(carParts$singletonList[(i-2):i])))
		}
	}
return(fakeSingFams)
}

#create spatial neighbors (sn) object from information in beta matrices of allFams
	#and link the simulation dataset to the sn object

createSN <- function(allFams=allFams,simDat=simDat){
	
	from <- numeric(0)
	to <- numeric(0)
	weight <- numeric(0)
	evar <- numeric(0)
	precWeight <- numeric(0)
	precDiag <- numeric(0)
	cID <- numeric(0)
	aID <- numeric(0)
	ffID <- numeric(0)
	rowCount <- 0
	uaIDCount <- 0
	for(i in 1:length(allFams)){
		fakFamID <- i
		wgtMat <- allFams[[i]]$carMats$Bmatrix
		pwgtMat <- allFams[[i]]$carMats$Pmatrix		
		errMat <- allFams[[i]]$carMats$Dmatrix
		famIDs <- rep(allFams[[i]]$famID,nrow(wgtMat))
		colCntWM <- 1:ncol(wgtMat)
		uaIDs <- uaIDCount + colCntWM
		uaIDCount <- max(uaIDs)
		uFamIDs <- length(unique(famIDs))	 
		for(j in colCntWM){
			#newWgtMat <- wgtMat[j,-j]
			from[rowCount+1:length(wgtMat[j,-j])] <- uaIDs[j]
			to[rowCount+1:length(wgtMat[j,-j])] <- uaIDs[-j]
			weight[rowCount+1:length(wgtMat[j,-j])] <- wgtMat[j,-j]
			evar[rowCount+1:length(wgtMat[j,-j])] <- errMat[j,j]
			precWeight[rowCount+1:length(wgtMat[j,-j])] <- pwgtMat[j,-j]
			precDiag[rowCount+1:length(wgtMat[j,-j])] <- pwgtMat[j,j]
			cID[rowCount+1:length(wgtMat[j,-j])] <- famIDs[j]
			aID[rowCount+1:length(wgtMat[j,-j])] <- ifelse(uFamIDs>1,1,j)
			ffID[rowCount+1:length(wgtMat[j,-j])] <- fakFamID
			rowCount <- length(weight)
		}		
	}
	spAMat <- as.data.frame(list(ffID=ffID,cID=cID,aID=aID,from=from,to=to,weight=weight,d=evar,precWeight=precWeight,precDiag=precDiag))
	spAMatNoDups <- subset(spAMat,subset=!duplicated(from),select=c(cID,aID,from,d,precDiag))
	if(nrow(spAMatNoDups) != nrow(simDat) - sum(simDat$MzT==1)/2) stop("The record count in the spatial neighbor object does not agree with the number of unique A individuals.")
	
	simDatLinked <- merge(simDat,spAMatNoDups,by.x=c("cID","aID"),by.y=c("cID","aID"),all.x=T)
	if(nrow(simDatLinked) != nrow(simDat)) stop("Cannot match all spatial neighbor object to unique A individuals.")
	
	class(spAMat) <- c("spatial.neighbour", class(spAMat))
	attr(spAMat, "region.id") <- unique(spAMat$from)
	attr(spAMat, "n") <- length(unique(spAMat$from))
return(list(spAMat=spAMat,simDatLinked=simDatLinked)) #spAMat is an sn object; simDatLinked is the sim dataset with a linked identifier to the sn object
}

#function used to create WinBUGS (WB) neighborhood object 
createWBmat <- function(dsNeighbors4=dsNeighbors4) {
	class(dsNeighbors4) <- c("spatial.neighbour", class(dsNeighbors4))
	attr(dsNeighbors4, "region.id") <- unique(dsNeighbors4$from) #bona fide sn object must only have these 2 attributes
	attr(dsNeighbors4, "n") <- length(unique(dsNeighbors4$from))
	
	library(spdep)
#spList <- nb2listw(dsNeighbors,style=NA,zero.policy=T)
	spList <- sn2listw(dsNeighbors4) #transform sn object to listw object
	summary(spList)
	
	#wmatrix <- as(listw2mat(spList), "dgTMatrix") #listw2mat(spList) #look at full N x N region matrix of distances
	#dim(wmatrix)
	wmatrix <- as_dgRMatrix_listw(spList) #create this as a sparse matrix due to R memory constraints
	dim(wmatrix)
	class(spList)
	wbWMat <- listw2WB(spList)
	
	wbWMat$nbLocator <- c(0,rep(NA,length(wbWMat$num)))
	for(i in 1:length(wbWMat$num)){
		wbWMat$nbLocator[i+1] <- wbWMat$num[i]+wbWMat$nbLocator[i]
	}
	return(list(wbWMat=wbWMat,wmatrix=wmatrix))
}








