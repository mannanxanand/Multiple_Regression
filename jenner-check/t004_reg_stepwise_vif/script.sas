/* From ABNB.sas: full-model and refined stepwise regression with VIF diagnostics.
   WORK.STOCKS is loaded by autoexec.sas from the bundled sample. */

/* Stepwise Regression on Airbnb Stock Prices */
proc reg data=STOCKS;
    model ABNB=AMZN APTV AZO BBWI BBY BKNG BWA CCL CMG CZR DECK DHI DPZ DRI EBAY ETSY EXPE F GM GPC GRMN HAS HD HLT KMX LEN LKQ LOW LULU LVS MAR MCD MGM MHK NCLH NKE NVR ORLY PHM POOL RCL RL ROST SBUX TJX TPR TSCO TSLA ULTA WYNN YUM/vif;
    title "Stepwise Regression Analysis for Predicting Airbnb Stock Prices";
run;

/* Refined Stepwise Regression for Airbnb Stock Prices */
proc reg data=STOCKS;
    model ABNB=AMZN CMG EBAY CZR DECK DRI HAS HD LKQ LOW LULU LVS NKE ORLY POOL RCL RL ROST SBUX TSLA WYNN / selection=stepwise slentry=0.05 slstay=0.05;
    title "Refined Stepwise Regression Analysis for Predicting Airbnb Stock Prices";
run;
