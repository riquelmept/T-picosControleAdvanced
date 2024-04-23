A = [0 1; 0 0]; B = [0;1]; C = [1 0]; K = [1 2]; xT = [1 1];
s = %s;
I = eye(2,2);
Gma = C*inv(s*I-A)*B
H = A + B*K
Gmf = C*inv(s*I-H)*B
t = 0:0.01:5;
xT = [1 1]'
mtlb_hold("on");
plot2d(t', csim('step', t,Gma, xT));
plot2d(t', csim('step', t,Gmf, xT),style = [color("blue")]);

H = A - B*K;
Gmf = C*inv(s*I-H)*B
xT = [1 1]'
mtlb_hold("on");
plot2d(t', csim('step', t,Gma, xT));
mtlb_hold("on");plot2d(t', csim('step', t,Gmf, xT),style = [color("blue")]);
