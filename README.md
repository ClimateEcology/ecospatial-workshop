
<!-- README.md is generated from README.Rmd. Please edit that file -->

# EcoSpatial Summit Workshop

## Install R and RStudio

In preparation for the EcoSpatial Summit Workshop, please download the
following programs:

- [R](https://cran.rstudio.com/)

- [RStudio](https://posit.co/download/rstudio-desktop/)

## Download this repository

To download the contents of this repository, click on the green “\<\>
Code” button and select “Download ZIP”. Unzip the downloaded zip file
and save the folder inside.

<figure>
<img src="README_files/figure-gfm/downloadcode.png?raw=true"
alt="Download code" />
<figcaption aria-hidden="true">Download code</figcaption>
</figure>

## Install packages

With R and RStudio installed, open the file
`ecospatial-workshops.Rproj`. This starts RStudio. Within the console
window in the lower left, run the following lines to install the R
packages needed for this workshop.

``` r
install.packages("dplyr", dependencies = TRUE)
install.packages("ggplot2", dependencies = TRUE)
install.packages("sf", dependencies = TRUE)
install.packages("terra", dependencies = TRUE)
install.packages("tidyterra", dependencies = TRUE)
install.packages("SPEI", dependencies = TRUE)
install.packages("tidyr", dependencies = TRUE)
```
