function f= softmax( z,v )
t=v*z';
t=exp(t);
s=sum(t);
[m,n]=size(t);
for i=1:m
    f(i,:)=t(i,:)./s;
end

