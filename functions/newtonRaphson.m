function [V,delta,P,Q,errorHistory] = newtonRaphson(busData,Ybus)

%% Parámetros

tol=1e-6;

maxIter=20;

n=size(busData,1);

%% Inicialización

V=busData(:,3);

delta=deg2rad(busData(:,4));

Pspec=busData(:,5);

Qspec=busData(:,6);

errorHistory=[];

%% Iteraciones Newton-Raphson

for iter=1:maxIter

    [P,Q]=calcPower(V,delta,Ybus);

    %% Mismatch

    dP=Pspec-P;

    dQ=Qspec-Q;

    % Barra 1 Slack
    % Barra 2 PV
    % Barra 3 PQ

    mismatch=[

        dP(2)
        dP(3)
        dQ(3)

    ];

    error=max(abs(mismatch));

    errorHistory=[errorHistory;error];

    if error<tol

        fprintf('Convergencia alcanzada\n');

        fprintf('Iteraciones: %d\n',iter);

        return

    end

    %% Jacobiano simplificado

    J = createJacobian(V,delta,Ybus);

    G=real(Ybus);

    B=imag(Ybus);

    J=zeros(3,3);

    i=2;
    k=3;

    % J1

    J(1,1)= -Q(i)-B(i,i)*V(i)^2;

    J(1,2)=V(i)*V(k)*(...
        G(i,k)*sin(delta(i)-delta(k))...
        -B(i,k)*cos(delta(i)-delta(k)));

    J(2,1)=V(k)*V(i)*(...
        G(k,i)*sin(delta(k)-delta(i))...
        -B(k,i)*cos(delta(k)-delta(i)));

    J(2,2)= -Q(k)-B(k,k)*V(k)^2;

    % J2

    J(1,3)=V(i)*(...
        G(i,k)*cos(delta(i)-delta(k))...
        +B(i,k)*sin(delta(i)-delta(k)));

    J(2,3)=P(k)/V(k)+G(k,k)*V(k);

    % J3

    J(3,1)=P(k)-G(k,k)*V(k)^2;

    J(3,2)= -V(k)*V(i)*(...
        G(k,i)*cos(delta(k)-delta(i))...
        +B(k,i)*sin(delta(k)-delta(i)));

    % J4

    J(3,3)=Q(k)/V(k)-B(k,k)*V(k);

    %% Corrección

    correction=J\mismatch;

    %% Actualización

    delta(2)=delta(2)+correction(1);

    delta(3)=delta(3)+correction(2);

    V(3)=V(3)+correction(3);

end

fprintf('No convergió\n');

end