# Notwendige Pakete
library(ggplot2)
library(grid)

# Arbeitsverzeichnis
wd = getwd()

# Klassen erstellen
source(paste0(wd, "/R/class_element.R"))
source(paste0(wd, "/R/class_node.R"))
source(paste0(wd, "/R/class_hinge.R"))
source(paste0(wd, "/R/class_rigid.R"))
source(paste0(wd, "/R/class_support.R"))
source(paste0(wd, "/R/class_freesupport.R"))
source(paste0(wd, "/R/class_rollersupport.R"))
source(paste0(wd, "/R/class_pinsupport.R"))
source(paste0(wd, "/R/class_fixsupport.R"))
source(paste0(wd, "/R/class_bar.R"))
source(paste0(wd, "/R/class_load.R"))
source(paste0(wd, "/R/class_linearload.R"))
source(paste0(wd, "/R/class_structure.R"))
source(paste0(wd, "/R/class_baseelement.R"))
