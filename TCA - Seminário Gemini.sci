clc;
close;

% Parâmetros do sistema
A = [0 1; -81 -54];
B = [0; 1];
C = [54 9/10];

% Entrada do sistema
u = [1; 0]; % Entrada constante para simulação

% Tempo de simulação
t = 0:0.1:10;

% Simulação do sistema original
x = zeros(2, length(t));
x(:, 1) = [1; 0]; % Condição inicial
for i = 1:length(t) - 1
  x(:, i + 1) = x(:, i) + A * (x(:, i) - u) * 0.1;
end

% Simulação do observador
x_hat = zeros(2, length(t));
x_hat(:, 1) = [1; 0]; % Condição inicial
L = -5 * inv(A) * (C - eye(2));
for i = 1:length(t) - 1
  x_hat(:, i + 1) = x_hat(:, i) + A * (x_hat(:, i) - u) * 0.1 + L * (C * x(:, i) - C * x_hat(:, i)) * 0.1;
end

% Plotagem dos resultados
plot(t, x(1, :), 'r', t, x_hat(1, :), 'b');
legend('Sistema Original', 'Observador');
xlabel('Tempo (s)');
ylabel('Velocidade do Vento (m/s)');

plot(t, x(2, :), 'r', t, x_hat(2, :), 'b');
legend('Sistema Original', 'Observador');
xlabel('Tempo (s)');
ylabel('Frequência da Rajada (Hz)');

