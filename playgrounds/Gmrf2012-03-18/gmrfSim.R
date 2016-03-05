library(MASS)
library(lme4)
library(MplusAutomation)
library(spdep)
library(R2WinBUGS)
library(coda)
library(INLA)
library(Matrix)

setwd("P:\\SAS\\Rodgers\\GMRF")
source(file.path(getwd(),"GMRF\\gmrfSimFuncs.R"))

#simulate ACE data for some complex pedigrees (stealing this name from Animal heritabilty world; e.g., Hollander, Waldmann, Wang, Sillanpaa, 2010)  
#create a handful of population complex pedigree matrices

mat1 <- matrix(c(1, 1, .5,
				 1, 1, .5,
				 .5, .5, 1), nrow=3)
mat2 <- matrix(c(1, 1, .25,
				1, 1, .25,
				.25,.25,1), nrow=3)
mat3 <- matrix(c(1,.5,.5,
				.5, 1, .5,
				.5, .5, 1), nrow=3)
mat4 <- matrix(c(1,.5, .25,
				.5, 1, .25,
				.25, .25, 1), nrow=3)
mat5 <- matrix(c(1, 1,
				1, 1), nrow=2)
mat6 <- matrix(c(1,.5,
				.5, 1), nrow=2)
mat7 <- matrix(c(1, .25,
				.25, 1), nrow=2)
cmplxPeds <- list(mat1,mat2,mat3,mat4,mat5,mat6,mat7)

#create sample of ACE family phenotypes

simDat <- genSample(numFam=1000,mu=0,vara=.7,varc=.1)
simDat[1:10,]
var(simDat$y[simDat$ID==1])
var(simDat$y[simDat$ID==2])
var(simDat$y[simDat$ID==3])
mean(simDat$y[simDat$ID==1])
mean(simDat$y[simDat$ID==2])
mean(simDat$y[simDat$ID==3])

#export simDat to M+ to run M&P analysis
#write.table(simDat,"C:\\Users\\ElizBard\\David\\Rodgers\\GMRF\\simDat.dat",sep=",",na=".",row.names=F)
prepareMplusData(simDat,file.path(getwd(),"GMRF\\ACEmplus.dat"))
#colnames(simDat)
unlink(file.path(getwd(),"GMRF\\ACEmplus.out"))

ptm <- proc.time()
runModels(file.path(getwd(),"GMRF"),replaceOutfile = "never")
cat("MPlus is Done","\n")
print(proc.time() - ptm)
mpMod <- extractModelParameters(file.path(getwd(),"GMRF\\ACEmplus.out"))
resultsMP <- mpMod$unstandardized  #shows results of ACE model
resultsMP

A <- resultsMP[resultsMP$paramHeader=="Variances" & resultsMP$param=="AC",c("est","se")]
C <- resultsMP[resultsMP$paramHeader=="Variances" & resultsMP$param=="Y",c("est","se")]
E <- resultsMP[resultsMP$paramHeader=="Residual.Variances" & resultsMP$param=="Y",c("est","se")]

totVar <- A[1]+C[1]+E[1]
h2 <- A[1]/totVar
c2 <- C[1]/totVar
e2 <- E[1]/totVar
cat(paste("H^2 =", round(h2,2),"\nC^2 =",round(c2,2),"\nE^2 =",round(e2,2)),"\n")

#prepare simulated data for the conditionally autoregressive biometric (CARB) mixed model
totFams <- length(unique(simDat$cID))
carParts <- sampleCarDecomp(famIDs=c(1:totFams))

#put humpty dumpty singletons back together into an arbitrary family structure
fakeSingFams <- fixHumpty(carParts = carParts)

#combine all families (fake and real)
allFams <- carParts$sibshipList
totSibships <- length(allFams)
totFakFams <- length(fakeSingFams)
allFams[(totSibships+1):(totSibships+totFakFams)] <- fakeSingFams

#create a spatial neighbors (sn) object and a new simulated dataset with a linking variable to the sn object
snObjects <- createSN(allFams=allFams,simDat=simDat)
snDF <- subset(snObjects$spAMat,select=c(from,to,weight)) #this is the spatial neighbors object (must get rid of all but these 3 variables)
attr(snDF, "region.id") <- unique(snDF$from) #assign sn attributes so that this object can be passed to spdep package
attr(snDF, "n") <- length(unique(snDF$from))
head(snDF,200)
simDatLinked <- subset(snObjects$simDatLinked) #sim dataset with linking "from" field 

wbWMats <- createWBmat(dsNeighbors4=snDF)
wbWMat <- wbWMats$wbWMat

#spList <- sn2listw(snDF) #this spdep function transforms sn object to listw object
#summary(spList)
#wmatrix <- listw2mat(spList) #look at full N x N weight matrix
#dim(wmatrix) #verify this matrix has same dim(simDat) squared
##wmatrix[2120:2125,2120:2125]
#
#wbWMat <- listw2WB(spList) # create WinBUGS spatial object
##names(wbWMat)
##wbWMat$adj
##wbWMat$weights
##wbWMat$num
#wbWMat$nbLocator <- c(0,rep(NA,length(wbWMat$num)))
#for(i in 1:length(wbWMat$num)){
#	wbWMat$nbLocator[i+1] <- wbWMat$num[i]+wbWMat$nbLocator[i]
#}

