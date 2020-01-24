
%%
%Run 1 plots for an Ecoli concentration of 10^5 CFU/ml

%calculate the single side standard deviation
actstand=0.5*stdR1

%Plot the response using a graphing function by Rob Campbell
%Set plot aestetics
e = shadedErrorBar(timin(1:length(aveR1)),aveR1,actstand, 'lineprops', {'O','color',[0/255 153/255 151/255],'markerfacecolor',[0/255 153/255 151/255],'markerfacecolor',[0/255 153/255 151/255],'MarkerSize',3},'patchSaturation',0.33) ;
%disable edge error bar line
set(e.edge,'LineWidth',2,'LineStyle','none')
set(gca,'FontSize',18);
xlabel('Time (minutes)','FontSize',25);
ylabel('Deviation of Carbon Dioxide from its Initial Value(PPM)','FontSize',25);

hold on

%Plot the baseline using the same function with standard deviation
%alter plot visually
e1 = shadedErrorBar(timin(1:length(aveBL)),aveBL,(0.5*stdevBL), 'lineprops', {'O','color',[255/255 75/255 30/255],'markerfacecolor',[255/255 75/255 30/255],'markerfacecolor',[255/255 75/255 30/255],'MarkerSize',3},'patchSaturation',0.33) ;
set(e1.edge,'LineWidth',2,'LineStyle','none')
xlim([0 300]);
% legend(); % Add a legend
set(legend,'FontSize',20);
legend boxoff



initialv(1:length(timin))=0;
plot(timin,initialv,'--','color','black','linewidth',2);


set(gca,'FontSize',25)
[~, objh] = legend({'E.Coli Run', 'Baseline','Initial Carbon Dioxide Value'}, 'location', 'NorthWest', 'Fontsize', 30);
objhl = findobj(objh, 'type', 'line'); %// objects of legend of type line
set(objhl, 'Markersize', 15);         %// set marker size as desired
legend boxoff
%%
actstand=0.5*stdR1
initialv(1:length(timin))=0;
e1 = shadedErrorBar(timin(1:length(aveR1)),(aveR1-aveBL(1:length(aveR1))),(actstand), 'lineprops', {'O','color',[255/255 75/255 30/255],'markerfacecolor',[255/255 75/255 30/255],'markerfacecolor',[255/255 75/255 30/255],'MarkerSize',3},'patchSaturation',0.33) ;

set(e1.edge,'LineWidth',2,'LineStyle','none')
set(gca,'FontSize',18);
xlabel('Time (minutes)','FontSize',25);
ylabel('Deviation of Carbon Dioxide from The Baseline(PPM)','FontSize',25);
hold on
plot(timin(1:length(aveR1)),initialv(1:length(aveR1)),'--','color','black','linewidth',2);
ylim([0 210]);
set(gca,'FontSize',25)
[~, objh] = legend({'E.Coli Run', 'Initial Carbon Dioxide Value'}, 'location', 'NorthWest', 'Fontsize', 30);
objhl = findobj(objh, 'type', 'line'); %// objects of legend of type line
set(objhl, 'Markersize', 15);         %// set marker size as desired
legend boxoff
%%
[h,p]=kstest2(aveR1lower(1:17249),baselineupper(1:17249),'Tail','smaller')
%%
%Display of Kolgomorov-Smirnov Plot 
clc;
%calculate the single side standard deviation
actstand=0.5*stdR1;
%get the length to which the test will be conducted by using the shortest
%variable
lgth=actstand;
%variable initialization
pv=1;
yn=0;
inc = 10;
newtime=0;
%obtain lower bound of experimental run
aveR1lower = (aveR1-actstand);

%Run for loop on increasing cumulative ranges of the experimental run and
%baseline
for cc = 1:inc:17249
    %get the boolean detection value and the p-value
    %set the alpha value and ensure a single sided test is carried out to
    %determine whether the run is greater than the baseline
    [h,p]=kstest2(aveR1lower(1:cc),baselineupper(1:cc),'Tail','smaller','Alpha',0.001);
    %store p vals in matrix
    pv=[pv;p];
    %store boolean vals
    yn=[yn;h];
    %get time values where the kstest2 was evaluated
    newtime=[newtime;timin(cc)];
    
end
%Get a column matrix equal to 0.001 to plot vs the p-val
siglevel(1:length(newtime))=0.001;
siglevel=siglevel';

