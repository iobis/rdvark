library(rdvark)

context("allowed")

values <- c(1, 2, 3, "a", "b", "c")
allowed <- c(1, "a")
ids <- seq(1, length(values))
errors <- validate_allowed(values, allowed, ids)

expect_equal(nrow(errors), 4)
expect_false(1 %in% errors$id)
expect_true(2 %in% errors$id)
