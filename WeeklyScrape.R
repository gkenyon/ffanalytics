#Weekly Projection Scrape
devtools::install_github("FantasyFootballAnalytics/ffanalytics")
library("ffanalytics", lib.loc="~/R/R-3.6.1/library")
collapse_list <- function (x, collapse_char = "; ") {
  if (is.null(x)) {return (NA_character_)} # just in case
  if (is.list(x)) {
    unlist(x) %>%
      paste(sep = "_", collapse = collapse_char) -> x
  }
  x
}
my_scrape <- scrape_data(src = c("CBS", "ESPN", "FantasyData", "FantasyPros", "FantasySharks", "FFToday", "FleaFlicker", "NumberFire", "Yahoo", "FantasyFootballNerd", "NFL"),
pos = c("QB", "RB", "WR", "TE"),
season = 2019, week = 8)

dfs_wk_8 <- projections_table(my_scrape) %>% add_player_info() %>% filter(avg_type=="average")

nf_scrape <- scrape_data(src = "NumberFire", pos = c("QB", "RB", "WR", "TE"),
season = 2019, week = 8)

nf_df <- bind_rows(nf_scrape)

dfs_wk_8_dk <- dfs_wk_8 %>% left_join(nf_df)
dfs_wk_8_dk <- dfs_wk_8_dk %>% select(id, player, player.1, pos.y, points, pos_rank, drop_off, sd_pts, floor, ceiling, tier, opp_team, draftkings_cost, draftkings_fp, draftkings_value) %>% filter(!is.na(player), tier<11)
