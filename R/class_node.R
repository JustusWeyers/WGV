
setClass(
  Class = "Node",
  slots = representation(
    x = "numeric", 
    y = "numeric",
    angle = "numeric",
    bars = "list"
  ),
  prototype = methods::prototype(
    x = NA_integer_, 
    y = NA_integer_,
    angle = 0,
    bars = list()
  ),
  contains = "Element"
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

setGeneric("width", function(self) standardGeneric("width"))

setMethod("width", signature("Node"), function(self) {
  return(1)
})

setMethod("draw", signature("Node"), function(self) {

})
