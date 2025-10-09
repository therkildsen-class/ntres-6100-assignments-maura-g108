

``` r
# Load required packages
library(tidyverse)
```

    ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ✔ dplyr     1.1.4     ✔ readr     2.1.5
    ✔ forcats   1.0.0     ✔ stringr   1.5.1
    ✔ ggplot2   3.5.2     ✔ tibble    3.2.1
    ✔ lubridate 1.9.4     ✔ tidyr     1.3.1
    ✔ purrr     1.1.0     
    ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ✖ dplyr::filter() masks stats::filter()
    ✖ dplyr::lag()    masks stats::lag()
    ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

``` r
library(knitr)

# Read in the data
whales <- read_csv("https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/main/datasets/whales.csv")
```

    Rows: 31 Columns: 9
    ── Column specification ────────────────────────────────────────────────────────
    Delimiter: ","
    chr (8): blue, humpback, southern_right, sei, fin, killer_whale, bowhead, grey
    dbl (1): observer

    ℹ Use `spec()` to retrieve the full column specification for this data.
    ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
whales |> head() |> kable()
```

| observer | blue | humpback | southern_right | sei | fin | killer_whale | bowhead | grey |
|---:|:---|:---|:---|:---|:---|:---|:---|:---|
| 1 | 1/20/15, death, , Indian | NA | NA | 8/9/11, injury, , indian | NA | NA | NA | NA |
| 2 | NA | 8/12/15, death, 50, atlantic | NA | NA | 8/2/13, death, 76, arctic | NA | 6/24/13, injury, 30, artic | NA |
| 3 | NA | NA | 7/14/13, injury, 47, pacific | NA | NA | NA | NA | NA |
| 4 | NA | 3/4/12, death, 56, pacific | NA | NA | NA | NA | NA | 5/24/16, death, , pacific |
| 5 | NA | NA | NA | 6/14/12, injury, 52, indian | NA | NA | NA | NA |
| 6 | 5/2/16, , 80, pacific | NA | NA | NA | NA | NA | NA | NA |

``` r
whales_long <- whales |>
  pivot_longer(-1, names_to = "species", values_to = "info")
whales_long |> head() |> kable()
```

| observer | species        | info                     |
|---------:|:---------------|:-------------------------|
|        1 | blue           | 1/20/15, death, , Indian |
|        1 | humpback       | NA                       |
|        1 | southern_right | NA                       |
|        1 | sei            | 8/9/11, injury, , indian |
|        1 | fin            | NA                       |
|        1 | killer_whale   | NA                       |

``` r
whales_clean <- whales_long |>
  filter(!is.na(info))
whales_clean |> head() |> kable()
```

| observer | species        | info                         |
|---------:|:---------------|:-----------------------------|
|        1 | blue           | 1/20/15, death, , Indian     |
|        1 | sei            | 8/9/11, injury, , indian     |
|        2 | humpback       | 8/12/15, death, 50, atlantic |
|        2 | fin            | 8/2/13, death, 76, arctic    |
|        2 | bowhead        | 6/24/13, injury, 30, artic   |
|        3 | southern_right | 7/14/13, injury, 47, pacific |

``` r
whales_split <- whales_clean |>
  separate(info, c("date", "outcome", "size", "ocean"), ",")
whales_split |> head() |> kable()
```

| observer | species        | date    | outcome | size | ocean    |
|---------:|:---------------|:--------|:--------|:-----|:---------|
|        1 | blue           | 1/20/15 | death   |      | Indian   |
|        1 | sei            | 8/9/11  | injury  |      | indian   |
|        2 | humpback       | 8/12/15 | death   | 50   | atlantic |
|        2 | fin            | 8/2/13  | death   | 76   | arctic   |
|        2 | bowhead        | 6/24/13 | injury  | 30   | artic    |
|        3 | southern_right | 7/14/13 | injury  | 47   | pacific  |

``` r
whales_parsed <- whales_split |>
  type_convert(
    col_types = cols(
      date = col_date(format = "%m/%d/%y"),
      size = col_integer()
    )
  )
