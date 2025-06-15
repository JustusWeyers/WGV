
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