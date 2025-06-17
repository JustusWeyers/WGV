setClass(
  Class = "LinearLoad",
  slots = methods::representation(
    element = "Element",
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
  
  w = self@element@length * self@x1 - self@element@length * self@x0
  
  if (self@amount >= 0) {
    y = c(0.55, 0.45, 1, 0.55)
  } else {
    y = c(0, 0.45, 0, 0.45)
  }
  
  tree = grid::gTree(children = grid::gList(grid::rectGrob(
    x = unit(self@element@length * self@x0, "native"), 
    y = y[1],
    width = unit(w, "native"), 
    height = y[2],
    just = c("left", "bottom"), 
    gp = grid::gpar(col = "red", lwd = 2, fill="transparent")
  )))
  
  for (a in c(0.0, 0.2, 0.4, 0.6, 0.8, 1.0)) {
    tree = grid::addGrob(tree, grid::linesGrob(
      x = unit(c(self@element@length * self@x0 + w*a, self@element@length * self@x0 + w*a), "native"),
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