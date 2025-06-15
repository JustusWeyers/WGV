
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