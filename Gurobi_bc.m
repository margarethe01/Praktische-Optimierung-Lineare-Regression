cd('C:\Users\margk\iCloudDrive\UNI\MASTER\3. Semester\Praktische Optimierung')
data = importdata("data");
data= readtable("data");
data(1:2, :) = []; % unnötiges aus den Daten löschen (Überschrift)
data(:, 1) = [];
head(data);
data = table2array(data);

%Größe des Problems
m=size(data,1);
n=size(data,2)-1;


%b) quadratischer Fehler

cvx_begin
    cvx_solver gurobi
    variables w g s(m)
    minimize(s'*s);
    subject to
       X*w+g*e-I*s==y;
cvx_end 

w_b_gurobi=w;
g_b_gurobi=g;


%c) Pseudo-Huber Fehler

d1=1; %delta

cvx_begin
    cvx_solver gurobi
    variables w g s(m) t(m) ep(m)
    minimize d1*(e'*s);
    subject to
       X*w+g*e-I*ep==y;
       t==d1*e;
       %s>=0;
       for i = 1:m
            norm([t(i),ep(i)]) <= s(i)+t(i);
       end
cvx_end

w_c1_gurobi=w;
g_c1_gurobi=g;




