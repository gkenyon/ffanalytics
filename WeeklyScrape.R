#Weekly Projection Scrape

library("ffanalytics", lib.loc="~/R/R-3.6.1/library")

my_scrape <- scrape_data(src = c("CBS", "ESPN", "FantasyData", "FantasyPros", "FantasySharks", "FFToday",
                                 "FleaFlicker", "NumberFire", "Yahoo", "FantasyFootballNerd", "NFL",
                                 "RTSports","Walterfootball"),
pos = c("QB", "RB", "WR", "TE", "DST"),
season = 2019, week = 2)

nf_scrape <- scrape_data(src = "NumberFire", pos = c("QB", "RB", "WR", "TE"),
season = 2019, week = 3)
nf_qb <- nf_scrape$QB
nf_rb <- nf_scrape$RB
nf_wr <- nf_scrape$WR
nf_te <- nf_scrape$TE
nf_qb <- select(nf_qb, id, player, player.1, pos, team, opp_team, draftkings_cost, draftkings_fp, draftkings_value)
nf_rb <- select(nf_rb, id, player, player.1, pos, team, opp_team, draftkings_cost, draftkings_fp, draftkings_value)
nf_wr <- select(nf_wr, id, player, player.1, pos, team, opp_team, draftkings_cost, draftkings_fp, draftkings_value)
nf_te <- select(nf_te, id, player, player.1, pos, team, opp_team, draftkings_cost, draftkings_fp, draftkings_value)

dvoa_qb <- read_excel(path = "D:/Dropbox (Personal)/nfl_dfs/DVOA_Scrape.xlsx", sheet=3, range = cell_cols("A:F"))
dvoa_rb <- read_excel(path = "D:/Dropbox (Personal)/nfl_dfs/DVOA_Scrape.xlsx", sheet=4, range = cell_cols("A:F"))
dvoa_wr <- read_excel(path = "D:/Dropbox (Personal)/nfl_dfs/DVOA_Scrape.xlsx", sheet=5, range = cell_cols("A:F"))
dvoa_te <- read_excel(path = "D:/Dropbox (Personal)/nfl_dfs/DVOA_Scrape.xlsx", sheet=6, range = cell_cols("A:F"))

qb <- stringdist_inner_join(nf_qb, dvoa_qb, by="player.1")
rb <- stringdist_inner_join(nf_rb, dvoa_rb, by="player.1")
wr <- stringdist_inner_join(nf_wr, dvoa_wr, by="player.1")
te <- stringdist_inner_join(nf_te, dvoa_te, by="player.1")

dk_match_df <- rbind.data.frame(qb, rb, wr, te)
my_projections <-  projections_table(my_scrape)
my_projections <- my_projections %>% add_player_info()
my_projections <- inner_join(my_projections, dk_match_df, by ="id")
ffa_proj_wk2 <- my_projections
write.csv(ffa_proj_wk2, file = "ffa_proj_week2.csv")
