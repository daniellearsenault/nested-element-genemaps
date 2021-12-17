library(tidyverse)
library(ggplot2)
library(gggenes)
library(RColorBrewer)
library(brew)
elements <- read.delim(file = "example_data.csv",
                       header = TRUE, 
                       sep = ',')
#use the line below to assign colors to elements by hand 
#(note: the elements are colored alphabetically, so in the example given below, 
#the element that comes first alphabetically will be colored red, second orange, and so on.)
#If you use this method be sure to edit lines 39 + 40!
#mycolors <- list('red', 'orange', 'yellow', 'white', 'green', 'purple')

ggplot(data = elements, 
       mapping = aes(xmin = elem_start, 
                     xmax = elem_stop, 
                     y = species, 
                     fill = elem_type, 
                     label = elem_type)) +
  facet_wrap(~ species, scales = "free", ncol = 1) +
  #coord_cartesian(xlim = c(4000, 127000) )+
  geom_gene_arrow(arrowhead_height = unit(3, "mm"), arrowhead_width = unit(1, "mm")) +
  #use geom_gene_label() line below to add labels to first layer (exons and introns)
  #geom_gene_label(align = 'left', min.size = 0) +
  geom_subgene_arrow(data = elements,
                     mapping = aes(xmin = elem_start, 
                                   xmax = elem_stop, 
                                   y = species, 
                                   fill = subelem_type, 
                                   label = subelem_type, 
                                   xsubmin = subelem_start, 
                                   xsubmax = subelem_stop), 
                     color = "black", alpha=.7) +
  geom_subgene_label(data = elements, 
                     mapping = aes(xsubmin = subelem_start, 
                                   xsubmax = subelem_stop, 
                                   label = subelem_type),
                     min.size = 0) +
  #scale_fill_manual(values = mycolors) +
  scale_fill_brewer(palette = 'Set3') + 
  theme_genes()
ggsave("example_genemaps.pdf", height = 8, width = 10, units = "in")