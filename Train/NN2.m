
%function [k l]=MyNN(epochs,num_hidden)
clear all
clc
load('databuild.mat');
X1=source';
Y1=target';
ind=randperm(7581);
X=X1(ind,:);
Y=Y1(ind,:);
input=1024;
output=62;
num_hidden=200;
epochs=150;
eta=0.01;
w = -0.3+(0.6)*rand(num_hidden,(input+1));
v = -0.3+(0.6)*rand(output,(num_hidden+1));

N=7581;
batchsize = 25;
nBatches = floor(N/batchsize);
batchindices = reshape([1:batchsize*nBatches]',batchsize, nBatches);
batchindices = batchindices';
if N - batchsize*nBatches >0
    batchindices(end+1,:)=batchindices(end,:);
    batchindices(end,1:(N - batchsize*nBatches)) = [batchsize*nBatches+1: N];
end


for i=1:epochs
epoch=i
for batch=1:nBatches
     x=X(batchindices(batch,:),:);
     y=Y(batchindices(batch,:),:);
  
[z ydash]=forwardpass(x,w,v);
[deltaw deltav]=computegradient(x,y,w,v,z,ydash);

  w = w + eta*deltaw;
  v = v + eta*deltav;
end
end

    
h1 = tanh([ones(N, 1) X] * w');
h2 = softmax([ones(N, 1) h1] , v)';
[x1,y1]=max(h2,[],2);
[x2,y2]=max(Y,[],2);
k=sum(abs(y1-y2)>0);

% tsX=X1(ind1,:);
% tsY=Y1(ind1,:);
% h1 = tanh([ones(, 1) tsX] * w');
% h2 = softmax([ones(2400, 1) h1] , v)';
% [x1,y1]=max(h2,[],2);
% [x2,y2]=max(tsY,[],2);
% l=sum(abs(y1-y2)>0);
% 
% end


