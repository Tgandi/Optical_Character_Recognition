function CC= conncomp(img);
%readImage=imread(img);
%read2Image=rgb2gray(readImage);
Fimage=im2bw(img);
ImageS=size(img);
B=strel('square',8);
A=Fimage;
p=find(A==1);
p=p(1);
compMark=zeros([size(A,1) size(A,2)]);
N=0;

while(~isempty(p))
    N=N+1;
    p=p(1);
X=false([size(A,1) size(A,2)]);
X(p)=1;

Y=A&imdilate(X,B);
while(~isequal(X,Y))
    X=Y;
    Y=A&imdilate(X,B);
end

Pos=find(Y==1);

A(Pos)=0;
compMark(Pos)=N;

p=find(A==1);
%CCC=bwconncomp(img);
end
%%imtool(compMark);
ImageSize=size(compMark);
[m n]=size(compMark);
NumObjects=0;
for i=1:m
    for j=1:n
        if (compMark(i,j)>=NumObjects) 
            NumObjects=compMark(i,j);
        end
    end
end

NumObjects;
connectivity=4;
for i=1:NumObjects
    Im=zeros([size(A,1) size(A,2)]);
    ele=find(compMark==i);
    Im(ele)=1;
  %    figure,imshow(Im);
    PixelIdxList{i}= ele;
end

CC = struct ('Connectivity', connectivity, 'ImageSize', ImageS, 'NumObjects', NumObjects);
  CC.PixelIdxList = PixelIdxList;
end


