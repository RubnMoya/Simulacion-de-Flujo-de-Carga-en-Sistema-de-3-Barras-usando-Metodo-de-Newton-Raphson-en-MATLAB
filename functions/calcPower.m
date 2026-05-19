function [P,Q] = calcPower(V,delta,Ybus)

n = length(V);

P = zeros(n,1);
Q = zeros(n,1);

G = real(Ybus);
B = imag(Ybus);

for i = 1:n

    for k = 1:n

        P(i) = P(i) + V(i)*V(k)*( ...
            G(i,k)*cos(delta(i)-delta(k)) + ...
            B(i,k)*sin(delta(i)-delta(k)) );

        Q(i) = Q(i) + V(i)*V(k)*( ...
            G(i,k)*sin(delta(i)-delta(k)) - ...
            B(i,k)*cos(delta(i)-delta(k)) );

    end

end

end