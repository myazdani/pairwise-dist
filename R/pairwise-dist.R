#' Pairwise Distance Data Frame Computation
#'
#' This function takes a data frame and computes the distance between ever pair of rows.
#' @param key A unique identifier key for each row
#' @param df Numeric data frame (or matrix) to compute pairwise distances of rows
#' @param dist.matrix Defaults to FALSE. Set to TRUE if the provided data is a pre-computed distance matrix
#' @param method Defaults to "euclidean" same as R dist function method. Ignored if dist.matrix = TRUE
#' @param p Defaults to 2 same R dist function used in Minkowski distance. Ignored if dist.matrix = TRUE
#' @keywords row pairwise distances
#' @export
#' @examples
#' pairwise.dist()
#' x <- read.table(textConnection('t0 t1 t2 
#' aaa  0  1  0
#' bbb  1  0  1
#' ccc  1  1  1
#' ddd  1  1  0
#' ' ), header=TRUE)
#' pairwise.dist(key = rownames(x), df = x)
#' 
pairwise.dist <- function(key, df, dist.matrix = FALSE, method = "euclidean", p = 2){
  if(dist.matrix == FALSE){
    x = as.matrix(df)
    d = dist(x, method = method, p = p)
  } else { 
    d = as.dist(df) 
  }
  pairs = t(combn(key, 2))
  m <- data.frame(paste0("|", pairs[,1], " - ", pairs[,2], "|"), as.numeric(d))
  names(m) <- c("pairs", "distance")
  return(m)
}


#' Pairwise Distance Comparison between Target and Source data frames
#'
#' This function computes the row pairwise distances for a target and a source dataframe and merges them based on a unique id row key.
#' @param target.key A unique identifier key for each row target data frame row. Must match the row key for the source data frame
#' @param target.df Numeric target data frame (or matrix) to compute pairwise distances of rows
#' @param source.key A unique identifier key for each row source data frame row. Must match the row key for the target data frame
#' @param source.df Numeric source data frame (or matrix) to compute pairwise distances of rows
#' @param target.matrix Defaults to FALSE. Set to TRUE if the provided target data is a pre-computed distance matrix
#' @param source.matrix Defaults to FALSE. Set to TRUE if the provided source data is a pre-computed distance matrix
#' @param target.method Defaults to "euclidean" same as R dist function method. Ignored if target.matrix = TRUE
#' @param target.p Defaults to 2 same R dist function used in Minkowski distance. Ignored if target.matrix = TRUE
#' @param source.method Defaults to "euclidean" same as R dist function method. Ignored if source.matrix = TRUE
#' @param source.p Defaults to 2 same R dist function used in Minkowski distance. Ignored if source.matrix = TRUE
#' @keywords row pairwise distances correlation
#' @export
#' @examples
#' pairwise.dist()
#' x <- read.table(textConnection('t0 t1 t2 
#' aaa  0  1  0
#' bbb  1  0  1
#' ccc  1  1  1
#' ddd  1  1  0
#' ' ), header=TRUE)
#' target.source.diff(target.key = rownames(x), target.df = x, source.key = rownames(x), source.df = x)
#' 
target.source.diff = function(target.key, target.df, source.key, source.df, target.matrix = FALSE, source.matrix = FALSE, 
                              target.method = "euclidean", target.p = 2, source.method = "euclidean", source.p = 2) {
  target.pairs = pairwise.dist(key = target.key, df = target.df, dist.matrix = target.matrix, method = target.method, p = target.p)
  names(target.pairs)[2] = paste0(deparse(substitute(target.df)), ".distances")
  source.pairs = pairwise.dist(key = source.key, df = source.df, dist.matrix = source.matrix, method = source.method, p = source.p)
  names(source.pairs)[2] = paste0(deparse(substitute(source.df)), ".distances")
  result = merge(target.pairs, source.pairs, by = "pairs")
  return(result)
}