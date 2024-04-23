//------------------------------------------------
// Gráfico equação diferença
//------------------------------------------------
clear all; clc;
// Define o eixo horizontal n de -2 a 50
n=-2:50;
// Define o sinal de entrada x[n]. O termo (n>=0) é uma comparação que retorna
// 1 caso seja verdadeira e retorna zero se for falsa, o resultado é multiplicado
// pela exponencial que ficará com os termos referentes a 'n' negativo zerados.
x = (0.8).^n  .*(n>=0);
y=zeros(x);               // Define o vetor y[]
// Condições iniciais
y(1)=0.8;  //corresponde a y[-2]
y(2)=1;    //corresponde a y[-1]
for k=3:length(y)
         y(k) = 1.4*y(k-1)-0.48*y(k-2)+2*x(k)-1.2*x(k-2);
end
//figure(20);
//Plota um gráfico com os dois sinais.
subplot(2,1,1);
bar(n,x, 0.2);
xlabel("n");
ylabel("x[n]")
title("Método Recursivo", "fontsize",3);
replot([-3,0, 40,1.1])
xgrid()
subplot(2,1,2);
bar(n,y, 0.2);
xlabel("n");
ylabel("y[n]")
replot([-3,0, 40,7])
xgrid()
