
<!-- README.md is generated from README.Rmd. Please edit that file -->

# audiomoth.tools

<!-- badges: start -->

[![R-CMD-check](https://github.com/samherniman/audiomoth.tools/workflows/R-CMD-check/badge.svg)](https://github.com/samherniman/audiomoth.tools/actions)
<!-- badges: end -->

[Audiomoths](https://www.openacousticdevices.info/audiomoth) are super
cool autonomous recording units (ARUs) that record audio on a set
recording schedule. They are often used to record the calls of birds or
bats in an environment. Audiomoth.tools is a collection of functions
that I have put together when using my Audiomoth. Feel free to recommend
changes or improvements!

## Installation

You can install the development version of this package from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("samherniman/audiomoth.tools")
```

## Example

``` r
library(audiomoth.tools)
```

Currently, there are only two useful functions in this package:

Use `extract_header_info` to extract the information contained in the
headers of each WAV file. The headers contain the recording date, time,
serial number, gain setting, battery state, and temperature. More
details and Python code are provided by Open Acoustic Devices
[here](https://github.com/OpenAcousticDevices/Application-Notes/blob/master/AudioMoth_Temperature_Measurements.pdf).
This function extracts these data from the header of all Audiomoth files
in a given directory and returns a dataframe.

``` r
extract_header_info(system.file("extdata", package = "audiomoth.tools"), recursive = FALSE)
#> # A tibble: 3 x 6
#>   recorded_date_time  timezone sensor_name_ser~ gain_setting battery_voltage
#>   <dttm>              <chr>    <chr>            <chr>                  <dbl>
#> 1 2021-02-01 21:01:00 UTC      AudioMoth 11X11~ medium                     4
#> 2 2021-02-01 21:06:00 UTC      AudioMoth 11X11~ medium                     4
#> 3 2021-02-01 21:11:00 UTC      AudioMoth 11X11~ medium                     4
#> # ... with 1 more variable: temperature_celcius <dbl>
```

Here’s an example of a figure you can make with the temperature.

``` r
header_df <- vroom::vroom(system.file("extdata", "header_df.csv", package = "audiomoth.tools"))

library(ggplot2)
library(magrittr)

header_df %>%
  ggplot(data = .)+
  geom_point(aes(x = recorded_date_time, y = temperature_celcius, color = temperature_celcius))+
  geom_smooth(
    aes(x = recorded_date_time, y = temperature_celcius),
    method = 'gam',
    se = FALSE,
    color = "brown"
    )+
  scico::scale_color_scico("Temperature (°C)", palette = "romaO", direction = -1) +
  labs(y = "Temperature (°C)", x = "Date") +
  theme(
    panel.background = element_rect(fill = "grey98"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank())
```

![](man/figures/README-graph-temp-2.png)

Depending on your version of the audiomoth software, filenames may look
like `20210201_210100T.WAV` (YYYYMMDD\_HHMMSST). If you want to upload
these files to [Arbimon](https://arbimon.rfcx.org/), you may have to
remove the *T* at the end of each filename. You can use
`rename_audiomoth_files` to do this.

``` r
rename_audiomoth_files(system.file("extdata", package = "audiomoth.tools"))
```
