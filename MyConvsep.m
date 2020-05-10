function f = MyConv(imag,mask)
mask=rot90(mask,2);
[x y]=size(mask);
pad_x=(y-1);
pad_y=(x-1);
[x,y,z]=size(imag);
f=[];
for k=1:z
    img=imag(:,:,k);
zero_ps=zeros(x,pad_x/2);
i_p=[];
i_p=[zero_ps img zero_ps];
[x y]=size(i_p);
zero_pt=zeros(pad_y/2,y);
i_p=[zero_pt;i_p;zero_pt];
[x,y,z]=size(img);
mask=double(mask);
i_p=double(i_p);
f=double(f);
for i=1:x
    for j=1:y
        f(i,j,k)=sum(dot(i_p(i:i+pad_y,j:j+pad_x),mask));
    end
end
end

end
