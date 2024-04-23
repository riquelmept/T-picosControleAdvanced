// Definindo o sistema
A = [0 1; -81 -54];
B = [0; 1];
C = [54 9/10];

// Calculando os polos do sistema
sys = syslin('c', A, B, C);
poles = roots(spec(A));

// Definindo os polos do observador 5 vezes mais rápidos
observer_poles = 5 * poles;

// Projetando o observador de estados
L = place(A', C', observer_poles)';

// Definindo o sistema do observador
A_observer = A - L*C;
B_observer = [B L];
C_observer = eye(2);

// Simulando o sistema e o observador
t = 0:0.01:10; // tempo de simulação
u = zeros(1, length(t)); // entrada
x0 = [0; 0]; // condições iniciais
x_observer0 = [0; 0]; // condições iniciais do observador

sys_observer = syslin('c', A_observer, B_observer, C_observer);
x = csim(u, t, sys, x0);
x_observer = csim([u; x], t, sys_observer, x_observer0);

// Plotando os resultados
scf();
subplot(2,1,1);
plot(t, x);
xtitle('Estados do sistema original', 'Tempo (s)', 'Estados');
legend('Vv', 'fv');

subplot(2,1,2);
plot(t, x_observer);
xtitle('Estados do observador', 'Tempo (s)', 'Estados');
legend('Vv', 'fv');
