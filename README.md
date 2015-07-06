# pairwiseDist R package

This is the R package repository for computing pairwise differences between a set of source and target vectors. The details of the method are described in the forthcoming paper by Yazdani, Chow, and Manovich.

## Installation

pairwise-dist was built on R version 3.2.0 (2015-04-16). First, install and load the devtools package. From within the R console, enter:

```
install.packages("devtools")
library("devtools")
```

Next install the pairwiseDist package again from the R console by entering:

```
install_github('myazdani/pairwise-dist')
library(pairwiseDist)
```

## Usage

The following functions are loaded with the package (see each individual help function for details on usage): 

- pairwise.dist: compute the pairwise distances of a matrix or data frame
- target.source.diff: compute the pairwise differences of a set target and source feature vectors. Joins the target and source differences. Can optionally provide pre-computed distance matrices. 
- metric.learning: learn the optimal metric for computing pairwise differences between source and target feature vectors. Uses the quadprog package to solve the Quadratic Program.
- pairwise.squared.diff: raw pairwise square differences of feature vectors. 

For example, target.source.diff can be used as:

```
pairwise.dist()
x <- read.table(textConnection('t0 t1 t2
aaa  0  1  0
bbb  1  0  1
ccc  1  1  1
ddd  1  1  0
' ), header=TRUE)
target.source.diff(target.key = rownames(x), target.df = x, source.key = rownames(x), source.df = x)
```

The target.source.diff function can be used to visualize the pairwise differences between source and feature vectors. This function was used to create the visualization of the change of color distributions of art works and also the change of microbial ecology over time for a single patient. 

- Change of color distibutions in art works: https://plot.ly/~crude2refined/297
- Change in microbial distributions: https://plot.ly/~crude2refined/803


## Contributing

1. Fork it
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request

## History

Version 0.1

## Contributors

- Mehrdad Yazdani <myazdani@ucsd.edu>
- Jay Chow <jaychow0702@gmail.com>
- Lev Manovich <manovich.lev@gmail.com>


## License

The MIT License (MIT)

Copyright (c) 2015

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
