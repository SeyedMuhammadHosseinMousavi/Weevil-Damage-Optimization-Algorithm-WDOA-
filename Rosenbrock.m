function z = Rosenbrock(x)
n = numel(x);
z = sum((1-x(1:n-1)).^2)+100*sum((x(2:n)-x(1:n-1).^2).^2);
end