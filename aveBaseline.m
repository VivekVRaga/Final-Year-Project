%% linear regression of the baseline data
clc
X=[ones(length(avet),1) avet];
b=X\aveBL;

c = b(1)
m = b(2)

%%
clc;
mdl = fitlm(avet,aveBL,[0;1])

rsquaredOrd    = mdl.Rsquared.Ordinary;
rsquaredadjust = mdl.Rsquared.Adjusted;
    
