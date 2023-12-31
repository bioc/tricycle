% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/diagnose_totalumi.R
\name{diagnose_totalumi}
\alias{diagnose_totalumi}
\title{Diagnostic function for UMI based datasets}
\arguments{
\item{theta.v}{The cell cycle position - a numeric vector with range between 0 to 2pi.}

\item{totalumis}{The total UMIs number for each cell (without log2 transformation) - a numeric vector with the same length as \code{theta.v}.}

\item{span}{The parameter \eqn{\alpha} which controls the degree of smoothing. See \code{\link[stats]{loess}}. Default: 0.3}

\item{length.out}{The number of data points on the fitted lines to be output in the prediction data.frame. Default: 200}

\item{plot}{If \code{TRUE}, a \code{ggplot} scatter plot will be included in the output list. The figure will plot log2(totalumis) ~ theta.v 
with points and the fitted \code{\link[stats]{loess}} line. Default: TRUE}

\item{fig.title}{The title of the figure. Default: NULL}

\item{point.size}{The size of the point in scatter plot used by \code{\link[scattermore]{geom_scattermore}}. Default: 2.1}

\item{point.alpha}{The alpha value (transparency) of the point in scatter plot used by \code{\link[scattermore]{geom_scattermore}}. Default: 0.6}

\item{line.size}{The size of the fitted line, used by \code{\link[ggplot2]{geom_path}}. Default: 0.8}

\item{line.alpha}{The alpha value (transparency) of the fitted line, used by \code{\link[ggplot2]{geom_path}}. Default: 0.8}

\item{x_lab}{Title of x-axis. Default: "\eqn{\theta}"}

\item{y_lab}{Title of y-axis. Default: "log2(totalumis)"}

\item{...}{Other arguments input to \code{\link[stats]{loess}}.}
}
\value{
A diagnostic message and a list with the following elements:
\itemize{
  \item fitted - The fitted vaues on the loess line. A vector of the length of y.
  \item residual - The residual values from the fitted loess line, i.e. y - y.fit. A vector of the length of y.
  \item pred.df - The prediction \code{data.frame} by uniformly sampling theta from 0 - 2*pi. Names of variables: \code{x} and \code{y}. The number of rows equals to \code{length.out}.
  \item loess.o - The fitted loess object.
  \item rsquared -  The coefficient of determination R2. Calculated as 1 - residual sum of squares / the total sum of squares.
  \item fig - When \code{plot} is \code{TRUE}, a \code{ggplot} scatter plot object will be returned with other items.
}
}
\description{
The function will fit loess line for total UMIs numbers over
cell cycle position to diagnose non-fitting data, of which cells are not cycling.
}
\details{
This function fit a loess line between cell cycle position and 
log2 transformed total UMI number, as described in \code{\link{fit_periodic_loess}}.
If almost all cells are not cycling in a dataset, the estimated cell cycle positions
might be incorrect due to the shifted embedding center. Using the fact that the cell
should have highest total UMI number at the end of S phase and almost half of that 
highest total UMI number at M phase, we could detect those datasets which should 
be analysesd and intepreted carefully when using tricycle package. For such probelmatic
datasets, the defaul embedding center (0, 0) could lead to wrong inference. Thus, 
We don't rececommend using cell cycle position values if you get warnings from the 
\code{diagnose_totalumi} function.
}
\examples{
data(neurosphere_example, package = "tricycle")
neurosphere_example <- estimate_cycle_position(neurosphere_example)
diagnose.l <- diagnose_totalumi(neurosphere_example$tricyclePosition,
 neurosphere_example$TotalUMIs, plot = TRUE)
}
\seealso{
\code{\link{fit_periodic_loess}}.
}
\author{
Shijie C. Zheng
}
