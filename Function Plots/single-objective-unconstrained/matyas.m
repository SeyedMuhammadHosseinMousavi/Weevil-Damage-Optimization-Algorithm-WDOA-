function varargout = matyas(xx)
% MATYAS FUNCTION
% if no input is given, return dimensions, bounds and minimum
if (nargin == 0)
varargout{1} = 2;  % # dims
varargout{2} = [-10, -10]; % LB
varargout{3} = [+10, +10]; % UB
varargout{4} = [1, 3]; % solution
varargout{5} = 0; % function value at solution

% otherwise, output function value
else
x1 = xx(1);
x2 = xx(2);
term1 = 0.26 * (x1^2 + x2^2);
term2 = -0.48*x1*x2;
varargout{1} = term1 + term2;
end
end
