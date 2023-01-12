library(jsonlite);
library(rio);
library(dplyr);

data0 <- jsonlite::fromJSON('https://services.arcgis.com/g1fRTDLeMgspWrYp/arcgis/rest/services/SAMHD_DailySurveillance_Data_Public/FeatureServer/0/query?where=1%3D1&outFields=*&returnGeometry=false&outSR=4326&f=json')
data1 <- data0$features$attributes %>% mutate(reporting_date = (reporting_date / 1000) %>% as.POSIXct(origin = '1970-01-01')) %>% subset(reporting_date >= '2020-03-19')


