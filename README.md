
<!-- README.md is generated from README.Rmd. Please edit that file -->

# EcoSpatial Summit Workshop

## Install R and RStudio

In preparation for the EcoSpatial Summit Workshop, please download the
following programs:

- [R](https://cran.rstudio.com/)

- [RStudio](https://posit.co/download/rstudio-desktop/)

## Download this repository

To download the contents of this repository, click on the green **\<\>
Code** button and select **Download ZIP**. Unzip the downloaded zip file
and save the folder to your computer.

<img src="README_files/figure/downloadcode.png?raw=true"
style="width:50.0%" />

## Install packages

With R and RStudio installed, open the file `ecospatial-workshops.Rproj`
in the downloaded folder. This starts RStudio. Within the console window
in the lower left, run the following lines to install the R packages
needed for this workshop.

``` r
install.packages("dplyr", dependencies = TRUE)
install.packages("ggplot2", dependencies = TRUE)
install.packages("sf", dependencies = TRUE)
install.packages("terra", dependencies = TRUE)
install.packages("tidyterra", dependencies = TRUE)
install.packages("SPEI", dependencies = TRUE)
install.packages("tidyr", dependencies = TRUE)
```
