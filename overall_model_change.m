% visualize changes of S E I R N in one plot with respect to time 

beta=0.57; % original data: 0.57
sigma=0.13;
gamma=0.067; %0.067
alpha=0.01;
rou=1;
A=0.005; %0.005
mu=0.005;
q=0.8; % 0.8
N0=4e7;
s0=1-1/N0;
e0=0;
r0=0;
i0=1/N0;
v0=0;
y0=[s0,e0,i0,r0,1];
phi=0;
trange=[0,800];

% plot graph of S E I R N 
overall_change(A, q, beta, mu, sigma, gamma,rou,alpha,phi,trange,y0,'q',0);



