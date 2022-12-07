library(magrittr)

data <- scan("input_7.txt","raw", sep= "\r") %>% 
  paste(collapse = "\n") %>% 
  paste("\n", ., sep="")

data %>% 
  strsplit("\n\\$") %>% 
  unlist %>% 
  .[-1] %>% 
  trimws

cd <- function(current_location, input){
  next_location <- ""
  if(input == "/") {
    next_location <- "/"
  } else if(input == "..") {
    if(current_location == "/") {
      next_location <- "/"
    } else{
      next_location <- current_location %>% 
        strsplit("/") %>% 
        unlist %>% 
        .[!grepl("^$", .)] %>% 
        .[-length(.)] %>% 
        paste(collapse = "/") %>% 
        paste("/", ., "/", sep="") %>% 
        ifelse(. == "//", "/", .)
    } 
  } else if(grepl("/(\\w+/)?" ,input)){
    next_location <- input
  }else {
    next_location <- paste(current_location, input, "/", sep="")
  }
  next_location
}
