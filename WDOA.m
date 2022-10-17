% Weevil Damage Optimization Algorithm (WDOA)
% Paper:
% http://www.growingscience.com/jfs/Vol2/jfs_2022_17.pdf
%-----------------------------------------------------------
% Developed by Seyed Muhammad Hossein Mousavi - (Oct 2022)
% Contact : mosavi.a.i.buali@gmail.com
%-----------------------------------------------------------
% Weevils are a type insect with elongated snouts coming from superfamily of 
% Curculionoidea with approximately 97,000 species. Most of them consider pest and
% cause environmental damages but some kinds like wheat weevil, maize weevil, and 
% boll weevils are famous to cause huge damage on crops, especially cereal grains. 
% This research is proposed a novel swarm-based metaheuristics algorithms called 
% Weevil Damage Optimization Algorithm (WDOA) which mimics weevils’ fly power, 
% snout power, and damage power on crops or agricultural products. The proposed 
% algorithm is tested with 12 benchmark unimodal and multimodal artificial landscapes
% or optimization test functions. 

%% Begin
clc;
clear;
close all;
warning ('off');
%%-----------------------------------------
% You can define the cost fucntion here.

% 1.Ackley, 2.Beale, 3.Bird, 4.Booth, 5.Dejong,
% 6.Easom, 7.Eggholder, 8.Levy, 9.Matyas, 10.Michalewicz
% 11.Rastrigin, 12.Rosenbrock, 13.Schwefel, 14.Sphere

CostFunction = @(x) Ackley(x);        % Cost Function
tic
%%-----------------------------------------
nVar = 10;                            % Number of Decision Variables
VarSize = [1 nVar];                   % Decision Variables Matrix Size
VarMin = -5;                          % Decision Variables Lower Bound
VarMax = 5;                           % Decision Variables Upper Bound

%% WDOA Parameters
MaxIt = 200;                        % Maximum Number of Iterations
nPop = 30;                          % Number of weevils 

DamageRate = 0.3;                   % Damage Rate
nweevil = round(DamageRate*nPop);   % Number of Remained weevils
nNew = nPop-nweevil;                % Number of New weevils
mu = linspace(1, 0, nPop);          % Mutation Rates
pMutation = 0.1;                    % Mutation Probability
MUtwo = 1-mu;                       % Second Mutation
SnoutPower = 0.8;                   % Weevil Snout power Rate
FlyPower = 0.03*(VarMax-VarMin);    % Weevil Fly Power Rate
%----------------------------------------

%% Basics
% Empty weevil
weevil.Position = []; 
weevil.Cost = [];
% Weevils Array
pop = repmat(weevil, nPop, 1);
% First weevils
for i = 1:nPop
pop(i).Position = unifrnd(VarMin, VarMax, VarSize);
pop(i).Cost = CostFunction(pop(i).Position);
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
newpop(i).Cost = CostFunction(newpop(i).Position);end;% Asses power
[~, SortOrder] = sort([newpop.Cost]);newpop = newpop(SortOrder);% Sort
pop = [pop(1:nweevil);newpop(1:nNew)];% Select 
[~, SortOrder] = sort([pop.Cost]);pop = pop(SortOrder);% Sort 
BestSol = pop(1);% Update 
BestCost(it) = BestSol.Cost;% Store 
% Iteration 
disp(['In Iteration No ' num2str(it) ': WDOA Best Cost = ' num2str(BestCost(it))]);
end;
%------------------------------
%% Plot ITR
plot(BestCost,'k', 'LineWidth', 2);
hold on;
xlabel('ITR');
ylabel('WDOA Cost');
ax = gca; 
ax.FontSize = 14; 
ax.FontWeight='bold';
grid on;
toc
