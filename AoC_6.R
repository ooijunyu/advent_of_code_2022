library(magrittr)
library(zoo, include.only = "rollapply")

data <- scan("input_6.txt", "raw")

is_unique_roll <- function(vec, window){
  vec %>% 
    rollapply(width = window,
              function(x){
                length(unique(x)) == length(x)
              })
}

find_marker <- function(signal, window){
  signal %>% 
    strsplit("") %>% 
    unlist %>% 
    is_unique_roll(window) %>% 
    match(TRUE, .) %>% 
    `+`(window - 1)
}

data %>% 
  find_marker(4)
data %>% 
  find_marker(14)


