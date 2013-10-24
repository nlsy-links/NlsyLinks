# C:\Windows\system32>  cd /D D:\Program Files\R\R-2.14.0\bin
# C:\Program Files\R\R-2.14.0\bin>  R CMD INSTALL F:/Projects/RDev/NlsyLinksStaging/NlsyLinks
#require(NlsyLinks)

#detach("package:NlsyLinks")
if( any(search()=="package:NlsyLinks") ) detach("package:NlsyLinks")
if( any(.packages(all.available=TRUE) == "NlsyLinks") ) remove.packages("NlsyLinks") #system("R CMD REMOVE NlsyLinks")
rm(list=ls(all=TRUE))
require(stats)
#require(SoDA)
packageName <- "NlsyLinks"
directory <- "F:/Projects/RDev/NlsyLinksStaging"
directoryStatic <- file.path(directory, "Static")
directoryDatasets <- file.path(directory, "Datasets")
directoryContent <- file.path(directory, "Content")
directoryVignetteSource <- file.path(directory, "Vignettes")

directoryDestination <- file.path(directory, packageName)
directoryDestinationCode <- file.path(directoryDestination, "R")
directoryDestinationManual <- file.path(directoryDestination, "man")
directoryDestinationVignette <- file.path(directoryDestination, "inst/doc")

unlink(directoryDestination, recursive=T) #system(paste("RD /S",directoryDestination)) #http://ss64.com/nt/rd.html

source(file.path(directoryContent, "AceEstimate.R"))

source(file.path(directoryContent, "Ace.R"))
source(file.path(directoryContent, "AceDF.R"))
source(file.path(directoryContent, "AcePreparation.R"))
source(file.path(directoryContent, "CreatePairDataset.R"))
source(file.path(directoryContent, "CreateSpatialNeighbours.R"))
source(file.path(directoryContent, "Datasets.R"))
source(file.path(directoryContent, "OutcomeDatasets.R"))
source(file.path(directoryContent, "ColumnUtilities.R"))
source(file.path(directoryContent, "AceLavaan.R"))

setwd(directory)

package.skeleton(name=packageName, list=c(
   "CreateSubjectTag"                             #ColumnUtilities.R     
  ,"VerifyColumnExists"                           #ColumnUtilities.R
  ,"RenameColumn"                                 #ColumnUtilities.R
  ,"RenameNlsyColumn"                             #ColumnUtilities.R
                                        
  ,"CreatePairLinksSingleEntered"                 #CreatePairDataset.R                                          
  ,"CreatePairLinksDoubleEntered"                 #CreatePairDataset.R
  ,"CreatePairLinksDoubleEnteredWithNoOutcomes"   #CreatePairDataset.R
  ,"ValidatePairLinks"                            #CreatePairDataset.R
  ,"ValidatePairLinksAreSymmetric"                #CreatePairDataset.R
  
  ,"CreateSpatialNeighbours"                      #CreateSpatialNeighbours.R
  ,"CreateSpatialNeighbours79Gen2"                #CreateSpatialNeighbours.R                                          

  ,"AceUnivariate"                                #Ace.R
  ,"DeFriesFulkerMethod1"                         #AceDF.R
  ,"DeFriesFulkerMethod3"                         #AceDF.R  
  
  #,"AceEstimate"                                 #AceEstimate.R
  #,"GetEstimate"                                 #AceEstimate.R
  ,"CreateAceEstimate"                            #AceEstimate.R
  
  ,"RGroupSummary"                                #AcePreparation.R
  ,"CleanSemAceDataset"                           #AcePreparation.R
  
  ,"ReadCsvNlsy79Gen2"                            #OutcomeDataset.R
  ,"ValidateOutcomeDataset"                       #OutcomeDataset.R

  ,"ExtraOutcomes79"                              #Datasets.R
  ,"Links79Pair"                                  #Datasets.R
  ,"Links79PairExpanded"                          #Datasets.R
  ,"Links79PairExpanded"                          #Datasets.R
  ,"SubjectDetails79"                             #Datasets.R
  
  ,"AceLavaanGroup"                               #AceLavaan.R
  ) 
)
#packageAdd(packageName, files=file.path(directoryContent, "AceEstimate.R"), path=directory, document=F)
#promptClass("AceEstimate", file.path(directoryContent, "AceEstimate.Rd"))
#promptMethods("GetDetails", file.path(directoryContent, "GetDetails.Rd"))
# promptMethods("GetDetails-methods", file.path(directoryContent, "GetDetails-methods.Rd"))

