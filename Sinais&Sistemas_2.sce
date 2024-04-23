//------------------------------------------------
// Gráfico equação diferença
//------------------------------------------------
//clear all; clc;
// Define o eixo horizontal n de -2 a 50
n=-2:50;
// Define o sinal de entrada x[n]. O termo (n>=0) é uma comparação que retorna
// 1 caso seja verdadeira e retorna zero se for falsa, o resultado é multiplicado
// pela exponencial que ficará com os termos referentes a 'n' negativo zerados.
x = (0.9).^n  .*(n>=0);
y=zeros(x);               // Define o vetor y[]
// Condições iniciais
y(1)=0.2;  //corresponde a y[-2]
y(2)=0.5;    //corresponde a y[-1]
for k=3:length(y)
         y(k) = 1.2*y(k-1)-0.7*y(k-2)+x(k)+0.4*x(k-1);
end
//figure(20);
//Plota um gráfico com os dois sinais.
subplot(2,1,1);
bar(n,x, 0.2);
//xlabel("n");
ylabel("x[n]", "fontsize", 5)
title("Método Recursivo", "fontsize",4);
replot([-2,0, 51,1.1])
//xgrid()
subplot(2,1,2);
bar(n,y, 0.2);
xlabel("n", "fontsize", 5);
ylabel("y[n]", "fontsize", 5)
replot([-2,0, 51, 3.5])

mprintf('[%d , %f , %f]\n', [n' x' y'])

//xgrid()
