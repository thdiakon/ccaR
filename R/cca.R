#' @title Calculates the overall Corrected Covered Area (CCA) Index
#'
#' @description It calculates the overall CCA index for the entire citation matrix. It is taking as input the citation matrix.
#'
#' @param cm Defines the data frame containing 1s, 0s, and NAs (in case of structural missingness).
#'
#' @return res
#'
#' @example man/examples/example3.R
#'
#' @export
cca <- function(cm){

  cm <- cm[, -1]

  cm <- cm[, order(colnames(cm))]

  studies<-nrow(cm)
  reviews<-ncol(cm)

  N <- sum(cm, na.rm = T)
  r <- nrow(cm)
  c <- ncol(cm)
  X <- sum(is.na(cm))
  CCA_Proportion <- (N-r)/((r*c)-r-X)
  CCA_Percentage <- round(CCA_Proportion*100, digits = 1)


  if (sum(is.na(cm)) == 0) {
    res <- data.frame(reviews, N, r, c, CCA_Proportion, CCA_Percentage, stringsAsFactors=FALSE)

  } else {
    res <- data.frame(reviews, N, r, c, X, CCA_Proportion, CCA_Percentage, stringsAsFactors=FALSE)
    names(res)[names(res) == 'X'] <- 'Structural_missingness'
    
    names(res)[names(res) == 'CCA_Proportion'] <- 'CCA_Proportion_adjusted'
    names(res)[names(res) == 'CCA_Percentage'] <- 'CCA_Percentage_adjusted'
    
    message("the CCA formula has been adjusted for structural missingness")
  }

      return(res)

}



