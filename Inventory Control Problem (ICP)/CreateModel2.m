function model=CreateModel2()
% D is demand (staff)
    D=[59    34    84    69    28
       84    34    31    46    78
       ];
    
    I0=[0 0]';
    
    u=[1 2]';
    
    Umax=1000;
    
    % a is cost or price of each staff 
    a=[188   138   176   104   153
       149   129   117   181   196
       ];
   % b is maintenance or keeping cost or price
    b=[3     6    10     2     4     
       8    10     4     8     5   
       ];
    
    K=size(D,1);
    H=size(D,2);
    
    model.K=K;
    model.H=H;
    model.D=D;
    model.I0=I0;
    model.Umax=Umax;
    model.u=u;
    model.a=a;
    model.b=b;

end