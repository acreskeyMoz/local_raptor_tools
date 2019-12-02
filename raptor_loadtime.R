library(dplyr) 
library(ggplot2) 
library(tidyr)

library("rjson")
library("rowr")
library("doBy")

setwd("/users/acreskey/tools/R/data/raptor")

dir.create("plots")
system('bash ./raptor_to_csv.sh')
system('bash ./unify_raptor_test_names.sh')

folders <- list.dirs(path = "./data", full.names=FALSE, recursive = FALSE)

df <- data.frame()
for (folder in folders)
{
  print(folder)
  thisPath <- paste("./data/", folder, sep="")
  my_files <- list.files(path=thisPath, pattern=".csv$", recursive=TRUE)
  print(my_files)
  for(i in seq_along(my_files))
  {
    thisFile = paste(thisPath, "/", my_files[i], sep="")
    print(thisFile)
    file <- read.csv(thisFile, header=TRUE,sep=",")
    csv_as_df <- as.data.frame(file)
    csv_as_df$test <- strtrim(csv_as_df$test, 40)
    # strip out 0 loadtime timeouts
    csv_as_df <- csv_as_df[csv_as_df$loadtime != 0,]
    df <- rbind(df, csv_as_df)
  }
}

save(df, file = "data.RData")

pngPath <- paste("./plots/", "output", ".png", sep="")
png(file=pngPath, width = 12, height = 12, units = 'in', res = 300)

df

title <- "Cold page load, n=50, Windows-Dell Precision"

#ggplot(df, aes(x=test, y=loadtime)) +labs(title=title) + geom_boxplot(aes(fill=mode)) + theme(axis.text.x=element_text(angle=-67.5, hjust=0, vjust=0))
ggplot(df, aes(x=test, y=loadtime)) +labs(title=title) + geom_point(aes(color=mode), position = position_dodge(width=0.6)) + theme(axis.text.x=element_text(angle=-67.5, hjust=0, vjust=0))
#ggplot(df, aes(x=test, y=loadtime)) +labs(title=title) + geom_violin(aes(fill=mode)) + theme(axis.text.x=element_text(angle=-67.5, hjust=0, vjust=0))


dev.off()

df


summary(subset(df, mode=="firefox_live"))
summary(subset(df, mode=="chrome_live"))

summary(subset(df, mode=="firefox_mitmproxy"))
summary(subset(df, mode=="chrome_mitmproxy"))

summary(subset(df, mode=="firefox_live" & test=="raptor-tp6-docs-cold"))
summary(subset(df, mode=="chrome_live" & test=="raptor-tp6-docs-cold"))
summary(subset(df, mode=="firefox_mitmproxy" & test=="raptor-tp6-docs-cold"))
summary(subset(df, mode=="chrome_mitmproxy" & test=="raptor-tp6-docs-cold"))
