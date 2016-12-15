#' Validate dataset.
#'
#' @param data
#' @param config
#' @return Validation report
#' @export
validate <- function(data, config) {

  errors <- data.frame(id = character(), column = character(), message = character())

  # iterate over column names in configuration
  for (column in names(config)) {

    # check if dataset has column
    if (column %in% names(data)) {

      # iterate over tests for column
      for (test in names(config[[column]])) {

        if (test != "if") {
          allowed_errors <- validate_any(data[[column]], test, config[[column]][[test]], data$occurrenceID)
          allowed_errors$column = column
          errors <- rbind(errors, allowed_errors)
        } else {
          # todo: conditional tests
          # https://github.com/inbo/data-validator/blob/master/examples/inboveg/dwc-measurementorfact.yaml
        }

      }
    }
  }

  return(errors)
}

#' Validate values with specific test.
#'
#' @param values Vector of values
#' @param test Test name
#' @param criteria Test criteria
#' @param ids Vector of ids
#' @return Errors data frame
#' @keywords internal
validate_any <- function(values, test, criteria, ids) {

  if (test == "allowed") {
    return(validate_allowed(values, criteria, ids))
  }

}

#' Validate allowed values.
#'
#' @param values Vector of values
#' @param allowed Vector of allowed values
#' @param ids Vector of ids
#' @return Errors data frame
#' @keywords internal
#' @export
validate_allowed <- function(values, allowed, ids) {
  errors <- NULL

  for (i in 1:length(values)) {
    if (!values[i] %in% allowed) {
      errors <- rbind(errors, data.frame(id = ids[i], message = paste0("unallowed value ", values[i])))
    }
  }

  return(errors);
}

#' Validate type.
#'
#' @param values Vector of values
#' @param type Allowed data type
#' @param ids Vector of ids
#' @return Errors data frame
#' @keywords internal
#' @export
validate_type <- function(values, type, ids) {
  errors <- NULL

  if (type == "integer") {
    for (i in 1:length(values)) {
      if (!grepl("^[-]?[0-9]+$", as.character(values[i]))) {
        errors <- rbind(errors, data.frame(id = ids[i], message = paste0(values[i], " is not an integer")))
      }
    }
  } else if (type == "url") {
    for (i in 1:length(values)) {
      if (!grepl("^(http|https|ftp)://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+$", as.character(values[i]))) {
        errors <- rbind(errors, data.frame(id = ids[i], message = paste0(values[i], " is not a url")))
      }
    }
  }


  return(errors);
}
