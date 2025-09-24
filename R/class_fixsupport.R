setClass(
  Class = "FixSupport",
  slots = methods::representation(
    
  ),
  prototype = methods::prototype(
    
  ),
  contains = c("Element", "Node", "Support")
)

setMethod("draw", signature("FixSupport"), function(self) {
  
  seg = grid::segmentsGrob(
    x0 = 0.25, 
    x1 = 0.75, 
    y0 = 0.5, 
    y1 = 0.5, 
    gp = grid::gpar(lwd = 2)
  )
  
  tree = grid::gTree(children = grid::gList(seg))
  
  for (s in seq(0.25, 0.65, length.out = 4)) {
    tree = grid::addGrob(
      tree,
      child = grid::segmentsGrob(
        x0 = s, x1 = s+0.1, y0 = 0.5, y1 = 0.41
      )
    )
  }  

  grid::grid.draw(tree)
  
})
