# R for Reproducible Scientific Analysis
# workshop 3: 2020-04-24
# https://pad.carpentries.org/2020-ucla-r
# http://swcarpentry.github.io/r-novice-gapminder/
# Gapminder Data: <<https://doi.org/10.25346/S6/WFC3KG>>

# Schedule
# 9:00 - 9:15 Zoom technical issues, Review
# 9:15 - 10:00 - Data slicing with dplyr - select, group_by, filter, summarize, mutate
# 10:00 - 10:30  - Break + Exercises
# 10:30 - 11:15 - Data manipulation and layout including pivot and merging
# 11:15 - 11:45 - Break + Exercises
# 11:45 - 12:00 - Wrap Up and feedback

# Key Combinations
#  New R script:   Cntl/Cmd + shift + n
#  Pipe symbol:    Cntl/Cmd + shift + m  

# Dataframe Manipulation with dplyr
# Functions in the dplyr package:
# select()   Selects columns from data
# mutate()  <- could be thought of as sort, creates NEW variables
# filter()
# groupby()  aggregates data
# summarize()  summary statistics
# arrange()    srots data

# if not installed
#install.packages("ggplot2")
#install.packages("plyr")
#install.packages("gapminder")
#install.packages('dplyr')

library(dplyr)
library(gapminder)
library(ggplot2)

gapminder<-read.csv(file="gapminder_data.csv",header=TRUE,sep=";")
read.csvgapminder_data <- read.csv("D:/work/LearnR/2020-ucla-r/gapminder_data.csv")
View(gapminder_data)

# Load your data
gapminder_data <- read.csv("gapminder_data.csv")

gapminder<-read.csv(file="gapminder_data.csv",header=TRUE,sep=",")


# Using select()
year_country_gdp <- select(gapminder, year, country, gdpPercap, lifeExp)


# Adding arrange()
sorted_data <- arrange(gapminder, desc(year))

sorted_data <- arrange(gapminder, desc(year), country)

# The Default is ascending
sorted_data <- arrange(gapminder, year)

# Piped from select to arrange
year_country_sorted <- gapminder %>% 
  select(year, country, gdpPercap, lifeExp) %>% 
  arrange(desc(year,country))


# Adding mutate()
# mutate() adds new variables and preserves existing ones; transmute() adds new variables and drops existing ones.

# Syntax: mutate(dataframe, new_variable=existing_var*something)

mutate(gapminder, age_rounded=round(lifeExp, 2))
year_country_sorted <- gapminder %>% 
  select(year, country, gdpPercap, lifeExp) %>% 
  arrange(desc(year,country)) %>% 
  mutate(age_rounded=round(lifeExp, 2))


# Using filter()
# == relational operator, is or is not

Year_country_gdp_euro <- gapminder %>%
  filter(continent == 'Europe')  %>%   
  select(year, country, gdpPercap)


# Using group_by() and summarize() - aggregate functions

str(gapminder)

str(gapminder %>%
      group_by(continent))
    
    
Gdp_by_continents <- gapminder %>%
      group_by(continent) %>%
      summarize(mean_gdp_percap = mean(gdpPercap))
    
Gapminder %>%
      group_by(continent) %>%
      summarize(
        mean_le = mean(lifeExp),
        min_le = min(lifeExp),
        max_le = max(lifeExp))
    

# Using count()

Gapminder %>%
  filter(year == 2002) %>%
  count(continent, sort=TRUE)



# Combining dply and ggplot2
library(ggplot2)

# Get the start letter of each country
starts.with <- substr(gapminder$country, start = 1, stop = 1)
# Filter countries that start with "A" or "Z"
az.countries <- gapminder[starts.with %in% c("A", "Z"), ]
# Make the plot
ggplot(data = az.countries, aes(x = year, y = lifeExp, color = continent)) +
  geom_line() + facet_wrap( ~ country)


gapminder %>%
  # Get the start letter of each country
  mutate(startsWith = substr(country, start = 1, stop = 1)) %>%
  # Filter countries that start with "A" or "Z"
  filter(startsWith %in% c("A", "Z")) %>%
  # Make the plot
  ggplot(aes(x = year, y = lifeExp, color = continent)) +
  geom_line() +
  facet_wrap( ~ country)

gapminder %>%
  # Filter countries that start with "A" or "Z"
  filter(substr(country, start = 1, stop = 1) %in% c("A", "Z")) %>%
  # Make the plot
  ggplot(aes(x = year, y = lifeExp, color = continent)) +
  geom_line() +
  facet_wrap( ~ country)