whales_parsed |> head()
```

    # A tibble: 6 × 6
      observer species        date       outcome  size ocean   
         <dbl> <chr>          <date>     <chr>   <int> <chr>   
    1        1 blue           2015-01-20 death      NA Indian  
    2        1 sei            2011-08-09 injury     NA indian  
    3        2 humpback       2015-08-12 death      50 atlantic
    4        2 fin            2013-08-02 death      76 arctic  
    5        2 bowhead        2013-06-24 injury     30 artic   
    6        3 southern_right 2013-07-14 injury     47 pacific 

``` r
whales_parsed |> 
  group_by(species) |> 
  summarise(number_of_ship_strikes = n(), average_size = mean(size, na.rm = T))  |>
  kable()
```

| species        | number_of_ship_strikes | average_size |
|:---------------|-----------------------:|-------------:|
| blue           |                      5 |     67.50000 |
| bowhead        |                      5 |     43.75000 |
| fin            |                      4 |     78.50000 |
| grey           |                      7 |     36.83333 |
| humpback       |                      7 |     44.33333 |
| killer_whale   |                      2 |     15.00000 |
| sei            |                      5 |     54.75000 |
| southern_right |                      7 |     47.00000 |

``` r
whales_parsed |>
  mutate(ocean = ifelse(ocean == "artic", "arctic", ocean)) |>
  ggplot(aes(x=date, y = size, color=outcome)) +
  geom_point() +
  facet_grid(ocean~species)
```

    Warning: Removed 8 rows containing missing values or values outside the scale range
    (`geom_point()`).

![](lab6_files/figure-commonmark/unnamed-chunk-7-1.png)

``` r
# Load required packages
library(babynames) # install.packages("babynames")

babynames |> head() |> kable()
```

| year | sex | name      |    n |      prop |
|-----:|:----|:----------|-----:|----------:|
| 1880 | F   | Mary      | 7065 | 0.0723836 |
| 1880 | F   | Anna      | 2604 | 0.0266790 |
| 1880 | F   | Emma      | 2003 | 0.0205215 |
| 1880 | F   | Elizabeth | 1939 | 0.0198658 |
| 1880 | F   | Minnie    | 1746 | 0.0178884 |
| 1880 | F   | Margaret  | 1578 | 0.0161672 |

``` r
top_6_boy_names <- babynames |>
  filter(sex == "M") |>
  group_by(name) |>
  summarise(total_count=sum(n)) |>
  slice_max(order_by = total_count, n = 6)

top_6_girl_names <- babynames |>
  filter(sex == "F") |>
  group_by(name) |>
  summarise(total_count=sum(n)) |>
  slice_max(order_by = total_count, n = 6) 

babynames |>
  filter(
    (name %in% top_6_boy_names$name & sex == "M") | (name %in% top_6_girl_names$name & sex == "F")
    ) |>
  ggplot(aes(x=year, y=prop, group=name, color=sex)) +
  geom_line() +
  facet_wrap(~name)
```

![](lab6_files/figure-commonmark/unnamed-chunk-9-1.png)

``` r
babynames |>
  mutate(decade = floor(year/10)*10) |>
  group_by(sex, decade, name) |>
  summarise(total_count = sum(n)) |>
  group_by(sex, decade) |>
  slice_max(order_by = total_count, n=1) |>
  ggplot(aes(x=decade, y=total_count, color=sex)) +
  geom_line(size = 1.5) +
  geom_point(size = 3)+
  ggrepel::geom_label_repel(aes(label=name)) +
  cowplot::theme_cowplot()
```

    `summarise()` has grouped output by 'sex', 'decade'. You can override using the
    `.groups` argument.

    Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
    ℹ Please use `linewidth` instead.

![](lab6_files/figure-commonmark/unnamed-chunk-10-1.png)
