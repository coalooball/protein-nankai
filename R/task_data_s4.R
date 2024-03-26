setClass(
  "TaskData",
  slots = c(name = "character", time = "character", data = "list")
)

TaskData <- function(name, time, data) {
    new("TaskData", name=name, time=time, data=data)
}