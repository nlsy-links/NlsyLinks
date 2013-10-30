#  system("R CMD Rd2pdf --force --output=F:/Projects/RDev/NlsyLinksStaging/NlsyLinksFromStatic.pdf F:/Projects/RDev/NlsyLinksStaging/Static" )

#Run Refresh.R, which does the package building, checking, and installation
if( any(search()=="package:NlsyLinks") ) detach("package:NlsyLinks")
rm(list=ls(all=TRUE))

setwd("F:/Projects/RDev/NlsyLinksStaging/")
system("R CMD build --resave-data D:/Projects/RDev/NlsyLinksStaging/NlsyLinks")
system("R CMD check D:/Projects/RDev/NlsyLinksStaging/NlsyLinks_1.205.tar.gz") #system("R CMD check F:/Projects/RDev/NlsyLinksStaging/NlsyLinks")
# system("R CMD check --as-cran F:/Projects/RDev/NlsyLinksStaging/NlsyLinks_1.200.tar.gz") #system("R CMD check F:/Projects/RDev/NlsyLinksStaging/NlsyLinks")
# q()

if( any(.packages(all.available=TRUE) == "NlsyLinks") ) remove.packages("NlsyLinks") #system("R CMD REMOVE NlsyLinks")
install.packages("F:/Projects/RDev/NlsyLinksStaging/NlsyLinks_1.200.tar.gz", repos=NULL, type="source")
#system("R CMD INSTALL F:/Projects/RDev/NlsyLinksStaging/NlsyLinks_0.26.tar.gz") #system("R CMD INSTALL F:/Projects/RDev/NlsyLinksStaging/NlsyLinks") #install.package("NlsyLinks")
#install.packages("NlsyLinks")

#In Linux
#setwd("/home/wibeasley/Desktop")
#install.packages("NlsyLinks_0.16.tar.gz")

library(NlsyLinks)
?NlsyLinks
# vignette("NlsyAce")
# vignette("NlsInvestigator")
# vignette("Faq")

# showClass("AceEstimate")
# getClass("AceEstimate")
