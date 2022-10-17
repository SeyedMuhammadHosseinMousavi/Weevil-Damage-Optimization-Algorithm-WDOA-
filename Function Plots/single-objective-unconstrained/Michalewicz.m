function varargout = Michalewicz(X, m)
% if no input is given, return dimensions, bounds and minimum
if (nargin == 0)
varargout{1} = 2;  % # dims
varargout{2} = [-4, -4]; % LB
varargout{3} = [+4, +4]; % UB
varargout{4} = [1, 3]; % solution
varargout{5} = 0; % function value at solution

% otherwise, output function value
else

if (nargin == 1)
m = 10;
end

d = length(X);
sum = 0;

for ii = 1:d
xi = X(ii);
new = sin(xi) * (sin(ii*xi^2/pi))^(2*m);
sum  = sum + new;
end

varargout{1} = -sum;

end
end