rm(list=ls(all=TRUE))
library(MCMCglmm)
# Ndata <- data.frame(y = rnorm(5, mean = 0, sd = sqrt(1)))
# possible.y<-seq(-3,3,0.1) # possible values of y
# Probability<-dnorm(possible.y, mean=0, sd=sqrt(1)) # density of possible values
# plot(Probability~possible.y, type="l")
# Probability.y<-dnorm(Ndata$y, mean=0, sd=sqrt(1)) # density of actual values
# points(Probability.y~Ndata$y)
#
# prod(dnorm(Ndata$y, mean = 0, sd = sqrt(1)))
data(BTdata)
data(BTped)
head(BTdata)
head(BTped)

fixed <- cbind(tarsus, back) ~ trait:sex + trait:hatchdate - 1
family <- c("gaussian", "gaussian")
random <- ~ us(trait):fosternest + us(trait):animal
rcov <- ~ us(trait):units

prior <- list(R=list(V=diag(2)/3, n=2),
             G=list(G1=list(V=diag(2)/3, n=2),
                    G2=list(V=diag(2)/3, n=2)))

m1 <- MCMCglmm(cbind(tarsus, back) ~ trait:sex + trait:hatchdate - 1,
             random = ~ us(trait):animal + us(trait):fosternest,
             rcov = ~ us(trait):units,
             prior = prior,
             family = rep("gaussian", 2),
             nitt = 1000, #60000,
             burnin = 100, #10000,
             thin=1, #25,
             data = BTdata, pedigree=BTped)

summary(m1)
