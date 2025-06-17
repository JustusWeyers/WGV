
setClass(
  Class = "Node",
  slots = representation(
    x = "numeric", 
    y = "numeric",
    bars = "list",
    c_phi = "numeric",
    c_w = "numeric",
    c_u = "numeric"
  ),
  prototype = methods::prototype(
    x = NA_integer_, 
    y = NA_integer_,
    bars = list(),
    
    c_phi = NA_integer_,
    c_w = NA_integer_,
    c_u = NA_integer_
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

setMethod("draw", signature("Node"), function(self) {

})
