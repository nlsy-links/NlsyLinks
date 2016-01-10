rm(list=ls(all=TRUE))

########## Production of reports from .Rmd files ###
path_index <- base::file.path("./index.Rmd")

patternToBuild <- "(?<!README)\\.(R){0,1}md$" #Gets all 'Rmd' and 'md' files, that aren't named `README`.
pathFilesToBuild <- list.files(full.names=TRUE, recursive=TRUE)
pathFilesToBuild <- grep(patternToBuild, pathFilesToBuild, perl=TRUE, value=TRUE)

####################################

testit::assert("The knitr Rmd and md files should exist.", base::file.exists(pathFilesToBuild))
for( pathFile in pathFilesToBuild ) {
  #   pathMd <- base::gsub(pattern=".Rmd$", replacement=".md", x=pathRmd)
  rmarkdown::render(input = pathFile, 
                    output_format=c(
                      # "pdf_document"
                      #,"md_document"
                      "html_document"
                    ),
                    clean=TRUE)
}

# base::system("bundle exec jekyll build")
# Or run this from the terminal to keep RStudio free to execute it's own stuff: `bundle exec jekyll serve` at localhost:4000
