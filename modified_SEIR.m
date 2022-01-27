% system of differential equations of modified SEIR

function dydt=modified_SEIR(y, A, q, beta, mu, sigma, gamma,rou,alpha,phi)
%{
A: Proportion of new individuals per unit of time 
β: Transmission rate
mu: Natural mortality rate
sigma: Inverse of the latent period
gamma: Recovery rate
alpha: Mortality rate caused by infection 
q: Fraction of vaccinated newborns
rou: efficacy of vaccination
phi: rate of losing immunity 
y: contains initial conditions
%}

%{
s: Proportion of susceptible individuals
e: Proportion of exposed individuals
i: Proportion of infectious individuals
r: Proportion of recovered individuals
N: population , normalied to 1
%}
    s=y(1);
    e=y(2);
    i=y(3);
    r=y(4);
    N=y(5);
    
    dsdt= (1-rou*q)*A - (beta*i+mu)*s+phi*r;
    dedt= beta*s*i-(mu+sigma)*e;
    didt= sigma*e-(mu+gamma+alpha)*i;
    drdt=gamma*i-mu*r+rou*q*A-phi*r;   
    dndt=A-N*mu-alpha*i;

    dydt=[dsdt;dedt;didt;drdt;dndt];

end