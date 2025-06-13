
setClass(
  Class = "Node",
  slots = representation(
    x = "numeric", 
    y = "numeric",
    forces = "list",
    bars = "list"
  ),
  prototype = methods::prototype(
    x = NA_integer_, 
    y = NA_integer_,
    forces = list(),
    bars = list()
  )
)

setGeneric("draw", function(self) standardGeneric("draw"))

setMethod("draw", signature("Node"), function(self) {
  print("draw node")
})

setClass(
  Class = "Hinge",
  slots = representation(
    momentum = "numeric"
  ),
  prototype = methods::prototype(
    momentum = 0
  ),
  contains = "Node"
)

setMethod("draw", signature("Hinge"), function(self) {
  grid::circleGrob(x = self@x, y = self@y, r = 0.1)
})

setClass(
  Class = "Rigid",
  slots = methods::representation(
    momentum = "numeric"
  ),
  prototype = methods::prototype(
    momentum = NA_integer_
  ),
  contains = "Node"
)

setMethod("draw", signature("Rigid"), function(self) {
  
})

setClass(
  Class = "Support",
  slots = methods::representation(
    angle = "numeric",
    clamping = "logical",
    pinned = "logical"
  ),
  prototype = methods::prototype(
    angle = 0,
    clamping = FALSE,
    pinned = FALSE
  ),
  contains = "Node"
)

setMethod("draw", signature("Support"), function(self) {
  tri = grid::polygonGrob(
    x = unit(c(self@x, self@x - 0.33, self@x + 0.33), "cm"), 
    y = unit(c(self@y, self@y - 1, self@y - 1), "cm"),
    gp=gpar()
  )
  cl = grid::circleGrob(
    x = unit(self@x, "cm"), 
    y = unit(self@y, "cm"), 
    r = grid::unit(0.16, "cm")
  )
  tree = grid::gTree(children = grid::gList(tri, cl))
  return(tree)
})

setClass(
  Class = "Bar",
  slots = representation(
    a = "Node",
    b = "Node", 
    E = "numeric",
    I = "numeric",
    A = "numeric",
    joints = "list",
    
    # "private"
    length = "numeric",
    angle = "numeric",
    loads = "list"
  ),
  prototype = methods::prototype(
    E = NA_integer_,
    I = NA_integer_,
    A = NA_integer_,
    joints = list(),
    length = NA_integer_,
    angle = NA_integer_,
    loads = list()
  )
)

setMethod("initialize", "Bar", function(.Object = "Bar", a, b, E, I, A, ...){
  .Object@a = a
  .Object@b = b
  .Object@E = E
  .Object@I = I
  .Object@A = A
  
  .Object@length = sqrt(
    (.Object@a@x - .Object@b@x)**2 + (.Object@a@y - .Object@b@y)**2
  )
  
  .Object@angle = atan2(.Object@b@y-.Object@a@y, .Object@b@x-.Object@a@x) * 180/pi

  return(.Object)
})

setMethod("draw", signature("Bar"), function(self) {
  tree = grid::gTree(children = grid::gList(grid::segmentsGrob(
    x0 = 0, 
    x1 = 1, 
    y0 = 0.5, 
    y1 = 0.5, 
    gp = gpar(lwd = unit(2, "pt"))
  )))
  
  for (g in lapply(self@loads, draw)) {
    tree = grid::addGrob(tree, g)
  }

  return(tree)
  
})

####

setClass(
  Class = "Load",
  slots = methods::representation(
    bar = "Bar",
    x = "numeric",
    amount = "numeric",
    angle = "numeric"
  ),
  prototype = methods::prototype(
    x = NA_integer_,
    amount = NA_integer_,
    angle = 0
  )
)

setMethod("draw", signature("Load"), function(self) {
  
  if (self@amount >= 0) {
    y = c(1.0, 0.55)
  } else {
    y = c(0, 0.45)
  }
  
  grid::linesGrob(
    x = unit(c(self@x, self@x), "cm"),
    y = y,
    arrow = grid::arrow(
      angle = 30,
      length = unit(0.25, "cm")
    ),
    gp = grid::gpar(col = "red", lwd = 2)
  )
})

setClass(
  Class = "LinearLoad",
  slots = methods::representation(
    bar = "Bar",
    x0 = "numeric",
    x1 = "numeric",
    amount = "numeric",
    angle = "numeric"
  ),
  prototype = methods::prototype(
    x0 = NA_integer_,
    x1 = NA_integer_,
    amount = NA_integer_,
    angle = 0
  )
)

