%%

clc;

e1 = shadedErrorBar(timin(1:length(aveBL)),aveBL,(0.5*stdevBL), 'lineprops', {'o','color',[255/255 75/255 30/255],'markerfacecolor',[255/255 75/255 30/255],'markerfacecolor',[255/255 75/255 30/255],'MarkerSize',3.5},'patchSaturation',1) ;
set(e1.edge,'LineWidth',2,'LineStyle','none')
hold on

e=scatter(timin(1:length(aveR4)),aveR4,3.5);
set(gca,'FontSize',18);
xlabel('Time (minutes)','FontSize',25);
% ylabel('Carbon Dioxide (PPM)','FontSize',25);
set(e,'MarkerFaceColor', [0/255 153/255 151/255],'MarkerEdgeColor',[0/255 153/255 151/255]);
xlim([0 1000]);

initialv(1:length(timin))=0;
plot(timin,initialv,'--','color','black','linewidth',2);
xlabel('Time (minutes)','FontSize',25);
ylabel('Deviation of Carbon Dioxide from its Initial Value(PPM)','FontSize',25);

set(gca,'FontSize',25)
[~, objh] = legend({'Baseline','Mixed River Run','Initial Carbon Dioxide Value'}, 'location', 'NorthWest', 'Fontsize', 30);
objhl = findobj(objh, 'type', 'line'); %// objects of legend of type line
set(objhl, 'Markersize', 20);         %// set marker size as desired

objhl = findobj(objh, 'type', 'patch'); % objects of legend of type patch
set(objhl, 'Markersize', 20); % set marker size as desired
legend boxoff;

%%
actstand= 0.5*sqrt(stdevBL.^2)
initialv(1:length(aveBL))=0;
e1 = shadedErrorBar(timin(1:length(aveBL)),(aveR4(1:length(aveBL))-aveBL),(actstand), 'lineprops', {'O','color',[255/255 75/255 30/255],'markerfacecolor',[255/255 75/255 30/255],'markerfacecolor',[255/255 75/255 30/255],'MarkerSize',3},'patchSaturation',0.33) ;

set(e1.edge,'LineWidth',2,'LineStyle','none')
set(gca,'FontSize',18);
xlabel('Time (minutes)','FontSize',25);
ylabel('Deviation of Carbon Dioxide from The Baseline(PPM)','FontSize',25);
hold on
plot(timin(1:length(aveR4)),initialv(1:length(aveR4)),'--','color','black','linewidth',2);

set(gca,'FontSize',25)
[~, objh] = legend({'E.Coli Run', 'Initial Carbon Dioxide Value'}, 'location', 'NorthWest', 'Fontsize', 30);
objhl = findobj(objh, 'type', 'line'); %// objects of legend of type line
set(objhl, 'Markersize', 15);         %// set marker size as desired
legend boxoff

%%
clc;
lgth=length(baselineupper);
pv=0;
yn=0;
inc =80;
newtime4=0;

for c = 1:inc:58568
    [h,p]=kstest2(aveR4(1:c),baselineupper(1:c),'Tail','smaller', 'Alpha',0.001)
    pv=[pv;p];
    yn=[yn;h];
    newtime4=[newtime4;timin(c)];
end
siglevel4(1:length(newtime4))=0.001;

hold on
scatter(newtime4,pv,'filled') %plots the p-value
hold on
% scatter(newtime4,yn);
hold on
plot(newtime4,siglevel4(1:length(newtime4)),'LineWidth',2,'color',[0 0 0/255])

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

%%
kstest2(aveR4,baselineupper,'Tail','smaller')

%%
clc;
y=length(aveR4)-1;
x=linspace(1,y,y)';

lgth=length(aveBL)-1;
pv=0
hv=0
for c = 1:60:lgth
    [h,p]=kstest2(aveR4(c),baselineupper(c),'Tail','smaller')
    pv=horzcat(pv,p)
    yn=horzcat(hv,h)
end
plot(timin(1:length(yn)),yn)
hold on
%plot(timin(1:length(pv)),pv)
%%
clc;
y=length(aveR4)-1;
x=linspace(1,y,y)';
lgth=length(aveBL)-1;
p=zeros(58567,1);


p=kstest22(aveR4(1:lgth),baselineupper(1:lgth),'Tail','smaller')



% [h,p]  = kstest2(aveR4(1:lgth),baselineupper(1:lgth),'Tail','smaller');




