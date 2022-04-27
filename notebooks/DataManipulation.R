rm(list=ls()); gc();
library(data.table)
df <- fread("D:/Kaggle/M5 Forecasting Challenge/data/sales_train_evaluation.csv")
dim(df)

cols <- colnames(df)[x=grep(colnames(df), pattern="d_")]

d <- data.table::groupingsets(df,
                              j = lapply(.SD, sum),
                              by = c('dept_id', 'cat_id', 'store_id', 'state_id', 'item_id'),
                              id=FALSE, 
                              .SDcols=cols, 
                              sets=list(character(),
                                        c('state_id'),
                                        c('store_id'),
                                        c('cat_id'),
                                        c('dept_id'),
                                        c('state_id','cat_id'),
                                        c('state_id', 'dept_id'),
                                        c('store_id','cat_id'),
                                        c('store_id', 'dept_id'),
                                        c('item_id'),
                                        c('item_id','state_id'),
                                        c('item_id','store_id')))

dim(d)

write.csv(x = d,
          file = "D:/Kaggle/M5 Forecasting Challenge/data/sales_train_evaluation_with_aggregations.csv",
          row.names=FALSE)