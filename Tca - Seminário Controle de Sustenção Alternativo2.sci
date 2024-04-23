// Definição das matrizes do sistema
A = [0 1; -81 -54];
B = [0; 1];
C = [54 9/10];
D = [0];

// Matriz de ganho L do observador (exemplo baseado em cálculos anteriores)
L = [27.76; -1425.31];
// Definindo o vetor de tempo e a entrada de degrau
t = 0:0.01:10;
u = ones(1, size(t, 'c'));

// Simulando a resposta do sistema (usando um loop manual ou funções específicas se disponível)
sys = syslin('c', A, B, C, D);
[x, y] = ode("rk", 0, [0; 0], t, sys, u);
// Inicialização do estado estimado e da saída estimada
x_hat = zeros(2, length(t));
y_hat = zeros(1, length(t));

for i=1:length(t)-1
    // Cálculo da derivada do estado estimado
    dx_hat = A*x_hat(:,i) + B*u(i) - L*(C*x_hat(:,i) - y(i));
    
    // Atualização do estado estimado
    x_hat(:,i+1) = x_hat(:,i) + dx_hat * 0.01; // Assumindo dt = 0.01 baseado no vetor de tempo
    
    // Cálculo da saída estimada
    y_hat(i) = C*x_hat(:,i);
end
y_hat($) = C*x_hat(:,$); // Calculando a última saída estimada
// Inicialização do estado estimado e da saída estimada
x_hat = zeros(2, length(t));
y_hat = zeros(1, length(t));

for i=1:length(t)-1
    // Cálculo da derivada do estado estimado
    dx_hat = A*x_hat(:,i) + B*u(i) - L*(C*x_hat(:,i) - y(i));
    
    // Atualização do estado estimado
    x_hat(:,i+1) = x_hat(:,i) + dx_hat * 0.01; // Assumindo dt = 0.01 baseado no vetor de tempo
    
    // Cálculo da saída estimada
    y_hat(i) = C*x_hat(:,i);
end
y_hat($) = C*x_hat(:,$); // Calculando a última saída estimada
// Plotando os estados reais
subplot(2, 1, 1);
plot(t, x');
title('Estados Reais');
xlabel('Tempo');
ylabel('Estados');

// Plotando os estados estimados pelo observador
subplot(2, 1, 2);
plot(t, x_hat');
title('Estados Estimados pelo Observador');
xlabel('Tempo');
ylabel('Estimativa dos Estados');
