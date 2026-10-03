## Fájlnevek
era5.grib <- "data.grib"
vgy.poly <- "cat.shp"
## Csomagok betöltése
library(terra)
library(sf)
## Grib import
era5 <- rast(era5.grib)
## A betöltött adatok összefoglalója
era5

## Vízgyűjtő beolvasása
basin <- st_read(vgy.poly)
## EPSG kód nem volt hozzáadva
st_crs(basin) <- 32633
## Átvetítés a raszter CRS-re
basin <- st_transform(basin, crs(era5))
## Extraction
t2m <- extract(era5, vect(basin), fun = mean, na.rm = TRUE, exact = TRUE, ID = FALSE)
t2mo <- t(t2m)
## xts hőmérsékleti korrekcióval
library(xts)
t2mh <- xts(t2mo[,1] - 273.15, as.POSIXct(time(era5)))
plot(apply.daily(t2mh, colMeans), main = "Rába")
