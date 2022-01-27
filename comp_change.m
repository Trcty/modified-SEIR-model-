function comp_change(A, q, beta, mu, sigma, gamma, rou,alpha,phi,trange,y0, name, position, variable, graph)
%{
description: Focusing on one compartment by changing the parameter phi or rou and
              compare with original model with phi=0, rou=1. The resulting
              animation will be saved 

A: Proportion of new individuals per unit of time 
β: Transmission rate
mu: Natural mortality rate
sigma: Inverse of the latent period
gamma: Recovery rate
alpha: Mortality rate caused by infection 
q: Fraction of vaccinated newborns
rou: efficacy of vaccination
phi: rate of losing immunity 
name: name of the compartment that will be plotted against time
position: S=1, E=2, I=3, R=4, N= 5
variable: change of  rou, phi, or both will be plotted against time
graph: save each plot if setting it equal to 1, otherwise no plot will be
        saved 

%}
    [t1,y1]=ode45(@(t,y)SEIR(y, A, q, beta, mu, sigma, gamma, alpha),trange,y0);

    step=10;
    rou_data=linspace(1,0,step);
    phi_data=linspace(0,1/200,step);
    name=upper(name);
    videoname=sprintf('%s_%s', name, variable);
    v = VideoWriter(videoname); 
    v.FrameRate=1;
    v.open()

    
for i =1:step
    
if(strcmp(variable, 'rou'))
    [t,y]=ode45(@(t,y)modified_SEIR(y, A, q, beta, mu, sigma, gamma,rou_data(i),alpha, phi),trange,y0);
    graph_name=sprintf('modified %s vs original %s : effectiveness = %.2f',name, name, rou_data(i));
elseif(strcmp(variable, 'phi'))
    [t,y]=ode45(@(t,y)modified_SEIR(y, A, q, beta, mu, sigma, gamma,rou,alpha, phi_data(i)),trange,y0);
    graph_name=sprintf('modified %s vs original %s : waning rate = %.6f',name, name, phi_data(i));
elseif(strcmp(variable, 'both'))
    [t,y]=ode45(@(t,y)modified_SEIR(y, A, q, beta, mu, sigma, gamma,rou_data(i),alpha, phi),trange,y0);
    [t2,y2]=ode45(@(t,y)modified_SEIR(y, A, q, beta, mu, sigma, gamma,rou,alpha, phi_data(i)),trange,y0);
    graph_name=sprintf('original: phi= %.6f,rou= %.2f\neffectiveness: fixed phi= %.6f, rou= %.2f\nwaning rate: phi = %.6f, fixed rou= %.2f',phi, rou,phi,rou_data(i),phi_data(i),rou);
end
    plot(t1, y1(:,position),'r','LineWidth',1.5);
    hold on;
    plot(t, y(:,position),'b','LineWidth',1.5);

if(strcmp(variable, 'both'))
    plot(t2,y2(:,position),'g','LineWidth',1.5);
end
    ori=y1(length(y1),position);
    txt_ori=sprintf('%s_f=%.3f',name, ori);
    text(trange(2)/7,ori, txt_ori,'FontSize',14);
    
    mod=y(length(y), position);
    txt_mod=sprintf('M_e%s_f=%.3f',name, mod);
    text(trange(2)/3,mod, txt_mod,'FontSize',14);
    
    if(strcmp(variable, 'both'))
        mod2=y2(length(y2), position);
        txt_mod2=sprintf('M%s_f=%.3f',name, mod2);
        text(trange(2)/20,mod2, txt_mod2,'FontSize',14);
    end
    
  
    hold off;
    ylim([0,1.1]);
    title(graph_name,'FontSize',16);
    xlabel('Time(days)','FontSize',16);
    ylabel('Proportion', 'FontSize',16);

if(strcmp(variable, 'both'))
    legend({'fixed original','effectiveness change', 'waning rate change'},'FontSize',16);
else
    legend({'original','modified'},'FontSize',18);
end

if(graph==1)
    filename=sprintf('q=%.2f_%s_%d_%s.png', q,name,i,variable);
    saveas(gcf,filename);
end

    f=getframe(gcf);
    writeVideo(v, f);
    pause(1);

end
v.close();
end