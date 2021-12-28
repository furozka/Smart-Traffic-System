clear;
image=imread('C:\Users\turhal\Desktop\Project1\shapes.png');
for renk=1:3
diff_im = imsubtract(image(:,:,renk),rgb2gray(image));
diff_im = medfilt2(diff_im, [3 3]);
diff_im = im2bw(diff_im,0.18);
diff_im = bwareaopen(diff_im,300);
bw = bwlabel(diff_im, 8);
s=size(bw);
s2=size(bw');
cc = bwconncomp(bw,4);
xlong=zeros(s(1),cc.NumObjects);
ylong=zeros(s2(1),cc.NumObjects);
xmaxlong=0;
ymaxlong=0;
cember=0;
kare=0;
dikdortgen=0;
ucgen=0;
tanimsiz_obje=0;
    for o=1:cc.NumObjects
        xlengths=[]; 
        ylengths=[];
        xtutucu=0;
        ytutucu=0;
        grain = false(size(bw));
        grain(cc.PixelIdxList{o}) = true;
        A=double(grain);
        B=A';
        for i=1:s(1)-1
            for j=1:s(2)-1
                X=A(i,j);
                if X==1
                    xlong(i,o)=xlong(i,o)+1;
                else
                    xlong(i,o)=xlong(i,o);
                end
            end
            if xlong(i,o)>0
                xlengths=[xlengths xlong(i,o)];
            end
        end
        for k=1:length(xlengths)-1
            if xlengths(k)>xlengths(k+1)
                xtutucu=xlengths(k);
                xlengths(k)=xlengths(k+1);
                xlengths(k+1)=xtutucu;
            end
            xmaxlong=xtutucu;
        end
        for m=1:s2(1)-1
            for n=1:s2(2)-1
                Y=B(m,n);
                if Y==1
                    ylong(m,o)=ylong(m,o)+1;
                else
                    ylong(m,o)=ylong(m,o);
                end
            end
            if ylong(m,o)>0
                ylengths=[ylengths ylong(m,o)];
            end
        end
        for l=1:length(ylengths)-1
            if ylengths(l)>ylengths(l+1)
                ytutucu=ylengths(l);
                ylengths(l)=ylengths(l+1);
                ylengths(l+1)=ytutucu;
            end
            ymaxlong=ytutucu;
        end
%        yay_uzunlugu=pi*xmaxlong;
        ilk_kenar=sqrt(ymaxlong^2+(xmaxlong/2)^2);
        ikinci_kenar=ilk_kenar;
        ucuncu_kenar=xmaxlong;
        ucgen_cevre=(ilk_kenar+ikinci_kenar+ucuncu_kenar)/2;
        ucgen_cevre_ile_alan=sqrt(ucgen_cevre*(ucgen_cevre-ilk_kenar)*(ucgen_cevre-ikinci_kenar)*(ucgen_cevre-ucuncu_kenar));
        ucgen_alan=xmaxlong*ymaxlong/2;
        if  (sum(xlengths)*0.99<= (pi*(xmaxlong/2)^2)*1.01+15) && (sum(xlengths)*0.99>= (pi*(xmaxlong/2)^2)*1.01-15 && xmaxlong==ymaxlong)
            cember=cember+1;
        elseif (sum(xlengths)<= (xmaxlong*ymaxlong)+5) && (sum(xlengths)>= (xmaxlong*ymaxlong)-5) && (xmaxlong==ymaxlong)
            kare=kare+1;
        elseif (sum(xlengths)<= (xmaxlong*ymaxlong)+5) && (sum(xlengths)>= (xmaxlong*ymaxlong)-5) && (xmaxlong~=ymaxlong)
            dikdortgen=dikdortgen+1;
        elseif (ucgen_cevre_ile_alan<=ucgen_alan+10) && (ucgen_cevre_ile_alan>=ucgen_alan-10)
            ucgen=ucgen+1;
        else
            tanimsiz_obje=tanimsiz_obje+1;
        end
    end
    if renk==1
        kirmizi_cember=cember;
        kirmizi_kare=kare;
        kirmizi_dikdortgen=dikdortgen;
        kirmizi_ucgen=ucgen;
        kirmizi_tanimsiz_obje=tanimsiz_obje;
    elseif renk==2
        yesil_cember=cember;
        yesil_kare=kare;
        yesil_dikdortgen=dikdortgen;
        yesil_ucgen=ucgen;
        yesil_tanimsiz_obje=tanimsiz_obje;
    elseif renk==3
        mavi_cember=cember;
        mavi_kare=kare;
        mavi_dikdortgen=dikdortgen;
        mavi_ucgen=ucgen;
        mavi_tanimsiz_obje=tanimsiz_obje;
    end
end
fprintf('%d tane kýrmýzý çember \n%d tane kýrmýzý kare \n%d tane kýrmýzý dikdörtgen \n%d tane kýrmýzý üçgen \n%d tane kýrmýzý tanýmsýz obje \n',kirmizi_cember,kirmizi_kare,kirmizi_dikdortgen,kirmizi_ucgen,kirmizi_tanimsiz_obje);
fprintf('%d tane yeþil çember \n%d tane yeþil kare \n%d tane yeþil dikdörtgen \n%d tane yeþil üçgen \n%d tane yeþil tanýmsýz obje \n',yesil_cember,yesil_kare,yesil_dikdortgen,yesil_ucgen,yesil_tanimsiz_obje);
fprintf('%d tane mavi çember \n%d tane mavi kare \n%d tane mavi dikdörtgen \n%d tane mavi üçgen \n%d tane mavi tanýmsýz obje \n',mavi_cember,mavi_kare,mavi_dikdortgen,mavi_ucgen,mavi_tanimsiz_obje);