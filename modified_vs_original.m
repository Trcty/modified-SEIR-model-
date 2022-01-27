% Focusing on one compartment by changing the parameter phi or rou and
% compare with original model with phi=0, rou=1

% S:1, E:2, I:3, R:4, N: 5

beta=0.57; %0.57
sigma=0.13;
gamma=0.067;
alpha=0.01;
rou=1;
A=0.005;
mu=0.005;
N0=4e7;
s0=1-1/N0;
e0=0;
r0=0;
i0=1/N0;
v0=0;
y0=[s0,e0,i0,r0,1];
q=0.8;
trange=[0,800];
phi=0;




comp_change(A, q, beta, mu, sigma, gamma,rou, alpha,phi,trange,y0, 'i', 3,'both',0);

