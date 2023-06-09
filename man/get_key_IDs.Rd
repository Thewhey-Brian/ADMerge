% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/adm_helper.R
\name{get_key_IDs}
\alias{get_key_IDs}
\title{Get full list of IDs}
\usage{
get_key_IDs(dict_src)
}
\arguments{
\item{dict_src}{A data frame containing information on the data files and their variables, potential ID and DATE variables, and merge options.}
}
\value{
A data frame containing all possible IDs across multiple data files.
}
\description{
This function creates a data frame containing all possible IDs across multiple data files.
It uses the source table generated by the 'get_src_table' function to identify potential ID variables in each data file
and merge them into a single data frame.
}
\examples{
\dontrun{
get_key_IDs(dict_src)
}

}
