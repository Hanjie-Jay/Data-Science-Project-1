# This is the script for obtaining two raw datasets by web scrapping

# Warning: The url may changed! The latest check for the availability of the url in this file was at 2023-2-16

library(tidyverse)
library(rvest)
library(roxygen2)

here::i_am("scr/web_scraping/get_raw_data.R")

library(here)

#' The function for scraping table from web and stored it as a csv file
#'
#' @param url The url of the web that we want to scrap.
#' @param tbNum 
#' @param filename The name of the file that we want to store the downloaded data with its directory.
#'
#' @return No return but writing the csv file to the given directory 
#' @examples
#' getData('https://wwwn.cdc.gov/NIOSH-Mining/MMWC/Employee/Count?StartYear=1983&EndYear=2021&SelectedMineType=', here::here("data","raw",'num_employees_by_sector.csv'))
#' 
getData <- function(url, filename, tbNum=1) {
  tbl <- url %>%
    read_html() %>%
    html_elements("table") %>%
    html_table()
  # write the csv file
  write_csv(tbl[[tbNum]], filename)
}


## Get the Mine operator employees by region dataset

# Without filtering the data

url1 <- 'https://wwwn.cdc.gov/NIOSH-Mining/MMWC/EmployeeMap/Table?Year='

for (year in levels(factor(seq(1983,2021)))) {
  url = paste0(url1,year)
  getData(url, paste0(here::here("data","raw", "num_employees_by_region","num_employees_by_region_"),year,".csv"))
  print(paste0("Finishing downloaded data from ",year)) # plot the progress
}


# With filtering the type and commodity

#' The function for scraping table from CDC NIOSH-Mining employee map dataset that can select different type of data and stored it as a csv file
#'
#' @param year The year of the data that we want to scrap.
#' @param SelectedMineType The type of the mining that we want. NA for all, Type=0 for surface, Type=1 for underground.
#' @param tbNum 
#' @param SelectedCommodity The type of commodity that we want.  1,2,3,4,5 follows from website
#'
#' @return No return but writing the csv file to the given directory 
#' @examples
#' getData_group_em(2021,1,'1%2C2%2C5')
#' getData_group_em(2011,0,'1%2C3%2C4')
#' 
getData_group_em <- function(year, SelectedMineType=NA, SelectedCommodity="1%2C2%2C3%2C4%2C5", tbNum=1) {
  raw_url <- 'https://wwwn.cdc.gov/NIOSH-Mining/MMWC/EmployeeMap/Table?Year=' # the source url
  url <- paste0(raw_url,year)   # concate year into url
  if (is.na(SelectedMineType)) {
    url <- paste0(url,"&SelectedCommodity=",SelectedCommodity)
    filename <- paste0("./num_operators_",year,"_all_",".csv")
  } else {
    url <- paste0(url,"&SelectedMineType=",SelectedMineType,"&SelectedCommodity=",SelectedCommodity)
    filename <- paste0(here::here("data","raw","num_employees_by_region","num_employees_by_region_"),year,"_",as.character(SelectedMineType),"_",SelectedCommodity,".csv")
  }
  # write the csv file
  tbl <- url %>%
    read_html() %>%
    html_elements("table") %>%
    html_table()
  write_csv(tbl[[tbNum]], filename)
  cat("Finishing downloaded data of",year," with SelectedMineType=",SelectedMineType," and SelectedCommodity=",SelectedCommodity,"\n",filename) # plot the progress
}

# getData_group_em(2021,1,'1%2C2%2C5')


## Get the active mining operations by region dataset

# Without filtering the data

url2 <- 'https://wwwn.cdc.gov/NIOSH-Mining/MMWC/MineMap/Table?Year='

for (year in levels(factor(seq(1983,2021)))) {
  url = paste0(url2,year)
  getData(url, paste0(here::here("data","raw", "num_operators_by_region","num_operators_by_region_"),year,".csv"))
  print(paste0("Finishing downloaded data from ",year)) # plot the progress
}


# With filtering the type and commodity

#' The function for scraping table from CDC NIOSH-Mining activate mining operation map dataset that can select different type of data and stored it as a csv file
#'
#' @param year The year of the data that we want to scrap.
#' @param SelectedMineType The type of the mining that we want. NA for all, Type=0 for surface, Type=1 for underground.
#' @param tbNum 
#' @param SelectedCommodity The type of commodity that we want.  1,2,3,4,5 follows from website
#'
#' @return No return but writing the csv file to the given directory 
#' @examples
#' getData_group_ope(2021,1,'1%2C2%2C5')
#' getData_group_ope(2011,0,'1%2C3%2C4')
#' 
getData_group_ope <- function(year, SelectedMineType=NA, SelectedCommodity="1%2C2%2C3%2C4%2C5", tbNum=1) {
  # Type=0 for surface, Type=1 for underground
  # Commodity 1,2,3,4,5 follows from websit
  raw_url <- 'https://wwwn.cdc.gov/NIOSH-Mining/MMWC/MineMap/Table?Year=' # the source url
  url <- paste0(raw_url,year)   # concate year into url
  if (is.na(SelectedMineType)) {
    url <- paste0(url,"&SelectedCommodity=",SelectedCommodity)
    filename <- paste0("./num_operators_",year,"_all_",".csv")
  } else {
    url <- paste0(url,"&SelectedMineType=",SelectedMineType,"&SelectedCommodity=",SelectedCommodity)
    filename <- paste0(here::here("data","raw","num_operators_by_region","num_operators_by_region_"),year,"_",as.character(SelectedMineType),"_",SelectedCommodity,".csv")
  }
  # write the csv file
  tbl <- url %>%
    read_html() %>%
    html_elements("table") %>%
    html_table()
  write_csv(tbl[[tbNum]], filename)
  cat("Finishing downloaded data of",year," with SelectedMineType=",SelectedMineType," and SelectedCommodity=",SelectedCommodity,"\n",filename)
}

# getData_group_ope('2021',SelectedMineType=1, SelectedCommodity='1%2C3%2C5')


## Get the data of number of employee working hour by sector

getData('https://wwwn.cdc.gov/NIOSH-Mining/MMWC/Employee/Hours#', here::here("data","raw",'num_of_employee_hour_by_sector.csv'))


## Get the data of number of active mines by sector and year

getData('https://wwwn.cdc.gov/NIOSH-Mining/MMWC/Mine#', here::here("data","raw",'num_of_active_mines_by_sector.csv'))


## Get the data of number mine operator and independent contractor employees by sector

getData('https://wwwn.cdc.gov/NIOSH-Mining/MMWC/Employee/Count?StartYear=1983&EndYear=2021&SelectedMineType=', here::here("data","raw",'num_employees_by_sector.csv'))
