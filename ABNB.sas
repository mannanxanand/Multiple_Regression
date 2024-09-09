%web_drop_table(WORK.IMPORT);
FILENAME REFFILE '/home/u63739262/sasuser.v94/ABNB/Stock Selection.xlsx';

PROC IMPORT DATAFILE=REFFILE
	DBMS=XLSX
	OUT=WORK.STOCKS;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.STOCKS; RUN;


%web_open_table(WORK.IMPORT);

proc univariate data=stocks;
   *var ABNB;
   histogram ABNB AMZN APTV AZO BBWI BBY BKNG BWA CCL CMG CZR DECK DHI DPZ DRI EBAY ETSY EXPE F GM GPC GRMN HAS HD HLT KMX LEN LKQ LOW LULU LVS MAR MCD MGM MHK NCLH NKE NVR ORLY PHM POOL RCL RL ROST SBUX TJX TPR TSCO TSLA ULTA WYNN YUM;
   inset N MEAN STD / position=ne;
run;


proc means data= stocks;
	var ABNB AMZN APTV AZO BBWI BBY BKNG BWA CCL CMG CZR DECK DHI DPZ DRI EBAY ETSY EXPE F GM GPC GRMN HAS HD HLT KMX LEN LKQ LOW LULU LVS MAR MCD MGM MHK NCLH NKE NVR ORLY PHM POOL RCL RL ROST SBUX TJX TPR TSCO TSLA ULTA WYNN YUM;;
	run;
	
proc corr data=STOCKS;
   var ABNB AMZN APTV AZO BBWI BBY BKNG BWA CCL CMG CZR DECK DHI DPZ DRI EBAY ETSY EXPE F GM GPC GRMN HAS HD HLT KMX LEN LKQ LOW LULU LVS MAR MCD MGM MHK NCLH NKE NVR ORLY PHM POOL RCL RL ROST SBUX TJX TPR TSCO TSLA ULTA WYNN YUM;
   with ABNB;
run;

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

/* Evaluation with R^2 */
proc reg data=stocks;
    model ABNB=AMZN EBAY CZR DECK DRI LOW RL SBUX TSLA / selection=rsquare;
    title "Model Evaluation with R-Square";
run;

/* Evaluation with Adjusted R-Square */
proc reg data=STOCKS;
    model ABNB=AMZN EBAY CZR DECK DRI LOW RL SBUX TSLA / selection=adjrsq;
    title "Model Evaluation with Adjusted R-Square";
run;

/* Evaluation with Cp Statistic */
proc reg data=STOCKS;
    model ABNB=AMZN EBAY CZR DECK DRI LOW RL SBUX TSLA / selection=cp;
    title "Model Evaluation with Cp Statistic";
run;

/* Evaluation with PRESS Statistic */
proc glmselect data=STOCKS;
    model ABNB=AMZN EBAY CZR DECK DRI LOW RL SBUX TSLA / selection=stepwise(choose=press);
    title "Evaluation of Model Predicting Airbnb Stock Prices Using PRESS Statistic";
run;

/* Variance Inflation Factor (VIF) Calculation for the model based on the lowest PRESS statistic */
proc reg data=STOCKS;
    model ABNB = EBAY CZR DECK DRI LOW RL SBUX TSLA / vif;
    title "VIF Calculation for Selected Model Based on PRESS";
run;

/* Variance Inflation Factor (VIF) Calculation for the model based on the lowest PRESS statistic */
proc reg data=STOCKS;
    model ABNB = EBAY CZR DRI SBUX TSLA / vif;
    title "VIF Calculation for Selected Model Based on PRESS";
run;

/* Creating a new dataset with interaction and second-order terms */
data stocks_2;
    set STOCKS;
    
    /* Second-order (Quadratic) terms */
    ebay2 = EBAY * EBAY;
    czr2 = CZR * CZR;
    dri2 = DRI * DRI;
    sbux2 = SBUX * SBUX;
    tsla2 = TSLA * TSLA;
    
    /* Interaction terms */
    ebay_czr = EBAY * CZR;
    ebay_dri = EBAY * DRI;
    ebay_sbux = EBAY * SBUX;
    ebay_tsla = EBAY * TSLA;
    
    czr_dri = CZR * DRI;
    czr_sbux = CZR * SBUX;
    czr_tsla = CZR * TSLA;
    
    dri_sbux = DRI * SBUX;
    dri_tsla = DRI * TSLA;
    
    sbux_tsla = SBUX * TSLA;
run;

/* Main Effects Model */
proc reg data=stocks_2;
    model ABNB = EBAY CZR DRI SBUX TSLA/vif;
    title "Main Effects Model";
run;

proc glm data=stocks_2;
    model ABNB = EBAY | CZR/solution ;
    title "Model Building for Airbnb Stock Price with Interaction Terms";
    store out=GLMMODEL;
run;

proc plm restore=GLMMODEL noinfo;
    effectplot slicefit(x=EBAY sliceby=CZR);
run;


/* Model with Interaction Terms */
proc reg data=stocks_2;
    model ABNB = EBAY CZR DRI SBUX TSLA ebay_czr ebay_dri ebay_sbux ebay_tsla  czr_sbux czr_tsla dri_sbux dri_tsla sbux_tsla/vif;
    test ebay_czr, ebay_dri, ebay_sbux, ebay_tsla, 
         czr_sbux, czr_tsla, dri_sbux, dri_tsla, sbux_tsla;
    title "Model with Interaction Terms";
run;


/* Model with Second-Order (Quadratic) Terms */
proc reg data=stocks_2;
    model ABNB = EBAY CZR DRI SBUX TSLA ebay2 czr2 dri2 sbux2 tsla2/vif;
    test ebay2, czr2, dri2, sbux2, tsla2;
    title "Model with Quadratic Terms";
run;

