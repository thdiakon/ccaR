## code to prepare `dt` dataset goes here
dt<-read_excel(system.file('extdata','cca.xlsx', package = 'ccaR') ,sep = ";")
usethis::use_data(dt, overwrite = TRUE)
