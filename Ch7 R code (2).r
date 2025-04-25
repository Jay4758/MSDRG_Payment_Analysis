#install.packages("dplyr")
library(dplyr)

drg2018_h <- group_by(drg2018_h, drg_definition, state)

drg2018_s <- summarize(
  drg2018_h,
  total_discharges_s = sum(total_discharges),
  average_covered_charges_s = weighted.mean(average_covered_charges, total_discharges),
  average_total_payments_s = weighted.mean(average_total_payments, total_discharges),
  average_medicare_payments_s = weighted.mean(average_medicare_payments, total_discharges)
)

drg2018_s <- group_by(drg2018_s, drg_definition)

drg2018_d <- summarize(
  drg2018_s,
  total_discharges_d = sum(total_discharges_s),
  average_covered_charges_d = weighted.mean(average_covered_charges_s, total_discharges_s),
  average_total_payments_d = weighted.mean(average_total_payments_s, total_discharges_s),
  average_medicare_payments_d = weighted.mean(average_medicare_payments_s, total_discharges_s)
)

drg2017_h <- group_by(drg2017_h, drg_definition, state)

drg2017_s <- summarize(
  drg2017_h,
  total_discharges_s = sum(total_discharges),
  average_covered_charges_s = weighted.mean(average_covered_charges, total_discharges),
  average_total_payments_s = weighted.mean(average_total_payments, total_discharges),
  average_medicare_payments_s = weighted.mean(average_medicare_payments, total_discharges)
)

drg2017_s <- group_by(drg2017_s, drg_definition)

drg2017_d <- summarize(
  drg2017_s,
  total_discharges_d = sum(total_discharges_s),
  average_covered_charges_d = weighted.mean(average_covered_charges_s, total_discharges_s),
  average_total_payments_d = weighted.mean(average_total_payments_s, total_discharges_s),
  average_medicare_payments_d = weighted.mean(average_medicare_payments_s, total_discharges_s)
)

drg2018_d50 <- slice_max(drg2018_d, order_by=total_discharges_d, n=50)

drg2018_h50 <- semi_join(drg2018_h, drg2018_d50, by="drg_definition")

drg2018_s50 <- semi_join(drg2018_s, drg2018_d50, by="drg_definition")

drg2017_d50 <- slice_max(drg2017_d, order_by=total_discharges_d, n=50)

drg2017_h50 <- semi_join(drg2017_h, drg2017_d50, by="drg_definition")

drg2017_s50 <- semi_join(drg2017_s, drg2017_d50, by="drg_definition")

drg2018_h50 <- mutate(drg2018_h50,
                      paymentdiff = average_total_payments - average_medicare_payments)

drg2018_s50 <- mutate(drg2018_s50,
                      paymentdiff_s = average_total_payments_s - average_medicare_payments_s)

drg2018_d50 <- mutate(drg2018_d50,
                      paymentdiff_d = average_total_payments_d - average_medicare_payments_d)

drg2017_h50 <- mutate(drg2017_h50,
                      paymentdiff = average_total_payments - average_medicare_payments)

drg2017_s50 <- mutate(drg2017_s50,
                      paymentdiff_s = average_total_payments_s - average_medicare_payments_s)

drg2017_d50 <- mutate(drg2017_d50,
                      paymentdiff_d = average_total_payments_d - average_medicare_payments_d)

#install.packages("ggplot2")
library(ggplot2)

diff_d50 <- ggplot(drg2018_d50,
                   aes(x = reorder(drg_definition, paymentdiff_d),
                       y = paymentdiff_d))

diff_d50 + geom_bar(stat = "identity") + coord_flip()

diff_d50 + geom_point(size = 3) + coord_flip()

drg2018_s50_fusion <- filter(drg2018_s50,
                             drg_definition == "460 - SPINAL FUSION EXCEPT CERVICAL W/O MCC")

diff_s50_fusion <- ggplot(drg2018_s50_fusion,
                          aes(x = reorder(state, paymentdiff_s),
                              y = paymentdiff_s))

diff_s50_fusion + geom_point(size = 3) + coord_flip()

diff_smap50 <- ggplot(drg2018_s50,
                      aes(x = state, y = drg_definition, fill = paymentdiff_s))

diff_smap50 + geom_tile() + scale_fill_gradient(low = "grey", high = "red")

diff2017 <-
  select(drg2017_s50, drg_definition, state, diff2017 = paymentdiff_s)

diff2018 <-
  select(drg2018_s50, drg_definition, state, diff2018 = paymentdiff_s)

diffchange <-
  inner_join(diff2017, diff2018, by = c("drg_definition", "state"))

diffchange <- mutate(diffchange, diff_change = diff2018 - diff2017)

diffmap <-
  ggplot(diffchange, aes(x = state, y = drg_definition, fill = diff_change))

diffmap + geom_tile() + scale_fill_gradient2(low = "black", mid = "grey", high =
                                               "red")
