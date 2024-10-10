bioclim <- function(x, year = "year", tmaxcol="tmax", tmincol="tmin", tmeancol="tmean", precipcol="pr") {

    yearlist <- sort(unique(x[[year]]))

    # wrapper function to allow processing multiple years
    x <- split(x, x[[year]])

    x <- lapply(x, bioclim.year, tmaxcol = tmaxcol, tmincol = tmincol, tmeancol = tmeancol, precipcol = precipcol)

    x <- do.call(rbind, x)

    x <- data.frame(idcol = yearlist, x)
    colnames(x)[1] <- year

    x
}

    



bioclim.year <- function(x, tmaxcol="tmax", tmincol="tmin", tmeancol="tmean", precipcol="pr") {

    # x should be weekly or monthly weather data for a single year
    # if there are 53 weeks, drop the last one
    if(nrow(x) == 12) {
        period <- 3
    } else {
        if(nrow(x) == 52) {
            period <- 13
        } else {
            if(nrow(x) == 53) {
                message("Truncating to 52 weeks.\n")
                x <- x[-53, ]
                period <- 13
            } else {
                stop("x should be a single year of 12 months or 52 weeks.\n")
            }
        }
    }

	tmax <- x[[tmaxcol]]
	tmin <- x[[tmincol]]
	precip <- x[[precipcol]]

	if(!(tmeancol %in% colnames(x))) {
		tmean <- (tmax + tmin) / 2
    } else {
        tmean <- x[[tmeancol]]
    }

    x.quarters <- quarter(x, tmaxcol, tmincol, tmeancol, precipcol, period=period, rotate=TRUE)

    bc <- rep(NA, 19)

    # 1. Annual mean temperature
    bc[1] <- mean(tmean, na.rm=TRUE)

    # 2. Mean diurnal range
    bc[2] <- mean(tmax - tmin, na.rm=TRUE)

    # 4. Temperature seasonality
    bc[4] <- 100 * sd(tmean, na.rm=TRUE)

    # 5. Maximum temperature of warmest period
    bc[5] <- max(tmax, na.rm=TRUE)

    # 6. Minimum temperature of coldest period
    bc[6] <- min(tmin, na.rm=TRUE)

    # 7. Temperature annual range
    bc[7] <- bc[5] - bc[6]

    # 3. Isothermality
    bc[3] <- 100 * bc[2] / bc[7]

    # 8. Mean temperature of wettest quarter
    bc[8] <- x.quarters[[tmeancol]][which.max(x.quarters[[precipcol]])]

    # 9. Mean temperature of driest quarter
    bc[9] <- x.quarters[[tmeancol]][which.min(x.quarters[[precipcol]])]

    # 10. Mean temperature of warmest quarter
    bc[10] <- max(x.quarters[[tmeancol]], na.rm=TRUE)

    # 11. Mean temperature of coldest quarter
    bc[11] <- min(x.quarters[[tmeancol]], na.rm=TRUE)

    # 12. Annual precipitation
    bc[12] <- sum(precip, na.rm=TRUE)

    # 13. Precipitation of wettest period
    bc[13] <- max(precip, na.rm=TRUE)

    # 14. Precipitation of driest period
    bc[14] <- min(precip, na.rm=TRUE)

    # 15. Precipitation seasonality
    bc[15] <- sd(precip, na.rm=TRUE) / mean(precip, na.rm=TRUE)

    # 16. Precipitation of wettest quarter
    bc[16] <- x.quarters[[precipcol]][which.max(x.quarters[[precipcol]])]

    # 17. Precipitation of driest quarter
    bc[17] <- x.quarters[[precipcol]][which.min(x.quarters[[precipcol]])]

    # 18. Precipitation of warmest quarter
    bc[18] <- x.quarters[[precipcol]][which.max(x.quarters[[tmeancol]])]

    # 19. Precipitation of coldest quarter
    bc[19] <- x.quarters[[precipcol]][which.min(x.quarters[[tmeancol]])]

    names(bc) <- paste0("bc", sprintf("%02d", seq_len(length(bc))))
    bc
}

quarter <- function(x, tmaxcol="tmax", tmincol="tmin", tmeancol="tmean", precipcol="precip", period = 3, rotate=FALSE) {
	# calculate statistics on a rolling period 
    # if rotate, will add beginning data to the end to get a complete set
    # - this is how climates::bioclim() handles yearly data

    if(rotate) {
        x <- rbind(x, x[seq(1, period - 1), ])
    }

	tmax <- x[[tmaxcol]]
	tmin <- x[[tmincol]]
	precip <- x[[precipcol]]

	if(!(tmeancol %in% colnames(x)))
		tmean <- (tmax + tmin) / 2
    else
        tmean <- x[[tmeancol]]

	maxrow <- length(tmax) - period + 1


	dat <- matrix(NA, nrow=maxrow, ncol=4)

	for(i in seq(1, maxrow)) {
		thisrows <- seq(i, i + period - 1)

        thisvar <- tmax[thisrows]
        thisvar <- thisvar[!is.na(thisvar)]
		dat[i, 1] <- mean(thisvar)

        thisvar <- tmin[thisrows]
        thisvar <- thisvar[!is.na(thisvar)]
		dat[i, 2] <- mean(thisvar)

        thisvar <- tmean[thisrows]
        thisvar <- thisvar[!is.na(thisvar)]
		dat[i, 3] <- mean(thisvar)

        thisvar <- precip[thisrows]
        thisvar <- thisvar[!is.na(thisvar)]
		dat[i, 4] <- sum(thisvar)
	}

	dat <- data.frame(dat)
	colnames(dat) <- c(tmaxcol, tmincol, tmeancol, precipcol)

	dat
}

