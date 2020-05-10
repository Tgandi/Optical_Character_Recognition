clear all;
clc;
imgPath = 'Msk\';
imgType = '*.png'; % change based on image type
dirs=dir(imgPath);
data=[];
target=[];
for j=3:length(dirs)
    images  = dir([imgPath dirs(j).name '\' imgType]);
for idx = 3:length(images)
    temp = imread([imgPath dirs(j).name '\' images(idx).name]);
    temp=imresize(temp,[32,32]);
    temp=im2bw(temp,graythresh(temp));
    data=[data ; temp(:)'];
    target=[target ; j-2];
  
end
end

