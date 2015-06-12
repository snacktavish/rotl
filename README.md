
[![Build Status](https://travis-ci.org/fmichonneau/rotl.svg)](https://travis-ci.org/fmichonneau/rotl)
[![Coverage Status](https://coveralls.io/repos/fmichonneau/rotl/badge.svg)](https://coveralls.io/r/fmichonneau/rotl)

# An R interface to Open Tree API

This is the bleedingly-Alpha developmental version of an R package wrapping the
Open Tree of Life data APIs, which being developed as part of the
[NESCENT/OpenTree/Arbor
hackathon](http://blog.opentreeoflife.org/2014/06/11/apply-for-tree-for-all-a-hackathon-to-access-opentree-resources/).

Check out the sister repos for
[Python](https://github.com/OpenTreeOfLife/opentree-interfaces/tree/master/python)
and [Ruby](https://github.com/SpeciesFileGroup/bark).

##Installation
If you want to play with these functions you can, via
[devtools](https://github.com/hadley/devtools). `rotl` uses [rncl](https://github.com/fmichonneau/rncl) to parse trees, so you first need to install that package, which is avaliable from CRAN or github:



`rotl` uses [rncl](https://github.com/fmichonneau/rncl) to parse trees, so you
first need to install that package. You can install the version available on
CRAN (recommended):


```r
install.packages("rncl")
```

(or the latest version available on github: `{r, eval=FALSE} devtools::install_github("fmichonneau/rncl")`).


```r
library(devtools)
install_github("fmichonneau/rotl")
```

## Vignette

For the time being a [small vignette lives here](http://dwinter.github.io/rotl-vignette/)

## Simple examples

Note: the library is still in active development and behaviour of the following
functions may well change in the future:

### Get a little bit of the big Open Tree tree

First find ott ids for a set of names:


```r
library(rotl)
apes <- c("Pan", "Pongo", "Pan", "Gorilla", "Hylobates", "Hoolock", "Homo")
(resolved_names <- tnrs_match_names(apes))
```

```
##   search_string                             unique_name approximate_match
## 1           pan      Pan (genus in subfamily Homininae)             FALSE
## 2         pongo     Pongo (genus in subfamily Ponginae)             FALSE
## 3           pan      Pan (genus in subfamily Homininae)             FALSE
## 4       gorilla                                 Gorilla             FALSE
## 5     hylobates Hylobates (genus in family Hylobatidae)             FALSE
## 6       hoolock                                 Hoolock             FALSE
## 7          homo                                    Homo             FALSE
##   ott_id number_matches is_synonym is_deprecated
## 1 417957              2      FALSE         FALSE
## 2 417949              2      FALSE         FALSE
## 3 417957              2      FALSE         FALSE
## 4 417969              3      FALSE         FALSE
## 5 166552              1      FALSE         FALSE
## 6 712902              1      FALSE         FALSE
## 7 770309              1      FALSE         FALSE
```
Now get open tree to return a tree with just those tips.



```r
tr <- tol_induced_subtree(ott_ids=resolved_names$ott_id)
plot(tr)
```

![plot of chunk get_tr](http://i.imgur.com/yCYhPrK.png) 


### Find trees focused on my favourite taxa


```r
furry_studies <- studies_find_studies(property="ot:focalCladeOTTTaxonName", value="Mammalia")
( furry_ids <- unlist(furry_studies$matched_studies) )
```

```
## ot:studyId 
##  "pg_2550"
```

### Get a specific study tree

```r
library(ape)
furry_metadata <-get_study_meta(2647)
furry_metadata$nexml$treesById
```

```
## $trees2647
## $trees2647$treeById
## $trees2647$treeById$tree6170
## NULL
## 
## $trees2647$treeById$tree6169
## NULL
## 
## 
## $trees2647$`^ot:treeElementOrder`
## $trees2647$`^ot:treeElementOrder`[[1]]
## [1] "tree6169"
## 
## $trees2647$`^ot:treeElementOrder`[[2]]
## [1] "tree6170"
## 
## 
## $trees2647$`@otus`
## [1] "otus2647"
```

```r
furry_tr <- get_study_tree(study_id="2647", tree_id="tree6169")
plot(furry_tr)
```

![plot of chunk tree](http://i.imgur.com/t1zecQb.png) 

### Code of Conduct

Please note that this project is released with a
[Contributor Code of Conduct](CONDUCT.md). By participating in this project you
agree to abide by its terms.
