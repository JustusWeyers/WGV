
setClass(
  Class = "Support",
  slots = methods::representation(
    angle = "numeric",
    pinned = "logical"
  ),
  prototype = methods::prototype(
    angle = 0,
    pinned = FALSE
  ),
  contains = c("Element", "Node")
)

setMethod("initialize", "Support", function(.Object, ...) {

  if (.Object@pinned & !is.na(.Object@c_u)) {
    .Object@pinned = FALSE
  }

  return(.Object)
})

setMethod("draw", signature("Support"), function(self) {
  tri = grid::polygonGrob(
    x = c(0.25, 0.5, 0.75),
    y = c(0.0, 0.5, 0.0),
    gp = grid::gpar()
  )
  tri_shrt = grid::polygonGrob(
    x = c(0.25, 0.5, 0.75),
    y = c(0.05, 0.5, 0.05),
    gp = grid::gpar()
  )
  cl = grid::circleGrob(
    x = 0.5, 
    y = 0.5, 
    r = 0.11
  )
  seg = grid::segmentsGrob(
    x0 = 0.25, 
    x1 = 0.75, 
    y0 = 0.0, 
    y1 = 0.0, 
    gp = grid::gpar(lwd = 2)
  )
  
  if (self@pinned) {
    tree = grid::gTree(children = grid::gList(tri_shrt, cl, seg))
  } else {
    tree = grid::gTree(children = grid::gList(tri, cl, seg))
  }
  
  return(tree)
})
