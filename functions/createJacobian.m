function J = createJacobian(V,delta,Ybus)

G = real(Ybus);
B = imag(Ybus);

n = length(V);

J = zeros(3,3);

i = 2;
k = 3;

theta = delta(i) - delta(k);

%% J11 = dP/dθ2
J(1,1) = -V(i)*V(k)*(G(i,k)*sin(theta) - B(i,k)*cos(theta));

%% J12 = dP/dθ3 (aprox simplificada)
J(1,2) = V(i)*V(k)*(G(i,k)*sin(theta) - B(i,k)*cos(theta));

%% J13 = dP/dV3
J(1,3) = V(i)*(G(i,k)*cos(theta) + B(i,k)*sin(theta));

%% J21 = dQ/dθ2
J(2,1) = -V(i)*V(k)*(G(i,k)*cos(theta) + B(i,k)*sin(theta));

%% J22 = dQ/dθ3
J(2,2) = V(i)*V(k)*(G(i,k)*cos(theta) + B(i,k)*sin(theta));

%% J23 = dQ/dV3
J(2,3) = V(i)*(G(i,k)*sin(theta) - B(i,k)*cos(theta));

%% fila adicional simplificada para estabilidad numérica
J(3,:) = J(2,:);

end