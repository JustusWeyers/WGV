setClass(
  Class = "Bar",
  slots = representation(
    a = "Node",
    b = "Node", 
    E = "numeric",
    I = "numeric",
    A = "numeric",

    # "private"
    length = "numeric",
    angle = "numeric",
    loads = "list"
  ),
  prototype = methods::prototype(
    E = NA_integer_,
    I = NA_integer_,
    A = NA_integer_,
    length = NA_integer_,
    angle = NA_integer_,
    loads = list()
  )
)

setMethod("initialize", "Bar", function(.Object = "Bar", a, b, E, I, A, ...){
  .Object@a = a
  .Object@b = b
  .Object@E = E
  .Object@I = I
  .Object@A = A
  
  .Object@length = sqrt(
    (.Object@a@x - .Object@b@x)**2 + (.Object@a@y - .Object@b@y)**2
  )
  
  .Object@angle = atan2(
    y = .Object@b@y - .Object@a@y, x = .Object@b@x - .Object@a@x
  ) * 180/pi
  
  return(.Object)
})

setMethod("coords", signature("Bar"), function(self, xy) {
  x = c(coords(self@a, "x"), coords(self@b, "x"))
  y = c(coords(self@a, "y"), coords(self@b, "y"))
  
  if (identical(xy, "x")) {
    return(x)
  } else if (identical(xy, "y")) {
    return(y)
  } else {
    return(c(x = x, y = y))
  }
})

setMethod("draw", signature("Bar"), function(self) {
  seg = grid::segmentsGrob(
    x0 = unit(0, "native"), 
    x1 = unit(self@length, "native"), 
    y0 = 0.5, 
    y1 = 0.5, 
    gp = gpar(lwd = unit(2, "pt"))
  )
})
