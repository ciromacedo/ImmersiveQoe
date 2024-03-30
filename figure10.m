clear;
Wid=1;
% colororder({'b','r'})
PkRper = 15:1:25;
for i = 1 : length(PkRper)
    [Res1(i),Res2(i),Res3(i),Res4(i)] = disanzhangtu(15, PkRper(i));
end

del = (Res3-Res2)./Res2;
yyaxis left
plot(PkRper,Res2,'b-x','LineWidth',Wid);hold on;
plot(PkRper,Res1,'b--s','LineWidth',Wid);hold on;
plot(PkRper,Res3,'b-.+','LineWidth',Wid);hold on;
plot(PkRper,Res4,'b-o','LineWidth',Wid);hold on;
ylabel('Meta-Immersion (QoE)')
yyaxis right
plot(PkRper,del,'r--o','LineWidth',Wid);hold on;grid on;
xlabel('Total Rendering Capacity/$N_{O3}$ $({\rm K})$')
ylabel('Improment from A2 to A3')
legend('A1: Random power allocation','A2: Uniform power allocation','A3: Semantic-aware power allocation','A4: Upper-bound','Improment')
set(gca,'fontname','Times New Roman','FontSize',12,'FontWeight','normal');

axis([15 25 0 0.7])