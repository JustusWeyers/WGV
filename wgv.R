# Global

source("global.R")
source("utils.R")

support0 = methods::new(
  Class = "FixSupport",
  x = 0,
  y = 0,
  angle = 0
)

rigid0 = methods::new(
  Class = "Rigid",
  x = 3,
  y = 3,
  c_phi = 500
)

support1 = methods::new(
  Class = "PinSupport",
  x = 7,
  y = 3
)

bar0 = methods::new(
  Class = "Bar",
  a = support0,
  b = rigid0,
  E = 210000,
  I = 149,
  A = 80
)

bar1 = methods::new(
  Class = "Bar",
  a = rigid0,
  b = support1,
  E = 210000,
  I = 149,
  A = 80
)

load0 = methods::new(
  Class = "Load",
  element = rigid0,
  amount = -20,
  angle = 10
)

load1 = methods::new(
  Class = "LinearLoad",
  element = bar1,
  x0 = 0.0,
  x1 = 1.0,
  q0 = -90,
  q1 = -30
)

truss = methods::new(
  Class = "Structure",
  nodes = list(
    support0, rigid0, support1
  ),
  bars = list(
    bar0, bar1
  ),
  loads = list(
   load1
  )
)

view(truss)
