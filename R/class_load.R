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

setGeneric("amount", function(self) standardGeneric("amount"))

setMethod("amount", signature("Load"), function(self) {
  return(max(self@amount))
})

setMethod("draw", signature("Load"), function(self) {
  
  if (self@amount >= 0) {
    y = c(1, 0.55)
  } else {
    y = c(0.55, 1)
  }
  
  if (is(self@element, "Bar")) {
    grid::linesGrob(
      x = unit(c(self@element@length, self@element@length) * self@x, "native"),
      y = y,
      arrow = grid::arrow(
        angle = 30,
        length = unit(0.25, "native")
      ),
      gp = grid::gpar(col = "red", lwd = 2)
    )
  } else if (is(self@element, "Node")) {
    grid::linesGrob(
      x = 0,
      y = y,
      arrow = grid::arrow(
        angle = 30,
        length = unit(0.25, "native")
      ),
      gp = grid::gpar(col = "red", lwd = 2)
    )
  }

})