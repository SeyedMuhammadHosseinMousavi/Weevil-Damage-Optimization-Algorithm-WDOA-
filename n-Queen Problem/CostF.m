function [z sol]=CostF(s)
n=numel(s);
[~, X]=sort(s);
Y=1:n;
Hit=zeros(n,n);
z=0;
for i=1:n-1
for j=i+1:n
if abs(X(i)-X(j))==abs(Y(i)-Y(j))
Hit(i,j)=1;
Hit(j,i)=1;
z=z+1;
end
end
end
sol.X=X;
sol.Y=Y;
sol.Hit=Hit;
sol.z=z;
end