%%Run 3 plots with std dev
clc;

%calculate the single side standard deviation
%Plot the response using a graphing function by Rob Campbell
%Set plot aestetics
e=shadedErrorBar(timin(1:length(aveR3)),aveR3,(0.5*stdR3), 'lineprops', {'O','color',[0/255 153/255 151/255],'markerfacecolor',[0/255 153/255 151/255],'markerfacecolor',[0/255 153/255 151/255],'MarkerSize',4},'patchSaturation',0.33) ;
set(e.edge,'LineWidth',2,'LineStyle','none')
set(gca,'FontSize',18);
xlabel('Time (minutes)','FontSize',25);
ylabel('Deviation of Carbon Dioxide from its Initial Value(PPM)','FontSize',25);
xlim([0 1000]);
ylim([0 140]);
set(gca,'FontSize',24);
hold on


%Plot the baseline using the same function with standard deviation
%alter plot visually
e1 = shadedErrorBar(timin(1:length(aveBL)),aveBL,(0.5*stdevBL), 'lineprops', {'O','color',[255/255 75/255 30/255],'markerfacecolor',[255/255 75/255 30/255],'markerfacecolor',[255/255 75/255 30/255],'MarkerSize',4},'patchSaturation',0.6) ;
set(e1.edge,'LineWidth',2,'LineStyle','none')

% legend('E.Coli Run', 'Baseline'); % Add a legend
% set(legend,'FontSize',20);
% legend boxoff
initialv(1:length(timin))=0;
plot(timin,initialv,'--','color','black','linewidth',2);


set(gca,'FontSize',25)
[~, objh] = legend({'E.Coli Run', 'Baseline','Initial Carbon Dioxide Value'}, 'location', 'NorthWest', 'Fontsize', 30);
objhl = findobj(objh, 'type', 'line'); %// objects of legend of type line
set(objhl, 'Markersize', 15);         %// set marker size as desired
legend boxoff
%%
actstand= 0.5*sqrt((stdR3(1:length(aveBL))).^2+ stdevBL.^2)
initialv(1:length(aveBL))=0;
e1 = shadedErrorBar(timin(1:length(aveBL)),(aveR3(1:length(aveBL))-aveBL),(actstand), 'lineprops', {'O','color',[255/255 75/255 30/255],'markerfacecolor',[255/255 75/255 30/255],'markerfacecolor',[255/255 75/255 30/255],'MarkerSize',3},'patchSaturation',0.33) ;

set(e1.edge,'LineWidth',2,'LineStyle','none')
set(gca,'FontSize',18);
xlabel('Time (minutes)','FontSize',25);
ylabel('Deviation of Carbon Dioxide from The Baseline(PPM)','FontSize',25);
hold on
plot(timin(1:length(aveR3)),initialv(1:length(aveR3)),'--','color','black','linewidth',2);

set(gca,'FontSize',25)
[~, objh] = legend({'E.Coli Run', 'Initial Carbon Dioxide Value'}, 'location', 'NorthWest', 'Fontsize', 30);
objhl = findobj(objh, 'type', 'line'); %// objects of legend of type line
set(objhl, 'Markersize', 15);         %// set marker size as desired
legend boxoff

%%
%Display of Kolgomorov-Smirnov Plot 
clc;
%calculate the single side standard deviation
actstand3=(0.5*stdR3)
aveR3lower = (aveR3-actstand3);

%get the length to which the test will be conducted by using the shortest
%variable
lgth=length(baselineupper);

%variable initialization
pv=0;
yn=0;
inc = 20;
newtime3=0;

for c = 1:inc:lgth
    [h,p]=kstest2(aveR3lower(1:c),baselineupper(1:c),'Tail','smaller', 'Alpha',0.001)
    yn=[yn;h];
    pv=[pv;p];
    newtime3=[newtime3;timin(c)];
end

siglevel3(1:length(newtime3))=0.001;
hold on
% scatter(newtime3,yn);
hold on
scatter(newtime3,pv,'filled') %plots the p-value
hold on
plot(newtime3,siglevel3,'LineWidth',2,'color',[0 0 0/255])
hold on
plot(newtime3,siglevel3,'LineWidth',3,'color','black')
xlim([0 950]);

set(gca, 'YScale', 'log')
set(gca,'FontSize',18);
xlabel('Time (minutes)','FontSize',25);
ylabel('Log of Probability','FontSize',25);
set(legend,'FontSize',20);

set(gca,'FontSize',25)
[~, objh] = legend({'P-Value','Significance Level'}, 'location', 'NorthWest', 'Fontsize', 30);
objhl = findobj(objh, 'type', 'marker'); %// objects of legend of type line
set(objhl, 'Markersize',35);         %// set marker size as desired
objhl = findobj(objh, 'type', 'patch'); % objects of legend of type patch
set(objhl, 'Markersize', 18); % set marker size as desired
legend boxoff

