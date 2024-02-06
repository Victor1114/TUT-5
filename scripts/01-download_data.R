#### Preamble ####
# Purpose: Get data on Wikipedia about how long prime ministers of the Australia lived
# Author: Yuchen Chen
# Email: victorchen.chen@mail.utoronto.ca
# Date: 4 February 2024
# Prerequisites: -

#### Workspace setup ####
install.packages("rvest")
install.packages("xml2")
library(rvest)
library(xml2)
#### Simulate ####
raw_data <-
  read_html(
    "https://en.wikipedia.org/wiki/List_of_prime_ministers_of_Australia"
  )
write_html(raw_data, "inputs/data/pms.html")
