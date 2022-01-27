% system of differential equations of SIR model

function dydt = SIR(y, beta, gamma,N)

    dsdt= -beta*y(1)*y(2)/N;
    didt= beta*y(1)*y(2)/N - gamma*y(2);
    drdt= gamma*y(2);
    dydt=[dsdt;didt;drdt];  
    
end