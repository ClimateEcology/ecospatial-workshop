---
title: "EcoSpatial Workshop"
author: "Heather Grab, Kevin Li, Sarah Goslee"
date: "2024-10-03"
output: 
  html_document:
    toc: true
    toc_float: true
    number_sections: true
    code_folding: show
editor_options: 
  chunk_output_type: console
---

#Notes

* how much background do we want to provide? 
    + ex do we need to explain what a raster is?


# Workshop Outline {-}
This workshop is designed to introduce users to the new beeshiny R shiny application. 

beeshiny can be used to query data commonly used when modeling the environemental drivers of species' or commmunity responses. beeshiny was originally build as a companion to [Beescape](https://beescape.psu.edu/). 

beeshiny allows users to extract:

* climate data: monthly precipitation, min, and max temperature from PRISM
* crop land covers: from the NASS CropLand Data Layer
* beescape indices: spring forage, summer forage, fall forage, nesting, and pesticides

## Load packages {-}
There are a number of packages in R that are helpful in working with spatial data. For this workshop we will be using [sf](https://r-spatial.github.io/sf/) and [terra](https://rspatial.org/index.html). 
For data wrangling and visualizations we will use `dplyr`, `ggplot2` and `tidyterra`. 

Because some spatial functions have the same names as dplyr functions it is helpful to load the spatial packages last. We can also use the `::` to specify the package for function calls. 

Unhash and use install.packages for any packages your may not already have installed
```{r packages, echo=TRUE, results='hide', message=FALSE}
library(dplyr)
library(ggplot2)
#install.packages("sf", dependencies = TRUE)
#install.packages("terra", dependencies = TRUE)
#install.packages("tidyterra", dependencies = TRUE)
library(sf)
library(terra)
library(tidyterra)
```


# Get raster data from beeshiny
Use beeshiny to download a CDL raster for any county in the US you would like for any year you want

## Working with raster data in R

## Read in raster data

Downloaded data from beeshiny is packaged as a zipped file called data.zip. Inside this file you should have a .tif file. The name indicates the data type, in this case CDL, the year and the FIPS code that corresponds to the county you selected. 

Move the .tif file into the /data folder in your ecospatial-workshop directory

The first thing we will do is use the `rast()` function to read the .tif file into R as a SpatRaster. NOTE: your CDL file may have a different year and a different number after the FIPS code. 

```{r create SpatRaster of cdl}
county_cdl <- rast("data/CDL_2021_FIPS_42027.tif") # <- replace the .tif file with your file name

county_cdl
```
 
An important attribute of spatial data are their Coordinate Reference System or CRS. This information tells us what model of the earth (ex WGS84 or NAD83) is being referenced as well as the units of the coordinates such as decimal degrees. 

Rasters downloaded from beeshiny inherit their CRS from the raster they were originally extracted from. 

Let's view the CRS for your county cdl:
```{r crs}
crs(county_cdl)
```
We can see that our CDL raster is using the North American Datum of 1983 as it's model for the shape of the earth. Our two-dimensional projection model of earth's 3d surface is Alber's Equal Area and the units of our coordinates are in meters. 

## Visualize raster data
We can visualize our county CDl raster using either base R plotting and terra 
```{r base}
plot(county_cdl)
```


or using ggplot2 and tidyterra
```{r ggplot}
ggplot() +
  geom_spatraster(data = county_cdl, aes(fill = Class_Names)) +
  scale_fill_grass_c()
```

## Reclass raster values

We can see from our plots that the CDL Class Names are stored as numeric values, these have no numeric meaning. They simply correspond to a land cover class. 
 
The values can be reclassified into their class names or into other values using the `classify()` function. 

### Reclass to spring floral resources map

We can reclassify the CDL into a map of floral resources using the values from [Koh et al. 2015](https://www.pnas.org/doi/abs/10.1073/pnas.1517685113). 

The table contains each CDL value, it's corresponding class name and the values for several indices. 

```{r read in koh table}
reclass_table <- read.csv("data/cdl_reclass_koh.csv")
head(reclass_table)
```

We will select just the columns corresponding to the CDL value and the spring floral resources to reclassify our county CDL and generate a map of spring floral resources across the county
```{r reclass to forage}
county_floral_sp <- classify(county_cdl,
                    reclass_table[,c("Class_Names",
                                     "floral_resources_spring_index")])

plot(county_floral_sp)
```

### Inspect raster values

Using the `values()` function we can inspect the distribution of spring floral values for your county 
```{r inspect cdl, warning=FALSE}
summary(values(county_floral_sp))
hist(values(county_floral_sp))
```
and look at at individual grid cell values. 
```{r inspect values}
values(county_floral_sp)[1:20]
```

### Reclass to named CDL classes

We can also reclassify the CDL to show it's land class names rather than the values. In this case we will use a differnt work flow by turing out raster into a categorical raster and then modifying the levels. 

First we will make our county raster categorical
```{r factor raster}
county_cdl_f <- as.factor(county_cdl)
```

Then we will get the current value labels using the `levels` function 
```{r get levels}
county_levels <- as.data.frame(levels(county_cdl_f))
```

We will change our reclass table values to characters before merging them with a `left_join()` and replacing the old label column
```{r}
reclass_table_f <- reclass_table[,c("Class_Names","CLASS_NAME")] %>% mutate(Class_Names=as.character(Class_Names))

new_county_levels <- left_join(county_levels,reclass_table_f) %>% 
  mutate(Class_Names=CLASS_NAME) %>% 
  select(-CLASS_NAME)

```

Finally, we will replace the old levels scheme with the new one
```{r}
levels(county_cdl_f) <- new_county_levels

plot(county_cdl_f)
```
 
## Check your learning

1. Use beeshiny to download the CDL raster for Centre County Pa for any year you want

2. Move the CDL raster for Centre County to the /data folder in your ecospatial-workshop directory

3. Read the raster into R as a terra SpatRaster

4. Replace the CDL value codes with the land cover class names

```{r check learning raster, class.source = 'fold-hide', message=FALSE}
centre_cdl <- rast("data/CDL_2021_FIPS_42027.tif") 

#OR if beeshiny not working:

centre_cdl <- rast("data/backups/pa_centre_cdl_2021.tif") 
centre_cdl_f <- as.factor(centre_cdl)
centre_levels <- as.data.frame(levels(centre_cdl_f))
reclass_table_f <- reclass_table[,c("Class_Names","CLASS_NAME")] %>% mutate(Class_Names=as.character(Class_Names))
new_centre_levels <- left_join(centre_levels,reclass_table_f) %>% 
  mutate(Class_Names=CLASS_NAME) %>% 
  select(-CLASS_NAME)
levels(centre_cdl_f) <- new_centre_levels
```



# Working with point data

## Read in point data

```{r}

```


# Working with climate data



```{r}

```

