
CreateCategoryStatsEmpty <- function( categoryCount, categoryNames=NA) {
  if( !(categoryCount > 0) ) stop("The argument 'categoryCount' must be a positive number.")
  if( is.na(categoryNames) ) categoryNames <- paste("Category", seq_len(categoryCount), sep="")
  if( categoryCount != length(categoryNames) ) stop("The length of 'categoryNames' must equal 'categoryCount'.")
  
  columnNames <- c("R", "SharedUterus", "Correlation", "N", "Mean", "Q0", "Q25", "Q50", "Q75", "Q100", "Skew", "Kurtosis")
  emptyMatrix <- matrix(NA, nrow=categoryCount, ncol=length(columnNames))
  colnames(emptyMatrix) <- columnNames
  rownames(emptyMatrix) <- categoryNames
 
  return( emptyMatrix )
}

categoryStats <- matrix(NA, nrow=1, ncol=12)
colnames(categoryStats) <- c("R", "SharedUterus", "Correlation", "N", "Mean", "Q0", "Q25", "Q50", "Q75", "Q100", "Skew", "Kurtosis")
rownames(categoryStats)[1] <- "Full Sibs"
categoryStats[1, ] <- c(.5, 0, .235, 45, .55, .01, .24, .51, .76, .98, 1.2, 1)

CreateCategoryStatsEmpty(3)
