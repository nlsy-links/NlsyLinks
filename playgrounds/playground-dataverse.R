# https://cran.r-project.org/web/packages/dataverse/vignettes/A-introduction.html
library("dataverse")
Sys.setenv("DATAVERSE_SERVER" = "dataverse.harvard.edu")
Sys.setenv("DATAVERSE_KEY" = "b53b024b-fc1f-4a96-8317-678f3d15101a")

str(dataverse_search(author = "Gary King", title = "Ecological Inference"), 1)

f <- get_file("constructionData.tab", "doi:10.7910/DVN/ARKOTI") # works
f <- get_file("BPchap7.tab", "doi:10.7910/DVN/ARKOTI")          # works
f <- get_file("war1800.tab", "doi:10.7910/DVN/ARKOTI")          # works
f <- get_file("owsiakJOP2013.tab", "doi:10.7910/DVN/ARKOTI")          # works
f <- get_file("alpl2013.tab", "doi:10.7910/DVN/ARKOTI")          # works

# load it into memory
tmp <- tempfile(fileext = ".dta")
writeBin(as.vector(f), tmp)
dat <- foreign::read.dta(tmp)

str(dataset_metadata("doi:10.7910/DVN/ARKOTI"), 1)
ds <- dataset_metadata("doi:10.7910/DVN/ARKOTI")

code3 <- get_file("chapter03.R", "doi:10.7910/DVN/ARKOTI")
writeBin(code3, "chapter03.R")

writeBin(get_file("PESenergy.csv", "doi:10.7910/DVN/ARKOTI"), "PESenergy.csv")

f1 <- get_file_metadata("constructionData.tab", "doi:10.7910/DVN/ARKOTI",  server = "dataverse.harvard.edu")
f1 <- get_file_metadata("PESenergy.csv", "doi:10.7910/DVN/ARKOTI", key = "", server = "dataverse.harvard.edu")

f1 <- get_file("constructionData.tab", "doi:10.7910/DVN/ARKOTI", key = "", server = "dataverse.harvard.edu")
f1 <- get_file("chapter01.R", "doi:10.7910/DVN/ARKOTI", key = "", server = "dataverse.harvard.edu")

f1 <- get_file(2692293, key = "", server = "dataverse.harvard.edu")
f1 <- get_file(2692202, key = "", server = "dataverse.harvard.edu")
f1 <- get_file(48830, key = "", server = "dataverse.harvard.edu")
dataverse::get_file_metadata(48830)


# https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/ARKOTI
monogan <- get_dataverse("monogan")
monogan_data <- dataverse_contents(monogan)
dataverse_metadata(monogan)

get_dataset("hdl:10622/DN9QDM", key = "", server = "datasets.socialhistory.org")
