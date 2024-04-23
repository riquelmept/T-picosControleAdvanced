clear
k1 = 30000;
k2 = 30000;
d1 = 2.50;
d2 = 2.50;
M = 400;
M1 = 120;
M2 = 120;
L = 5.0;
L1 = 50.0;
L2 = 3.7;
L0 = 0.3;
Y_0 = L0;
b = 0.1;
c1 = 2100.0;
c2 = 2100.0;
v = 18.0;
g = 9.8;
H = 0.1;
b1 = 0.7;
y0 = [L0; 0.0; 0.0; 0.0; 0.0];
JO = M*(b*b + L*L)/12;
A = M1 + M2 + M;
B = (M1*d1 - M2*d2);
C = M1*d1*d1 + M2*d2*d2 + M*(b*b + L*L)/12;
tA1 = L1/v
tA2 = (L1 + L2)/v
tB1 = (L1 + L)/v
tB2 = (L1 + L2 + L)/v
t_inicial = 0.0;
Dt = 0.001;
t_final = 10.0;
t = [t_inicial:Dt:t_final];
function [dy]=car(t,y)
if t < tA1 then
yA = 0.0;
dyA = 0.0;
else
if t < tA2 then
yA = H*(1 - cos(2*%pi*(v*t - L1)/L2))/2;
dyA = H*(sin(2*%pi*(v*t - L1)/L2))*%pi*v/L2;
else
yA = 0.0;
dyA = 0.0;
end
end
if t < tB1 then
yB = 0.0;
dyB = 0.0;
else
if t < tB2 then
yB = H*(1 - cos(2*%pi*(v*t - L1 - L)/L2))/2;
dyB = H*(sin(2*%pi*(v*t - L1 - L)/L2))*%pi*v/L2;
else
yB = 0.0;
dyB = 0.0;
end
end
F = -A*g + B*sin(y(3))*y(4)*y(4) + k1*(L0-y(1) - L*sin(y(3))/2 + yA) +...
k2*(L0-y(1)+L*sin(y(3))/2 + yB) - c1*(y(2) + L*y(4)*cos(y(3))/2 - dyA) - ...
c2*(y(2) - L*y(4)*cos(y(3))/2 - dyB);
H = -B*g*cos(y(3)) + k1*L*cos(y(3))*(L0 - y(1) - L*sin(y(3))/2 + yA)/2 - ...
k2*L*cos(y(3))*(L0 - y(1) + L*sin(y(3))/2 + yB)/2 - c1*L*cos(y(3))*(y(2) + ...
L*y(4)*cos(y(3))/2 - dyA)/2 + c2*L*cos(y(3))*(y(2) - L*y(4)*cos(y(3))/2 - dyB)/2;
determinante = A*C - B*B*cos(y(3))*cos(y(3));
dy1 = y(2);
dy2 = (C*F - B*cos(y(3))*H)/determinante;
dy3 = y(4);
dy4 = (A*H-B*cos(y(3))*F)/determinante;
dy5 = dy2;
dy = [dy1;dy2;dy3;dy4;dy5];
endfunction
