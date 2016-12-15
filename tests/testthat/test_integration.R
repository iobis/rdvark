library(rdvark)
library(finch)
library(yaml)

context("integration")

# Broedvogel dataset, tests "allowed"

archive <- dwca_read("data/broedvogel_data.zip", read = TRUE)
data <- archive$data$occurrence.txt
config <- yaml.load_file("data/broedvogel_settings.yml")
errors <- validate(data, config)
expect_equal(nrow(errors), 7)
unlink("data/broedvogel_data", recursive = TRUE)
