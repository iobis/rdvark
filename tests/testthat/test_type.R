library(rdvark)

context("type")

# integer

values <- c(1, 2, 3, "a", "b", "c", TRUE)
ids <- seq(1, length(values))
errors <- validate_type(values, "integer", ids)

expect_equal(nrow(errors), 4)
