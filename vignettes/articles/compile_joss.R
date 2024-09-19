compile_joss <- function(...) {
  message("Rendering rmarkdown document...")

  rmarkdown::render('E:/Dropbox/Lab/Research/Projects/2023/NlsyLinks/vignettes/articles/paper.Rmd',
                    encoding = 'UTF-8',
                    knit_root_dir = '~/R')

  message("Done rendering!")
}

compile_joss()
