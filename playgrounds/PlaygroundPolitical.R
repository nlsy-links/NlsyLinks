rm(list=ls(all=TRUE))
library(NlsyLinks)
pathLinks <-  'F:/Projects/RDev/NlsyLinksStaging/Datasets/Links2011V31Draft.csv'
pathOutcome <- 'F:/Projects/RDev/NlsyLinksStaging/Datasets/PoliticalData.csv'
pathLinkedOutcome <- 'F:/Projects/RDev/NlsyLinksStaging/Datasets/LinkedPolitical.csv'

#Read the CSVs
dsLinks <- read.csv(pathLinks)
dsOutcomes <- read.csv(pathOutcome, stringsAsFactors=F)

#Manipulate the Outcome dataset into something useful.
outcomeNames <- c("Intell","Strength","Orientation")
dsOutcomes <- dsOutcomes[, c("ID", outcomeNames)]
dsOutcomes$Generation <- 1
dsOutcomes$SubjectTag <- CreateSubjectTag(subjectID=dsOutcomes$ID, generation=dsOutcomes$Generation)
for( outcomeName in outcomeNames ) { #This loop converts the missing values, and then converts them to numeric values.
  isMissing <- (dsOutcomes[[outcomeName]]==".")
  dsOutcomes[[outcomeName]][isMissing] <- NA
  dsOutcomes[[outcomeName]] <- as.numeric(dsOutcomes[[outcomeName]])
}
summary(dsOutcomes)

#Create the linked outcome file.
ds <- CreatePairLinksDoubleEntered(outcomeDataset=dsOutcomes, linksPairDataset=dsLinks, outcomeNames=outcomeNames)

#Display descriptives for each value of R
rValues <- sort(unique(ds$R))
for( rValue in rValues ) {
  print("---")
  print(paste("R:", rValue))
  #print(summary(subset(ds, R==rValue, select=c("Intell_1","Strength_1","Orientation_1"))))
  print(paste("Nonmissing Intell_1 AND Intell_2:", nrow(subset(ds, R==rValue & !is.na(Intell_1) & !is.na(Intell_2)))))
  print(paste("Nonmissing Strength_1 AND Strength_2:", nrow(subset(ds, R==rValue & !is.na(Strength_1) & !is.na(Strength_2)))))
  print(paste("Nonmissing Orientation_1 AND Orientation_2:", nrow(subset(ds, R==rValue & !is.na(Orientation_1) & !is.na(Orientation_2)))))
}

write.csv(ds, pathLinkedOutcome)
