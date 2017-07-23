clc
close all
clear all
f_pt = importdata('position_triangle.txt');
tri_pt = importdata('triangle_points.txt');

%dis_pt = importdata('displacement_happy.txt');
%dis_pt = importdata('displacement_upset.txt');
%dis_pt = importdata('displacement_angry.txt');
dis_pt = importdata('displacement_sleepy.txt');

rgbimg = imread('lena.tiff');
warpimg = rgbimg;
figure(1)
imshow(rgbimg);
title('Original Image')
hold on

for i = 1:22
plot(f_pt(i,1),f_pt(i,2),'go');
end

for jj = 1:32
    plot([f_pt(tri_pt(jj,1),1) f_pt(tri_pt(jj,2),1) f_pt(tri_pt(jj,3),1)], [f_pt(tri_pt(jj,1),2) f_pt(tri_pt(jj,2),2) f_pt(tri_pt(jj,3),2)], 'r');     
end

lambda = zeros(3,1);
for x = 215:365
    for y = 200:400
        v_p = [y; x; 1];
        
        for j = 1:32
         B = [dis_pt(tri_pt(j,1),2) dis_pt(tri_pt(j,1),1) 1; 
             dis_pt(tri_pt(j,2),2) dis_pt(tri_pt(j,2),1) 1; 
             dis_pt(tri_pt(j,3),2) dis_pt(tri_pt(j,3),1) 1]'; 
         
         A = [f_pt(tri_pt(j,1),2) f_pt(tri_pt(j,1),1) 1; 
             f_pt(tri_pt(j,2),2) f_pt(tri_pt(j,2),1) 1; 
             f_pt(tri_pt(j,3),2) f_pt(tri_pt(j,3),1) 1]';
                  
            lambda = B\v_p;
            if lambda(1)> 0 && lambda(2)> 0 && lambda(3)> 0
                v = round(A * lambda);
                warpimg(v(1),v(2),1:3) = rgbimg(y,x,1:3);
            end         
            
        end 
    end
end

figure(2)
imshow(warpimg);
title('Warp Image')
