setClass(
  Class = "Load",
  slots = methods::representation(
    element = "Element",
    x = "numeric",
    amount = "numeric",
    angle = "numeric"
  ),
  prototype = methods::prototype(
    x = NA_integer_,
    amount = NA_integer_,
    angle = 0
  )
)

setMethod("draw", signature("Load"), function(self) {
  if (is(self@element, "Bar")) {
    grid::linesGrob(
      x = unit(c(self@element@length, self@element@length) * self@x, "native"),
      y = c(1.0, 0.55),
      arrow = grid::arrow(
        angle = 30,
        length = unit(0.25, "native")
      ),
      gp = grid::gpar(col = "red", lwd = 2)
    )
  } else if (is(self@element, "Node")) {
    grid::linesGrob(
      x = 0.5,
      y = c(1.0, 0.55),
      arrow = grid::arrow(
        angle = 30,
        length = unit(0.25, "native")
      ),
      gp = grid::gpar(col = "red", lwd = 2)
    )
  }

})