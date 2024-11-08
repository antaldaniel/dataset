#' @title Get / Set a variable label
#' @description
#' See \code{haven::\link[haven:var_label]{var_label}} for details.
#'
#' @name var_label
#' @rdname var_label
#' @keywords internal
#' @export
#' @importFrom labelled var_label
#' @param x a vector or a data.frame
#' @param value a character string or `NULL` to remove the label
#'  For data frames, with `var_labels()`, it could also be a named list or a
#'  character vector of same length as the number of columns in `x`.
NULL

#' @rdname var_label
#' @export
var_label.haven_labelled_unit <- function(x, ...) {
  attr(x, "label", exact = TRUE)
}

#' @rdname var_label
#' @param unlist for data frames, return a named vector instead of a list
#' @param null_action for data frames, by default `NULL` will be returned for
#' columns with no variable label. Use `"fill"` to populate with the column name
#' instead, `"skip"` to remove such values from the returned list, `"na"` to
#' populate with `NA` or `"empty"` to populate with an empty string (`""`).
#' @param recurse if `TRUE`, will apply `var_label()` on packed columns
#' (see [tidyr::pack()]) to return the variable labels of each sub-column;
#' otherwise, the label of the group of columns will be returned.
#' @importFrom labelled var_label
#' @export
var_label.dataset_df <- function(x,
                                 unlist = FALSE,
                                 null_action =
                                   c("keep", "fill", "skip", "na", "empty"),
                                 recurse = FALSE,
                                 ...) {
  if (recurse) {
    r <- lapply(
      x,
      var_label_no_check,
      unlist = unlist,
      null_action = null_action,
      recurse = TRUE
    )
  } else {
    r <- lapply(x, label_attribute)
  }

  null_action <- match.arg(null_action)

  if (null_action == "fill") {
    r <- mapply(
      function(l, n) {
        if (is.null(l)) n else l
      },
      r,
      names(r),
      SIMPLIFY = FALSE
    )
  }

  if (null_action == "empty") {
    r <- lapply(
      r,
      function(x) {
        if (is.null(x)) "" else x
      }
    )
  }

  if (null_action == "na") {
    r <- lapply(
      r,
      function(x) {
        if (is.null(x)) as.character(NA) else x
      }
    )
  }

  if (null_action == "skip") {
    r <- r[!sapply(r, is.null)]
  }

  if (unlist) {
    r <- lapply(
      r,
      function(x) {
        if (is.null(x)) "" else x
      }
    )
    r <- base::unlist(r, use.names = TRUE)
  }

  r
}

#`var_label<-.haven_labelled_unit` <- function(x, value) {
#  set_var_labels(x, value)
#}


get_var_labels <- function(x) UseMethod("get_var_labels")
set_var_labels <- function(x) UseMethod("set_var_labels")

#' @export
get_var_labels.dataset_df <- function(dataset) {
  attr(dataset, "var_labels")
}

#' @export
set_var_labels <- function(dataset, var_labels) {

  var_label_list <- list()
  var_label_list <- lapply(colnames(dataset), function(i) i)
  names(var_label_list) <- colnames(dataset)

  for (rn in which(names(var_label_list) %in% names(var_labels))) {
    var_label_list[[rn]] <- var_labels[[which(names(var_label_list)[rn]==names(var_labels))]]
  }

  attr(dataset, "var_labels") <- var_label_list

  dataset
}

#' @keywords internal
set_label_attribute <- function(x, value) {
  if ((!is.character(value) && !is.null(value)) || length(value) > 1) {
    stop(
      "`unit` should be a single character string or NULL",
      call. = FALSE,
      domain = "R-dataset"
    )
  }
  attr(x, "label") <- value
  x
}

#' @rdname var_label
#' @export
`var_label<-` <- set_label_attribute
