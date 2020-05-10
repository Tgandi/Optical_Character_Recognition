
function sortmat= sortcol(comps)
ind = comps;
m1 = size(ind,1);
if m1 == 1
sortmat = ind;
return
end

i = 1;
while ind(i+1,1) < ind(1,3)
    i = i+1;
    if i == m1
        break
    end
end

sr = sortrows(ind(1:i,:),2);
if i == m1
    sortmat = sr;
else
    sortmat = [sr;sortcol(ind(i+1:m1,:))];


end