unlink(file.path(directoryDestination, "Read-and-delete-me")) #Crap created by package.skeleton
unlink(file.path(directoryDestinationManual, "VerifyColumnExists.Rd")) #This is aliased
unlink(file.path(directoryDestinationManual, "RenameColumn.Rd")) #This is aliased
unlink(file.path(directoryDestinationManual, "RenameNlsyColumn.Rd")) #This is aliased

unlink(file.path(directoryDestinationManual, "CreatePairLinksDoubleEntered.Rd")) #This is aliased
unlink(file.path(directoryDestinationManual, "CreatePairLinksDoubleEnteredWithNoOutcomes.Rd")) #This is aliased
unlink(file.path(directoryDestinationManual, "CreatePairLinksSingleEntered.Rd")) #This is aliased
unlink(file.path(directoryDestinationManual, "CreateSpatialNeighbours.Rd")) #This is aliased
unlink(file.path(directoryDestinationManual, "CreateSpatialNeighbours79Gen2.Rd")) #This is aliased

unlink(file.path(directoryDestinationManual, "AceUnivariate.Rd")) #This is aliased
unlink(file.path(directoryDestinationManual, "DeFriesFulkerMethod1.Rd")) #This is aliased
unlink(file.path(directoryDestinationManual, "DeFriesFulkerMethod3.Rd")) #This is aliased

# unlink(file.path(directoryDestinationManual, "RGroupSummary.Rd")) #This is aliased
# unlink(file.path(directoryDestinationManual, "CleanSemAceDataset.Rd")) #This is aliased

unlink(file.path(directoryDestinationManual, "ReadCsvNlsy79Gen2.Rd")) #This is aliased

system(paste("robocopy ", directoryStatic, " ", directoryDestination, " /S /NP /NFL /NDL /NJH /NS /NJS", sep="")) #NJS http://ss64.com/nt/robocopy.html
#A robocopy status of 2 or 3 is desired; http://ss64.com/nt/robocopy-exit.html

file.copy(from=file.path(directoryContent, "AceEstimate.R"), to=directoryDestinationCode)

aceVignetteName <- "NlsyAce"
investigatorVignetteName <- "NlsInvestigator"
faqVignetteName <- "Faq"
file.copy(from=paste(directoryVignetteSource, "/", aceVignetteName, ".pdf", sep=""), to=paste(directoryDestinationVignette, "/", aceVignetteName, ".pdf", sep=""))
file.copy(from=paste(directoryVignetteSource, "/", aceVignetteName, ".Rnw", sep=""), to=paste(directoryDestinationVignette, "/", aceVignetteName, ".Rnw", sep=""))
file.copy(from=paste(directoryVignetteSource, "/", investigatorVignetteName, ".pdf", sep=""), to=paste(directoryDestinationVignette, "/", investigatorVignetteName, ".pdf", sep=""))
file.copy(from=paste(directoryVignetteSource, "/", investigatorVignetteName, ".Rnw", sep=""), to=paste(directoryDestinationVignette, "/", investigatorVignetteName, ".Rnw", sep=""))
file.copy(from=paste(directoryVignetteSource, "/", faqVignetteName, ".pdf", sep=""), to=paste(directoryDestinationVignette, "/", faqVignetteName, ".pdf", sep=""))
file.copy(from=paste(directoryVignetteSource, "/", faqVignetteName, ".Rnw", sep=""), to=paste(directoryDestinationVignette, "/", faqVignetteName, ".Rnw", sep=""))

rm(list=ls(all=TRUE))
