// Definição das matrizes do sistema
A = [0 1; -81 -54];
B = [0; 1];
C = [54 9/10];
D = [0];

// Matriz de ganho L do observador
L = [27.76; -1425.31];

// Definindo o vetor de tempo e a entrada de degrau
t = 0:0.01:10;
u = ones(size(t));

// Inicialização dos estados do sistema e do observador
x = zeros(2, length(t)); // Estados reais
x_hat = zeros(2, length(t)); // Estados estimados
y = zeros(1, length(t)); // Saídas medidas

// Loop de simulação para o sistema e o observador
for i=1:length(t)-1
    // Simulação do sistema
    dx = A*x(:,i) + B*u(i);
    x(:,i+1) = x(:,i) + dx * 0.01; // Assumindo dt = 0.01 baseado no vetor de tempo
    y(i) = C*x(:,i) + D*u(i); // Calculando a saída medida
    
    // Simulação do observador
    dx_hat = A*x_hat(:,i) + B*u(i) + L*(y(i) - C*x_hat(:,i));
    x_hat(:,i+1) = x_hat(:,i) + dx_hat * 0.01; // Atualizando o estado estimado
end
y($) = C*x(:,$) + D*u($); // Calculando a última saída medida para completar o vetor y

// Plotando os resultados
scf(0); // Abrindo uma nova janela gráfica
subplot(2, 1, 1);
plot(t, x');
xtitle('Estados Reais', 'Tempo', 'Estados');
subplot(2, 1, 2);
plot(t, x_hat');
xtitle('Estados Estimados pelo Observador', 'Tempo', 'Estimativa dos Estados');
