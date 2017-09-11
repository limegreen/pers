### Get Data 11 Sept 2017 ###

require(tidyverse)

#read in pharmacy data, remove potentially identifying variables, add source id variable "pharm"
pharm.headers <-  read.csv("~/personality/pers analysis/Processing and Analysis/pers/pharm pers 11 sept 2017 num.csv", 
                        , header = F, nrows = 1, as.is = T)
pharm <- read_csv("~/personality/pers analysis/Processing and Analysis/pers/pharm pers 11 sept 2017 num.csv", skip = 3,
                  col_names = as.character(pharm.headers)) %>%
  select(-IPAddress, -RecipientLastName, -RecipientFirstName, -RecipientEmail, -LocationLatitude, -LocationLongitude) %>%
  mutate(pharm = "pharm")

#read in questions for headers (line 2)
np.headers <-  read.csv("~/personality/pers analysis/Processing and Analysis/pers/np pers 11 sept 2017 num.csv", 
                     , header = F, nrows = 1, as.is = T)

#read in data with text labels (eg gender, ethnicity etc)
np <- read_csv("~/personality/pers analysis/Processing and Analysis/pers/np pers 11 sept 2017 num.csv", skip = 3, 
                      col_names = as.character(np.headers)) %>%
  select(-IPAddress, -RecipientLastName, -RecipientFirstName, -RecipientEmail, -LocationLatitude, -LocationLongitude) %>%
  mutate(pharm = "nonpharm")

names(pharm) <- tolower(names(pharm))
names(np) <- tolower(names(np))

pers <- full_join(pharm, np)

save(pers, file = "pers.Rdata")
