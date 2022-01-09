#Country classification
country_code <- read.csv("~/Documents/GitHub/macroeconomics-research/00_Database/country_code.csv")
url_IMF = 'https://www.imf.org/external/datamapper/FMEconGroup.xlsx'
url_WB = 'https://databank.worldbank.org/data/download/site-content/OGHIST.xls'
url_HDI = 'http://hdr.undp.org/sites/default/files/2020_statistical_annex_table_1.xlsx'
library(readxl)
#World Bank
OG2019 <- read_excel("Google Drive/1.1. GPEM Master/4th semester/thesis_1/OG2019.xlsx")
country_code$region <- OG2019$region[match(country_code$ISO_code_3,OG2019$code)]
country_code$WB_class_2019 <- OG2019$classification[match(country_code$ISO_code_3,OG2019$code)]
#IMF
IMFClass2019 <- read.csv("~/Google Drive/1.1. GPEM Master/4th semester/thesis_1/IMFClass2019.csv")
country_code$IMF_class_2019 <- IMFClass2019$classification[match(country_code$country,IMFClass2019$country)]
#HDI
HDIClass2019 <- read_excel("Google Drive/1.1. GPEM Master/4th semester/thesis_1/HDIClass2019.xlsx")
country_code$hdi <- HDIClass2019$hdi[match(country_code$country,HDIClass2019$country)]
country_code$life_exp <- HDIClass2019$life_exp[match(country_code$country,HDIClass2019$country)]
country_code$exp_yr_schooling <- HDIClass2019$life_exp[match(country_code$country,HDIClass2019$country)]
country_code$mean_yr_schooling <- HDIClass2019$mean_yr_schooling[match(country_code$country,HDIClass2019$country)]
#2017_PPP_USD
country_code$gni_pc <- HDIClass2019$gni_pc[match(country_code$country,HDIClass2019$country)]
country_code$HDI_class_2019 <- HDIClass2019$classification[match(country_code$country,HDIClass2019$country)]
write.csv(country_code, '/Users/thanhqtran/Documents/GitHub/macroeconomics-research/00_Database/210615_country_code.csv')
