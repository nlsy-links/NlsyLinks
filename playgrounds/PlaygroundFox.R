rm(list=ls(all=TRUE))
#install.packages("NlsyLinks", repos="http://R-Forge.R-project.org")
library(NlsyLinks)
library(sem)

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
A1 =~ label('a') * M1
A2 =~ equal('a') * M2
C1 =~ label('c') * M1
C2 =~ equal('c') * M2
E1 =~ label('e') * M1
E2 =~ equal('e') * M2

A1 ~~ c(1, .5, .375, .25) * A2 #+ label('rr')*A2
A1 ~~ 1 * A1
A2 ~~ 1 * A2

C1 ~~ 1 * C2 #+ label('cc')*C2
C1 ~~ 1 * C1
C2 ~~ 1 * C2

E1 ~~ 0 * E2
E1 ~~ 1 * E1
E2 ~~ 1 * E2

M1 ~~ 0*M2
M1 ~~ 0*M1 #All the error should be coming through E1
M2 ~~ 0*M2 #All the error should be coming through E2

M1 ~ label('int') * 1
M2 ~ equal('int') * 1

a2 := a*a
c2 := c*c
e2 := e*e

#C1 =~ 1*M1
#C2 =~ 1*M2
#E1 =~ 1*M1
#E2 =~ 1*M2
#C1 ~~ label('vc') * C1
#C2 ~~ equal('vc') * C2
#E1 ~~ label('ve') * E1
#E2 ~~ equal('ve') * E2
#One =~ label('int') * M1 + equal('int') * M2
#M1 ~ 0 * 1
#M2 ~ 0 * 1

"
#fit <- lavaan(model, data=ds)
#fit <- lavaan(model, data=ds, group="Group", group.equal=c("loadings", "intercepts"), group.partial=c("A1~~A2"))
#fit <- lavaan(model, data=ds, group="Group", group.equal=c("loadings", "intercepts", "means", "residuals"), group.partial=c("rr"))
#fit <- lavaan(model, data=ds, group="Group", group.equal=c("loadings", "intercepts", "means", "residuals"), group.partial=c("A1~~A2"))
fit <- lavaan(model, data=ds, group="Group",
  estimator="ML", #"WLS"GLS MLM MLF MLR #The LSes didn't converge; the MLs were all about the same.
  group.equal=c("loadings", "intercepts", "means", "residuals", "residual.covariances", "lv.variances", "lv.covariances", "regressions"),
  group.partial=c("A1~~A2"))
summary(fit)
fitMeasures(fit)
#lavaanify(model)
#parTable(fit)
#parameterEstimates(fit)

#Version 1:
a <- parameterEstimates(fit)[parameterEstimates(fit)$label=="a", "est"][1]
c <- parameterEstimates(fit)[parameterEstimates(fit)$label=="c", "est"][1]
e <- parameterEstimates(fit)[parameterEstimates(fit)$label=="e", "est"][1]
a2V1 <- a*a
c2V1 <- c*c
e2V1 <- e*e
cbind(a2V1, c2V1, e2V1) / (a2V1 + c2V1 + e2V1)

#Version 2:
a2V2 <- parameterEstimates(fit)[parameterEstimates(fit)$label=="a2", "est"][1]
c2V2 <- parameterEstimates(fit)[parameterEstimates(fit)$label=="c2", "est"][1]
e2V2 <- parameterEstimates(fit)[parameterEstimates(fit)$label=="e2", "est"][1]
cbind(a2V2, c2V2, e2V2) / (a2V2 + c2V2 + e2V2)
#inspect(fit)
