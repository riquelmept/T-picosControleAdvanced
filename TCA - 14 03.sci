A = [-3 1; -1 0]; B = [0;1]; C = [1 0];
MOB = [C; C*A]
det(MOB)
rank(MOB)
s = %s
PA = det(s*eye(2,2)-A)
polos = roots(PA)

PD = (s - 10*polos(1))*(s - 10*polos(2))
/* Aumentando a frequência visando diminuir o período
Multiplicando os polos por 10*/

coef_pd = coeff(PD);
coef_pd
/*Separa os coeficientes do polinômio em um vetor
No polinômio em questão são 100, 30 e 1*/

L = (A^2 + 30*A + 100*eye(2,2))* inv(MOB)*[0;1]
/*eye() cria matriz identidade nas dimensões x e y que definirmos
Exemplo (2,2) 
1 0
0 1
*/

AOB = A-L*C
GMA = C*inv(s*eye(2,2)-A)*B
GOB = C*inv(s*eye(2,2)-AOB)*B
Xi = [1 1]';
t = 0:0.01:15
sGMA = syslin('c', A, B, C, 0, Xi);
sGOB = syslin('c', AOB, B, C, 0, Xi);
plot2d(t', csim('step', t,sGMA, Xi),style = [color("blue")],leg = "Sistema Malha Aberta")
mtlb_hold("on")
plot2d(t', csim('step', t,sGOB, Xi),style = [color("red")],leg = "Sistema Observador")
GOB = 100*C*inv(s*eye(2,2)-AOB)*B
plot2d(t', csim('step', t,tf2ss(GOB), Xi),style = [color("green")],leg = "Sistema Observador Compensado")
