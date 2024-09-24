clear all, close all, clc
% load the data 
load VolumeItems50.txt
V=VolumeItems50;  % vector of the volumes of the items
N=length(V);      % number of items
C = 2.7;          % capacity of the boxes
B = 18;

L_y = -C*eye(B, B);
Litem = zeros(B, N^2);
Lbin = zeros(N, N^2);

for i=1:B
    for j=1:N
        Litem(i, (j-1)*B+i) = V(j);
    end
end


for i=1:N
    Lbin(i, (i-1)*B+1: (i-1)*B+B) = ones(1,B);
end

%A = [L_y -Litem]

Aeq = [zeros(N, B) Lbin];
A = [L_y Litem]
beq = ones(N, 1)
b = zeros(B, 1)
f = [ones(B, 1) ; zeros(N^2, 1)]
S = N^2 + B
%[x_min, f_min] = intlinprog(f, 1:S, A, b, Aeq, beq, zeros(1,S), ones(1,S))

% Question 4

constraint_1 = zeros(1, S);

constraint_1(B+1) = 1;
constraint_1(B+2) = 1;


constraint_2 = zeros(1, S);

constraint_2(B+1) = 1;
constraint_2(B+2) = 1;

constraint_3 = zeros(1, S);

constraint_3(B+1) = 1;
constraint_3(B+2) = 1;
constraint_4 = zeros(1, S);

constraint_4(B+1) = 1;
constraint_4(B+2) = 1;
constraint_5 = zeros(1, S);

constraint_5(B+1) = 1;
constraint_5(B+2) = 1;
new_constraints = [constraint_1;constraint_2;constraint_3;constraint_4;constraint_5];
b_new = ones(5, 1)
Aeq_new = [Aeq; new_constraints];
beq_new = [beq;b_new];
[x_min_4, f_min_4] = intlinprog(f, 1:S, A, b, Aeq_new, beq_new, zeros(1,S), ones(1,S))