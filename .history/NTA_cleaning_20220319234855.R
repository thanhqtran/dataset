#loading library
library(dplyr)
library(tidyverse)
require(dplyr)
require(tidyverse)
#importing data
path_nta <- 'path_to_nta_data'
path_life <- 'https://raw.githubusercontent.com/thanhqtran/dataset/main/un_demography/life_edu.csv'
# import nta data
nta_world_raw <- read.csv(path_nta)
nodata <- c('Taiwan') #no data of education index available
nta_world <- subset(nta_world_raw, !(Country %in% nodata))
# normalized labor income
nta_world_scaled <- nta_world %>%
  group_by(Country, Year) %>%
  mutate(norm_income = scale(Labor.Income)) %>%
  mutate(income = norm_income - norm_income[1])
nta_world_scaled$id <- paste(nta_world_scaled$Country, nta_world_scaled$Year, sep="-")
# merge normalized nta data with life expectancy and education
lifedu_world <- read.csv(path_life)
nta_world_joint <- nta_world_scaled %>%
  left_join(lifedu_world, by = c('Country','Year'))
nta_world_joint$epsilon = as.numeric(as.character(nta_world_joint$epsilon))
nta_world_new <- subset(nta_world_joint)
nta_asia_new <- subset(nta_world_new, Region=='Asia')
selection <- c('Vietnam-2008','Thailand-2004','China-2002','South Korea-2000','Japan-2004')
nta_selected <- subset(nta_asia_new, id %in% selection)
# write to csv
n <- 5
data <- nta_selected %>%
  group_by(Country, Year) %>%
  group_by(mean = (row_number() - 1) %/% n) %>%
  mutate(AgeGroup = paste("Age", Age[row_number()],"-", Age[row_number()]+4 )) %>%
  mutate(meanIncome_norm = mean(income)) %>%
  filter(row_number() %% 5 == 1)
data