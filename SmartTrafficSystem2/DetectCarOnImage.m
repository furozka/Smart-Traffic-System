clc; clear;
car_number=0;
car=imread('C:\Users\turhal\Desktop\ders\araba4.jpg');
car=imcrop(car,[300 175 520 1000]);
figure
imshow(car);
gray=rgb2gray(car);
    bw=im2bw(gray, 0.75);
    bw=medfilt2(bw, [3 3]);
    bw=bwareaopen(bw, 2000);
    bw = bwlabel(bw, 8);
    cc=bwconncomp(bw, 8);
    stats = regionprops(bw, 'BoundingBox', 'Centroid','Extent');
figure, imshow(bw);
figure
imshow(gray);
figure
imshow(car);
hold on
    for object=1:length(stats)
        A=stats(object).Extent;
        bb = stats(object).BoundingBox;
        bc = stats(object).Centroid;
        if (0.2<=A)&&(A<=1.8)
            car_number=car_number+1;
            rectangle('Position',bb,'EdgeColor','r','LineWidth',2);
            a=text(bc(1)+15,bc(2), strcat('Car   ',num2str(car_number)));
            set(a, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');
        end
    end
hold off