#prepare the CARB BUGS model
Na <- length(unique(simDatLinked$from)) #should equal length(wbWMat$num)
Nc <- length(unique(simDatLinked$cID))
NN <- length(wbWMat$weights)
aID <- simDatLinked$from
cID <- simDatLinked$cID
wgts <- wbWMat$weights
adj <- wbWMat$adj
loc <- wbWMat$nbLocator
y <- simDatLinked$y
d <- snObjects$spAMat$d[!duplicated(snObjects$spAMat$from)]  
#d2 <- simDatLinked$d[!duplicated(simDatLinked$from)][order(simDatLinked$from[!duplicated(simDatLinked$from)])]
Ns <- nrow(simDatLinked)

CARB.data <- list("Ns","Na","Nc","NN","aID","cID","wgts","adj","loc","y","d")

CARB.inits <- function(){list(#mu=rnorm(n=Ns),
			tau.e=runif(n=1,.01,100),s=rnorm(n=Na),
			c=rnorm(n=Nc),#S=rnorm(n=Na),#tau.s=runif(n=1,.1,100),#Ws=rnorm(n=NN),
			tau.a=runif(n=1,.01,100),alpha=rnorm(n=1),                
			tau.c=runif(n=1,.01,100))}

CARB.parameters <- c("var.a","var.c","var.e","alpha")#,"mu[]") #"s[]","c[]","S[]",

start.time1 <- Sys.time() 
carb.sim <- bugs(data=CARB.data, inits=CARB.inits, parameters.to.save=CARB.parameters,
		model.file="P:\\SAS\\Rodgers\\GMRF\\GMRF\\carBG.odc", n.chains=2, n.iter=15000,n.thin=10,
		n.burnin=5000, debug=F, bugs.directory="C:\\Program Files\\winbugs14\\WinBUGS14\\", codaPkg=F)
stop.time1 <- Sys.time()
diff.time1 <- stop.time1 - start.time1
print(carb.sim, digits=4)
print(diff.time1)
save(list=c("carb.sim","diff.time1"),file="CARBresults.RData")

#map.sim$summary[c("kappa","sigma.nu[1]","sigma.nu[2]"),]
#rm(list=c("ARBlist","ACPUtimes"))
#load(file="ARB.RData")
#ls()

keepvar <- rownames(carb.sim$summary)[grepl("var.|alpha",rownames(carb.sim$summary))]
bcoda <- as.mcmc.list(carb.sim)[,keepvar,drop=F]
#bcoda2 <- window(bcoda,start=91,end=100) #distributions didn't really converge until 15000ish iteration
wbResults <- summary(bcoda)
#graphics.off()
#windows(record=TRUE)
#.SavedPlots <- NULL
windows(record=TRUE)
plot(bcoda)

#WinBUGS results from CARB model
wbResults$statistics[,1:2]
	
#compare to Mplus results
as.data.frame(rbind(A,C,E),row.names=c("h2","c2","e2"))

totVarWB <- sum(wbResults$statistics[1:3,1])
h2 <- wbResults$statistics[1,1]/totVarWB
c2 <- wbResults$statistics[2,1]/totVarWB
e2 <- wbResults$statistics[3,1]/totVarWB
cat(paste("H^2 =", round(h2,2),"\nC^2 =",round(c2,2),"\nE^2 =",round(e2,2)),"\n")


#use R-INLA package to estimate ACE model
#inla.doc("generic")

#will use this following object for R-INLA analyses
#this neighborhood object actual contains the contents of the joint density precision matrix in the weights slot
snDF <- subset(snObjects$spAMat,select=c(from,to,precWeight)) #this is the spatial neighbors object (must get rid of all but these 3 variables)
colnames(snDF) <- c("from","to","weight")
attr(snDF, "region.id") <- unique(snDF$from) #assign sn attributes so that this object can be passed to spdep package
attr(snDF, "n") <- length(unique(snDF$from))
head(snDF,200)
wbPWMats <- createWBmat(dsNeighbors4=snDF) 
wbPWMat <- wbPWMats$wbWMat

Na <- length(unique(simDatLinked$from)) #should equal length(wbWMat$num)
Nc <- length(unique(simDatLinked$cID))
NN <- length(wbWMat$weights)
aID <- simDatLinked$from
cID <- simDatLinked$cID
wgts <- wbWMat$weights
adj <- wbWMat$adj
loc <- wbWMat$nbLocator
y <- simDatLinked$y
d <- snObjects$spAMat$d[!duplicated(snObjects$spAMat$from)]  
#d2 <- simDatLinked$d[!duplicated(simDatLinked$from)][order(simDatLinked$from[!duplicated(simDatLinked$from)])]
Ns <- nrow(simDatLinked)

#Q will store the precision matrix which contains 1/tau.i * b.ij in offdiagonal, and 1/tau.i in diagonal
Q <- wbPWMats$wmatrix #assign offdiagonal elements
precDiagonal <- snObjects$spAMat[!duplicated(snObjects$spAMat$from),"precDiag"]
length(diag(Q))==length(precDiagonal) #make sure these agree
diag(Q) <- precDiagonal #have to replace the spatial weight matrix diagonal with the precision matrix weights
Q[1:10,1:10]
#make Q a sparse matrix to optimize space and computation (requires library(Matrix))
Q <- as(Q, "dgTMatrix")
Q[1:10,1:10]

ptm <- proc.time()
formula1 <- y ~ f(cID, model="iid") + f(from, model="generic0",Cmatrix=Q,constr=TRUE, diagonal=1e-05)
inlaResult <- inla(formula1,data=simDatLinked,family="gaussian")
print(proc.time() - ptm)
summary(inlaResult)

totvar <- sum(1/inlaResult$summary.hyperpar[,"mean"])
varComps <- as.data.frame(t(1/inlaResult$summary.hyperpar[,"mean"]/totvar))
colnames(varComps) <- c("e2","c2","a2")
round(varComps[3:1],2)






