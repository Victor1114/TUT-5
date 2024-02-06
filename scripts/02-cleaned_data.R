#### Preamble ####
# Purpose: Get data on Wikipedia about how long prime ministers of the Australia lived
# Author: Yuchen Chen
# Email: victorchen.chen@mail.utoronto.ca
# Date: 4 February 2024
# Prerequisites: -

#### Workspace setup ####
install.packages("janitor")
install.packages("knitr")
library(rvest)
library(janitor)
library(knitr)


raw_data <- read_html("inputs/data/pms.html")

parse_data_selector_gadget <-
  raw_data |>
  html_element(".wikitable") |>
  html_table()

head(parse_data_selector_gadget)

parsed_data <-
  parse_data_selector_gadget |> 
  clean_names() |> 
  rename(raw_text = name_birth_death_constituency) |> 
  select(raw_text) |> 
  filter(raw_text !="Name(Birth–Death)Constituency") |> 
  distinct() 

head(parsed_data)

initial_clean <-
  parsed_data |>
  separate(
    raw_text, into = c("name", "not_name"), sep = "\\(", extra = "merge",
  ) |> 
  mutate(date = str_extract(not_name, "[[:digit:]]{4}–[[:digit:]]{4}"),
         born = str_extract(not_name, "b.[[:space:]][[:digit:]]{4}")
  ) |>
  select(name, date, born)

head(initial_clean)


write_csv(cleaned_data,"outputs/data/cleaned_data.csv")