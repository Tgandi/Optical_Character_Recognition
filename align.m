function aimg = align(img)
    maxm = 0;
    for i=1:40
        angle = i-20;
        temp = imrotate(img,angle);
        histg = sum(temp,2);
        m = sort(histg,'descend');
        m = mean(m(1:5,1));
        if maxm < m
            maxm = m;
            max_angle = angle;
        end
    end
    aimg = imrotate(img,max_angle);
end