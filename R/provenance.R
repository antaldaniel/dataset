#' @title Provenance
#' @param dataset A dataset created with \code{\link{dataset_df}}.
#' @return A string with N-Triple format provenance metadata
#' @examples
#' provenance(iris_dataset)
#' @export

provenance <- function(dataset) {
  prov <- attr(dataset, "prov")
  paste(prov, collapse = "\n")
}

#' @keywords internal
initialise_provenance <- function(dataset) {

  this_bibentry <- get_bibentry(dataset)

  prov <- n_triples(
    c(n_triple(this_bibentry$doi, "a", "http://purl.org/linked-data/cube#DataSet"),
      n_triple(get_orcid(ad), "a", "http://www.w3.org/ns/prov#Agent"),
      n_triple("10.5281/zenodo.6703764.", "a", "http://www.w3.org/ns/prov#SoftwareAgent")
      )
  )

  attr(dataset, "prov") <- prov

  dataset
}


