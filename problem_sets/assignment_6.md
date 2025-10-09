

``` r
library(tidyverse)
library(knitr)
```

<br>

## Exercise 1. Tibble and Data Import

Import the data frames listed below into R and
[parse](https://r4ds.had.co.nz/data-import.html#parsing-a-vector) the
columns appropriately when needed. Watch out for the formatting oddities
of each dataset. Print the results directly, **without** using
`kable()`.

**You only need to finish any three out of the five questions in this
exercise in order to get credit.**

<br>

#### 1.1 Create the following tibble manually, first using `tribble()` and then using `tibble()`. Print both results. \[We didn’t have time to cover this in class, but look up how these functions work [here](https://r4ds.had.co.nz/tibbles.html#creating-tibbles)\]

`tribble()`:

``` r
tribble(
  ~a, ~b, ~c,
  1, 2.1, "apple",
  2, 3.2, "orange"
)
```

    ## # A tibble: 2 × 3
    ##       a     b c     
    ##   <dbl> <dbl> <chr> 
    ## 1     1   2.1 apple 
    ## 2     2   3.2 orange

`tibble()`:

``` r
tibble(
  a = c(1, 2),
  b = c(2.1, 3.2),
  c = c("apple", "orange")
)
```

    ## # A tibble: 2 × 3
    ##       a     b c     
    ##   <dbl> <dbl> <chr> 
    ## 1     1   2.1 apple 
    ## 2     2   3.2 orange

<br>

#### 1.2 Import `https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/dataset2.txt` into R. Change the column names into “Name”, “Weight”, “Price”.

``` r
q1.2 <- read_delim("https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/dataset2.txt", delim = ",", col_names = c("Name", "Weight", "Price"))

print(q1.2)
```

    ## # A tibble: 3 × 3
    ##   Name   Weight Price
    ##   <chr>   <dbl> <dbl>
    ## 1 apple       1   2.9
    ## 2 orange      2   4.9
    ## 3 durian     10  19.9

<br>

#### 1.3 Import `https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/dataset3.txt` into R. Watch out for the first few lines, missing values, separators, quotation marks, and deliminaters.

``` r
q1.3 <- read_delim("https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/dataset3.txt", skip = 3, delim = ";", col_names = c("Name", "Weight", "Price")) |> 
  mutate(across(everything(), ~str_remove_all(., "/"))) |> 
  mutate(Weight = as.numeric(Weight), Price = as.numeric(Price))

q1.3
```

    ## # A tibble: 3 × 3
    ##   Name   Weight Price
    ##   <chr>   <dbl> <dbl>
    ## 1 apple       1   2.9
    ## 2 orange      2  NA  
    ## 3 durian     NA  19.9

## Exercise 2. Weather station

This dataset contains the weather and air quality data collected by a
weather station in Taiwan. It was obtained from the Environmental
Protection Administration, Executive Yuan, R.O.C. (Taiwan).

#### 2.1 Variable descriptions

- The text file
  `https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/2015y_Weather_Station_notes.txt`
  contains descriptions of different variables collected by the station.

- Import it into R and print it in a table as shown below with
  `kable()`.

<br>

``` r
q2.1 <- read_delim("https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/2015y_Weather_Station_notes.txt", delim = "-")

kable(q2.1)
```

| Item | Unit | Description |
|:---|:---|:---|
| AMB_TEMP | Celsius | Ambient air temperature |
| CO | ppm | Carbon monoxide |
| NO | ppb | Nitric oxide |
| NO2 | ppb | Nitrogen dioxide |
| NOx | ppb | Nitrogen oxides |
| O3 | ppb | Ozone |
| PM10 | μg/m3 | Particulate matter with a diameter between 2.5 and 10 μm |
| PM2.5 | μg/m3 | Particulate matter with a diameter of 2.5 μm or less |
| RAINFALL | mm | Rainfall |
| RH | % | Relative humidity |
| SO2 | ppb | Sulfur dioxide |
| WD_HR | degress | Wind direction (The average of hour) |
| WIND_DIREC | degress | Wind direction (The average of last ten minutes per hour) |
| WIND_SPEED | m/sec | Wind speed (The average of last ten minutes per hour) |
| WS_HR | m/sec | Wind speed (The average of hour) |

`#` indicates invalid value by equipment inspection  
`*` indicates invalid value by program inspection  
`x` indicates invalid value by human inspection  
`NR` indicates no rainfall  
blank indicates no data

<br>

#### 2.2 Data tidying

- Import
  `https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/2015y_Weather_Station.csv`
  into R. As you can see, this dataset is a classic example of untidy
  data: values of a variable (i.e. hour of the day) are stored as column
  names; variable names are stored in the `item` column.

- Clean this dataset up and restructure it into a tidy format.

- Parse the `date` variable into date format and parse `hour` into time.

- Turn all invalid values into `NA` and turn `NR` in rainfall into `0`.

- Parse all values into numbers.

- Show the first 6 rows and 10 columns of this cleaned dataset, as shown
  below, *without* using `kable()`.

*Hints: you don’t have to perform these tasks in the given order; also,
warning messages are not necessarily signs of trouble.*

<br>

Before cleaning:

``` r
q2.2unclean <- read_csv("https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/2015y_Weather_Station.csv", col_types = cols(.default = "c"))
q2.2unclean |> 
  head(6) |> 
  select(1:10)
```

    ## # A tibble: 6 × 10
    ##   date       station item     `00`  `01`  `02`  `03`  `04`  `05`  `06` 
    ##   <chr>      <chr>   <chr>    <chr> <chr> <chr> <chr> <chr> <chr> <chr>
    ## 1 2015/01/01 Cailiao AMB_TEMP 16    16    15    15    15    14    14   
    ## 2 2015/01/01 Cailiao CO       0.74  0.7   0.66  0.61  0.51  0.51  0.51 
    ## 3 2015/01/01 Cailiao NO       1     0.8   1.1   1.7   2     1.7   1.9  
    ## 4 2015/01/01 Cailiao NO2      15    13    13    12    11    13    13   
    ## 5 2015/01/01 Cailiao NOx      16    14    14    13    13    15    15   
    ## 6 2015/01/01 Cailiao O3       35    36    35    34    34    32    30

<br>

After cleaning:

``` r
q2.2clean <- q2.2unclean |> 
  mutate(across(-c(date, station, item), as.character)) |> 
  pivot_longer(
    cols = -c(date, station, item),
    names_to = "hour",
    values_to = "value"
  ) |> 
  mutate(value = if_else(value == "NR", "0", value)) |> 
  mutate(value = as.numeric(value)) |> 
  pivot_wider(
    names_from = item,
    values_from = value
  ) |> 
  mutate(hour = hms::parse_hms(paste0(hour, ":00:00")),
         date = ymd(date))

q2.2clean |> 
  head(6) |> 
  select(1:10)
```

    ## # A tibble: 6 × 10
    ##   date       station hour   AMB_TEMP    CO    NO   NO2   NOx    O3  PM10
    ##   <date>     <chr>   <time>    <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
    ## 1 2015-01-01 Cailiao 00:00        16  0.74   1      15    16    35   171
    ## 2 2015-01-01 Cailiao 01:00        16  0.7    0.8    13    14    36   174
    ## 3 2015-01-01 Cailiao 02:00        15  0.66   1.1    13    14    35   160
    ## 4 2015-01-01 Cailiao 03:00        15  0.61   1.7    12    13    34   142
    ## 5 2015-01-01 Cailiao 04:00        15  0.51   2      11    13    34   123
    ## 6 2015-01-01 Cailiao 05:00        14  0.51   1.7    13    15    32   110

<br>

#### 2.3 Using this cleaned dataset, plot the daily variation in ambient temperature on September 25, 2015, as shown below.

``` r
q2.3 <- q2.2clean |> 
  filter(date == "2015-09-25") |> 
  ggplot() +
  geom_line(mapping = aes(y = AMB_TEMP, x = hour))

q2.3
```

![](assignment_6_files/figure-commonmark/unnamed-chunk-9-1.png)

<br>

#### 2.4 Plot the daily average ambient temperature throughout the year with a **continuous line**, as shown below.

``` r
q2.4 <- q2.2clean |> 
  group_by(date) |> 
  summarise(daily_average_ambient_temp = mean(AMB_TEMP, na.rm = T))|> 
  ggplot() +
  geom_line(mapping = aes(x = date, y = daily_average_ambient_temp))

q2.4
```

![](assignment_6_files/figure-commonmark/unnamed-chunk-10-1.png)

<br>

#### 2.5 Plot the total rainfall per month in a bar chart, as shown below.

*Hint: separating date into three columns might be helpful.*

``` r
q2.5 <- q2.2clean |> 
  separate(date, into = c("year", "month", "day"), sep = "-") |> 
  group_by(month) |> 
  summarise(MonthlyRainfall = sum(RAINFALL, na.rm = T)) |> 
  ggplot() +
  geom_col(mapping = aes(x = month, y = MonthlyRainfall))

q2.5
```

![](assignment_6_files/figure-commonmark/unnamed-chunk-11-1.png)

<br>

#### 2.6 Plot the per hour variation in PM2.5 in the first week of September with a **continuous line**, as shown below.

*Hint: uniting the date and hour and parsing the new variable might be
helpful.*

``` r
q2.6 <- q2.2clean |> 
  filter(date >= "2015-09-01" & date <= "2015-09-07") |> 
  filter(!is.na(PM2.5)) |> 
  unite(col = "time", date, hour, sep = " ") |> 
  mutate(time = as.POSIXct(time)) |> 
  ggplot() +
  geom_line(mapping = aes(x = time, y = PM2.5), na.rm = T)
q2.6
```

![](assignment_6_files/figure-commonmark/unnamed-chunk-12-1.png)

<br>
