%% Weevil Damage Optimization Algorithm (WDOA) Bin Packing Problem 
% Paper:
% http://www.growingscience.com/jfs/Vol2/jfs_2022_17.pdf
%%----------------------------------------------------------
% Developer: Seyed Muhammad Hossein Mousavi   (Oct 2022)
% Contact: mosavi.a.i.buali@gmail.com 
%%----------------------------------------------------------

% Bin Packing Problem (BPP) is a NP-hard optimization problem which has application
% in loading trucks with constant capacity, creating backups for media and more. 
% As it is NP-hard, one of the best ways to solve it is by nature-inspired methods. 
% The problem is based on number of items which should be fitted inside number of bins 
% or containers. Items has different sized but bins have a constant size. The main 
% objective is to use less bins for all items. 

clc;
clear;
close all;

%% Problem Definition

model = CreateModel();  % Create Bin Packing Model
CostFunction = @(x) BinPackingCost(x, model);  % Objective Function
nVar = 2*model.n-1;     % Number of Decision Variables
VarSize = [1 nVar];     % Decision Variables Matrix Size
VarMin = 0;     % Lower Bound of Decision Variables
VarMax = 1;     % Upper Bound of Decision Variables

%% WDOA Parameters
MaxIt = 200;          % Maximum Number of Iterations
nPop = 10;            % Number of weevils 

DamageRate = 0.1;                   % Damage Rate
nweevil = round(DamageRate*nPop);   % Number of Remained weevils
nNew = nPop-nweevil;                % Number of New weevils
mu = linspace(1, 0, nPop);          % Mutation Rates
pMutation = 0.2;                    % Mutation Probability
MUtwo = 1-mu;                       % Second Mutation
SnoutPower = 0.8;                   % Weevil Snout power Rate
FlyPower = 0.03*(VarMax-VarMin);    % Weevil Fly Power Rate


%% Basics
% Empty weevil
weevil.Position = []; 
weevil.Cost = [];
weevil.Sol = [];

% Weevils Array
pop = repmat(weevil, nPop, 1);
% First weevils
for i = 1:nPop
pop(i).Position = unifrnd(VarMin, VarMax, VarSize);
[pop(i).Cost pop(i).Sol] = CostFunction(pop(i).Position);
end;

% Sort 
[~, SortOrder] = sort([pop.Cost]);pop = pop(SortOrder);
% Best Solution
BestSol = pop(1);
% Best Costs Array
BestCost = zeros(MaxIt, 1);
%--------------------------------
%% WDOA Body
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

[newpop(i).Cost newpop(i).Sol] = CostFunction(newpop(i).Position);

end;% Asses power
[~, SortOrder] = sort([newpop.Cost]);newpop = newpop(SortOrder);% Sort
pop = [pop(1:nweevil);newpop(1:nNew)];% Select 
[~, SortOrder] = sort([pop.Cost]);pop = pop(SortOrder);% Sort 
BestSol = pop(1);% Update 
BestCost(it) = BestSol.Cost;% Store 
% Iteration 
disp(['In Iteration No ' num2str(it) ': WDOA Best Cost = ' num2str(BestCost(it))]);
end

%% Results
figure;
plot(BestCost,'k', 'LineWidth', 2);
xlabel('ITR');
ylabel('Cost Value');
ax = gca; 
ax.FontSize = 14; 
ax.FontWeight='bold';
set(gca,'Color','c')
grid on;

%% Statistics
items=model.v;
itemindex=BestSol.Sol.B;
sizebins=size(itemindex);
for i=1: sizebins(1,1)
itemvalue{i}=items(itemindex{i});
end;
itemvalue=itemvalue';
%
disp(['Number of Items is ' num2str(model.n)]);
disp(['Items are ' num2str(items)]);
disp(['Bins size is ' num2str(model.Vmax)]);
disp(['Selected bins is ' num2str(BestCost(end))]);
disp(['Selected bins indexes are ']);
itemindex
disp(['Selected bins values are ']);
itemvalue



