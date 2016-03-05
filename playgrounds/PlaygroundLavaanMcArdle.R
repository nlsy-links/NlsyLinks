rm(list=ls(all=TRUE))
#install.packages("NlsyLinks", repos="http://R-Forge.R-project.org")
library(NlsyLinks)
library(lavaan)

ds <- Links79PairExpanded
ds$Group <- NA
ds$Group[ds$R==1] <- 1
ds$Group[ds$R==.5] <- 2
ds$Group[ds$R==.375] <- 3
ds$Group[ds$R==.25] <- 4
ds$Group <- factor(ds$Group)
#ds$M1 <- ds$MathStandardized_1 #Stands for Manifest1
#ds$M2 <- ds$MathStandardized_2 #Stands for Manifest2
ds$M1 <- ds$WeightStandardizedForAge19To25_1 #Stands for Manifest1
ds$M2 <- ds$WeightStandardizedForAge19To25_2 #Stands for Manifest2
ds$One <- 1


ds <- subset(ds,  !is.na(Group) & !is.na(M1) & !is.na(M2)) #It's necessary to drop the missing Groups, but not M1 & M2

model <-"
              AC =~ c(sqrt(.5),sqrt(.5),sqrt(.375),sqrt(.25))* M1 + c(sqrt(.5),sqrt(.5),sqrt(.375),sqrt(.25))* M2
              AU1 =~ c(0,sqrt(1-.5),sqrt(1-.375),sqrt(1-.25))* M1
              AU2 =~ c(0,sqrt(1-.5),sqrt(1-.375),sqrt(1-.25))* M2
              AM =~ c(sqrt(.5),0,0,0)*M1 + c(sqrt(.5),0,0,0)*M2

              C =~ 1*M1 + 1*M2
              E1 =~ 1*M1
              E2 =~ 1*M2

              AC ~~ a2*AC
              AU1 ~~ a2*AU1
              AU2 ~~ a2*AU2
              AM ~~ a2*AM

              C ~~ c2*C

              E1 ~~ 0 * E2
              E1 ~~ e2 * E1
              E2 ~~ e2 * E2

              M1 ~~ 0*M1
              M2 ~~ 0*M2

              M1 ~ int* 1
              M2 ~ int* 1

              "

fit <- lavaan(model, data=ds, group="Group",
              estimator="MLR", #"WLS"GLS MLM MLF MLR #The LSes didn't converge; the MLs were all about the same.
              group.equal=c("loadings", "intercepts", "means", "residuals", "residual.covariances", "lv.variances", "lv.covariances", "regressions"),
              group.partial=c("AC=~M1","AC=~M2","AU1=~M1","AU2=~M2","AM=~M1","AM=~M2"))

summary(fit)
fitMeasures(fit)
#lavaanify(model)
#parTable(fit)
#parameterEstimates(fit)

#Version 2:
a2V2 <- parameterEstimates(fit)[parameterEstimates(fit)$label=="a2", "est"][1]
c2V2 <- parameterEstimates(fit)[parameterEstimates(fit)$label=="c2", "est"][1]
e2V2 <- parameterEstimates(fit)[parameterEstimates(fit)$label=="e2", "est"][1]
cbind(a2V2, c2V2, e2V2) / (a2V2 + c2V2 + e2V2)
#inspect(fit)
