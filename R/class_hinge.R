setClass(
  Class = "Hinge",
  slots = representation(
    momentum = "numeric"
  ),
  prototype = methods::prototype(
    momentum = 0
  ),
  contains = "Node"
)

setMethod("draw", signature("Hinge"), function(self) {
  grid::circleGrob(x = self@x, y = self@y, r = 0.1)
})
