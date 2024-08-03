%function lp()
cd('C:\Users\margk\iCloudDrive\UNI\MASTER\3. Semester\Praktische Optimierung')
data = importdata("data");
data= readtable("data");
data(1:2, :) = []; % unnötiges aus den Daten löschen (Überschrift)
data(:, 1) = [];
head(data);
data = table2array(data);
m=size(data,1);
n=size(data,2)-1;
X = data(:, 1);
e = ones(m, 1);
I = eye(m);
y = data(:, 2);


% Blockmatrix für die Ungleichungsbedingungen erstellen
A = [X, e, -I; -X, -e, -I];
b = [y; -y];
c = [0;0;e];
model.A = sparse(A);
model.obj = c;
model.modelsense = 'min';
model.rhs = b;
model.sense =  repmat('<', size(b)) ;
model.lb = -inf(n + 1 + m, 1);
result = gurobi(model); 



%disp(result.x(1:2))
w_a_gurobi=result.x(1);
g_a_gurobi=result.x(2);
%end