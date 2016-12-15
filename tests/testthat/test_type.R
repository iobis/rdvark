library(rdvark)

context("type")

# integer

values <- c(1, 2, 3, "a", "b", "c", TRUE)
ids <- seq(1, length(values))
errors <- validate_type(values, "integer", ids)

expect_equal(nrow(errors), 4)

# url

values <- c(1, 2, "aaa", "http://", "c://test.me", "ftp://iobis.org/somefile.zip", "http://ipt.vliz.be/eurobis/archive.do?r=gbif_14227&v=1.1", TRUE)
ids <- seq(1, length(values))
errors <- validate_type(values, "url", ids)

expect_equal(nrow(errors), 6)
