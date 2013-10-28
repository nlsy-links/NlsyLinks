rm(list=ls(all=TRUE))
#install.packages("NlsyLinks", repos="http://R-Forge.R-project.org")
#install.packages("lavaan", repos="http://www.da.ugent.be", type="source")
require(NlsyLinks)
require(lavaan)
require(stringr) #Necessary for the 'str_c' function
#require(ggplot2) #Necessary only for the diagnostic plots at the end.

estimateA <- T #Should the user estimate the 'A' variance component (ie, the genetic source)
estimateC <- T #Should the user estimate the 'C' variance component (ie, the enviroment source)

dsFull <- Links79PairExpanded #Start with the built-in data.frame in NlsyLinks
dsFull <- dsFull[dsFull$RelationshipPath=='Gen2Siblings', ]
rName <- "R"
o1Name <- "MathStandardized_1" #Stands for Manifest1
o2Name <- "MathStandardized_2" #Stands for Manifest2
# o1Name <- "WeightStandardizedForAge19To25_1"
# o2Name <- "WeightStandardizedForAge19To25_2"

dsGroupSummary <- RGroupSummary(dsFull, o1Name, o2Name)
dsGroupSummary

rLevels <- dsGroupSummary[dsGroupSummary$Included, rName]
rLevelsToExclude <- dsGroupSummary[!dsGroupSummary$Included, 'R']

#source("F:/Projects/RDev/NlsyLinksStaging/Content/ToBeIncorporated.R")
dsClean <- CleanSemAceDataset(dsDirty=dsFull, dsGroupSummary=dsGroupSummary, o1Name, o2Name)
#hist(dsClean$GroupID)
# unique(dsClean$GroupID)
# tail(dsClean[order(dsClean$GroupID), ])

###
###  Everything above this line should be agnostic to the chosen SEM program.
###

#plot(jitter(dsClean$R), ylim=range(c(0, 1, range(dsClean$R, na.rm=T))))

#These five lines enumerate the path coefficient labels to be inserted into the model statement.
#rString <- paste(rLevels, collapse=", ") #The output is typically "1, 0.5, 0.375, 0.25"
rString <- stringr::str_c(rLevels, collapse=", ") #The output is typically "1, 0.5, 0.375, 0.25"
# aString <- str_c(rep("a", length(rLevels)), collapse=",") #The output is typically "a,a,a,a"
# cString <- str_c(rep("c", length(rLevels)), collapse=",") #The output is typically "c,c,c,c"
# eString <- str_c(rep("e", length(rLevels)), collapse=",") #The output is typically "e,e,e,e"
# intString <- str_c(rep("int", length(rLevels)), collapse=",") #The output is typically "int,int,int,int"
groupCount <- length(rLevels)

