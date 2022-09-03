#' @title Calculates the Corrected Covered Area (CCA) Index
#'
#' @description It creates a data frame with the pairwise CCA for each possible pair of SRs from the citation matrix and the overall CCA. It is taking as input the citation matrix.
#'
#' @param cm Defines the data frame containing 1s, 0s, and NAs (in case of structural missingness).
#'
#' @return res
#'
#' @example man/examples/example1.R
#'
#' @export

cca_table <- function(cm){


  cm <- cm[, -1]

  cm<-cm[,order(colnames(cm))]

  studies <- nrow(cm)
  reviews <- ncol(cm)

  overlap_counts <- c()
  N <-c()
  r <- c()
  c <- c()
  X <- c()
  CCA_Proportion <- c()
  CCA_Percentage <- c()

  j <- t(utils::combn(reviews, 2))


  for (i in 1:nrow(j)){

    cm2 <- cm[j[i,]]

    reviews[i] <- paste(colnames(cm2[1]), "vs." ,colnames(cm2[2]))

    overlap_counts[i] <- nrow(cm2[rowSums(cm2, na.rm = T) == 2, ])

    N[i] <- sum(cm2, na.rm = T)

    r[i] <- nrow(cm2[rowSums(cm2, na.rm = T) != 0, ])

    c[i] <- ncol(cm2)

    X[i] <- sum(is.na(cm2[rowSums(cm2, na.rm = T) == 1, ]) )

    CCA_Proportion[i] <- (N[i]-r[i])/((r[i]*c[i])-r[i]-X[i])

    CCA_Percentage[i] <- round(CCA_Proportion[i]*100, digits = 1)
  }

  overall <- nrow(j) + 1

  if (sum(is.na(cm)) == 0) {
    reviews[overall] <- "Overall"
  } else {
    reviews[overall] <- "Overall (adusted for structural missingness)"
  }

  overlap_counts[overall] <- " "
  N[overall] <- sum(cm, na.rm = T)
  r[overall] <- nrow(cm)
  c[overall] <- ncol(cm)
  X[overall] <- sum(is.na(cm))
  CCA_Proportion[overall] <- (N[overall]-r[overall])/((r[overall]*c[overall])-r[overall]-X[overall])
  CCA_Percentage[overall] <- round(CCA_Proportion[overall]*100, digits = 1)


   if (sum(is.na(cm)) == 0) {
    res <- data.frame(reviews, overlap_counts, N, r, c, CCA_Proportion, CCA_Percentage, stringsAsFactors=FALSE)
  } else {
     res <- data.frame(reviews, overlap_counts, N, r, c, X, CCA_Proportion, CCA_Percentage, stringsAsFactors=FALSE)
     names(res)[names(res) == 'X'] <- 'Structural_missingness'
     names(res)[names(res) == 'CCA_Proportion'] <- 'CCA_Proportion_adjusted'
     names(res)[names(res) == 'CCA_Percentage'] <- 'CCA_Percentage_adjusted'
  }

      return(res)

}
