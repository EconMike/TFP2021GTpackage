library(tidyverse)
library(readxl)
library(ggplot2)
library(lubridate)
library(cowplot)
library(gt)
install.packages("gt")
install.packages("kableExtra")
library(kableExtra)
library(gtsummary)
install.packages("gtsummary")
install.packages("cli")
library(cli)
remove.packages("cli")

setwd("G:/DRIVE/LOOKING WORK/LinkedIn Posts/prod")

df<-read_excel("SourcesOfOutput.xlsx", sheet = "data")
class(df)
head(df)
df2<-df%>%select(Years,Output,LaborC,CapitalC,TFP)
head(df2)



ab<-gt(df2)%>%cols_align(align = c("center"),
  columns =everything())%>% 
  cols_label(
    Years = "Periods",
    Output = "Real GDP",
    LaborC = "Labor Input*(a)",
    CapitalC="Capital Input*(1-a)",
    TFP="Total Factor Productivity"
  )%>%cols_width(vars(CapitalC)~pct(20))%>%
  tab_options(
    table.width = pct(80),
    table.font.size = "smaller",
    column_labels.font.size = "small")%>%
    tab_header(title = "SOURCE OF REAL ECONOMIC GROWTH - PRIVATE NONFARM BUSINESS")%>% 
  tab_spanner(label = html("=Labor Input<sup>*</sup>+ Capital Input<sup>*</sup> + TFP"), columns = matches("LaborC|CapitalC|MFP"))%>%
  tab_source_note(md("*Contribution points towards output growth"))%>%
  tab_source_note(md("  a: average labor cost share"))%>%
  tab_source_note(md("Source: Bureau of Labor Statistics"))%>%
  
  tab_footnote(
    footnote = "Excludes Nonprofits, Private Households, Owner-occupied Housing, Government and Government Enterprise",
    locations = cells_column_labels(
      columns = vars(Output)
    ) )
  

  

 gtsave(ab,"SourceGDPGrowth2022.png")
 
plot_grid(a, ab)

ggsave("wow.png")
