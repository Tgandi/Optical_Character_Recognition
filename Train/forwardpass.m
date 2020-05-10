
function [z ydash] = forwardpass(X, w, v)
% this function performs the forward pass on a set of data points in the
% variable X and returns the output of the hidden layer units- z and the
% output layer units ydash
% 'TO DO'
[m,n]=size(X);
pad=ones(m,1);
x=[pad X];
z=tanh(x*w'); 
z=[pad z];
ydash=softmax(z,v)'; 

return;