/* From ABNB.sas: correlation of every candidate ticker against the ABNB target.
   WORK.STOCKS is loaded by autoexec.sas from the bundled sample. */

proc corr data=STOCKS;
   var ABNB AMZN APTV AZO BBWI BBY BKNG BWA CCL CMG CZR DECK DHI DPZ DRI EBAY ETSY EXPE F GM GPC GRMN HAS HD HLT KMX LEN LKQ LOW LULU LVS MAR MCD MGM MHK NCLH NKE NVR ORLY PHM POOL RCL RL ROST SBUX TJX TPR TSCO TSLA ULTA WYNN YUM;
   with ABNB;
run;
