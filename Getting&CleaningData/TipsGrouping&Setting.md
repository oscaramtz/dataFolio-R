# Summarize

```{R}
# that you really understand what is going on.

pack_sum <- summarize(by_package,
                      count = n(),
                      unique = n_distinct(ip_id),
                      countries = n_distinct(country),
                      avg_bytes = mean(size))
# here for clarity.

by_package <- group_by(cran, package)
pack_sum <- summarize(by_package,
                      count = n(),
                      unique = n_distinct(ip_id),
                      countries = n_distinct(country),
                      avg_bytes = mean(size))

# Here's the new bit, but using the same approach we've
# been using this whole time.

top_countries <- filter(pack_sum, countries > 60)
result1 <- arrange(top_countries, desc(countries), avg_bytes)

# Print the results to the console.
print(result1)



result2 <-
  arrange(
    filter(
      summarize(
        group_by(cran,
                 package
        ),
        count = n(),
        unique = n_distinct(ip_id),
        countries = n_distinct(country),
        avg_bytes = mean(size)
      ),
      countries > 60
    ),
    desc(countries),
    avg_bytes
  )

print(result2)



result3 <-
  cran %>%
  group_by(package) %>%
  summarize(count = n(),
            unique = n_distinct(ip_id),
            countries = n_distinct(country),
            avg_bytes = mean(size)
  ) %>%
  filter(countries > 60) %>%
  arrange(desc(countries), avg_bytes)

# Print result to console
  print(result3)
  ```
## Chainging

```{R}
cran %>%
  select(ip_id, country, package, size) %>%
  mutate(size_mb = size / 2^20) %>%
  filter(size_mb <= 0.5) %>%
  arrange(desc(size_mb))
  # Your call to arrange() goes here
```

## Grouping

```{R}
sat %>%
  select(-contains("total")) %>%
  gather(part_sex, count, -score_range) %>%
  separate(part_sex, c("part", "sex")) %>%
  group_by(part, sex) %>%
  mutate(total = sum(count),
        prop = count / total) %>%
  print
```
## XTabs

```{R}
data("UCBAdmissions")
df <- as.data.frame(UCBAdmissions)
summary(df)
sum(df[df$Admit == "Rejected", "Freq"])

xt <- xtabs(Freq ~ Gender + Admit, data = df)
xtabs(Freq ~ Gender + Admit, df)
ftable(df)


warpbreaks <- warpbreaks[,1:3]
warpbreaks$replicate <- rep(1:9, len = 54)
xt <- xtabs(breaks ~ ., data = warpbreaks)
ftable(xt)
```



##For a general solution that works regardless of how many digits are in data$anim, use the sprintf function. It works like this:

```{R}
sprintf("%04d", 1)
# [1] "0001"
sprintf("%04d", 104)
# [1] "0104"
sprintf("%010d", 104)
# [1] "0000000104"
```
