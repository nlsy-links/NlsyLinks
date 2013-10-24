
ReadCsvNlsy79Gen2 <- function( filePath ) {
  ds <- read.csv(filePath)
  if( !("C0000100" %in% colnames(ds)) ) stop("The NLSY variable 'C0000100' should be present, but was not found.")
  if( !("C0000200" %in% colnames(ds)) ) stop("The NLSY variable 'C0000200' should be present, but was not found.")
  
  colnames(ds)[colnames(ds)=='C0000100'] <- "SubjectID"
  colnames(ds)[colnames(ds)=='C0000200'] <- "SubjectTagOfMother"
  ds$SubjectTagOfMother <- ds$SubjectTagOfMother * 100
  ds$Generation <- 2
  ds$SubjectTag <- ds$SubjectID #CreateSubjectTag(ds$SubjectID, ds$Generation)
  
  data(SubjectDetails79)
  #dsWithExtended <- subset(SubjectDetails79, Generation==2, select=c("SubjectTag", "ExtendedID"))
  dsWithExtended <- SubjectDetails79[SubjectDetails79$Generation==2, c("SubjectTag", "ExtendedID")]
  #summary(dsWithExtended)
  ds <- merge(x=ds, y=dsWithExtended, by="SubjectTag", all.x=TRUE, all.y=FALSE)
  
  firstColumns <- c("SubjectTag", "SubjectID", "ExtendedID", "Generation")
  remaining <- setdiff(colnames(ds), firstColumns)
  ds <- ds[, c(firstColumns, remaining)]
  
  return( ds )   
}

ValidateOutcomeDataset <- function( dsOutcome, outcomeNames ) {
  if( missing(dsOutcome) ) stop("The parameter for 'dsOutcome' should be passed, but was not.")
  if( missing(outcomeNames) ) stop("The parameter for 'outcomeNames' should be passed, but was not.")
  
  if(!nrow(dsOutcome) > 0 ) stop("The dsOutcome data frame should have at least one row, but does not.")
  
  columnNames <- colnames(dsOutcome)
  if( !any(columnNames=="SubjectTag") ) stop("The column 'SubjectTag' should exist in the data frame, but does not. See the documentation for the 'CreateSubjectTag' function.")
  if( mode(dsOutcome$SubjectTag) != 'numeric' ) stop("The column 'SubjectTag' should have a 'numeric' mode, but does not.")   
  if( !(all(dsOutcome$SubjectTag > 0)) ) stop("The column 'SubjectTag' should contain only positive values, but does not.")
  if( anyDuplicated(dsOutcome$SubjectTag) > 0 ) stop("The column 'SubjectTag' should not contain duplicated, but it does.")
  
  if( length(outcomeNames) <= 0 ) stop("There should be at least one element in 'outcomeNames', but there were zero.")  
  #if( !any(outcomeNames %in% colnames(dsOutcome)) ) stop("All 'outcomeNames' should be columns in 'dsOutcome', but at least one was missing.")
  for( i in seq(outcomeNames) ) {
    if( !(outcomeNames[i] %in% colnames(dsOutcome)) ) stop(paste("The outcomeName '", outcomeNames[i], "' should be found in 'dsOutcome', but was missing."))
  }

  return( TRUE )
}
