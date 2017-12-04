\name{spotsInBox}
\alias{spotsInBox}


\title{Put spots in boxes

}
\description{
Takes a dataframe containing Mesh x/y coordinates and a dataframe containing Spots/Object x/y coordinates and returns the relative localization of the Spots/Objects inside the meshes, and the relative coordinates of the meshes from the mid-point of each mesh, where the longest axis of the cell is horizontal in the x/y plane.
}
\usage{
spotsInBox(spotfile, MESH, Xs = "x", Ys = "y", Xm = "X", Ym = "Y")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{spotfile}{dataframe containing spot coordinates. Needs at least the columns \code{$frame, $x} and \code{$y}.Possible to define x/y column names in the function input arguments \code{Xs} and \code{Ys}.}
  \item{MESH}{dataframe containing mesh coordinates. Needs at least the columns \code{$frame, $cell, $x} and \code{$y}. Possible to define x/y column names in the function input arguments \code{Xm} and \code{Ym}.}
  \item{Xs}{column in dataframe \code{spotfile} containing the x-coordinates of the spots or object points. Default = "x".}
  \item{Ys}{column in dataframe \code{spotfile} containing the y-coordinates of the spots or object points. Default = "y".}
  \item{Xm}{column in dataframe \code{MESH} containing the x-coordinates of the mesh outline points. Default = "X".}
  \item{Ym}{column in dataframe \code{MESH} containing the y-coordinates of the mesh outline points. Default = "Y".}
}

\details{
%%  ~~ If necessary, more details than the description above ~~
}

\value{
A list of two data frames:

\code{REP:}
\item{$x}{x-coordinate of the spot or object point (same as original dataframe)}
\item{$y}{y-coordinate of the spot or object point (same as original dataframe)}
\item{$cell}{identifies the cell the spot/object point belongs to}
\item{$frame}{frame number of original image stack}
\item{$max.width}{maximum cell width}
\item{$length}{length of the cell}
\item{$L}{relative location of the spot/object point to the length axis of the cell}
\item{$D}{relative location of the spot/object point to the width axis of the cell}

\code{Mfull:}
\item{$X}{x-coordinate of the mesh contour point (same as original dataframe)}
\item{$Y}{y-coordinate of the mesh contour point (same as original dataframe)}
\item{$cell}{identifies the cell}
\item{$frame}{frame number of the original image stack}
\item{$max.width}{maximum cell width}
\item{$length}{length of the cell}
\item{$X_rot}{x-coordinate of the mesh point when the cell is turned with the length axis horizontally, midpoint at coordinate (0,0)}
\item{$Y_rot}{y-coordinate of the mesh point when the cell is turned with the length axis horizontally, midpoint at coordinate (0,0)}

}
\references{

}
\author{
Renske van Raaphorst
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{shotGroups}}

\code{\link{pnt.in.poly}}

}
\examples{
##get spot data from ISBatch
spots <- shinyspots::extr.ISBatch(file.choose())

##get mesh data from Oufti
mesh <- shinyspots::extr.Oufti(file.choose())$mesh

##get relative spot and mesh locations
outlist <- spotsInBox(spots, mesh, Xm="x", Ym="y")

}
