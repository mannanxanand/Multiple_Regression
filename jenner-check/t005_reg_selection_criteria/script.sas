/* From ABNB.sas: comparing candidate models by R-square, adjusted R-square,
   and Mallows' Cp, then VIF checks on the retained predictors.
   WORK.STOCKS is loaded by autoexec.sas from the bundled sample. */

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
