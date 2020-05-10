function [val] = thresh(I)
iptchecknargin(1,1,nargin,mfilename); 
%check -> checking validity of image
iptcheckinput(I,{'uint8','uint16','double','single','int16'},{'nonsparse'},mfilename,'I',1);
%checking input format of image
if ~isempty(I)
%checking for non emtiness of image
    I=im2uint8(I(:));
%if not empty converting image to uint8 format
noofbins=256;
% declaring noof bins to 256 used in histigram
bars=imhist(I,noofbins);
%bars represent the no of pixels in that range
weight=bars/sum(bars);
%weight gives the idea of no of pixels in that range(bar range) compared to
%all pixels in all ranges  i.e  weight=(present value in hist)/(total values of hist)
%sum is in built command to find the total sum of values 
ascendingsum=cumsum(weight);
%ascendingsum gives the cummulative sum of values in weight
% cumsum is inbuilt command for finding cummulative sum of values

cummulativenum=cumsum(weight.* (1:noofbins)');
noob=cummulativenum(end);
%end is a inbuilt command to give the lastvalue of noob
assumsqu = (noob * ascendingsum - cummulativenum).^2 ./ (ascendingsum .* (1 - ascendingsum));
highestval = max(assumsqu);
%max is inbuilt command to give highest value of all the values given to it
  isfinite_highestval = isfinite(highestval);
  %is finite is inbuilt command which gives 1 if passed value is not zero
  %and zero if passed value is zero
  if isfinite_highestval
    %index=mean(find(assumsqu == highestval));
    %idx = mean(find(sigma_b_squared == maxval));
    idx = mean(find(assumsqu == highestval));
    %mean is an inbuilt command which returns the mean value of given
    %values.  find is also an inbuilt command  which returns the index of
    %values  which are non-zero
    %i.e INDEX gives the mean value of indices who entries are non zero and
    %whose value is equal to highest value of assum
    val = (idx-1)/(noofbins-1);
  end
end