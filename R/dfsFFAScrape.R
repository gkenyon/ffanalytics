library("ffanalytics", lib.loc="~/R/R-3.6.1/library")
library(tidyr)
library(dplyr)

# Scrape ------------------------------------------------------------------
week <- 8
sources <- c('CBS', 'Yahoo', 'FantasySharks', 'NumberFire', 'FantasyPros', 'FantasyData', 'FleaFlicker')
scrape <- scrape_data(src = sources,
                      pos=c('QB', 'RB', 'WR', 'TE'),
                      season = 2019,
                      week=week)

# Scoring -----------------------------------------------------------------
scoring <- list(
  pass = list(
    pass_att = 0, pass_comp = 0, pass_inc = 0, pass_yds = 0.04, pass_tds = 4,
    pass_int = -1, pass_40_yds = 0,  pass_300_yds = 3, pass_350_yds = 0,
    pass_400_yds = 0
  ),
  rush = list(
    all_pos = TRUE,
    rush_yds = 0.1,  rush_att = 0, rush_40_yds = 0, rush_tds = 6,
    rush_100_yds = 3, rush_150_yds = 0, rush_200_yds = 0),
  rec = list(
    all_pos = TRUE,
    rec = 1, rec_yds = 0.1, rec_tds = 6, rec_40_yds = 0, rec_100_yds = 3,
    rec_150_yds = 0, rec_200_yds = 0
  ),
  misc = list(
    all_pos = TRUE,
    fumbles_lost = -1, fumbles_total = 0,
    sacks = 0, two_pts = 2
  ),
  ret = list(
    all_pos = TRUE,
    return_tds = 6, return_yds = 0
  ),
  dst = list(
    dst_fum_rec = 2,  dst_int = 2, dst_safety = 2, dst_sacks = 1, dst_td = 6,
    dst_blk = 2, dst_ret_yds = 0, dst_pts_allowed = 0
  ),
  pts_bracket = list(
    list(threshold = 0, points = 10),
    list(threshold = 1, points = 7),
    list(threshold = 7, points = 4),
    list(threshold = 14, points = 1),
    list(threshold = 21, points = 0),
    list(threshold = 28, points = -1),
    list(threshold = 35, points = -4)
  )
)

# Projections -------------------------------------------------------------
my_projections <-  projections_table(scrape, scoring_rules = scoring)%>% add_player_info() %>% filter(avg_type=="average")
saveRDS(my_projections,"C:/Users/kenyong/Documents/GitHub/nflscrapR/proj_wk8.rds")


# Add Opponent ------------------------------------------------------------


