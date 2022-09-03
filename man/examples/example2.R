DATASET<-readxl::read_excel(system.file('extdata','cca.xlsx', package = 'ccaR'))


cca_heatmap(DATASET, 3) +
    ggplot2::theme(
        plot.caption = ggplot2::element_text(size = 16, margin=ggplot2::margin(30,0,0,0)),
        legend.title = ggplot2::element_text(size = 16, face = "bold", vjust=4),
        legend.text = ggplot2::element_text(size = 16),
        legend.key.size = ggplot2::unit(1.0, "cm"),
        legend.title.align = 0.5,
        legend.text.align = 0.5,
        axis.text.x=ggplot2::element_text(size = 16),
        axis.text.y=ggplot2::element_text(size = 16),
        axis.title=ggplot2::element_blank(),
        axis.ticks=ggplot2::element_blank(),
        axis.line=ggplot2::element_blank(),
        panel.border=ggplot2::element_blank(),
        panel.grid.major.x=ggplot2::element_line(colour = "grey80", linetype = "dashed"))
