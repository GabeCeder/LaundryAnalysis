library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(tidyr)

# load in data
load(file = "full.Rdata")
load(file = "full_data.Rdata")

# location dropdown in UI
vars <- c("10 DEWOLFE STREET",
          "1201 MASS AVE 3RD FLR LR",
          "1202 MASS AVE 4TH FLR LR",
          "1306 MASS AVE",
          "20 DEWOLFE STREET",
          "20 PRESCOTT ST",
          "22 PRESCOTT ST",
          "24 PRESCOTT ST",
          "65 MOUNT AUBURN STREET",
          "8 PLYMPTON STREET",
          "CABOT HOUSE - BERTRAM HALL",
          "CABOT HOUSE - BRIGGS HALL",
          "CABOT HOUSE - ELLIOT HALL",
          "CABOT HOUSE - WHITMAN HALL",
          "CURRIER HOUSE - BINGHAM HALL",
          "CURRIER HOUSE - DANIELS HALL",
          "CURRIER HOUSE - GILBERT HALL",
          "CURRIER HOUSE - TUCHMAN HALL",
          "PFORZHEIMER HOUSE - COMSTOCK HA",
          "PFORZHEIMER HOUSE - HOLMES HALL",
          "PFORZHEIMER HOUSE - JORDAN NORT",
          "PFORZHEIMER HOUSE - JORDAN SOUT",
          "PFORZHEIMER HOUSE - MOORS HALL",
          "PFORZHEIMER HOUSE - WOLBACH HAL",
          "ADAMS HOUSE",
          "CLAVERLY HALL",
          "LOWELL HOUSE D",
          "LOWELL HOUSE G",
          "LOWELL HOUSE N",
          "NEW QUINCY-6TH FLOOR",
          "NEW QUINCY-BASEMENT STUDENT LAU",
          "STONE HALL",
          "DUNSTER HOUSE",
          "LEVERETT HOUSE F TOWER",
          "LEVERETT HOUSE G TOWER",
          "LEVERETT HOUSE MCKINLOCK",
          "MATHER HOUSE HIGH-RISE",
          "MATHER HOUSE LOW-RISE",
          "ELIOT HOUSE J",
          "KIRKLAND HOUSE G",
          "KIRKLAND HOUSE J",
          "WINTHROP - GORE",
          "WINTHROP - STANDISH",
          "APLEY COURT",
          "CANADAY HALL",
          "GREENOUGH HALL",
          "HURLBUT HALL",
          "MATTHEWS HALL",
          "STOUGHTON HALL",
          "THAYER HALL",
          "WELD HALL",
          "WIGGLESWORTH HALL")

