#' @title Plots the cca heatmap
#'
#' @description This function plots the cca heatmap. The tiles within the upper triangular matrix contain color-coded data that demonstrate the degree of overlap between pairs of reviews using the corrected covered area (CCA) measure. It is taking as input the citation matrix, the font size of the text in the tiles and the color used in the heatmap.
#'
#' @param cm Defines the data frame containing 1s, 0s, and NAs (in case of structural missingness).
#'
#' @param fontsize Defines the size of the font in the tiles. Default is fontsize=5.
#'
#' @param fontsize_diag Defines the size of the font in the diagonal grey tiles. Default is fontsize_diag=4.
#'
#' @param chroma Defines the color of the plot. Default is chroma="#527e11".
#'
#' @param decimal_digits Defines the number of digits in the tiles. Default is decimal_digits=1 and it can also be set as 0.
#'
#' @return cca_heatmap
#'
#' @example man/examples/example2.R
#'
#' @export
cca_heatmap <- function(cm, fontsize=5, fontsize_diag=4, chroma="#527e11", decimal_digits=1){

    c(missing(fontsize), missing(fontsize_diag) , missing(chroma), missing(decimal_digits))

    # create a table with all the parameters

    V1 <- c()
    V2 <- c()
    
    if (sum(is.na(cm)) == 0) {
        CCA_Percentage <- 0
    } else {
       CCA_Percentage_adjusted <- 0
    }


    a <- cca_table(cm)
    cm <- cm[, -1]
    cm <- cm[, order(colnames(cm))]

    a2 <- a[-nrow(a),]

    j2 <- t(utils::combn(colnames(cm),2))

    colnames(j2) <- paste0("V", 1:2)

    data_hm <- cbind(j2, a2)


    # create a table with the number of singles/total primary studies for each SR

    cm_singles <- cm[rowSums(cm, na.rm = T) == 1, ]
    
    V3 <- colnames(cm)
    V4 <- colnames(cm)
    single_studies <- c()
    total_studies <- c()
    single_total_studies <- c()
    
    for (i in 1:ncol(cm)){
        single_studies[i] <- sum(cm_singles[i], na.rm = T)
        total_studies[i] <- sum(cm[i], na.rm = T)
        single_total_studies[i] <- paste(single_studies[i],"/", total_studies[i], "*")
    }


    data_hm2 <- data.frame(V3, V4, single_total_studies)



    # CCA heatmap --------------------------------------------------------------------------------

    if (sum(is.na(cm)) == 0) {
        Percent <- data_hm$CCA_Percentage
        caption <- "*single/total number of primary studies included in the review \nCCA: Corrected Covered Area"
    } else {
        Percent <- data_hm$CCA_Percentage_adjusted
        caption <- "*single/total number of primary studies included in the review\nCCA: Corrected Covered Area (adjusted values for structural missingness)"
    }

    
   cca_heatmap <- ggplot2::ggplot(data = data_hm, ggplot2::aes(x = V1, y = V2)) +
        ggplot2::theme_classic(base_size = 16) +
        ggplot2::geom_tile(ggplot2::aes(fill = Percent), color='grey') +
        ggplot2::geom_tile(data = data_hm2, ggplot2::aes(x = V3, y = V4), fill = "grey", color='grey', inherit.aes = F) +
        ggplot2::coord_equal() +
        ggplot2::geom_text(ggplot2::aes(color = Percent > 60, label = round(Percent, digits = decimal_digits)), size = fontsize) +
        ggplot2::geom_text(data = data_hm2, ggplot2::aes(x = V3, y = V4),  label = single_total_studies, hjust = 0.3, size = fontsize_diag, inherit.aes = F) +
        ggplot2::scale_fill_gradient(low="white", limits = c(0, 100),
                            breaks=c(0, 20, 40, 60, 80, 100), high=chroma,
                            name = "CCA (%)") +
        ggplot2::scale_x_discrete(position = "top") +
        ggplot2::scale_color_manual(guide = "none", values = c("black", "white")) +
        ggplot2::labs(caption = caption) +
        ggplot2::theme(
            axis.title=ggplot2::element_blank(),
            axis.text.x.top=ggplot2::element_text(angle=90, vjust = 0.3, hjust=0.05))

    return(cca_heatmap)
}
