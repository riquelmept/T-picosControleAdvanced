/*Aula 29-02
Resolvendo sistema
*/

clear all; close;
// Sistema na Forma Original
A=[-5 1 0;0 -2 1; 0 0 -1];
B=[0 0 1]';
C=[-1 1 0];
d=0; 

//Sistema Original
x0=[0 0 0]'; //Condiçoes iniciais

t=0:0.01:8 //Intervalo de simulação

//Criando o Sistema Linear em espaço contínuo Malha Aberta Original
sMAo = syslin('c',A,B,C,d,x0)

//Simulando o sistema em Malha Aberta
//[y, x] = csim(u, t, sMA, x0)

plot2d(t',csim('step', t, sMAo, x0),style=[color("blue")], leg="Sistema Original")

//Matriz de Controlabilidade do Sistema: 3° grau
Mc = [B A*B (A^2)*B]

//Sistema na Forma Canônica Controlável - FCC
Ap=[0 1 0;0 0 1; -10 -17 -8];
Bp=[0 0 1]';
Cp=[4 1 0];
dp=0; //Sistema na FCC
x0=[0 0 0]'; //Condiçoes iniciais
t=0:0.01:8 //Intervalo de simulação

//Criando o Sistema Linear em espaço contínuo Malha Aberta FCC
sMAp = syslin('c',Ap,Bp,Cp,dp,x0)

//Simulando o sistema em Malha Aberta na FCC
plot2d(t',csim('step', t, sMAp, x0), style=[color("red")],leg="Sistema na FCC")

//Matriz de Controlabilidade do Sistema: 3° grau
Mcp = [Bp Ap*Bp (Ap^2)*Bp]

//Criando o polinômio característico de Malha Aberta e Malha Fechada
s=poly(0,'s');

//Problema de Autovalores: Malha Aberta
pMA = det(s*eye(3,3)-A)// ou pMAp = det(s*eye(3,3)-Ap)

//Polinômio característico desejado
pMF = (s-(-1+%i*2))*(s-(-1-%i*2))*(s-(-4))

//Vetor de Ganhos K para FCC (Kfase)
Kfase = coeff(pMF)-coeff(pMA)

//Retirando o coeficiente da maior potência
Kfase =real(Kfase(1:length(Kfase)-1)) 

//Obtendo K na forma original do Sistema
//-->Transformação P
P = Mc*inv(Mcp)
K = Kfase*inv(P)

//Sistema Original Realimentado
AMF =[A-B*K]; //Realimentação da Matriz Dinâmica

sMF = syslin('c',AMF,B,C,d,x0)

figure
plot2d(t',csim('step', t, sMAo, x0), style=[color("blue")])

plot2d(t',csim('step', t, sMF, x0), style=[color("red")])
//legends(["Sistema Original";"Sistema Realimentado"],[color("blue"); color("red")],with_box=%f, opt="ul")

/*
K=[-2 0]; //Matriz de Ganhos
AMF=[A+B*K]; //Matriz Dinamica realimentada
//t=0:0.01:5; //Tempo da simulaçao
sMF = syslin('c',AMF,B,C,d,x0)
//Simulando o sistema em Malha Aberta
//[y, x] = csim(u, t, sMA, x0)
figure
plot2d(t',csim('step', t, sMF, x0))
