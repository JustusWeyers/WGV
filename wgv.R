# Global

source("global.R")

support0 = methods::new(
  Class = "Support",
  x = 0,
  y = 0,
  angle = 0,
  pinned = TRUE
)

hinge0 = methods::new(
  Class = "Hinge",
  x = 7,
  y = 3
)

support1 = methods::new(
  Class = "Support",
  x = -7,
  y = 3,
  angle = 0,
  pinned = FALSE
)


bar0 = methods::new(
  Class = "Bar",
  a = support0,
  b = hinge0,
  E = 210000,
  I = 149,
  A = 80
)

bar1 = methods::new(
  Class = "Bar",
  a = hinge0,
  b = support1,
  E = 210000,
  I = 149,
  A = 80
)

load0 = methods::new(
  Class = "LinearLoad",
  element = bar0,
  x0 = 0.0,
  x1 = 1.0,
  amount = 10
)

load1 = methods::new(
  Class = "Load",
  element = bar0,
  amount = 10,
  x = 0.5,
  angle = 10
)

truss = methods::new(
  Class = "Structure",
  nodes = list(
    support0, hinge0, support1
  ),
  bars = list(
    bar0, bar1
  ),
  loads = list(
   load0, load1
  )
)

view(truss)
