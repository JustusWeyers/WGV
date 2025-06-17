setClass(
  Class = "BaseElement",
  slots = methods::representation(
    N_l = "numeric",
    V_l = "numeric",
    M_l = "numeric",
    
    N_r = "numeric",
    V_r = "numeric",
    M_r = "numeric"
    
  ),
  prototype = methods::prototype(
    N_l = NA_integer_,
    V_l = NA_integer_,
    M_l = NA_integer_,
    
    N_r = NA_integer_,
    V_r = NA_integer_,
    M_r = NA_integer_
  )
)

setMethod("initialize", "BaseElement", function(.Object = "BaseElement", length, angle, loads, ...){
  # .Object@nodes = nodes
  # .Object@bars = bars
  # .Object@loads = loads
  
  
  
  return(.Object)
  
})