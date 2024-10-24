
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Introduction to the **beeshiny** data app

This repository holds the material needed to recreate the workshop
introducing [**beeshiny**](https://beesuite.psu.edu/beeshiny/), which
was held at the [EcoSpatial Summit](https://ecospatialsummit.com/) on
Oct. 10-11, 2024. Beeshiny is a web-based tool that makes it easier to
access the land use, habitat quality, weather and climate data currently
featured in [Beescape](https://beescape.psu.edu/), another tool
developed by Penn State University. Beescape can be used by beekeepers,
gardeners, urban planners, growers, researchers, and land managers to
assess the quality of their landscapes for supporting bees and other
pollinators. Beeshiny is a researcher-focused complement to Beescape.

The workshop covered topics on how to use R to process GIS layers and
tabular outputs downloaded from the beehiny app. The instructions for
these tutorials are included as html files within the main repository
directory.

## Install R and RStudio

To run the content of this tutorial, please download the following
programs:

- [R](https://cran.rstudio.com/)

- [RStudio](https://posit.co/download/rstudio-desktop/)

## Download this repository

To download the contents of this repository, click on the green **\<\>
Code** button and select **Download ZIP**. Unzip the downloaded zip file
and save the folder to your computer.

<img src="README_files/figure/downloadcode.png?raw=true"
style="width:50.0%" />

## Tutorial instructions

Within the ‘*ecospatial-workshop*’ folder, tutorial instructions for
working with GIS data and tabular weather data are found in the files
‘*EcoSpatial_Workshop_GIS.html*’ and
‘*EcoSpatial_Workshop_Weather.html*’, respectively.

## Install packages

With R and RStudio installed, open the file
‘*ecospatial-workshop.Rproj*’ in the downloaded folder. This starts
RStudio. Within the console window in the lower left, run the following
lines to install the R packages needed for this workshop.

``` r
install.packages("dplyr", dependencies = TRUE)
install.packages("ggplot2", dependencies = TRUE)
install.packages("sf", dependencies = TRUE)
install.packages("terra", dependencies = TRUE)
install.packages("tidyterra", dependencies = TRUE)
install.packages("SPEI", dependencies = TRUE)
install.packages("tidyr", dependencies = TRUE)
```
