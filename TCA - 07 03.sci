A = [1, 2; -3 -4]; B = [1;2]
MC = [B A*B]; MCI = inv(MC)
PDA = A^2 + 20*A + 200*eye(2,2)
K = [0 1]*MCI*PDA
AMF = A-B*K
C = [1 0]; D = 0; Xi = [0 0]'
BF = [1 ; 2]; CF = [1 0]; Xf = [0 0];

//Continuação na aula 13-03

contr(A, B)
sMA = syslin('c', A, B, C, D, Xi)
t = 0:0.01:8;
plot2d(t', csim('step', t,sMA, Xi),style = [color("blue")],leg = "Sistema Malha Aberta")
sMF = syslin('c', AMF, B, C, D, Xi)
mtlb_hold("on")
plot2d(t', csim('step', t,sMF, Xi),style = [color("green")],leg = "Sistema Observador")
