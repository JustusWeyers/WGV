setClass(
  Class = "LinearLoad",
  slots = methods::representation(
    element = "Element",
    x0 = "numeric",
    x1 = "numeric",
    q0 = "numeric",
    q1 = "numeric",
    angle = "numeric"
  ),
  prototype = methods::prototype(
    x0 = NA_integer_,
    x1 = NA_integer_,
    q0 = NA_integer_,
    q1 = NA_integer_,
    angle = 0
  )
)

setMethod("amount", signature("LinearLoad"), function(self) {
  return(max(c(self@q0, self@q1)))
})

setMethod("draw", signature("LinearLoad"), function(self) {
  
  # w = self@element@length * self@x1 - self@element@length * self@x0

  poly = grid::polygonGrob(
    x = c(
      self@x0, 
      self@x0, 
      self@x1, 
      self@x1
    ),
    y = c(
      0.5, 
      0.5 + 0.5 * self@q0/max(c(self@q0, self@q1)), 
      0.5 + 0.5 * self@q1/max(c(self@q0, self@q1)), 
      0.5
    ),
    gp = grid::gpar(col = "red", fill = "transparent")
  )
  
  y = function(x) {
    y1 = 0.5 + abs(0.5 * self@q0/max(c(self@q0, self@q1)))
    
    y2 = 0.5 + abs(0.5 * self@q1/max(c(self@q0, self@q1)))
    m = (y2-y1)/(self@x1-self@x0)
    return(m * x + y1)
  }
  
  tree = grid::gTree(children = grid::gList(poly))
  
  for (a in c(0.0, 0.2, 0.4, 0.6, 0.8, 1.0)) {
    x_ = c(a, a)
    y_ = c(y(x = a), 0.55)
    
    print(x_)
    print(y_)
    
    tree = grid::addGrob(tree, grid::linesGrob(
      x = x_,
      y = y_,
      arrow = grid::arrow(
        angle = 30,
        length = unit(0.25*y_, "cm")
      ),
      gp = grid::gpar(col = "red", lwd = 2)
    ))
  }
  
  return(tree)
  
})