setMethod("draw", signature("LinearLoad"), function(self) {
  
  w = self@x1-self@x0
  
  if (self@amount >= 0) {
    y = c(0.55, 0.45, 1, 0.55)
  } else {
    y = c(0, 0.45, 0, 0.45)
  }
  
  tree = grid::gTree(children = grid::gList(grid::rectGrob(
    x = unit(self@x0, "cm"), 
    y = y[1],
    width = unit(w, "native"), 
    height = y[2],
    just = c("left", "bottom"), 
    gp = grid::gpar(col = "red", lwd = 2, fill="transparent")
  )))
  
  for (a in c(0.0, 0.2, 0.4, 0.6, 0.8, 1.0)) {
    tree = grid::addGrob(tree, grid::linesGrob(
      x = unit(c(self@x0 + w*a, self@x0 + w*a), "native"),
      y = c(y[3], y[4]),
      arrow = grid::arrow(
        angle = 30,
        length = unit(0.25, "cm")
      ),
      gp = grid::gpar(col = "red", lwd = 2)
    ))
  }
  
  return(tree)
  
})

#### 

suppressWarnings(setClass(
  Class = "Structure",
  slots = methods::representation(
    nodes = "list",
    bars = "list",
    loads = "list",
    
    # "private"
    GE = "list",
    rangeX = "numeric",
    rangeY = "numeric",
    default_vp = "viewport",
    vps = "list"
  ),
  prototype = methods::prototype(
    nodes = list(),
    bars = list(),
    loads = list(),
    
    # "private"
    GE = list(),
    rangeX = NA_integer_,
    rangeY = NA_integer_,
    vps = list()
  )
))

setMethod("initialize", "Structure", function(.Object = "Structure", nodes, bars, loads, ...){
  .Object@nodes = nodes
  .Object@bars = bars
  .Object@loads = loads
  
  
  #### Backwards association ----
  
  ## loads -> bars
  for (l in .Object@loads) {
    for (i in 1:length(.Object@bars)) {
      if (identical(l@bar, bars[[i]])) {
        .Object@bars[[i]]@loads = c(.Object@bars[[i]]@loads, l)
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
  
  #### ----
  
  .Object@rangeX = c(
    -max(abs(sapply(.Object@bars, function(b) c(b@a@x, b@b@x)))),
    max(abs(sapply(.Object@bars, function(b) c(b@a@x, b@b@x))))
  )
  
  .Object@rangeY = c(
    -max(abs(sapply(.Object@bars, function(b) c(b@a@y, b@b@y)))),
    max(abs(sapply(.Object@bars, function(b) c(b@a@y, b@b@y))))
  )
  
  if (identical(.Object@rangeY, c(0, 0))) {
    .Object@rangeY = c(-10, 10)
  }
  
  .Object@default_vp = viewport(
    x = 0, y = 0, 
    width = unit(1, "snpc"), 
    height = unit(1, "snpc"),
    just = c("left", "bottom"),
    xscale = unit(c(0, diff(.Object@rangeX)), "cm"),
    yscale = unit(c(0, diff(.Object@rangeY)), "cm"),
  )
  
  .Object@vps = lapply(.Object@bars, function(bar) {
    viewport(
      x = unit(bar@a@x, "cm"), # 
      y = unit(bar@a@y, "cm"), # 
      width = unit(bar@length, "cm"),
      height = 0.2,
      angle = bar@angle,
      just = c("left", "center"),
    )
  })
  
  return(.Object)
})

setGeneric("view", function(self) standardGeneric("view"))

setMethod("view", signature("Structure"), function(self) {
  p = {

    grid.newpage()

    # Base viewport
    pushViewport(viewport(
      x = 0.125,
      y = 0.125,
      width = 0.75,
      height = 0.75,
      just = c("left", "bottom"),
    ))
    # grid.draw(grid::roundrectGrob())
    
    
    pushViewport(self@default_vp)
    # grid.draw(grid::roundrectGrob())
    grid.draw(grid::circleGrob(x = 0, y = 0, r = 0.01, gp = gpar(fill = "black")))
    
    for (i in 1:length(self@vps)) {
      pushViewport(self@vps[[i]])
      # grid.draw(grid::roundrectGrob())
      grid.draw(draw(self@bars[[i]]))
      grid::popViewport(n = 1)
    }
    
    for (node in self@nodes) {
      grid.draw(draw(
        node
      ))
    }

  }
  return(p)
})
