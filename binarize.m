function bin = binarize(img)
if (size(img,3)~=1)
    img = rgb2gray(img);
end
%E = edge(medfilt2(img,[3 3]),'canny',0.2);
E=MyCanny(img);
CC= conncomp(E);
num_comp = CC.NumObjects;
im_sz = CC.ImageSize(1);
pix_list = CC.PixelIdxList;

comps = zeros(num_comp,4);
for i = 1:num_comp
    pix = pix_list{1,i};
    pix_c = mod(pix,im_sz*ones(size(pix)));
    pix_r = ceil(pix./im_sz);
    
    comps(i,:)=[min(pix_c) min(pix_r) max(pix_c) max(pix_r) ];
end

for i = 1:num_comp
    olap=0;
    olp_comps=[];                 %overlapping components 2 B removed
    for j=1:num_comp 
        if (comps(j,1)>comps(i,1) && comps(j,2)>comps(i,2) && comps(j,3)<comps(i,3) && comps(j,4)<comps(i,4))
            olap=olap+1;
            olp_comps(olap,1)=j;
        end
    end
    if olap<3
        for k=1:olap
            comps(olp_comps(k,1),:)=0;
        end
    else
        comps(i,:)=0;
    end
end

temp=[];
sz=size(comps,1);
for i=1:sz
    if comps(i,1)~=0
        temp=[temp; comps(i,:)];
    end
end
comps=temp;
sz=size(comps,1);
[r, c] = size(E);
bin = zeros(r,c);

for i=1:sz
    n=0;
    egpix=[]; %edge pixels indices
    x1=comps(i,1);
    y1=comps(i,2);
    x2=comps(i,3);
    y2=comps(i,4);
    
    for j=x1:x2
        for k=y1:y2
            if E(j,k)
                egpix = [egpix img(j,k)];
                n=n+1;
            end
        end
    end
    egpix = mean(egpix);
    %nbmed - neighbourhood median
    nbmed = median([img(x1-1,y1-1), img(x1-1,y1), img(x1,y1-1), img(x1+1,y2-1), img(x1,y2-1), img(x1+1,y2), img(x2-1,y1+1), img(x2-1,y1), img(x2,y1+1), img(x2+1,y2+1), img(x2,y2+1), img(x2+1,y2)]);
    for j=x1:x2
        for k=y1:y2
            if(egpix<nbmed && img(j,k)<egpix)
                bin(j,k)=1;
            elseif(egpix>=nbmed && img(j,k)>=egpix)
                bin(j,k)=1;
            end
        end
    end  
end
end