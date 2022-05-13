% Weevil Optimizer Algorithm (WOA)
% Developed by Seyed Muhammad Hossein Mousavi - 2022
% Weevils, also referred to as nunus, are beetles belonging to the superfamily 
% Curculionoidea, known for their elongated snouts. Many weevils are considered 
% pests because of their ability to damage and kill crops. I just made this code 
% out of scratch and there is no related paper about it. 

clc;
clear;
close all;
warning ('off');
%-----------------------------------------
nVar = 9;                             % Number of Decision Variables
VarSize = [1 nVar];                   % Decision Variables Matrix Size
VarMin = -5;                          % Decision Variables Lower Bound
VarMax = 5;                           % Decision Variables Upper Bound
%% WOA Parameters
MaxIt = 200;          % Maximum Number of Iterations
nPop = 10;            % Number of weevils 
DamageRate = 0.2;                   % Damage Rate
nweevil = round(DamageRate*nPop);   % Number of Remained weevils
nNew = nPop-nweevil;                % Number of New weevils
mu = linspace(1, 0, nPop);          % Mutation Rates
pMutation = 0.1;                    % Mutation Probability
MUtwo = 1-mu;                       % Second Mutation
SnoutPower = 0.8;                   % Weevil Snout power Rate
FlyPower = 0.03*(VarMax-VarMin);    % Weevil Fly Power Rate
%----------------------------------------
%% Cost Functions
a=["@(x) Ackley(x)","@(x) Beale(x)","@(x) Booth(x)","@(x) Rastrigin(x)","@(x) Rosenbrock(x)"];
siza=size(a);
siza=siza(1,2);
for fun = 1 : siza
c=str2num(a(1,fun));
CostFunction = c;        % Cost Function
%% Basics
% Empty weevil
weevil.Position = []; 
weevil.Cost = [];
% Weevils Array
pop = repmat(weevil, nPop, 1);
% First weevils
for i = 1:nPop
pop(i).Position = unifrnd(VarMin, VarMax, VarSize);
pop(i).Cost = CostFunction(pop(i).Position);end;
% Sort 
[~, SortOrder] = sort([pop.Cost]);pop = pop(SortOrder);
% Best Solution
BestSol = pop(1);
% Best Costs Array
BestCost = zeros(MaxIt, 1);
%--------------------------------
%% WOA Body
for it = 1:MaxIt
newpop = pop;
for i = 1:nPop
for k = 1:nVar
if rand <= MUtwo(i)
TMP = mu;TMP(i) = 0;TMP = TMP/sum(TMP);
j = RouletteWheelS(TMP);
newpop(i).Position(k) = pop(i).Position(k)+SnoutPower*(pop(j).Position(k)-pop(i).Position(k));
end;
% Mutation
if rand <= pMutation
newpop(i).Position(k) = newpop(i).Position(k)+FlyPower*randn;
end;end;
% Apply Lower and Upper Bound Limits
newpop(i).Position = max(newpop(i).Position, VarMin);
newpop(i).Position = min(newpop(i).Position, VarMax);
newpop(i).Cost = CostFunction(newpop(i).Position);end;% Asses power
[~, SortOrder] = sort([newpop.Cost]);newpop = newpop(SortOrder);% Sort
pop = [pop(1:nweevil);newpop(1:nNew)];% Select 
[~, SortOrder] = sort([pop.Cost]);pop = pop(SortOrder);% Sort 
BestSol = pop(1);% Update 
BestCost(it) = BestSol.Cost;% Store 
% Iteration 
disp(['In Iteration No ' num2str(it) ': Weevil Optimizer Best Cost = ' num2str(BestCost(it))]);
end;
%------------------------------
%% Plot ITR
plot(normalize(BestCost,'range'), 'LineWidth', 1);
legend('Ackley','Beale','Booth','Rastrigin','Rosenbrock');
hold on;
xlabel('ITR');
ylabel('Weevil Optimizer Cost Value');
grid on;
end;
hold off;
