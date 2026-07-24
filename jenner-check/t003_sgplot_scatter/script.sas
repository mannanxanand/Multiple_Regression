/* From ABNB.sas: scatterplots of ABNB against selected tickers.
   WORK.STOCKS is loaded by autoexec.sas from the bundled sample. */

/* Scatterplot for ABNB vs Amazon (AMZN) */
proc sgplot data=STOCKS;
    scatter x=ABNB y=AMZN / markerattrs=(symbol=circlefilled color=blue);
    title "Scatterplot of Airbnb (ABNB) vs Amazon (AMZN)";
run;

/* Scatterplot for ABNB vs Booking Holdings (BKNG) */
proc sgplot data=STOCKS;
    scatter x=ABNB y=BKNG / markerattrs=(symbol=circlefilled color=red);
    title "Scatterplot of Airbnb (ABNB) vs Booking Holdings (BKNG)";
run;

*Bad Ones:;
/* Scatterplot for ABNB vs Ford Motor Company (F) */
proc sgplot data=STOCKS;
    scatter x=ABNB y=F / markerattrs=(symbol=circlefilled color=green);
    title "Scatterplot of Airbnb (ABNB) vs Ford Motor Company (F)";
run;

/* Scatterplot for ABNB vs BorgWarner (BWA) */
proc sgplot data=STOCKS;
    scatter x=ABNB y=BWA / markerattrs=(symbol=circlefilled color=black);
    title "Scatterplot of Airbnb (ABNB) vs BorgWarner (BWA)";
run;
