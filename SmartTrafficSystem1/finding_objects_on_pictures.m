image=imread('C:\Users\turhal\Desktop\Project1\shapes.png');
for color=1:3
diff_im = imsubtract(image(:,:,color),rgb2gray(image));
diff_im = medfilt2(diff_im, [3 3]);
diff_im = im2bw(diff_im,0.18);
diff_im = bwareaopen(diff_im,300);
bw = bwlabel(diff_im, 8);
cc = bwconncomp(bw,4); 
stats = regionprops(bw, 'BoundingBox', 'Centroid','MajorAxisLength','MinorAxisLength','Area','Extent');
imshow('C:\Users\turhal\Desktop\Project1\shapes.png');
trishape=0;
recshape=0;
circshape=0;
for o=1:cc.NumObjects
    grain = false(size(bw));
    grain(cc.PixelIdxList{o}) = true;
    C=corner(grain);
    bb = stats(o).BoundingBox;
    bc = stats(o).Centroid;
    d=mean([stats(o).MajorAxisLength stats(o).MinorAxisLength],2);
    r=d/2;
    %a=text(bc(1)+15,bc(2), strcat('X: ', num2str(round(bc(1))), '    Y: ', num2str(round(bc(2)))));
    %set(a, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');
    A=stats(o).Extent       
    area=stats(o).Area
    circularity = ((2*pi*r) .^ 2) ./ (4 * pi * area);
    bw1=edge(grain,'Roberts');
    data=corner(bw1);
    ver1=zeros(1,2);
    ver1(1,1)=data(1,1);
    ver1(1,2)=data(1,2);
    ver2=zeros(1,2);
    ver2(1,1)=data(2,1);
    ver2(1,2)=data(2,2);
    ver3=zeros(1,2);
    ver3(1,1)=data(3,1);
    ver3(1,2)=data(3,2);
    ver4=zeros(1,2);
    ver4(1,1)=data(4,1);
    ver4(1,2)=data(4,2);
     if (0.99<=A)&&(A<=1.05) && (ver1(1)==ver2(1)) && (ver3(1)==ver4(1))
        
        recshape=recshape+1;

     else if (0.98<=circularity)&&(circularity<=1.05) && (0.75<A)&&(A<0.80)% && (ver1(1)==ver2(1)) || (ver1(1)+1==ver2(1)) || (ver1(1)==ver2(1)+1) || (ver3(2)==ver4(2)) || (ver3(2)+1==ver4(2)) || (ver3(2)==ver4(2)+1)
        Rmin=30;
        Rmax=600;
        [centersBright, radiiBright] = imfindcircles(diff_im,[Rmin Rmax],'ObjectPolarity','bright');
        [centersDark, radiiDark] = imfindcircles(diff_im,[Rmin Rmax],'ObjectPolarity','dark');
        
        circshape=circshape+1;
    %a=text(bc(1)+15,bc(2), strcat('Circle   ',num2str(circshape)));
    %set(a, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');
         end
     end
    if (ver3(2)==ver2(2)) && ((A>0.5)&&(A<0.99)||(A>1.05)) && (circularity>1.1) || (circularity<0.99)%ver3(2)==ver4(2) & ver1(1)~=ver2(1) & ver1(1)+1~=ver2(1) & ver1(1)~=ver2(1) & circularity>1.1
                
                trishape=trishape+1;
           %  a=text(bc(1)+15,bc(2), strcat('Triangle   ',num2str(trishape)));
            % set(a, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');
    end
    if color==1
        red_recshape=recshape;
        red_circshape=circshape;
        red_trishape=trishape;
    elseif color==2
        green_recshape=recshape;
        green_circshape=circshape;
        green_trishape=trishape;
    elseif color==3
        blue_recshape=recshape;
        blue_circshape=circshape;
        blue_trishape=trishape;
    end
end
end
if red_recshape>0
    rectangle('Position',bb,'EdgeColor','b','LineWidth',2);
    a=text(bc(1)+15,bc(2), strcat('Rectangle   ',num2str(red_recshape)));
    set(a, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');
elseif red_circshape>0
    viscircles(centersBright, radiiBright,'Color','b');
    b=text(bc(1)+15,bc(2), strcat('Circle   ',num2str(red_circshape)));
    set(b, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');
elseif red_trishape>0
    rectangle('Position',bb,'EdgeColor','b','LineWidth',2);
    c=text(bc(1)+15,bc(2), strcat('Triangle   ',num2str(red_trishape)));
    set(c, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');
end
        if green_recshape>0
            rectangle('Position',bb,'EdgeColor','b','LineWidth',2);
            a=text(bc(1)+15,bc(2), strcat('Rectangle   ',num2str(green_recshape)));
            set(a, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');
        elseif green_circshape>0
            viscircles(centersBright, radiiBright,'Color','b');
            b=text(bc(1)+15,bc(2), strcat('Circle   ',num2str(green_circshape)));
            set(b, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');
        elseif green_trishape>0
            rectangle('Position',bb,'EdgeColor','b','LineWidth',2);
            c=text(bc(1)+15,bc(2), strcat('Triangle   ',num2str(green_trishape)));
            set(c, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');
        end
        if blue_recshape>0
            rectangle('Position',bb,'EdgeColor','b','LineWidth',2);
            a=text(bc(1)+15,bc(2), strcat('Rectangle   ',num2str(blue_recshape)));
            set(a, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');
        elseif blue_circshape>0
            viscircles(centersBright, radiiBright,'Color','b');
            b=text(bc(1)+15,bc(2), strcat('Circle   ',num2str(blue_circshape)));
            set(b, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');
        elseif blue_trishape>0
            rectangle('Position',bb,'EdgeColor','b','LineWidth',2);
            c=text(bc(1)+15,bc(2), strcat('Triangle   ',num2str(blue_trishape)));
            set(c, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');
        end