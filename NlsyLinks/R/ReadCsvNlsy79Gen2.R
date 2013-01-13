ReadCsvNlsy79Gen2 <-
function( filePath ) {
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
