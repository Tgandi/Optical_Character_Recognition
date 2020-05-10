function MyScript(Image)
Image=imread(Image);
Image=rgb2gray(Image);
binimg = binarize(Image);
th=align(binimg);
th=bin(th);
comp=conncomp(th);
num_comp=comp.NumObjects;
sz = comp.ImageSize(1);
pix_list = comp.PixelIdxList;
comps = zeros(num_comp,4);
temp=[];
for i = 1:num_comp
    pix = pix_list{1,i};
    pix_c = mod(pix,sz*ones(size(pix)));
    pix_r = ceil(pix./sz); 
    comps(i,:)=[min(pix_c) min(pix_r) max(pix_c) max(pix_r) ];
    temp=[temp ; (comps(i,3)-comps(i,1))*(comps(i,4)-comps(i,2))];
end

ind = mean(temp)/8;
for i = 1:num_comp
    if  temp(i)< ind               %comps(i,5)                        
        th(pix_list{1,i}) = 0;
        comps(i,:) = 0;
    end
end


temp=[];
sb=size(comps,1);
for i=1:sb
    if(comps(i,1)~=0)
        temp=[temp;comps(i,:)];
    end
end
fcomp=sortrows(temp);
fcomp=sortcol(fcomp);
fnumcomp=size(fcomp,1);



tsdata = zeros(fnumcomp,1024);  %test data
for i = 1:fnumcomp
pix = th(fcomp(i,1):fcomp(i,3),fcomp(i,2):fcomp(i,4));
pix = imresize(pix,[32,32]);
pix=pix(:);
tsdata(i,:) = pix;
end

tslab = predict(tsdata);    %predicting for the observed feature

p1 = zeros(fnumcomp,1);
m3=[];
for i = 1:fnumcomp-1
    p1(i) = fcomp(i+1,2)-fcomp(i,4);
    if (p1(i)>0)
        m3=[m3 i];
    end
end
ind2 = mean(p1(m3));
splab = zeros(fnumcomp,1); %space/line divider
spthr = ind2*1.5;       %space threshold
nlthr = ind2*(-10);     %new line threshold
for i = 1:fnumcomp
    if p1(i)>spthr
        splab(i) = 1;
    end
    if p1(i) < nlthr
        splab(i) = 2;
    end
end

tslab = [tslab splab];

labels = ['0';'1';'2';'3';'4';'5';'6';'7';'8';'9';'A';'B';'C';'D';'E';'F';'G';'H';'I';'J';'K';'L';'M';'N';'O';'P';'Q';'R';'S';'T';'U';'V';'W';'X';'Y';'Z';'a';'b';'c';'d';'e';'f';'g';'h';'i';'j';'k';'l';'m';'n';'o';'p';'q';'r';'s';'t';'u';'v';'w';'x';'y';'z'];

file = [ 'output.txt'];

fileID = fopen(file,'w');
for i = 1:size(tslab,1)
    if tslab(i,2)==0
        fprintf(fileID,'%1s',labels(tslab(i,1)));
    elseif tslab(i,2) == 1
        fprintf(fileID,'%1s ',labels(tslab(i,1)));
    else
        fprintf(fileID,'%1s\n',labels(tslab(i,1)));
    end
end
fclose(fileID);
open(file);
end