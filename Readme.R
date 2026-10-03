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
## Data frame hőmérsékleti korrekcióval
t2m <- data.frame(
  time = time(era5),
  temp = t2mo[,1] - 273.15
)
