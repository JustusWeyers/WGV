
# Notwendige Pakete
library(ggplot2)
library(grid)

# Arbeitsverzeichnis
wd = getwd()

# Klassen erstellen
source(paste0(wd, "/R/class_structure.R"))
source(paste0(wd, "/R/class_node.R"))
source(paste0(wd, "/R/class_support.R"))
source(paste0(wd, "/R/class_bar.R"))
source(paste0(wd, "/R/class_load.R"))
source(paste0(wd, "/R/class_linearload.R"))

support0 = methods::new(
  Class = "Support",
  x = -4,
  y = 0,
  angle = 0,
  pinned = TRUE
)

support1 = methods::new(
  Class = "Support",
  x = 0,
  y = 0,
  angle = 0,
  pinned = FALSE
)

support2 = methods::new(
  Class = "Support",
  x = -4,
  y = 1,
  angle = 0,
  pinned = FALSE
)

bar0 = methods::new(
  Class = "Bar",
  a = support0,
  b = support1,
  E = 210000,
  I = 149,
  A = 80
)

bar1 = methods::new(
  Class = "Bar",
  a = support1,
  b = support2,
  E = 210000,
  I = 149,
  A = 80
)

load0 = methods::new(
  Class = "LinearLoad",
  bar = bar0,
  x0 = 0.0,
  x1 = 0.5,
  amount = 10
)

load1 = methods::new(
  Class = "Load",
  bar = bar1,
  x = 0.5,
  amount = -10,
  angle = 90
)

truss = methods::new(
  Class = "Structure",
  nodes = list(
    support0, support1, support2
  ),
  bars = list(
    bar0, bar1
  ),
  loads = list(
    load0, load1
  )
)

view(truss)
