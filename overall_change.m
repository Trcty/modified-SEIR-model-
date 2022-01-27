% visualize changes of SEIRN of original model or modified model

function overall_change(A, q, beta, mu, sigma, gamma, rou,alpha,phi,trange,y0,name, graph)
%{
for original model, rou=1, phi=0
for modified model, q is fixed
trange: [start time, ends time]
y0:intial condition for S,E,I,R,N
name: parameter that is to be studied, (phi, rou, or q)
graph: save each plot if setting it equal to 1, otherwise no plot will be
        saved 
%} 
    step=10;
    q_data=linspace(0,1,step);
    rou_data=linspace(1,0,step);
    phi_data=linspace(0,1/200,step);
    video_name=sprintf("overall change with respect to %s",name);
    
    B=(mu+sigma)*(mu+gamma+alpha);
    D=mu*mu+phi*mu;
    

    v = VideoWriter(video_name); 
    v.FrameRate=1;
    v.open()
    
    for i=1:step
        if(strcmp(name, "q"))
            [t,y]=ode45(@(t,y)SEIR(y, A, q_data(i), beta, mu, sigma, gamma, alpha),trange,y0);
            betac=mu*(mu+sigma)*(mu+gamma+alpha)/(A*sigma*(1-q_data(i)));
            fprintf('when q= %.4f, bet_critical=%.4f\n', q_data(i), betac);
             graph_name=sprintf('q= %.2f',q_data(i) );
        elseif(strcmp(name, "rou"))
            [t,y]=ode45(@(t,y)modified_SEIR(y, A, q, beta, mu, sigma, gamma,rou_data(i),alpha, phi),trange,y0);
            C=mu*A-mu*rou_data(i)*q*A+phi*A;
             betac=B*D/C/sigma;
             fprintf('when rou= %.4f, bet_critical=%.4f\n', rou_data(i), betac);
             graph_name=sprintf('vaccination effectiveness = %.5f',rou_data(i) );
        elseif(strcmp(name, "phi"))
            [t,y]=ode45(@(t,y)modified_SEIR(y, A, q, beta, mu, sigma, gamma,rou,alpha, phi_data(i)),trange,y0);
            C=mu*A-mu*rou*q*A+phi_data(i)*A;
            betac=B*D/C/sigma;
            fprintf('when phi= %.4f, bet_critical=%.4f\n', phi_data(i), betac);
             graph_name=sprintf('rate of losing immunity = %.5f',phi_data(i) );
        end
        plotSEIR(t,y);
        
        sf=y(length(y),1);
        ef=y(length(y),2);
        If=y(length(y),3);
        rf=y(length(y),4);
        nf=y(length(y),5);
        txts=sprintf('S_f=%.3f',sf);
        txte=sprintf('E_f=%.3f',ef);
        txti=sprintf('I_f=%.3f',If);
        txtr=sprintf('R_f=%.3f',rf);
        txtn=sprintf('N_f=%.3f',nf);
        text(trange(2)/2,sf, txts);
        text(trange(2),ef, txte); 
        text(trange(2)*2/3,If, txti); 
        text(trange(2)/3,rf, txtr); 
        text(trange(2),nf, txtn); 
        title(graph_name);
        if(graph==1)
             filename=sprintf('change_%s_%d.png', name,i);
             saveas(gcf,filename);
        end
        
        frame=getframe(gcf);
   
        writeVideo(v, frame);
        pause(0.8);
    end
    v.close();
    
end