%plot the p-val; boolean detection val and the significance value on the
%sme plot
hold on
scatter(newtime,pv,'MarkerFaceColor',[0/255 153/255 151/255],'MarkerEdgeColor',[0/255 153/255 151/255]) %plots the p-value
hold on
% scatter(newtime,yn);
hold on
plot(newtime,siglevel,'LineWidth',3,'color','black')
xlim([0 60]);
set(gca, 'YScale', 'log')
set(gca,'FontSize',18);
xlabel('Time (minutes)','FontSize',25);
ylabel('Log of Probability','FontSize',25);



set(gca,'FontSize',25)

[~, objh] = legend({'P-Value','Significance Level'}, 'location', 'NorthWest', 'Fontsize', 30);
objhl = findobj(objh, 'type', 'line'); %// objects of legend of type line
set(objhl, 'Markersize', 25);         %// set marker size as desired
legend boxoff


set(gca,'FontSize',25)
[~, objh] = legend({'P-Value','Significance Level'}, 'location', 'NorthWest', 'Fontsize', 30);
objhl = findobj(objh, 'type', 'marker'); %// objects of legend of type line
set(objhl, 'Markersize',35);         %// set marker size as desired
objhl = findobj(objh, 'type', 'patch'); % objects of legend of type patch
set(objhl, 'Markersize', 18); % set marker size as desired
legend boxoff

%%
A=[1 2 3 4]'
B=[23 4 5 5]'

vertcat(A,B)
%%

plot_areaerrorbar(timin(1:length(aveR1)),aveR1);
%%
clc
n1     =  linspace(1,length(aveR1),length(aveR1))
n2     =  linspace(1,length(baselineupper),length(baselineupper))

%%
[h]=kstest22(aveR1(1:17249),baselineupper(1:17249),'Tail','smaller')


%%
%baseline
a =      128.9;
b =       180.4;
cc =       -8.258;
x=linspace(1,300,300);
FUNbl = @(b, x) b(1)*(1-exp(-x/b(2)))+b(3);
mdl = fitnlm(avet, aveBL,FUNbl,[a b cc])
hold on
scatter(timin(1:length(aveR1up)), aveBL(1:length(aveR1up)))
%plot(timin(1:length(aveR1up)),a*(1-exp(-timin(1:length(aveR1up))/b))+c);
%%
%%%%%%%%%% BL ave %%%%%%%%%%%%%%%%%%
plot(timin(1:length(regBL)), regBL); %plot(avet, regBL);
hold on
%%%%%%%%%% BL up %%%%%%%%%%%%%%%%%%
plot(timin(1:length(regBL)), regBLup,'r','LineStyle','--');
hold on
%%%%%%%%%% BL up %%%%%%%%%%%%%%%%%%
plot(timin(1:length(regBL)), regBLlow,'r','LineStyle','--');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%
%
%
%
%
%
%% Polynomial Linear Regression%%
%3rd degree polynomial
clc;

mdl = fitlm(timin(1:length(aveR1)),aveR1,[0;1;2;3])

a3 = mdl.Coefficients.Estimate(1); %intercept
b3 = mdl.Coefficients.Estimate(2); %x1
c3 = mdl.Coefficients.Estimate(3); %x2
d3 = mdl.Coefficients.Estimate(4); %x3

regBL = a3 + b3*avet + c3*avet.^2 + d3*avet.^3;

plot(avet, regBL); %plot(avet, regBL);
hold on
%scatter( avet, aveBL);
%% Polynomial Linear Regression%%
%3rd degree polynomial upper
clc;

mdl = fitlm(avet,regBLup,[0;1;2;3])

a3u = mdl.Coefficients.Estimate(1); %intercept
b3u = mdl.Coefficients.Estimate(2); %x1
c3u = mdl.Coefficients.Estimate(3); %x2
d3u = mdl.Coefficients.Estimate(4); %x3

regBLup = a3u + b3u*avet + c3u*avet.^2 + d3u*avet.^3;

plot(avet, regBLup,'r','LineStyle','--');

%%
%3rd degree polynomial lower
mdl = fitlm(avet,regBLlow,[0;1;2;3])

a3u = mdl.Coefficients.Estimate(1); %intercept
b3u = mdl.Coefficients.Estimate(2); %x1
c3u = mdl.Coefficients.Estimate(3); %x2
d3u = mdl.Coefficients.Estimate(4); %x3

regBLlow = a3u + b3u*avet + c3u*avet.^2 + d3u*avet.^3;

plot(avet, regBLlow,'r','LineStyle','--');