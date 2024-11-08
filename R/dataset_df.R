#' @title Create a new dataset_df object
#' @param reference A list of bibliographic references and descriptive metadata
#' about the dataset as a whole.
#' @param var_labels The long, human readable labels of each variable.
#' @param units The units of measurement for the measured variables.
#' @param ... The vectors (variables) that should be included in the dataset.
#' @return A dataset_df object with rich metadata.
#' @import vctrs
#' @import pillar
#' @export
# User constructor
dataset_df <- function(reference=NULL, var_labels=NULL, units=NULL, ...) {

  dots <- list(...)

  sys_time <- Sys.time()
  year <- substr(as.character(sys_time),1,4)

  if(is.null(reference)) {
    reference <- list(title="Untitled Dataset",
                     author="Unknown Author")
  }

  if(is.null(reference$year)) reference$year <- year

  reference
  dataset_bibentry <- create_bibentry(reference)

  new_my_tibble(tibble::tibble(...),
                dataset_bibentry=dataset_bibentry)
}

# Developer constructor
#' @importFrom tibble new_tibble
#' @keywords internal
new_my_tibble <- function(x,
                          dataset_bibentry = NULL,
                          var_labels = NULL) {
  stopifnot(is.data.frame(x))
  tmp <- tibble::new_tibble(
    x,
    dataset_bibentry = dataset_bibentry,
    class = "dataset_df",
    nrow = nrow(x)
  )

  set_var_labels(tmp, var_labels = var_labels)

}

#' @rdname dataset_df
#' @export
print.dataset_df <- function(x, ...) {

  dataset_bibentry <- get_bibentry(x)

  author_person <- dataset_bibentry$author
  year          <- dataset_bibentry$year
  title         <- dataset_bibentry$title

  if (inherits(author_person, "persont")) {
    print_name <- ""
    if (!is.null(author_person$family)) print_name <- paste0(author_person$family, ", ")
    if (!is.null(author_person$given))  print_name <- paste0(print_name, author_person$given, ": ")
  } else if (is.character(attr(x, "person"))) {
    print_name <- paste0(attr(x, "person"), ": ")
  } else { print_name = ""}

  #if(!is.null(title)) {
  #  print_title <- title
  #} else { print_title: "A dataset"}

  #cat(print_name)
  #cat(print_title)
  if (!is.null(year)) {
    #cat(paste0(" (", substr(as.character(year), 1,4), ")"))
  }
  print(get_bibentry(x), "text")
  vr_labels <- vapply(attr(x, "var_labels"), function(x) x, character(1))
  cli::cat_line(format(x)[-1])
}

#' @importFrom vctrs df_list
#' @export
#dataset_df <- function(...) {
#  data <- df_list(...)
#  new_dataset(data)
#}

#' @export
tbl_sum.dataset_df <- function(x, ...) {
  NextMethod()
}

#' @export
summary.dataset_df <- function(object, ...) {
  print(get_bibentry(object), "text")
  NextMethod()
}

#' @rdname dataset_df
#' @export
is_dataset_df <- function(x) {
  inherits(x, "dataset_df")
}

#' @rdname dataset_df
#' @export
names.dataset_df <- function(x) {
  should_inform <- rlang::env_is_user_facing(rlang::caller_env())
  if (should_inform) {
    cli::cli_inform(c(
      `!` = "The {.fn names} method of {.cls dataset_df} is for internal use only.",
      i = "Did you mean {.fn colnames}?"
    ))
  }
  NextMethod("names")
}

