# This is the script for plotting data visualisations graphs

library(tidyverse)
library(geofacet)
library(urbnthemes)

here::i_am("scr/data_visualisations/data_visualisations.R")

library(here)

## Read datasets into R

em_state_tbl <- readr::read_csv(here::here("data","derived","num_employees_by_state.csv"))
op_state_tbl <- readr::read_csv(here::here("data","derived","num_operators_by_state.csv"))
hour_em_sector_tbl <- readr::read_csv(here::here("data","derived","num_of_employee_hour_by_sector_clean.csv"))
em_sector_tbl <- readr::read_csv(here::here("data","derived","num_employees_by_sector_clean.csv"))
op_sector_tbl <- readr::read_csv(here::here("data","derived","num_of_active_mines_by_sector_clean.csv"))


## Tidying dataset

# Tidying number of employee working hour by state dataset

tidy_state_em_tbl <- em_state_tbl %>% 
  tidyr::pivot_longer(cols = levels(factor(seq(1983,2021))), names_to ="year", values_to = "num")
tidy_state_em_tbl$year <- as.integer(tidy_state_em_tbl$year)

# Tidying number of activate mining operations by state dataset

tidy_op_state_tbl <- op_state_tbl %>% 
  tidyr::pivot_longer(cols = levels(factor(seq(1983,2021))), names_to ="year", values_to = "num")
tidy_op_state_tbl$year <- as.integer(tidy_op_state_tbl$year)

# Tidying number of employee working hour by sector dataset

tidy_hour_em_sector_tbl <- hour_em_sector_tbl %>% 
  tidyr::pivot_longer(cols = levels(factor(seq(1983,2021))), names_to ="year", values_to = "num")
tidy_hour_em_sector_tbl$year <- as.integer(tidy_hour_em_sector_tbl$year)

# Tidying number of employee by sector dataset

tidy_em_sector_tbl <- em_sector_tbl %>% 
  tidyr::pivot_longer(cols = levels(factor(seq(1983,2021))), names_to ="year", values_to = "num")
tidy_em_sector_tbl$year <- as.integer(tidy_em_sector_tbl$year)

# Tidying number of activate mining operations by sector dataset

tidy_op_sector_tbl <- op_sector_tbl %>% 
  tidyr::pivot_longer(cols = levels(factor(seq(1983,2021))), names_to ="year", values_to = "num")
tidy_op_sector_tbl$year <- as.integer(tidy_op_sector_tbl$year)


## Plot the graphs

# Plotting the number of employee working hour by sector dataset and save

set_urbn_defaults(style = "print")

emp_hour_plot <- ggplot(data=tidy_hour_em_sector_tbl, mapping=aes(year, num, col = Sector)) +
  geom_line() +
  scale_x_continuous(expand = expand_scale(mult = c(0.002, 0)), 
                     breaks = c(1983 + 0:8 * 5), 
                     limits = c(1982, 2022)) +
  scale_y_continuous(expand = expand_scale(mult = c(0, 0.002)), 
                     breaks = 0:8 * 50,
                     limits = c(0, 400)) +
  remove_ticks() +
  theme(legend.position="bottom", panel.grid=element_line(linetype = 'dotted'))+
  labs(x = "Year", y=NULL, title=NULL, caption=NULL) 

ur_em_hour <- urbn_plot(urbn_subtitle('  '),
    urbn_title('Number of employee hours for mine operators and contractors by sector and year, 1983 - 2021'),
    get_legend(emp_hour_plot),
    urbn_y_title('Number of Employee Hours (in millions)'),
    remove_legend(emp_hour_plot),
    urbn_source(text = "United States CDC NIOSH Mining Dataset: https://wwwn.cdc.gov/NIOSH-Mining/MMWC/Employee/Hours# ", width = 100),
    urbn_note(text = "The original dataset have seperated Coal operator and Coal contractor row, here we add this two rows together into the Coal operator & contractor row", width = 135),
    urbn_logo_text(),
    ncol=1, heights = c(0.5, 3.75, 3.25, 1, 35, 1.5, 3, 1))

urbn_save(here::here('outputs','em_hour_plot.png'), plot=ur_em_hour, height=5, dpi=650)

# Plotting the number of mine employee by sector dataset and save

emp_num_plot <- ggplot(data=as.data.frame(tidy_em_sector_tbl),mapping=aes(year, num, col = Sector)) +
  geom_line() +
  scale_x_continuous(expand = expand_scale(mult = c(0.002, 0)), 
                     breaks = c(1983 + 0:8 * 5), 
                     limits = c(1982, 2022)) +
  scale_y_continuous(expand = expand_scale(mult = c(0, 0.002)), 
                     breaks = 0:12 * 20000,
                     limits = c(10000, 210000)) +
  remove_ticks() +
  theme(panel.grid=element_line(linetype = 'dotted'))+
  labs(x = "Year", y=NULL, title=NULL, caption=NULL) 

