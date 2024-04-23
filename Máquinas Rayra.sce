r1 = 1.43; %resistencia do estator
x1 = 2.98; %reatancia do estator
xm = 31.1; %reatancia de magnetizacao
x2 = 2.98; %reatancia do rotor
r2 = 1.68; %resistencia do rotor
r2v = (0.1*r2:0.1*r2:1.2*r2) ;
vf = 220; %tensao de fase
sm = (3600-3450)/3600; %escorregamento
nsinc = 3600; %velocidade do motor
wsinc = nsinc * (pi/30);
vth = vf * (xm/(sqrt(r1+(x1+xm)^2)));
zth = (1i*xm*(r1+1i*x1))/(r1+1i*(x1+xm));
rth = real(zth);
xth = imag(zth);
s = (0.001:0.001:1) ; % Escorregamento
nm = (1 - s) * nsinc;
conjv = zeros(length(s),1);
conjva = zeros(length(s),1);
%2
figure()
for a = 1:length(r2v)
for b = 1:length(s)
conjv(b) = (3 * vth^2 * r2v(a) / s(b)) /(wsinc * ((rth + r2v(a)/s(b))^2 + (xth + x2)^2));
end
plot(s,conjv,'LineWidth',2.0);
hold on;
end
xlabel('Escorregamento');
ylabel('Conjugado');
title ('\bfConjugado X escorregamento (R2 variando)','LineWidth',3.0);
grid on;
figure()
for b = 1:length(s)
conjva(b) = (3 * vth^2 * r2 / s(b)) /(wsinc * ((rth + r2/s(b))^2 + (xth + x2)^2));
end
plot(s,conjva,'LineWidth',2.0);
xlabel('Escorregamento');
ylabel('Conjugado');
title ('\bfConjugado X escorregamento','LineWidth',3.0);
grid on;
ifase = zeros(length(s),1);
za2 = zeros(length(s),1);
zeq = zeros(length(s),1);
zres = zeros(length(s),1);
for b = 1:length(s)
za2(b)=r2/s(b)+1i*x2;
zeq(b)=1/(1/(1i*xm)+1/za2(b));
zres(b)=r1+1i*x1+zeq(b);
ifase(b) = vf/zres(b);
end
figure()
plot(s,abs(ifase),'LineWidth',2.0);
xlabel('Escorregamento');
ylabel('corrente de fase');
title('\bfescorregamento X Corrente de fase','LineWidth',3.0);
grid on;
vm = zeros(length(s),1);
im = zeros(length(s),1);
for b = 1:length(s)
za2(b)=r2/s(b)+1i*x2;
zeq(b)=1/(1/(1i*xm)+1/za2(b));
zres(b)=r1+1i*x1+zeq(b);
ifase(b) = vf/zres(b);
vm(b) = zeq(b) * ifase(b);
im(b) = vm(b)/(1i*xm);
end
figure()
plot(s,abs(im),'LineWidth',2.0);
xlabel('Escorregamento');
ylabel('corrente de fase');
title('\bfescorregamento X Corrente de magnetização','LineWidth',3.0);
grid on;
perdasjoule = zeros(length(s),1);
i2 = zeros(length(s),1);
for b = 1:length(s)
i2(b) = ifase(b) - im(b);
perdasjoule(b)=3*r2*abs(i2(b))^2 + 3*r1*abs(ifase(b)^2);
end
figure()
plot(s,perdasjoule,'LineWidth',2.0);
xlabel('Escorregamento');
ylabel('perdasJoule');
title('\bfescorregamento X Perdas Joule','LineWidth',3.0);
grid on;
fp = zeros(length(s),1);
for b = 1:length(s)
fp(b) = cos(angle(vf*ifase(b)));
end
figure()
plot(s,fp,'LineWidth',2.0);
xlabel('Escorregamento');
ylabel('Fator de Potência');
title('\bfescorregamento X Fator de Potência','LineWidth',3.0);
grid on;
pent = zeros(length(s),1);
psaida = zeros(length(s),1);
rend = zeros(length(s),1);
for b = 1:length(s)
pent(b) = 3 *vf * ifase(b);
psaida(b) = 3*abs(i2(b))^2*r2/s(b)*(1-s(b));
rend(b) = abs(psaida(b)/pent(b));
end
figure()
plot(s,rend,'LineWidth',2.0);
xlabel('Escorregamento');
ylabel('Rendimento');
title('\bfescorregamento X Rendimento','LineWidth',3.0);
grid on;
