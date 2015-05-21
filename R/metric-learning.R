#' Metric learning between source data and desired target
#'
#' This function computes the weighted metric between a source data frame and a desired target. 
#' @param target A vector (or single column data frame) that is the desired targets. 
#' @param df Numeric data frame where features are columns. 
#' @keywords row pairwise distances correlation
#' @export
#' @examples
#' metric.learning()
#' x <- read.table(textConnection('t0 t1 t2 
#' aaa  0  1  0
#' bbb  1  0  1
#' ccc  1  1  1
#' ddd  1  1  0
#' ' ), header=TRUE)
#' metric.learning(target = x$t0, df = x)
#' 
metric.learning = function(target, df){
  require(quadprog)
  target.diff = pairwise.squared.diff(target)
  colnames(target.diff) = "target"
  df.diff = pairwise.squared.diff(df)
  res = merge(target.diff, df.diff, by = "row.names")
  D.features = as.matrix(res[,-which(names(res) %in% c("Row.names", "target"))])
  desired.target = as.matrix(res[,"target"])
  Dmat = t(D.features)%*%D.features
  dvec = t(desired.target)%*%D.features
  Amat = diag(1, ncol(D.features))
  metric = solve.QP(Dmat, dvec, Amat)
  return(metric$solution)
}


#' Returns the pairwise differences for each componeted of a data frame and squares every element 
#' @param target A vector (or single column data frame) that is the desired targets. 
#' @param df Numeric data frame where features are columns. 
#' @keywords row pairwise distances correlation
#' @export
#' @examples
#' metric.learning()
#' x <- read.table(textConnection('t0 t1 t2 
#' aaa  0  1  0
#' bbb  1  0  1
#' ccc  1  1  1
#' ddd  1  1  0
#' ' ), header=TRUE)
#' pairwise.squared.diff(target = x$t0, df = x)
#' 
pairwise.squared.diff = function(df, desired.key = TRUE){
  if(class(df) != "data.frame"){
    df = as.data.frame(df)
  }
  indx = as.data.frame(combn(c(1:nrow(df)), 2))
  take.diff = function(x){
    row.diff = as.data.frame(df[x[1], ] - df[x[2],])
    row.names(row.diff) = paste(x[1], "-", x[2])
    return(row.diff)
  }
  res = lapply(indx, take.diff)
  res = do.call(rbind,res)
  row.names(res) = sapply(indx, FUN = function(x) paste(x[1], "-", x[2]))
  return(res**2)
}
