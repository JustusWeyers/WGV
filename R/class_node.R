

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

setGeneric("coords", function(self, xy = NULL) standardGeneric("coords"))

setMethod("coords", signature("Node"), function(self, xy = NULL) {
  if (identical(xy, "x")) {
    return(self@x)
  } else if (identical(xy, "y")) {
    return(self@y)
  } else {
    return(c(self@x, self@y))
  }
})

setGeneric("draw", function(self) standardGeneric("draw"))

setMethod("draw", signature("Node"), function(self) {
  print("draw node")
})
