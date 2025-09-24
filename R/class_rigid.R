
setClass(
  Class = "Rigid",
  slots = methods::representation(
    c_phi = "numeric",
    c_u = "numeric",
    c_w = "numeric"
  ),
  prototype = methods::prototype(
    c_phi = NA_integer_,
    c_u = NA_integer_,
    c_w = NA_integer_
  ),
  contains = c("Element", "Node")
)

setMethod("draw", signature("Rigid"), function(self) {
  tree = grid::gTree()
  
  # u Feather
  if (!is.na(self@c_u)) {
    tree = feather_u(tree)
  }
  
  # w Feather
  if (!is.na(self@c_w)) {
    tree = feather_w(tree)
  }
  
  # phi Feather
  if (!is.na(self@c_phi)) {
    tree = spirale(tree)
  }
  
  grid::grid.draw(tree)
})
