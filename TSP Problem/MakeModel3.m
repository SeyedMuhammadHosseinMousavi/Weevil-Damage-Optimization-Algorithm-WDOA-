function model=MakeModel3()
x=[13 25 91 86 66 87 50 22 19 3 67 86 52 5 21];
y=[19 28 37 100 10 32 56 97 47 27 43 39 89 5 79];

n=numel(x);
d=zeros(n,n);
for i=1:n-1
for j=i+1:n
d(i,j)=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
d(j,i)=d(i,j);
end
end
model.n=n;
model.x=x;
model.y=y;
model.d=d;
end