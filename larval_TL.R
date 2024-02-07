# force data into a data frame
 larval_TL<- as.data.frame(larval_TL)
class(larval_TL) #check!

# pull in ggplot
library(ggplot2)
rm(larval_Tl_plot) #fucked up

# scatter plot of larval TL by date with ggplot
larval_TL_plot <-ggplot(data=larval_TL, aes(x=Date, y=TL)) +
  geom_point() +
  labs(title = "Larval Total Length(mm) by Month",
       y = "Total Length (mm)") +
  theme(plot.title = element_text(size=24, hjust = 0.5),
          axis.text.x = element_text(size=16),
          axis.text.y=element_text(size=16),
          axis.title.x=element_text(size=20),
          axis.title.y=element_text(size=20))
larval_TL_plot

library(tidyverse)
library(plotrix)

# use dplyr to summarize TL by date
summary <- larval_TL %>%
  group_by(Date) %>%
  summarise_each(funs(mean, sd, se=std.error))

mean(larval_TL$TL) #overall mean

# plot mean by date against overall mean
larval_TL_avg_plot <- ggplot(summary, aes(x=Date, y=TL_mean)) + 
  geom_point()+
  geom_errorbar(aes(ymin=TL_mean-TL_se, ymax=TL_mean+TL_se), width=.2, position=position_dodge(0.05)) +
  geom_hline(yintercept=9.656566, linetype="solid", color= "blue")+
  ggtitle("Mean Larval Total Length (mm) by Month vs. Overall Mean") +
  theme(plot.title = element_text(size=24, hjust = 0.5),
        axis.text.x = element_text(size=16),
        axis.text.y=element_text(size=16),
        axis.title.x=element_text(size=20),
        axis.title.y=element_text(size=20))
larval_TL_avg_plot + labs( x= "", y= "Mean TL(mm)")