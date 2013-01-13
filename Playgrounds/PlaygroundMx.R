rm(list=ls(all=TRUE))
require(NlsyLinks)
require(OpenMx)

ds <- Links79PairExpanded
# ds$Group <- NA
# ds$Group[ds$R==1] <- 1
# ds$Group[ds$R==.5] <- 2
# ds$Group[ds$R==.25] <- 3
# ds$M1 <- ds$MathStandardized_1 #Stands for Manifest1
# ds$M2 <- ds$MathStandardized_2 #Stands for Manifest2
# ds$M1 <- scale(ds$MathStandardized_1) #Stands for Manifest1
# ds$M2 <- scale(ds$MathStandardized_2) #Stands for Manifest2
# ds$M1 <- ds$MathStandardized_1-100 #Stands for Manifest1
# ds$M2 <- ds$MathStandardized_2-100 #Stands for Manifest2

ds$M1 <- ds$WeightStandardizedForAge19To25_1 #Stands for Manifest1
ds$M2 <- ds$WeightStandardizedForAge19To25_2 #Stands for Manifest2


#ds <- subset(ds,  !is.na(R) & !is.na(M1) & !is.na(M2)) #It's necessary to drop the missing Groups, but not M1 & M2
#http://openmx.psyc.virginia.edu/wiki/howto-build-openmx-source-repository
#install.packages("H:/Downloads/OpenMx_1.2.3-2011.tar.gz", repos=NULL, type="source",  configure.args=c('--disable-openmp'))
installed <- installed.packages()
installed[rownames(installed)=="OpenMx", ]


selVars <- c("M1","M2")
aceVars <- c("A1","C1","E1","A2","C2","E2")
mzData <- as.matrix(subset(ds, R==1, c(M1,M2)))
fsData <- as.matrix(subset(ds, R==.5, c(M1,M2)))
asData <- as.matrix(subset(ds, R==.375, c(M1,M2)))
hsData <- as.matrix(subset(ds, R==.25, c(M1,M2)))
colMeans(mzData,na.rm=TRUE)
colMeans(fsData,na.rm=TRUE)
colMeans(asData,na.rm=TRUE)
colMeans(hsData,na.rm=TRUE)
cov(mzData,use="complete")
cov(fsData,use="complete")
cov(asData,use="complete")
cov(hsData,use="complete")
cor(mzData,use="complete")
cor(fsData,use="complete")
cor(asData,use="complete")
cor(hsData,use="complete")

ACEModel <- mxModel("ACE", # Twin ACE Model -- Path Specification
                    type="RAM",
                    manifestVars=selVars,
                    latentVars=aceVars,
                    mxPath(
                      from=aceVars,
                      arrows=2,
                      free=FALSE,
                      values=1
                      ),
                    mxPath(
                      from="one",
                      to=aceVars,
                      arrows=1,
                      free=FALSE,
                      values=0
                      ),
                    mxPath(
                      from="one",
                      to=selVars,
                      arrows=1,
                      free=TRUE,
                      values=0,
                      labels= "mean"
                      ),
                    mxPath(
                      from=c("A1","C1","E1"),
                      to="M1",
                      arrows=1,
                      free=TRUE,
                      values=.6,
                      label=c("a","c","e")
                      ),
                    mxPath(
                      from=c("A2","C2","E2"),
                      to="M2",
                      arrows=1,
                      free=TRUE,
                      values=.6,
                      label=c("a","c","e")
                      ),
                    mxPath(
                      from="C1",
                      to="C2",
                      arrows=2,
                      free=FALSE,
                      values=1
                      )
                    )
mzModel <- mxModel(ACEModel, name="MZ",
                   mxPath(
                     from="A1",
                     to="A2",
                     arrows=2,
                     free=FALSE,
                     values=1
                     ),
                   mxData(
                     observed=mzData,
                     type="raw"
                     )
                   )
fsModel <- mxModel(ACEModel, name="FS",
                   mxPath(
                     from="A1",
                     to="A2",
                     arrows=2,
                     free=FALSE,
                     values=.5
                     ),
                   mxData(
                     observed=fsData,
                     type="raw"
                     )
                   )
asModel <- mxModel(ACEModel, name="AS",
                   mxPath(
                     from="A1",
                     to="A2",
                     arrows=2,
                     free=FALSE,
                     values=.375
                     ),
                   mxData(
                     observed=asData,
                     type="raw"
                     )
                   )
hsModel <- mxModel(ACEModel, name="HS",
                   mxPath(
                     from="A1",
                     to="A2",
                     arrows=2,
                     free=FALSE,
                     values=.25
                     ),
                   mxData(
                     observed=hsData,
                     type="raw"
                     )
                   )
famACEModel <- mxModel("famACE", mzModel, fsModel, asModel, hsModel,
                       mxAlgebra(
                         expression=MZ.objective + FS.objective + AS.objective + HS.objective,
                         name="twin"
                         ),
                       mxAlgebraObjective("twin")
                       )

famACEFit <- mxRun(famACEModel)
MZc <- famACEFit$MZ.objective@expCov
FSc <- famACEFit$FS.objective@expCov
ASc <- famACEFit$AS.objective@expCov
HSc <- famACEFit$HS.objective@expCov
cov(mzData,use="complete")
MZc
cov(fsData,use="complete")
FSc
cov(asData,use="complete")
ASc
cov(hsData,use="complete")
HSc

M <- famACEFit$MZ.objective@expMean
A <- mxEval(a*a, famACEFit)
C <- mxEval(c*c, famACEFit)
E <- mxEval(e*e, famACEFit)
V <- (A+C+E)
a2 <- A/V
c2 <- C/V
e2 <- E/V
(ACEest <- rbind(cbind(A,C,E),cbind(a2,c2,e2)))
(LL_ACE <- mxEval(objective, famACEFit))