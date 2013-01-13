### Test Links79Pair
rm(list=ls(all=TRUE))
require(NlsyLinks)
data(Links79Pair)

expectedColumnCount <- 5
actualColumnCount <- ncol(Links79Pair)
stopifnot(all.equal(expectedColumnCount, actualColumnCount))

expectedRowCount <- 42773 #42714 #11075
actualRowCount <- nrow(Links79Pair)
stopifnot(all.equal(expectedRowCount, actualRowCount))

### Test Links79PairExpanded
rm(list=ls(all=TRUE))
require(NlsyLinks)
data(Links79PairExpanded)

expectedColumnCount <- 26
actualColumnCount <- ncol(Links79PairExpanded)
stopifnot(all.equal(expectedColumnCount, actualColumnCount))

expectedRowCount <- 42773 #42714 #11075
actualRowCount <- nrow(Links79PairExpanded)
stopifnot(all.equal(expectedRowCount, actualRowCount))
