function sol=ParseSolution(xhat,model)

    K=model.K;
    H=model.H;
    D=model.D;
    I0=model.I0;
    Umax=model.Umax;
    u=model.u;
    a=model.a;
    b=model.b;
    
    Xmin=0;
    Xmax=3*max(D(:));

    X=min(floor(Xmin+(Xmax-Xmin+1)*xhat),Xmax);
    
    I=zeros(K,H);
    UC=zeros(1,H);
    for t=1:H
        if t==1
            PreviousInventory=I0;
        else
            PreviousInventory=I(:,t-1);
        end
        
        I(:,t)=PreviousInventory+X(:,t)-D(:,t);
        
        UC(t)=sum(u.*I(:,t));
    end

    vmin=max(0,-I);
    VMIN=mean(vmin(:));
    
    VMAX=mean(max(UC/Umax-1,0));
    
    SumAX=sum(a(:).*X(:));
    SumBI=sum(b(:).*I(:));
    
    sol.X=X;
    sol.I=I;
    sol.UC=UC;
    sol.SumAX=SumAX;
    sol.SumBI=SumBI;
    sol.VMIN=VMIN;
    sol.VMAX=VMAX;
    sol.IsFeasible=(VMIN==0 && VMAX==0);
    
end