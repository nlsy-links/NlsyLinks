rm(list=ls(all=TRUE))
library(NlsyLinks) #Load the package into the current R session.
library(plyr) 

#Start with the built-in data.frame in NlsyLinks, select only the Gen2 Siblings (ie, NLSY79-C subjects)
dsLinks <- NlsyLinks::Links79PairExpanded 
dsLinks <- dsLinks[dsLinks$RelationshipPath=='Gen2Siblings', ]

#Define the names of the manifest/outcome/phenotype variable
oName_1 <- "MathStandardized_1" #Stands for Outcome1 -for the first subject in the pair
oName_2 <- "MathStandardized_2" #Stands for Outcome2 -for the second subject in the pair

#Define bunch (which is artificial in this example)
bunchCount <- 5
dsLinks$Bunch <- cut(dsLinks$Subject1Tag, breaks=bunchCount, labels=paste("Bunch", seq_len(bunchCount)))

#Define the function that plyr will execute for each value of `Bunch`
SummarizeBunch <- function( df ) {
  dsGroupSummary <- NlsyLinks::RGroupSummary(df, oName_1, oName_2)
  dsClean <- NlsyLinks::CleanSemAceDataset(dsDirty=df, dsGroupSummary, oName_1, oName_2)
  
  ace <- NlsyLinks::AceLavaanGroup(dsClean)
  dfReturned <- data.frame(
    ASquared=ace@ASquared, 
    CSquared=ace@CSquared, 
    ESquared=ace@ESquared, 
    CaseCount=ace@CaseCount, 
    Unity=ace@Unity,
    WithinBounds=ace@WithinBounds
  )
  return( dfReturned )
}

#Execute ddply (which returns a data.frame) to calculate the ace for each Bunch separately.
plyr::ddply(dsLinks, .variables="Bunch", .fun=SummarizeBunch)

#Compare against the whole sample together
dsGroupSummaryTotal <- NlsyLinks::RGroupSummary(dsLinks, oName_1, oName_2)
dsCleanTotal <- NlsyLinks::CleanSemAceDataset(dsDirty=dsLinks, dsGroupSummaryTotal, oName_1, oName_2)

(aceTotal <- NlsyLinks::AceLavaanGroup(dsCleanTotal))

#Display the all estimates of lavaan.  The first way is formatted output, 
#   which is good for humans to read.  The second way is a data.frame, 
#   which is useful for using the output as input to a downstream function. 
lavaan::summary(aceTotal@Details$lavaan) 
lavaan::parameterestimates(aceTotal@Details$lavaan)
