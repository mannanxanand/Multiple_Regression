/* From ABNB.sas: building second-order and interaction terms, then fitting
   the interaction model with PROC GLM (STORE) + PROC PLM effect plot and
   PROC REG TEST statements for the added terms.
   WORK.STOCKS is loaded by autoexec.sas from the bundled sample. */

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
