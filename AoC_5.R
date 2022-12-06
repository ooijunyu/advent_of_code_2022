library(dplyr, include.only = "%>%")
library(purrr, include.only = c("map", "reduce", "map2"))

data <- scan("input_5.txt", "raw", sep="\n")

initial_containers <- data[grep("\\[.\\]", data)]

stacks_index <- data[grep("^[ 0-9]+$", data)] %>% 
  strsplit("") %>% 
  unlist %>% 
  grep("^\\d+$", .)
num_of_stacks <- length(stacks_index)
names(stacks_index) <- seq(1, num_of_stacks)

move_instructions <- data[grep("move", data)] %>% 
  gsub("( |move)", "", .) %>% 
  gsub("(from|to)", ",", .) %>% 
  strsplit(",") %>% 
  map(as.integer)

container_On_stacks <- vector(mode = "list", length = num_of_stacks)

create_initial_stacks <- function(line){
  crates <- line %>% 
    strsplit("") %>% 
    unlist
  
  # modifying global container_On_stacks
  map2(stacks_index, names(stacks_index), function(x, index){
    container_On_stacks[[index]] <<- c(crates[x], container_On_stacks[[index]])
  })
}

map(initial_containers, create_initial_stacks)

# For some reasons there are some NULL entries generated
# To remove empty entries
container_On_stacks <- Filter(Negate(is.null), container_On_stacks)

# Remove empty string entries in the stacks so to ease transferring actions
# by push or pop
container_On_stacks <- map(container_On_stacks, function(x){
  x[x != " "]
  })

move_crates <- function(instructions, reverse=TRUE){
  size <- instructions[1]
  from <- instructions[2]
  to <- instructions[3]
  
  length_of_from <- length(container_On_stacks[[from]])
  trasferred_crates <- tail(container_On_stacks[[from]], n=size)
  if(reverse) {trasferred_crates <- rev(trasferred_crates)}
  
  # modifying global container_On_stacks
  container_On_stacks[[from]] <<- c(container_On_stacks[[from]][seq(1, length_of_from - size)])
  container_On_stacks[[to]] <<- c(container_On_stacks[[to]], trasferred_crates)
}

lapply(move_instructions, move_crates, reverse=TRUE)
lapply(container_On_stacks, tail, n=1) %>% 
  unlist %>% 
  paste(collapse = "")

