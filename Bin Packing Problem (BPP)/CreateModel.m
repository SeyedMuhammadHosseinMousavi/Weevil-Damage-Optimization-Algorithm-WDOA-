function model = CreateModel()
% Items
model.v = [6 3 4 6 8 7 4 7 7 5 5 6 7 7 6 4 8 7 8 8 2 1 4 9 6];
% Number of items
model.n = numel(model.v);
% Bin size
model.Vmax = 35;
end