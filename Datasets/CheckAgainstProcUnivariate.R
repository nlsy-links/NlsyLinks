require(NlsyLinks)
nrow(Links79PairExpanded)
summary(Links79PairExpanded)

Descriptives <- function( scores ) {

}

mean(Links79PairExpanded$RExplicitYoungerSibVersion, na.rm=T)
sum(!is.na(Links79PairExpanded$RExplicitYoungerSibVersion))
