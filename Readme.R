## Fájlnév
era5.grib <- "data.grib"
## Csomagok betöltése
library(terra)
library(sf)
## Grib import
era5 <- rast(era5.grib)
## A betöltött adatok összefoglalója
era5
