rm(list=ls(all=TRUE))
require(NlsyLinks)
require(lavaan)

model <-"
W =~ NA*MathStandardized_1 + NA*MathStandardized_2 + NA*WeightStandardizedForAge19To25_1
W ~~ 1*W
MathStandardized_1 ~~ MathStandardized_1
MathStandardized_2 ~~ MathStandardized_2
WeightStandardizedForAge19To25_1 ~~ WeightStandardizedForAge19To25_1
"
#fit <- sem(model, data=Links79PairExpanded)
fit <- lavaan(model, data=Links79PairExpanded)
summary(fit)
#lavaanify(model)
parTable(fit)
parameterEstimates(fit)

#InformativeTesting(model, Links79PairExpanded)
#######
summary(lm(MathStandardized_1 ~ MathStandardized_2, data=Links79PairExpanded))

lavaanModel <- "
MathStandardized_1 ~  MathStandardized_2
MathStandardized_1 ~ 1
"

fit <- sem(lavaanModel, data=Links79PairExpanded)
summary(fit)
#lavaanify(model)
parTable(fit)