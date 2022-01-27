% plot solution trajectory  of SEIR model 

function plotSEIR(t, y)
% t: time interval
% y: solutions of S E I R N at each t

plot(t, y(:,1),'b','LineWidth',1.5)
hold on
plot(t, y(:,2), 'm','LineWidth',1.5);
plot(t,y(:,3),'r','LineWidth',1.5);
plot(t,y(:,4),'k','LineWidth',1.5);
plot(t,y(:,5),'g','LineWidth',1.5);

hold off
xlabel('Time(days)','FontSize',16);
ylabel('Proportion','FontSize',16);
ylim([0,1.1]);
legend('susceptible','exposed','infectious','recovered','total population','FontSize',10);

end