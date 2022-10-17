function [z sol]=MyCost(xhat,model)
sol=ParseSolution(xhat,model);
SumAX=sol.SumAX;
SumBI=sol.SumBI;
VMIN=sol.VMIN;
VMAX=sol.VMAX;
alpha=100000;
beta=10;
z=((SumAX+SumBI)+alpha*VMIN)*(1+beta*VMAX);
end