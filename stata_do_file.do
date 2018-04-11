cd C:\Users\cookchr2\Downloads\1881_heatstroke_deaths-master\1881_heatstroke_deaths-master

*Read in data
import delimited using heatstroke_death1881.csv, clear

*Create dummies for the sky being cloudy or clear. Fair is the omitted group
gen cloudy = 0
replace cloudy = 1 if state_of_weather == "Cloudy "

gen clear = 0
replace clear = 1 if state_of_weather == "Clear"

*Create a residual deaths variable
gen resid_deaths = tot_deaths - deaths

*Simple bivariate retression
reg deaths humidity,r

*Testing using all variables on hand
reg deaths max_temp min_temp mean_temp barometer humidity rainfall resid_deaths cloudy clear,r

*Evaluate as time series data:

*dropping first unrelated observations
gen day = _n
drop if day <= 4
tsset day

reg deaths max_temp L.max_temp min_temp L.min_temp mean_temp L.mean_temp barometer L.barometer humidity L.humidity rainfall L.rainfall resid_deaths L.resid_deaths cloudy L.cloudy clear L.clear,r

*Test on only weather variables
reg deaths max_temp min_temp mean_temp barometer humidity rainfall cloudy clear,r
reg deaths max_temp L.max_temp min_temp L.min_temp mean_temp L.mean_temp barometer L.barometer humidity L.humidity rainfall L.rainfall cloudy L.cloudy clear L.clear,r


