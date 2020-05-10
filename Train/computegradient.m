function [deltaw deltav] = computegradient(X, Y, w, v, z, ydash)
% this function computes the gradient of the error function with resepct to
% the weights
% 'TO DO'
[m,n]=size(X);
X=[ones(m,1) X];
deltav=((Y-ydash)'*z);
deltaw = (((Y-ydash)*v(:,(2:end))).*((1-z(:,(2:end)).*z(:,2:end))))'*X;
if m==0
    abc
end
deltaw=deltaw/m;
deltav=deltav/m;
return;