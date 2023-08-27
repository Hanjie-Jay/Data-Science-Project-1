# 02242799 Data Science project 1

## A short description of what the project is about

- Aim 1: Selecting and gathering data from [CDC webpage about Mining](https://wwwn.cdc.gov/niosh-mining/MMWC#disasters)
- Aim 2: Cleaning the data using `R` to satisfy the need for data visualisations
- Aim 3: Visualising the data using `R` by plotting graphs and write a short article to describe the graph

## The version information about `R`, the OS and attached packages are shown below:
```
R version 4.2.1 (2022-06-23)
Platform: aarch64-apple-darwin20 (64-bit)
Running under: macOS Ventura 13.1

Matrix products: default
LAPACK: /Library/Frameworks/R.framework/Versions/4.2-arm64/Resources/lib/libRlapack.dylib

locale:
[1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
 [1] roxygen2_7.2.3   urbnthemes_0.0.2 geofacet_0.2.0   here_1.0.1      
 [5] rvest_1.0.3      forcats_0.5.2    stringr_1.5.0    dplyr_1.0.10    
 [9] purrr_1.0.1      readr_2.1.3      tidyr_1.3.0      tibble_3.1.8    
[13] ggplot2_3.4.0    tidyverse_1.3.2 
```

**Please set the working directory to this project file in `R` to reproduce this project.** Using the same `R` and packages version, as shown above, is strongly recommended.

## The code and analysis are structured as follows:

### [data/](/data/) folder

This directory contains 2 folders ([raw/](/data/raw/) & [derived/](/data/derived/)) that contain all raw and derived data sets. Further informaton can be found in [`metadata.md`](./data/raw/metadata.md) and [`cleandata.md`](./data/derived/cleandata.md).

### [outputs/](/outputs/) folder

This directory contains the output of 5 data visualisation graphs generated using the R code in [data_visualisations](/scr/data_visualisations/) folder with the [derived data](/data/derived/).

### [reports/](/outputs/) folder

This directory contains the [`submision.pdf`](/reports/02242799-submission.pdf) and its source `.tex` file [`submission.tex`](/reports/02242799-submission.tex) which use some of the [data visualisation graph](/outputs/) with corresponding analyses. 

### [scr/](/scr/) folder

This directory contains 3 folders ([data_cleaning](/scr/data_cleaning/), [data_visualisations](/scr/data_visualisations/) & [web_scraping](/scr/web_scraping/)). More information can be found in [source_code.md](/scr/source_code.md).

### [`note-to-editor.md`](/notes-to-editor.md) file 

This file contain a reflective summary of my submission as require.

## Future research direction

- In the submission, we use only 2 of the 5 [data visualisations](/outputs/). We can have a deeper analysis of the 3 visualisations that are not used.

- In the [`get_raw_data.R`](/scr/web_scraping/get_raw_data.R) file, we mainly use 1 of the 3 functions. In the future, we can use the 2 functions to receive data from specified groups and do analysis based on it.

- Our project focuses on visualising data without using any model to predict or analyse the data. In the future, we can use different models to analyse the data.
