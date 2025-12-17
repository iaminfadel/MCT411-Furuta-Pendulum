A = [0, 0, 1, 0;
    0, 0, 0, 1;
    0, 0.05612, 0, 0;
    0, -64.75587, 0, 0];

B = [0; 0; 123.4146; 2.85366];

Q = [1, 0, 0, 0;
    0, 0.1, 0, 0;
    0, 0, 1000, 0;
    0, 0, 0, 10];

R = 0.01;

[K, S, P] = lqr(A, B, Q, R);
disp('LQR Gain K:');
disp(K);

disp('Eigenvalues of A:');
eig(A)

disp('Rank of Controllability Matrix:');
rank(ctrb(A,B))