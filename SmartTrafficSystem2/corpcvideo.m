clc; clear;
obj=VideoReader('C:\Users\turhal\Desktop\ders\arabakýsa2.mp4');
nFrames=obj.NumberOfFrames;

for frame=500:nFrames
    kare=0;
    thisFrame=read(obj,frame);
    araba=imcrop(thisFrame,[250 100 400 600]);
    gray=rgb2gray(araba);
    bw=im2bw(gray, 0.75);
    bw=medfilt2(bw, [3 3]);
    bw=bwareaopen(bw, 1800);
    bw = bwlabel(bw, 8);
    cc=bwconncomp(bw, 8);
    stats = regionprops(bw, 'BoundingBox', 'Centroid','Extent');
    
    figure
    imshow(araba);
    hold on
    for object=1:length(stats)
        A=stats(object).Extent;
        bb = stats(object).BoundingBox;
        bc = stats(object).Centroid;
        if (0.2<=A)&&(A<=1.8)
            kare=kare+1;
            rectangle('Position',bb,'EdgeColor','r','LineWidth',2);
            a=text(bc(1)+15,bc(2), strcat('Car   ',num2str(kare)));
            set(a, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');
        end
    end
    hold off
end    
    %bw= insertText(bw, [10 10], kare, 'BoxOpacity', 1, 'FontSize', 36);
    %figure
    %imshow(bw);
    %araba(frame)=ic;
    %araba3=VideoWriter('myFile','Archival');
    %imshow(araba3);

%mFrames=araba.NumberOfFrames;