function [T, X, Y, Z, U, V, W] = satellite(Xo, Yo, Zo, Uo, Vo, Wo, Tf)

%Preallocate
dt = 1;

nt = ceil(Tf/dt);
T = zeros(1,nt);
X = zeros(1,nt);
Y = zeros(1,nt);
Z = zeros(1,nt);
U = zeros(1,nt);
V = zeros(1,nt);
W = zeros(1,nt);

%Initialize variables
T(1) = 0;
X(1) = Xo;
Y(1) = Yo;
Z(1) = Zo;
U(1) = Uo;
V(1) = Vo;
W(1) = Wo;

C = 2.2;
G = 6.67408e-11;
Me = 5.97e24;
m = 250;
A = 0.25;
d = 5.5e-12;

for n=1:nt
    SS = sqrt((U(n)^2)+(V(n)^2)+(W(n)^2));
    PP = (X(n)^2)+(Y(n)^2)+(Z(n)^2);
    U(n+1) = U(n) - (G*Me*((X(n))/(PP^(1.5)))+((C*d*A)/(2*m))*U(n)*SS)*dt;
    V(n+1) = V(n) - (G*Me*((Y(n))/(PP^(1.5)))+((C*d*A)/(2*m))*V(n)*SS)*dt;
    W(n+1) = W(n) - (G*Me*((Z(n))/(PP^(1.5)))+((C*d*A)/(2*m))*W(n)*SS)*dt;
    X(n+1) = X(n) + U(n+1)*dt;
    Y(n+1) = Y(n) + V(n+1)*dt;
    Z(n+1) = Z(n) + W(n+1)*dt;
    T(n+1) = T(n) + dt;
end

end %function satellite