ur_num_em <- urbn_plot(urbn_subtitle('  '),
  urbn_title('Mine operator and independent contractor employees by sector, 1983 - 2021'),
  get_legend(emp_num_plot),
  urbn_y_title('Number of Employee'),
  remove_legend(emp_num_plot),
  urbn_source(text = "United States CDC NIOSH Mining Dataset: https://wwwn.cdc.gov/NIOSH-Mining/MMWC/Employee/Count?StartYear=1983&EndYear=2021", width = 100),
  urbn_note(text = "The original dataset have seperated Coal operator and Coal contractor row, here we add this two rows together into the Coal operator & contractor row", width = 135),
  urbn_logo_text(),
  ncol=1, heights = c(0.5, 3, 2.5, 1, 35, 2.5, 3, 1))

urbn_save(here::here('outputs','em_num_plot.png'), plot=ur_num_em, height=5, dpi=650)

# Plotting the number of activate mining operations by sector dataset and save

opt_num_plot <- ggplot(as.data.frame(tidy_op_sector_tbl), mapping=aes(year, num, col = Sector)) +
  geom_line() +
  scale_x_continuous(expand = expand_scale(mult = c(0.002, 0)), 
                     breaks = c(1983 + 0:8 * 5), 
                     limits = c(1982, 2022)) +
  scale_y_continuous(expand = expand_scale(mult = c(0, 0.002)), 
                     breaks = 0:10 * 750,
                     limits = c(0, 7500)) +
  remove_ticks() +
  theme(panel.grid=element_line(linetype = 'dotted'))+
  labs(x = "Year", y=NULL, title=NULL, caption=NULL) 

ur_opt_num <- urbn_plot(urbn_subtitle('  '),
  urbn_title('Number of active mines by sector and year, 1983 - 2021'),
  get_legend(opt_num_plot),
  urbn_y_title('Number of Mines'),
  remove_legend(opt_num_plot),
  urbn_source(text = "United States CDC NIOSH Mining Dataset: https://wwwn.cdc.gov/NIOSH-Mining/MMWC/Mine#", width = 100),
  urbn_logo_text(),
  ncol=1, heights = c(0.5, 2, 1, 1, 35, 1, 1))

urbn_save(here::here('outputs','opt_num_plot.png'), plot=ur_opt_num, height=5, dpi=650)

# Plotting the Active mining operations by state and year dataset and save

set_urbn_defaults(style = "print")

my_grid <- us_state_grid2[-51,] # Remove District of Columbia from grid which does not have any data related to

opt_state_plot <- ggplot(data=tidy_op_state_tbl)+
  geom_line(aes(x=year,y=num))+
  remove_ticks() +
  theme(panel.grid=element_line(linetype = 'dotted'), 
        plot.subtitle = element_text(family='Lato', size=8.5, face = "italic"),
        plot.caption = element_text(family='Lato', size=8, hjust = 0))+
  labs(x = "Year", y=NULL, 
       title='Number of active mining operations by state and year, 1983 - 2021',
       subtitle='Number of Mines',
       caption=bquote(bold("Source: ")~"United States CDC NIOSH Mining Dataset: https://wwwn.cdc.gov/NIOSH-Mining/MMWC/MineMap?Year=")) +
  facet_geo(~ state, grid = my_grid, scales = "free_y")+
  scale_x_continuous(breaks = c(1983, 2021), 
                     limits = c(1982, 2022))

ggsave(here::here('outputs','opt_state_plot.png'), plot=opt_state_plot, device='png',height=9, width=16, units='in', dpi=650)

# Plotting the number of mine employees by state and year dataset and save

state_em_plot <- ggplot(data=tidy_state_em_tbl)+
  geom_line(aes(x=year,y=num))+
  theme(panel.grid=element_line(linetype = 'dotted'), 
        plot.subtitle = element_text(family='Lato', size=8.5, face = "italic"),
        plot.caption = element_text(family='Lato', size=8, hjust = 0))+
  labs(x = "Year", y=NULL, 
       title='Number of mine employees by state and year, 1983 - 2021',
       subtitle='Number of Employees',
       caption=bquote(bold("Source: ")~"United States CDC NIOSH Mining Dataset: https://wwwn.cdc.gov/NIOSH-Mining/MMWC/MineMap?Year=")) +
  facet_geo(~ state, grid = my_grid, scales = "free_y")+
  scale_x_continuous(breaks = c(1983, 2021), 
                     limits = c(1982, 2022))

ggsave(here::here('outputs','state_em_plot.png'), plot=state_em_plot, device='png',height=9, width=17, units='in', dpi=650)
