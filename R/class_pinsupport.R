setClass(
  Class = "PinSupport",
  slots = methods::representation(
    c_phi = "numeric"
  ),
  prototype = methods::prototype(
    c_phi = NA_integer_
  ),
  contains = c("Element", "Node", "Support")
)

setMethod("draw", signature("PinSupport"), function(self) {
  
  tri = grid::polygonGrob(
    x = c(0.25, 0.5, 0.75),
    y = c(0.0, 0.5, 0.0),
    gp = grid::gpar()
  )
  
  cl = grid::circleGrob(
    x = 0.5, 
    y = 0.5, 
    r = 0.11
  )

  tree = grid::gTree(children = grid::gList(tri, cl))
  
  for (s in seq(0.25, 0.65, length.out = 4)) {
    tree = grid::addGrob(
      tree,
      child = grid::segmentsGrob(
        x0 = s, x1 = s+0.1, y0 = 0.0, y1 = -0.09
      )
    )
  }   
  
  return(tree)
})