#Generate the model statements that will exist in all models (ie, ACE, AE, AC, & E)
modelBase <- paste("
O1 ~~ 0 * O2                          #The manifest variables are uncorrelated.
O1 + O2 ~ rep('int', 4) * 1           #The manifest variables are fed the same intercept (for all groups).

E1 =~ rep('e', 4) * O1                #Declare the contributions of E to Subject1 (for all groups).
E2 =~ rep('e', 4) * O2                #Declare the contributions of E to Subject2 (for all groups).

E1 ~~ 0 * E2                          #The Es are uncorrelated
E1 ~~ 1 * E1                          #The Es have a variance of 1
E2 ~~ 1 * E2
e2 := e * e                           #Declare e^2 for easy point and variance estimation.
")

# O1 + O2 ~ rep('int',",groupCount,") * 1      #The manifest variables are fed the same intercept (for all groups).
# E1 =~ rep('e',", groupCount, ") * O1         #Declare the contributions of E to Subject1 (for all groups).
# E2 =~ rep('e',", groupCount, ") * O2         #Declare the contributions of E to Subject2 (for all groups).

#Generate the model statements that will exist in all models estimating the A component.
modelA <- paste("
A1 =~ rep('a', 4) * O1                #Declare the contributions of A to Subject1 (for all groups).
A2 =~ rep('a', 4) * O2                #Declare the contributions of A to Subject2 (for all groups).
A1 ~~ c(", rString, ") * A2           #Declare the genetic relatedness between Subject1 and Subject2. This coefficient differs for all groups.

A1 ~~ 1 * A1                          #The As have a variance of 1
A2 ~~ 1 * A2
a2 := a * a                           #Declare a^2 for easy point and variance estimation.
")

# A1 ~~ c(", rString, ") * A2         #Declare the genetic relatedness between Subject1 and Subject2. This coefficient differs for all groups.
# A1 ~~ evalq(rLevels) * A2           #Declare the genetic relatedness between Subject1 and Subject2. This coefficient differs for all groups.
# A1 ~~ rLevels*A2                    #Declare the genetic relatedness between Subject1 and Subject2. This coefficient differs for all groups.
# A1 =~ rep('a',", groupCount,") * O1 #Declare the contributions of A to Subject1 (for all groups).


#Generate the model statements that will exist in all models estimating the C component.
modelC <- paste("
C1 =~ rep('c',", groupCount,") * O1   #Declare the contributions of C to Subject1 (for all groups).
C2 =~ rep('c',", groupCount,") * O2   #Declare the contributions of C to Subject2 (for all groups).

C1 ~~ 1 * C2                          #The Cs are perfectly correlated. !!Note this restricts the sample to immediate families!!
C1 ~~ 1 * C1                          #The Cs have a variance of 1
C2 ~~ 1 * C2
c2 := c * c                           #Declare c^2 for easy point and variance estimation.
")

#If the A/C component's excluded: (1) overwrite the code and (2) declare a2/c2, so the parameter value can be retrieved later without if statements.
if( !estimateA ) modelA <- "\n a2 := 0 \n"
if( !estimateC ) modelC <- "\n c2 := 0 \n"

model <- paste(modelBase, modelA, modelC) #Assemble the three parts of the model.

#Run the model and review the results
fit <- lavaan(model, data=dsClean, group="GroupID", missing="listwise", information="observed")
summary(fit)
#lavaanify(model) #lavaanify(modelA)
#parseModelString(modelA)
#lavaanNames(modelA)
#parTable(fit)
#parameterEstimates(fit)
#inspect(fit)
#names(fitMeasures(fit)) #str(fitMeasures(fit)[c("chisq", "df")])
print(paste("Chi Square: ", fitMeasures(fit)[["chisq"]])) #Print the Chi Square value

#Extract the UNSCALED ACE components.
est <- parameterEstimates(fit)
a2 <- est[est$label=="a2", "est"]
c2 <- est[est$label=="c2", "est"]
e2 <- est[est$label=="e2", "est"]

# a2 <- subset(parameterEstimates(fit), label=="a2", select="est")[1, 1]
# c2 <- subset(parameterEstimates(fit), label=="c2", select="est")[1, 1]
# e2 <- subset(parameterEstimates(fit), label=="e2", select="est")[1, 1]

#variogram-like diagnostics
# plot(dsGroupSummary$R, dsGroupSummary$Covariance, pch=(4-3*dsGroupSummary$Included))
# plot(dsGroupSummary$R, dsGroupSummary$Correlation, pch=(4-3*dsGroupSummary$Included))
# text(dsGroupSummary$PairCount, x=dsGroupSummary$R, y=dsGroupSummary$Correlation)
# 
# ggplot(data=dsGroupSummary, aes(x=R, y=Correlation, label=PairCount, color=Included)) + #substitute(N == b, list(b=dsGroupSummary$PairCount)) )) + #geom_line()
#   layer(geom="line") + layer(geom="text") + scale_x_reverse(limits=c(1,0)) + scale_y_continuous(limits=c(0,1))
# ggplot(data=dsGroupSummary, aes(x=R, y=Covariance, label=PairCount, color=Included)) + #substitute(N == b, list(b=dsGroupSummary$PairCount)) )) + #geom_line()
#   layer(geom="line") + layer(geom="text") + scale_x_reverse(limits=c(1,0))

print(cbind(a2, c2, e2)[1,] / (a2 + c2 + e2)) #Print the unity-SCALED ace components.
print(paste("R Levels excluded:",  stringr::str_c(rLevelsToExclude, collapse=", "), "; R Levels retained:", rString)) #Print the dropped & retained groups.

components <- as.numeric(cbind(a2, c2, e2)[1,] / (a2 + c2 + e2)) #The 'as.numeric' gets rid of the vector labels.
print(components) #Print the unity-SCALED ace components.
caseCount <- nrow(dsClean)
details <- list(lavaan=fit)
#print(paste("R Levels excluded:", stringr::str_c(rLevelsToExclude, collapse=", "), "; R Levels retained:", rString)) #Print the dropped & retained groups.
ace <- CreateAceEstimate(aSquared=components[1], cSquared=components[2], eSquared=components[3], caseCount=caseCount, details=details)
ace
