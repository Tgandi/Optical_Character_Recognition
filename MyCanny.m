function [ res ] = MyCanny( Image )

%Image=rgb2gray(Image);
[R C]=size(Image);
Mask=MyGauss(1.2,5);
Image1=MyConv(Image,Mask);
Hx = [-1, 0, 1; -2, 0, 2; -1, 0, 1];
Hx1=[1;2;1];
Hx2=[-1 0 1];
Hy = [1, 2, 1; 0, 0, 0; -1, -2, -1];
Hy1=[1;0;-1];
Hy2=[1 2 1];
% Dx=MyConv(Image1,Hx);
% Dy=MyConv(Image1,Hy);
Dx=MyConvsep(MyConvsep(Image1,Hx1),Hx2);
Dy=MyConvsep(MyConvsep(Image1,Hy1),Hy2);
Dx=double(Dx);
Dy=double(Dy);
G=zeros(R,C);
T=zeros(R,C);
T2=zeros(R,C);
for i=1:R
    for j=1:C
        G(i,j)=sqrt(Dx(i,j)^2+Dy(i,j)^2);
    end
end
%G=sqrt(Dx.^2+Dy.^2);

for i=1:R
    for j=1:C
        T(i,j)=atand(Dy(i,j)/Dx(i,j));
        if(T(i,j)<0)
            T(i,j)=360+T(i,j);
        end
        if ((T(i, j) >= 0 ) && (T(i, j) < 22.5) || (T(i, j) >= 157.5) && (T(i, j) < 202.5) || (T(i, j) >= 337.5) && (T(i, j) <= 360))
            T2(i, j) = 0;
        elseif ((T(i, j) >= 22.5) && (T(i, j) < 67.5) || (T(i, j) >= 202.5) && (T(i, j) < 247.5))
            T2(i, j) = 45;
        elseif ((T(i, j) >= 67.5 && T(i, j) < 112.5) || (T(i, j) >= 247.5 && T(i, j) < 292.5))
            T2(i, j) = 90;
        elseif ((T(i, j) >= 112.5 && T(i, j) < 157.5) || (T(i, j) >= 292.5 && T(i, j) < 337.5))
            T2(i, j) = 135;
        end;
    end
end
Final=zeros(R,C);
for i=2:R-1
    for j=2:C-1
        if (T2(i,j)==0)
            Final(i,j) = (G(i,j) == max([G(i,j), G(i,j+1), G(i,j-1)]));
        elseif (T2(i,j)==45)
            Final(i,j) = (G(i,j) == max([G(i,j), G(i+1,j-1), G(i-1,j+1)]));
        elseif (T2(i,j)==90)
            Final(i,j) = (G(i,j) == max([G(i,j), G(i+1,j), G(i-1,j)]));
        elseif (T2(i,j)==135)
            Final(i,j) = (G(i,j) == max([G(i,j), G(i+1,j+1), G(i-1,j-1)]));
        end;
    end;
end;
Final=Final.*G;
res=zeros(R,C);
Low=0.075;
High=0.175;
Low = Low * max(max(Final));
High = High * max(max(Final));
for i = 1  : R
    for j = 1 : C
        if (Final(i, j) < Low)
            res(i, j) = 0;
        elseif (Final(i, j) > High)
            res(i, j) = 1;
        elseif ( Final(i+1,j)>High || Final(i-1,j)>High || Final(i,j+1)>High || Final(i,j-1)>High || Final(i-1, j-1)>High || Final(i-1, j+1)>High || Final(i+1, j+1)>High || Final(i+1, j-1)>High)
            res(i,j) = 1;
        end;
    end;
end;
%imshow(logical(res));

end

