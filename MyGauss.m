function [H]=MyGauss(Sigma,Size)
    n=Size;
    H=zeros(Size);
    for i=1:Size
        for j=1:Size
            H(i,j)=(1/(2*3*(Sigma)^2))*exp(-((i-(n+1)/2)^2+(j-(n+1)/2)^2)/Sigma^2);
        end
    end
    