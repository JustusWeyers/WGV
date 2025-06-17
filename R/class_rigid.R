
setClass(
  Class = "Rigid",
  slots = methods::representation(
    momentum = "numeric"
  ),
  prototype = methods::prototype(
    momentum = NA_integer_
  ),
  contains = c("Element", "Node")
)

setMethod("draw", signature("Rigid"), function(self) {
  # Nothing
})
