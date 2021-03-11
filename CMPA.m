% Ryan Lindsay 101038101


%% Part 1

V = linspace(-1.95,0.7,200);
L = length(V);

Is = 0.01e-12;

Ib = 0.1e-12;

Vb = 1.3;

Gp = 0.1;


I  = zeros(1,L);

Irand = -0.1 + (0.2).*rand(1,L);


for i = 1:200
    
    I(i) = Is*(exp((1.2/.025)*V(i))-1)+(Gp*V(i))-(Ib*exp(-(1.2/0.025)*(V(i) +Vb)-1)); 
    
    Iv(i) = I(i) + Irand(i);
    
end


figure(1)
plot(V,Iv)



figure(2)
semilogy(V,abs(I))


%% Part 2

P1 = polyfit(V,I,4);

P2 = polyfit(V,I,8);


V1 = polyval(P1,V);

V2 = polyval(P2,V);



figure(3)
plot(V,I)
hold on 
plot(V,V1)
title('4th Order')
xlabel('Voltage V')
ylabel('Current pA')
hold off


figure(4)
plot(V,I)
hold on
plot(V,V2)
title('8th Order')
xlabel('Voltage V')
ylabel('Current pA')
hold off



figure(5)
semilogy(V,abs(I))
hold on 
semilogy(V,abs(V1))
title('4th Order')
xlabel('Voltage V')
ylabel('Current pA')
hold off


figure(6)
semilogy(V,abs(I))
hold on
semilogy(V,abs(V2))
title('8th Order')
xlabel('Voltage V')
ylabel('Current pA')
hold off





%% Part 3

I = I';
V = V';

fo = fittype('A.*(exp(1.2*x/25e-3)-1) + 0.1.*x - C*(exp(1.2*(-(x+1.3))/25e-3)-1)');
ff = fit(V,I,fo);
If = ff(V);


%Second Case 
fo2 = fittype('A.*(exp(1.2*x/25e-3)-1) + B.*x - C*(exp(1.2*(-(x+1.3))/25e-3)-1)');
ff2 = fit(V,I,fo2);
If2 = ff2(V);

%Third Case 
fo3 = fittype('A.*(exp(1.2*x/25e-3)-1) + B.*x - C*(exp(1.2*(-(x+D))/25e-3)-1)');
ff3 = fit(V,I,fo3);
If3 = ff3(V);

figure(7)
semilogy(V,abs(If1))
hold on 
semilogy(V,abs(If2))
semilogy(V,abs(If3))
legend('If1','If2','If3')

%% Part 4: Neutral Net 

inputs = V.';
targets = I.';
hiddenLayerSize = 10;
net = fitnet(hiddenLayerSize);
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
[net,tr] = train(net,inputs,targets);
outputs = net(inputs);
errors = gsubtract(outputs,targets);
performance = perform(net,targets,outputs);
view(net);
Inn = outputs;

figure(8)
plot(V,Inn)
hold on 
plot(V,I)
title 'Neural Fit'

figure(9)
semilogy(V,abs(Inn))
hold on 
semilogy(V,abs(I))
title 'Neural Fit SemiLog'
