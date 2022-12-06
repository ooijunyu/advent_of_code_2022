start_time <- Sys.time()
library(dplyr)
data <- scan("input_3.txt", "raw")

priorities <- seq(1,52)
names(priorities) <- c(letters, LETTERS)

init_time <- Sys.time()

# Q1
compute_priorities <- function(input){
  length <- nchar(input)
  half <- as.integer(length/2)
  char_array <- input %>% 
    strsplit('') %>% 
    unlist
  comp1 <- char_array[seq(1,half)]
  comp2 <- char_array[seq(half + 1,length)]
  intersect(comp1, comp2) %>% 
    priorities[.]
}

lapply(data,compute_priorities) %>% 
  purrr::reduce(sum)

Q1_time <- Sys.time()

# Q2
compute_priorites2 <- function(char_vector){
  char_vector %>% 
    purrr::map(~strsplit(.x, '')) %>% 
    purrr::map(unlist) %>%
    purrr::reduce(intersect) %>% 
    priorities[.]
}

data %>% 
  split(., ceiling(seq_along(.)/3)) %>% 
  lapply(compute_priorites2) %>% 
  purrr::reduce(sum)

Q2_time <- Sys.time()

c(init = init_time - start_time,
  Q1_time = Q1_time - start_time,
  Q2_time = init_time - start_time + Q2_time - Q1_time)


