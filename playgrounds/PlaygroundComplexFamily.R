rm(list=ls(all=TRUE))
#install.packages("NlsyLinks", repos="http://R-Forge.R-project.org")
library(NlsyLinks)

startTime <- Sys.time()
dsLinks <- Links79PairExpanded
dsSubject <- SubjectDetails79
extendedIDs <- unique(sort(dsSubject$ExtendedID))

for( extendedID in extendedIDs ) {
  #dsSlice <- dsLinks[dsLinks$ExtendedID==extendedID & dsLinks$RelationshipPath %in% c("Gen2Siblings", "Gen2Cousins"), ]
  dsSlice <- dsLinks[dsLinks$ExtendedID==extendedID , ]
  dsSlice <- dsSlice[dsSlice$RelationshipPath %in% c("Gen2Siblings", "Gen2Cousins") & !is.na(dsSlice$MathStandardized_1) & !is.na(dsSlice$MathStandardized_2), ]
  mzCount <- sum(dsSlice$R == 1)
  momIDCount <- length(unique(c(dsSlice$Subject1Tag,dsSlice$Subject2Tag) %/%100))
  if( mzCount>0 & momIDCount>1 & nrow(dsSlice) >=4 ) {
    #stop("dummy error")
    print(extendedID)
  }
}

(elapsedTime <- Sys.time() - startTime)
dsInspect <- dsLinks[dsLinks$ExtendedID==8869 & dsLinks$RelationshipPath %in% c("Gen2Siblings", "Gen2Cousins"), ] #Math
dsInspect <- dsInspect[ order(dsInspect$Subject1Tag, dsInspect$Subject2Tag), ]


#Verify that the Gen1 moms of Gen2Cousins (342801, 342901) are actually MZs
#dsLinks[dsLinks$Subject1Tag==342800 & dsLinks$Subject2Tag==342900, ]
