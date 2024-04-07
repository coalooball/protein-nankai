setClass(
  "EicResults",
  slots = c(rt_min_max = "numeric", int_min_max = "numeric", data = "list")
)

EicResults <- function(rt_min_max, int_min_max, data) {
    new("EicResults", rt_min_max=rt_min_max, int_min_max=int_min_max, data=data)
}
