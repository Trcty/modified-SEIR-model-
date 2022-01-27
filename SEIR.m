function dydt=SEIR(y, A, q, beta, mu, sigma, gamma, alpha)
%{

A: Proportion of new individuals per unit of time 
β: Transmission rate
mu: Natural mortality rate
sigma: Inverse of the latent period
gamma: Recovery rate
alpha: Mortality rate caused by infection 
q: Fraction of vaccinated newborns
y: contains initial proportion of S E I R N
%}

% s: Proportion of susceptible individuals
% e: Proportion of exposed individuals
% i: Proportion of infectious individuals
% r: Proportion of recovered individuals
% N: population , normalied to 1
    s=y(1);
    e=y(2);
    i=y(3);
    r=y(4);
    N=y(5);
    dsdt= (1-q)*A - (beta*i+mu)*s;
    dedt= beta*s*i-(mu+sigma)*e;
    didt= sigma*e-(mu+gamma+alpha)*i;
    drdt=q*A+gamma*i-mu*r;
    dndt=A-N*mu-alpha*i;
    dydt=[dsdt;dedt;didt;drdt;dndt];

end