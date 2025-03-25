
X1=[0.5 0.25 0.25];
% P=[0.5 0.25 0.25; 0.6667 0 0.3333; 0.6667 0.3333 0];
%
P = [0 0 1; 0.5 0.33333 0.1667; 0.5 0.5 0];

% 打印变量
fprintf('X1 = \n'); disp(X1);
fprintf('P = \n');  disp(P);

X2 = X1 * P;
X3 = X1 * P * P;

% 打印变量
fprintf('X2 = X1 * P = \n'); disp(X1);
fprintf('X3 = X1 * P * P = \n');  disp(P);

HX1 = 1.5;
HX2_X1 = X1(1) * 1.5 + X1(2) * 0.9128 + X1(3) * 0.9128;
HX3_X2 = X2(1) * 1.5 + X2(2) * 0.9128 + X2(3) * 0.9128;

H123 = HX1 + HX2_X1 + HX3_X2;
AH123 = H123 / 3;

% ---------------------------
N = 100;
Number = 1 : N;
Probability = zeros(N, 3);
EntropyRate = zeros(N, 1);
Probability(1, :) = X1;
EntropyRate(1, 1) = HX1;

for i = 2 : N
    Probability(i, :) = Probability(i-1, :)*P;
    EntropyRate(i, :) = ((i - 1) * EntropyRate(i - 1, 1) + Probability(i - 1, 1) * 1.5 + ...
        Probability(i - 1, 2) * 0.9128 + Probability(i - 1, 3) * 0.9128) / i;
end

figure;
plot(Number, Probability(:, 1), Number, Probability(:, 2), Number, Probability(:, 3));
title('状态概率分布');
legend('P(X=1)', 'P(X=2)', 'P(X=3)');
xlabel('N');
ylabel('Entropy Rate (bit/symbol)');

figure;
plot(Number, EntropyRate);
title('平均符号熵');
xlabel('N');
ylabel('Entropy Rate (bit/symbol)');
