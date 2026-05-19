clc
clear
close all

%% Datos barras

busData=[

1 1 1.04 0 0 0
2 2 1.01 0 0.5 0
3 3 1 0 -0.8 -0.3

];

%% Datos líneas

lineData=[

1 2 0.02 0.06
1 3 0.08 0.24
2 3 0.06 0.18

];

addpath('functions')

Ybus=createYbus(lineData);

[V,delta,P,Q,errorHistory] = newtonRaphson(busData,Ybus);

disp('Ángulos en radianes:')
disp(delta)

disp('Ángulos en grados:')
disp(rad2deg(delta))

disp('Voltajes')

disp(V)

disp('Ángulos')

disp(rad2deg(delta))

figure

bar(V)

xlabel('Bus')

ylabel('Voltage (pu)')

title('Voltage Profile')

grid on

s=[1 1 2];

t=[2 3 3];

G=graph(s,t);

figure

plot(G)

T=table(V,P,Q);

writetable(T,'results/results.csv')

saveas(gcf,'plots/VoltageProfile.png')
figure

bar(V)

xlabel('Bus')

ylabel('Voltage (pu)')

title('Voltage Profile')

grid on

figure

plot(errorHistory)

xlabel('Iteration')

ylabel('Error')

title('Newton-Raphson Convergence')

grid on
