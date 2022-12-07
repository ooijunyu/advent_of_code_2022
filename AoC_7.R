library(magrittr)
library(dplyr)

data <- scan("input_7.txt","raw", sep= "\r") %>% 
  paste(collapse = "\n") %>% 
  paste("\n", ., sep="")

console_output <- data %>% 
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
  c(location = next_location)
}

eval_ls_output <- function(output){
  item <- c()
  if(grepl("^dir", output)){
    dir_name <- output %>% 
      strsplit(" ") %>% 
      unlist %>% 
      .[2]
    item <- c(name = dir_name, type = "dir")
  } else if(grepl("\\d+ \\w+", output)){
    file <- output %>% 
      strsplit(" ") %>% 
      unlist
    item <- c(name = file[2], size = file[1], type = "file")
  }
  
  item
}

ls <- function(string){
  string %>% 
    strsplit("\n") %>% 
    unlist %>% 
    .[-1] %>% 
    lapply(eval_ls_output)
}

# eval_command <- function(command, current_location){
#   next_location <- ""
#   if(grepl("^cd", command)){
#     
#   } else if(grepl("^ls", command)){
#     
#   }
# }

location <- "/"
tree <- tibble(
  folder = character(),
  file = character(),
  size = numeric())
generate_file_tree <- function(console_output){
  output_command <- console_output %>% 
    strsplit("\n\\$") %>% 
    unlist %>% 
    .[-1] %>% 
    trimws
  
  for(command in output_command){
    print(command)
    
    
    if(grepl("^cd", command)){
      command <- sub("^cd ", "", command)
      location <<- cd(location, command)
    } else if(grepl("^ls", command)){
      items <- ls(command)
      for(item in items){
        if(item["type"] == "file"){
          tree <<- add_row(tree,
                           folder=location,
                           file=item["name"],
                           size=as.numeric(item["size"]))
        }
      }
    }
    print(location)
    print(tree)
  }
}

generate_file_tree(data) %>% 
  dplyr::group_by(folder) %>% 
  dplyr::summarize(folder_size = sum(size))


