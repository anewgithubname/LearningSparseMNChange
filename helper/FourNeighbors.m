function adj = FourNeighbors(s,m)
mat = zeros(s,s);             %# Sample matrix
[r,c] = size(mat);                        %# Get the matrix size
diagVec1 = repmat([ones(c-1,1); 0],r,1);  %# Make the first diagonal vector
%#   (for horizontal connections)
diagVec1 = diagVec1(1:end-1);             %# Remove the last value
diagVec2 = ones(c*(r-1),1);               %# Make the second diagonal vector
%#   (for vertical connections)
adj = diag(diagVec1,1)+...                %# Add the diagonals to a zero matrix
    diag(diagVec2,c);
adj = adj+adj.';                         %'# Add the matrix to a transposed
%#   copy of itself to make it
%#   symmetric

for i = 1:m
    [x,y] = find(adj==1);
    idx = randperm(length(x));
    adj(x(idx(i)),y(idx(i))) = 0;
    adj(y(idx(i)),x(idx(i))) = 0;
end
% figure;
% spy(adj)
end