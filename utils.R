
spirale = function(gTree) {
  x = c()
  y = c()
  r = 0
  for (theta in seq(0, 2*pi*1.25, length.out = 90)) {
    r = r + 0.005
    x = c(x, r*cos(theta) + 0.5)
    y = c(y, r*sin(theta) + 0.5)
  }
  gTree = grid::addGrob(gTree, child = grid::linesGrob(
    x = x, y = y
  ))
  gTree = grid::addGrob(gTree, child = grid::segmentsGrob(
    x0 = 0.5, x1 = 0.5, y0 = 0.90, y1 = 1.0, gp = grid::gpar(lwd = 3)
  ))
  return(gTree)
}

feather_u = function(gTree) {
  gTree = grid::addGrob(gTree, child = grid::linesGrob(
    x = c(seq(0, 0.4, length.out = 10), 0.5),
    y = c(0.5, 0.5, rep(c(0.6, 0.4), 3), 0.5, 0.5, 0.5)
  ))
  gTree = grid::addGrob(gTree, child = grid::segmentsGrob(
    x0 = 0, x1 = 0, y0 = 0.45, y1 = 0.55,
    gp = grid::gpar(lwd = 3))
  )
  return(gTree)
}

feather_w = function(gTree) {
  gTree = grid::addGrob(gTree, child = grid::linesGrob(
    x = c(0.5, 0.5, rep(c(0.6, 0.4), 3), 0.5, 0.5, 0.5),
    y = c(seq(0, 0.4, length.out = 10), 0.5)
  ))
  gTree = grid::addGrob(gTree, child = grid::segmentsGrob(
    x0 = 0.45, x1 = 0.55, y0 = 0.0, y1 = 0.0,
    gp = grid::gpar(lwd = 3))
  )
  return(gTree)
}
