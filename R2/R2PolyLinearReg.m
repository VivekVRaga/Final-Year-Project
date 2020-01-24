%%Run 2 plots with std dev x10^3
clc;

%calculate the single side standard deviation
%Plot the response using a graphing function by Rob Campbell
%Set plot aestetics
e=shadedErrorBar(timin(1:length(aveR2)),aveR2,(0.5*stdRun2), 'lineprops', {'O','color',[0/255 153/255 151/255],'markerfacecolor',[0/255 153/255 151/255],'markerfacecolor',[0/255 153/255 151/255],'MarkerSize',4},'patchSaturation',0.33) ;
set(e.edge,'LineWidth',2,'LineStyle','none')
set(gca,'FontSize',18);
xlabel('Time (minutes)','FontSize',25);
ylabel('Deviation of Carbon Dioxide from its Initial Value(PPM)','FontSize',25);
xlim([0 1000]);
hold on

%Plot the baseline using the same function with standard deviation
%alter plot visually
e1 = shadedErrorBar(timin(1:length(aveBL)),aveBL,(0.5*stdevBL), 'lineprops', {'O','color',[255/255 75/255 30/255],'markerfacecolor',[255/255 75/255 30/255],'markerfacecolor',[255/255 75/255 30/255],'MarkerSize',4},'patchSaturation',0.33) ;
set(e1.edge,'LineWidth',2,'LineStyle','none')
%Legend!
% legend('E.Coli Run', 'Baseline'); % Add a legend
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
actstand=0.5*sqrt(stdRun2(1:length(aveBL)).^2+ stdevBL.^2)
initialv(1:length(aveBL))=0;
e1 = shadedErrorBar(timin(1:length(aveBL)),(aveR2(1:length(aveBL))-aveBL),(actstand), 'lineprops', {'O','color',[255/255 75/255 30/255],'markerfacecolor',[255/255 75/255 30/255],'markerfacecolor',[255/255 75/255 30/255],'MarkerSize',3},'patchSaturation',0.33) ;

set(e1.edge,'LineWidth',2,'LineStyle','none')
set(gca,'FontSize',18);
xlabel('Time (minutes)','FontSize',25);
ylabel('Deviation of Carbon Dioxide from The Baseline(PPM)','FontSize',25);
hold on
plot(timin(1:1000),initialv(1:1000),'--','color','black','linewidth',2);

set(gca,'FontSize',25)
[~, objh] = legend({'E.Coli Run', 'Initial Carbon Dioxide Value'}, 'location', 'NorthWest', 'Fontsize', 30);
objhl = findobj(objh, 'type', 'line'); %// objects of legend of type line
set(objhl, 'Markersize', 15);         %// set marker size as desired
legend boxoff

%%
%Display of Kolgomorov-Smirnov Plot 
clc;
%calculate the single side standard deviation
actstand2=(0.5*stdRun2);
%get the length to which the test will be conducted by using the shortest
%variable
lgth=baselineupper;
%variable initialization
pv=0;
yn=0;
inc = 30;
newtime=0;


%obtain lower bound of experimental run
aveR2lower = (aveR2-actstand2);

%Run for loop on increasing cumulative ranges of the experimental run and
%baseline

for c = 1:inc:58568
    %get the boolean detection value and the p-value
    %set the alpha value and ensure a single sided test is carried out to
    %determine whether the run is greater than the baseline
    [h,p]=kstest2(aveR2lower(1:c),baselineupper(1:c),'Tail','smaller', 'Alpha',0.001);
    %store p vals in matrix
    pv=[pv;p];
    %store boolean vals
    yn=[yn;h];
    %get time values where the kstest2 was evaluated
    newtime=[newtime;timin(c)];
end

%Get a column matrix equal to 0.001 to plot vs the p-val
siglevel(1:length(newtime))=0.001;
siglevel=siglevel';

%plot the p-val; boolean detection val and the significance value on the
%same plot

hold on
scatter(newtime,pv,'MarkerFaceColor',[0/255 153/255 151/255],'MarkerEdgeColor',[0/255 153/255 151/255]); %plots the p-value
hold on
% scatter(newtime,yn);
hold on
plot(newtime,siglevel,'LineWidth',3,'color','black')


set(gca, 'YScale', 'log')
set(gca,'FontSize',18);
xlabel('Time (minutes)','FontSize',25);
ylabel('Log of Probability','FontSize',25);

set(gca,'FontSize',25)
xlim([0 250]);
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
