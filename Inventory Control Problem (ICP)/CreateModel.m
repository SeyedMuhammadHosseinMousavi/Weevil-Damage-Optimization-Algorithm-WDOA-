function model=CreateModel()
% D is demand (staff)
    D=[59    34    84    69    28    25    55    65    74    36
       84    34    31    46    78    36    80    64    22    40
       57    56    50    79    40    54    22    90    41    37];
    
    I0=[0 0 0]';
    
    u=[1 3 2]';
    
    Umax=1000;
    
    % a is cost or price of each staff 
    a=[188   138   176   104   153   133   200   189   163   181
       149   129   117   181   196   173   182   117   188   183
       147   173   188   182   185   103   120   171   200   154];
   % b is maintanence or keeping cost or price
    b=[3     6    10     2     4     7     3     7     3    10
       8    10     4     8     5     5     5     4     7     6
       3     9     5     7     8     8     8     4     3     6];
    
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