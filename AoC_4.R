library(dplyr, include.only = "%>%")
library(purrr, include.only = c("map", "reduce"))

# can just do boundary checking
# instead of generating whole set

data <- scan("input_4.txt", "raw") %>% 
  map(~unlist(strsplit(.x, ","))) %>% 
  map(~map(.x, create_set))

create_set <- function(str){
  seq_vec <- str %>% 
    strsplit("-") %>%
    unlist
  seq(seq_vec[1], seq_vec[2])
}

# Q1
check_subset <- function(list_of_vec){
  all(list_of_vec[[1]] %in% list_of_vec[[2]]) ||
    all(list_of_vec[[2]] %in% list_of_vec[[1]])
}

data %>% 
  map(~check_subset(.x)) %>% 
  reduce(sum)

# Q2
check_subset2 <- function(list_of_vec){
  length(intersect(list_of_vec[[1]], list_of_vec[[2]])) > 0
}

data %>% 
  map(~check_subset2(.x)) %>% 
  reduce(sum)
