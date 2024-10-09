
<!-- README.md is generated from README.Rmd. Please edit that file -->

# EcoSpatial Summit Workshop

In preparation for the EcoSpatial Summit Workshop, please download the
following programs:

- [R](https://cran.rstudio.com/)

- [RStudio](https://posit.co/download/rstudio-desktop/)

## Load packages

There are a number of packages in R that are helpful in working with
spatial data. For this workshop we will be using `sf` and `terra`. For
data wrangling and visualizations we will use `dplyr`, `ggplot2` and
`tidyterra`.

| Name | Description | Link |
|:---|:---|:---|
| `dplyr` | Package that provides a ‘grammar’ of data manipulation in `R` | <https://dplyr.tidyverse.org/> |
| `ggplot2` | Package that provides a system for declaratively creating graphics | <https://ggplot2.tidyverse.org/> |
| `sf` | Package for manipulating 2-D geographic vector data | <https://r-spatial.github.io/sf/> |
| `terra` | Package for spatial data analysis | <https://rspatial.github.io/terra/> |
| `tidyterra` | Package for integrating objects from `terra` with the `dplyr` and `ggplot2` packages | <https://dieghernan.github.io/tidyterra/> |

Because some spatial functions have the same names as dplyr functions it
is helpful to load the spatial packages last. We can also use the `::`
to specify the package for function calls.

Unhash (remove the preceding `#`) and use install.packages for any
packages your may not already have installed

``` r
# install.packages("dplyr", dependencies = TRUE)
# install.packages("ggplot2", dependencies = TRUE)
# install.packages("sf", dependencies = TRUE)
# install.packages("terra", dependencies = TRUE)
# install.packages("tidyterra", dependencies = TRUE)

library(dplyr)
library(ggplot2)
library(sf)
library(terra)
library(tidyterra)
```
