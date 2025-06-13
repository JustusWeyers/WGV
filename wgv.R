
# Notwendige Pakete
library(ggplot2)
library(grid)
library(gridExtra)

# Arbeitsverzeichnis
wd = getwd()

# Klassen erstellen
source(paste0(wd, "/classes.R"))
source(paste0(wd, "/utils.R"))

support0 = methods::new(
  Class = "Support",
  x = 0,
  y = 5,
  angle = 0,
  pinned = TRUE
)

support1 = methods::new(
  Class = "Support",
  x = 5,
  y = 0,
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

load0 = methods::new(
  Class = "LinearLoad",
  bar = bar0,
  x0 = 0,
  x1 = 0.5,
  amount = 10,
  angle = 90
)

load1 = methods::new(
  Class = "Load",
  bar = bar0,
  x = 2.5,
  amount = -10,
  angle = 90
)

truss = methods::new(
  Class = "Structure",
  nodes = list(
    support0, support1
  ),
  bars = list(
    bar0
  ),
  loads = list(
    load0, load1
  )
)

view(truss)
