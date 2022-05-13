%% Weevils Scattering

clc;
clear;
close all;
warning('off');
%% Variables
Gen= 200; % Number of Generations
for ooo=1:Gen

nVar = 3;                             % Number of Decision Variables
VarSize = [1 nVar];                   % Decision Variables Matrix Size
VarMin = -2;                          % Decision Variables Lower Bound
VarMax = 2;                           % Decision Variables Upper Bound
%% WOA Parameters
MaxIt = 80;          % Maximum Number of Iterations
nPop = 3;            % Number of weevils 
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
a=["@(x) Ackley(x)"];
c=str2num(a);
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
AllSol(it)=BestSol;
% Iteration 
disp(['In Iteration No ' num2str(it) ': Weevil Optimizer Best Cost = ' num2str(BestCost(it))]);
all=AllSol(it).Position;
allone=all(1,1);
alltwo=all(1,2);
meshone(it)=all(1,1);
meshtwo(it)=all(1,2);
aaa(it)=allone;
bbb(it)=alltwo;
end;
aaaa(ooo,:)=aaa;
bbbb(ooo,:)=bbb;
end;
plot(aaaa,bbbb,'kp','MarkerEdgeColor','k','MarkerFaceColor','r');



