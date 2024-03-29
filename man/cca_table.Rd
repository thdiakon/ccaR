% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cca_table.R
\name{cca_table}
\alias{cca_table}
\title{Calculates the Corrected Covered Area (CCA) Index}
\usage{
cca_table(cm)
}
\arguments{
\item{cm}{Defines the data frame containing 1s, 0s, and NAs (in case of structural missingness).}
}
\value{
res
}
\description{
It creates a data frame with the pairwise CCA for each possible pair of SRs from the citation matrix and the overall CCA. It is taking as input the citation matrix.
}
\examples{
DATASET <- readxl::read_excel(system.file('extdata','cca.xlsx', package = 'ccaR'))

tb <- cca_table(DATASET)



}
