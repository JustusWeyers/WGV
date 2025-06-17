setClass(
  Class = "Hinge",
  slots = representation(
    momentum = "numeric"
  ),
  prototype = methods::prototype(
    momentum = 0
  ),
  contains = c("Element", "Node")
)

setMethod("draw", signature("Hinge"), function(self) {
  grid::circleGrob(x = 0.5, y = 0.5, r = 0.11)
})
