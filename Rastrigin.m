function z=Rastrigin(x)
n=numel(x);
A=10;
z=n*A+sum(x.^2-A*cos(2*pi*x));
end