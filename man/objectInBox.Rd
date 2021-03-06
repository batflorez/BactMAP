\name{objectInBox}
\alias{objectInBox}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Connect detected objects to detected cell meshes; turn all objects & cells in the same orientation for relative comparison.
}
\description{
ObjectInBox is a function based on spotsInBox - it returns a dataframe which has the same variables as the "object_relative" dataframe.
}
\usage{
objectInBox(objectdata, meshdata, mag = "No_PixelCorrection")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{objectdata}{
Object dataframe with at least the variables: "ob_x" & "ob_y" (object outline coordinates), "frame" and "obID" (object identifier).
}
  \item{meshdata}{
Mesh dataframe.
}
  \item{mag}{
Magnification converter (see \code{\link{pixels2um}}).
}
}

\value{
An object_relative dataframe (see \code{\link{object}}).
}

\author{
Renske van Raaphorst
}


\examples{
\dontrun{
#example data:

#download example datasets from https://veeninglab.com/f/example_datasets.zip

load("vanFL_meshWT.rda")

load("vanFL_objWT")

#these objects are already connected to cells. but no harm in re-doing:

WTbox <- objectInBox(vanFL_objWT, vanFL_meshWT, mag="100x_DVMolgen")
}
}

