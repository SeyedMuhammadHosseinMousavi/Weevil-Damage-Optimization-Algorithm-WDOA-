function varargout = schwefel(xx)
% SCHWEFEL FUNCTION

% if no input is given, return dimensions, bounds and minimum
if (nargin == 0)
varargout{1} = 2;  % # dims
varargout{2} = [-10, -10]; % LB
varargout{3} = [+10, +10]; % UB
varargout{4} = [1, 3]; % solution
varargout{5} = 0; % function value at solution

% otherwise, output function value
else

d = length(xx);
sum = 0;
for ii = 1:d
xi = xx(ii);
sum = sum + xi*sin(sqrt(abs(xi)));
end
varargout{1} = 418.9829*d - sum;
end
end