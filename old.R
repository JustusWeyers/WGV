














####





#### 

({
  .Object@rangeX = c(
    -max(abs(sapply(.Object@bars, function(b) c(b@a@x, b@b@x)))),
    max(abs(sapply(.Object@bars, function(b) c(b@a@x, b@b@x))))
  )
  
  .Object@rangeY = c(
    -max(abs(sapply(.Object@bars, function(b) c(b@a@y, b@b@y)))),
    max(abs(sapply(.Object@bars, function(b) c(b@a@y, b@b@y))))
  )
  
  if (identical(.Object@rangeY, c(0, 0))) {
    .Object@rangeY = c(-10, 10)
  }
  
  .Object@default_vp = 
  
  .Object@vps = lapply(.Object@bars, function(bar) {
    
  })
  
  return(.Object)
})

setGeneric("view", function(self) standardGeneric("view"))

setMethod("view", signature("Structure"), function(self) {
  p = {

    
    
    pushViewport(self@default_vp)
    # grid.draw(grid::roundrectGrob())
    
    for (i in 1:length(self@vps)) {
      pushViewport(self@vps[[i]])
      # grid.draw(grid::roundrectGrob())
      grid.draw(draw(self@bars[[i]]))
      grid::popViewport(n = 1)
    }
    
    for (node in self@nodes) {
      grid.draw(draw(
        node
      ))
    }
    
  }
  return(p)
})
