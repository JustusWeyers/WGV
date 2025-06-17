setClass(
  Class = "Element",
  slots = representation(
    loads = "list"
  ),
  prototype = methods::prototype(
    loads = list()
  )
)

setGeneric("draw", function(self) standardGeneric("draw"))

setMethod("draw", signature("Element"), function(self) {
  
})
