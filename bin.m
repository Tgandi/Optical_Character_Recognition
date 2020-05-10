function BW = bin(I)
level=thresh(I);
if ndims(I)==3,
  I = rgb2gray(I);
end 
range = getrangefromclass(I);
if isinteger(I)
  BWp = (I > range(2) *level);
elseif islogical(I)
  BWp = I;
else 
  BWp = (I > level);
end  
BW = BWp;
end