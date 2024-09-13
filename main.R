suppressPackageStartupMessages(library(tidyverse))
library(glue)
library(yaml)
library(openxlsx)
source("R/script.R")
source("R/densidades.R")

config = read_yaml("config.yaml")
dados = read_csv(glue("dados/{config$data}.raw"), skip = 19, show_col_types = F)

df = func(drive = dados %>% select(config$variables$drive) %>% pull(),
          signal = dados %>% select(config$variables$signal) %>% pull(),
          bin = dados %>% select(config$variables$bin) %>% pull(),
          frequency = dados %>% select(config$variables$frequency) %>% pull(),
          images = config$variables$images)

densidades(df)

write.xlsx(df, glue("resultados/{config$data}/results.xlsx"))

