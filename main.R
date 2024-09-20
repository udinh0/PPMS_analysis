suppressPackageStartupMessages(library(tidyverse))
library(glue)
library(yaml)
library(openxlsx)
source("R/script.R")
source("R/densidades.R")

config = read_yaml("config.yaml")

for (i in stringr::str_split(config$data, pattern = " ")[[1]]) {
  dados = read_csv(glue("dados/{i}.raw"), skip = 19, show_col_types = F)
  df = func(drive = dados %>% select(config$variables$drive) %>% pull(),
          signal = dados %>% select(config$variables$signal) %>% pull(),
          bin = dados %>% select(config$variables$bin) %>% pull(),
          frequency = dados %>% select(config$variables$frequency) %>% pull(),
          images = config$variables$histereses)
  densidades(df)
  write.xlsx(df, glue("resultados/{i}/results.xlsx"))
}
