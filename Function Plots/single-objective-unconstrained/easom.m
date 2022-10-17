function varargout = easom(xx)

% if no input is given, return dimensions, bounds and minimum
if (nargin == 0)
varargout{1} = 2;  % # dims
varargout{2} = [-10, -10]; % LB
varargout{3} = [+10, +10]; % UB
varargout{4} = [1, 3]; % solution
varargout{5} = 0; % function value at solution

% otherwise, output function value
else

% EASOM FUNCTION
x1 = xx(1);
x2 = xx(2);
fact1 = -cos(x1)*cos(x2);
fact2 = exp(-(x1-pi)^2-(x2-pi)^2);
varargout{1} = fact1*fact2;
end
end