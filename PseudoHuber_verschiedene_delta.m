cd('C:\Users\margk\iCloudDrive\UNI\MASTER\3. Semester\Praktische Optimierung')
data = importdata("data");
data= readtable("data");
data(1:2, :) = []; % unnötiges aus den Daten löschen (Überschrift)
data(:, 1) = [];
head(data);
data = table2array(data);

%delta = 1
d1=1;
cvx_begin
    cvx_solver sdpt3
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

w_c1_sdpt3=w;
g_c1_sdpt3=g;

%delta = 0.1
d2=0.1;
cvx_begin
    cvx_solver sdpt3
    variables w g s(m) t(m) ep(m)
    minimize d2*(e'*s);
    subject to
       X*w+g*e-I*ep==y;
       t==d2*e;
       %s>=0;
       for i = 1:m
            norm([t(i),ep(i)]) <= s(i)+t(i);
       end
cvx_end

w_c2_sdpt3=w;
g_c2_sdpt3=g;

%delta = 5
d3=5;
cvx_begin
    cvx_solver sdpt3
    variables w g s(m) t(m) ep(m)
    minimize d3*(e'*s);
    subject to
       X*w+g*e-I*ep==y;
       t==d3*e;
       %s>=0;
       for i = 1:m
            norm([t(i),ep(i)]) <= s(i)+t(i);
       end
cvx_end

w_c3_sdpt3=w;
g_c3_sdpt3=g;



