### Get Data 11 Sept 2017 ###

require(tidyverse)

#read in pharmacy data, remove potentially identifying variables, add source id variable "pharm"
pharm.headers <-  read.csv("~/personality/pers analysis/Processing and Analysis/pers/pharm pers 11 sept 2017 num.csv", 
                        header = F, nrows = 1, as.is = T) %>%
  tolower()
pharm <- read_csv("~/personality/pers analysis/Processing and Analysis/pers/pharm pers 11 sept 2017 num.csv", skip = 3,
                  col_names = as.character(pharm.headers)) %>%
  select(-ipaddress, -recipientlastname, -recipientfirstname, -recipientemail, -locationlatitude, -locationlongitude) %>%
  mutate(pharm = "pharm") %>%
  rename(q20_19 = q5_19, q20_20 = q5_20, q20_21 = q5_21, q20_22 = q5_22,
         q20_23 = q5_23, q20_24 = q5_24, q20_25 = q5_25, q20_26 = q5_26,
         q20_27 = q5_27, q20_28 = q5_28,
         consent = q4)

#fix question numbering issue
names(pharm) <- gsub("q4_", "q22_", names(pharm))

#read in questions for headers (line 2)
np.headers <-  read.csv("~/personality/pers analysis/Processing and Analysis/pers/np pers 11 sept 2017 num.csv", 
                    header = F, nrows = 1, as.is = T) %>%
  tolower()

#read in data with text labels (eg gender, ethnicity etc)
np <- read_csv("~/personality/pers analysis/Processing and Analysis/pers/np pers 11 sept 2017 num.csv", skip = 3, 
                      col_names = as.character(np.headers)) %>%
  select(-ipaddress, -recipientlastname, -recipientfirstname, -recipientemail, -locationlatitude, -locationlongitude) %>%
  mutate(pharm = "nonpharm") %>%
  rename(consent = q4)

pers <- full_join(pharm, np)

save(pers, file = "pers.Rdata")

write.csv(pers, file = "pers.csv")
