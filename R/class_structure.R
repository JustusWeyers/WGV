setClass(
  Class = "Structure",
  slots = methods::representation(
    nodes = "list",
    bars = "list",
    loads = "list",
    
    # "private"
    extent = "numeric",
    max_load = "numeric",
    viewports = "list",
    GE = "list"
  ),
  prototype = methods::prototype(
    nodes = list(),
    bars = list(),
    loads = list(),
    
    # "private"
    extent = NA_integer_,
    max_load = NA_integer_,
    viewports = list(),
    GE = list()
  )
)

setMethod("initialize", "Structure", function(.Object = "Structure", nodes, bars, loads, ...){
    
  .Object@nodes = nodes
  .Object@bars = bars
  .Object@loads = loads


  ## loads -> bars
  for (l in .Object@loads) {
    for (i in 1:length(.Object@bars)) {
      if (identical(l@element, bars[[i]])) {
        .Object@bars[[i]]@loads = c(.Object@bars[[i]]@loads, l)
      }
    }
  }
  
  ## loads -> nodes
  for (l in .Object@loads) {
    for (i in 1:length(.Object@nodes)) {
      if (identical(l@element, nodes[[i]])) {
        .Object@nodes[[i]]@loads = c(.Object@nodes[[i]]@loads, l)
      }
    }
  }

  ## bars -> nodes
  for (b in .Object@bars) {
    for (i in 1:length(.Object@nodes)) {
      if (identical(b@a, nodes[[i]])) {
        .Object@nodes[[i]]@bars = c(.Object@nodes[[i]]@bars, b)
      }
      if (identical(b@b, nodes[[i]])) {
        .Object@nodes[[i]]@bars = c(.Object@nodes[[i]]@bars, b)
      }
    }
  }
  
  .Object@max_load = max(sapply(.Object@loads, methods::slot, "amount"))

  .Object@extent = c(
    x = range(sapply(c(.Object@nodes), coords, "x")),
    y = range(sapply(c(.Object@nodes), coords, "y"))
  )

  return(.Object)
  
})

setGeneric("view", function(self) standardGeneric("view"))

setMethod("view", signature("Structure"), function(self) {
  
  scale = min(c(10/diff(self@extent[1:2]), 10/diff(self@extent[3:4])))

  X = function(x, x1 = self@extent[["x1"]], x2 = self@extent[["x2"]]) {
    if (!identical(x1, x2)) {
      (10-0)/(x2-x1)*(x-x1) + 0
    } else {
      return(5)
    }
  }

  Y = function(y, y1 = self@extent[["y1"]], y2 = self@extent[["y2"]]) {
    if (!identical(y1, y2)) {
      (10-0)/(y2-y1)*(y-y1) + 0
    } else {
      return(5)
    }
  }

  grid::grid.newpage()

  # Base viewport
  grid::pushViewport(grid::viewport(
    x = 0.125,
    y = 0.125,
    width = 0.75,
    height = 0.75,
    just = c("left", "bottom"),
  ))

  # grid::grid.draw(grid::roundrectGrob())

  grid::pushViewport(grid::viewport(
    x = 0, y = 0,
    width = grid::unit(1, "snpc"),
    height = grid::unit(1, "snpc"),
    just = c("left", "bottom"),
    xscale = grid::unit(c(0, 10), "cm"),
    yscale = grid::unit(c(0, 10), "cm")
  ))

  # grid::grid.draw(grid::roundrectGrob())

  for (bar in self@bars) {
    print("Test")
    print(bar@a)
    print("---")
    print(print(bar@b))
    grid::pushViewport(grid::viewport(
      x = grid::unit(X(bar@a@x), "native"),
      y = grid::unit(Y(bar@a@y), "native"),
      width = grid::unit(sqrt(
        (X(bar@a@x) - X(bar@b@x))**2 + (Y(bar@a@y) - Y(bar@b@y))**2
      ), "native"),
      height = 0.2,
      angle = atan2(
        y = Y(bar@b@y) - Y(bar@a@y), x = X(bar@b@x) - X(bar@a@x)
      ) * 180/pi,
      just = c("left", "center"),
      xscale = grid::unit(c(0, bar@length), "native")
    ))
    
    
    grid::grid.draw(draw(bar))
    
    for (load in bar@loads) {
      grid::grid.draw(draw(load))
    }

    grid::popViewport(n = 1)
  }

  for (node in self@nodes) {
    grid::pushViewport(grid::viewport(
      x = grid::unit(X(node@x)-0.5, "native"),
      y = grid::unit(Y(node@y), "native"),
      width = grid::unit(1, "native"),
      height = grid::unit(1, "native"),
      angle = 0,
      just = c("left", "center"),
    ))
    # grid::grid.draw(grid::roundrectGrob())
    grid::grid.draw(draw(node))

    print(node@loads)
    for (load in node@loads) {
      grid::grid.draw(draw(load))
    }

    grid::popViewport(n = 1)
  }
  
})

