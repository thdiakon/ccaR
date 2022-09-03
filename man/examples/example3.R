DATASET <- readxl::read_excel(system.file('extdata','cca.xlsx', package = 'ccaR'))

tb <- cca(DATASET)



