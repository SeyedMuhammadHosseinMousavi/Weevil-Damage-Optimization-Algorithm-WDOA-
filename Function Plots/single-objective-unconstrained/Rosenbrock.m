function varargout = Rosenbrock(x)
% if no input is given, return dimensions, bounds and minimum
if (nargin == 0)
varargout{1} = 2;  % # dims
varargout{2} = [-10, -10]; % LB
varargout{3} = [+10, +10]; % UB
varargout{4} = [1, 3]; % solution
varargout{5} = 0; % function value at solution

% otherwise, output function value
else
n = numel(x);
varargout{1} = sum((1-x(1:n-1)).^2)+100*sum((x(2:n)-x(1:n-1).^2).^2);
end
end