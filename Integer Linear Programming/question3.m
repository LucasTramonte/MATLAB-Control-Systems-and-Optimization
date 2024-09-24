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
[x_min, f_min] = intlinprog(f, 1:S, A, b, Aeq, beq, zeros(1,S), ones(1,S))