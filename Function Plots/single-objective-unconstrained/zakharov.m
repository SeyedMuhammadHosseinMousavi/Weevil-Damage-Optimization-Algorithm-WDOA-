function varargout = zakharov(X)

% if no input is given, return dimensions, bounds and minimum
if (nargin == 0)
varargout{1} = 2;  % # dims
varargout{2} = [-10, -10]; % LB
varargout{3} = [+10, +10]; % UB
varargout{4} = [1, 3]; % solution
varargout{5} = 0; % function value at solution

% otherwise, output function value
else

d = length(X);
sum1 = 0;
sum2 = 0;
for ii = 1:d
xi = X(ii);
sum1 = sum1 + xi^2;
sum2 = sum2 + 0.5*ii*xi;
end
varargout{1} = sum1 + sum2^2 + sum2^4;
end

end
