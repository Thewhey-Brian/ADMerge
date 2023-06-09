% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/adm_helper.R
\name{read_by_type}
\alias{read_by_type}
\title{Read files by type.}
\usage{
read_by_type(file_name, path)
}
\arguments{
\item{file_name}{The name of the file to be read.}

\item{path}{The path of the file to be read.}
}
\value{
The data from the specified file.
}
\description{
This function detects the file type and reads it. Currently supported file types are .xls, .xlsx, and .csv.
}
\examples{
\dontrun{
dat = read_by_type("example_file.xlsx", "example_path/")
}

}
