%test
clear;clc;

Ia = imread('test1.jpg');

Ias = single(rgb2gray(Ia));



binSize = 8 ;
magnif = 3 ;
step = 3;
Ias_smooth = vl_imsmooth(Ias, sqrt((binSize/magnif)^2 - .25)) ;
[fa, da] = vl_dsift(Ias_smooth, 'size', binSize,'step',step) ;  



Ib = imread('test2.jpg');
Ibs = single(rgb2gray(Ib));

binSize = 8 ;
magnif = 3 ;
step = 3;
Ibs_smooth = vl_imsmooth(Ibs, sqrt((binSize/magnif)^2 - .25)) ;
[fb, db] = vl_dsift(Ibs_smooth, 'size', binSize,'step',step) ;  


[matches, scores] = vl_ubcmatch(da, db);

[drop, perma] = sort(scores, 'descend') ;
matches = matches(:, perma) ;
scores  = scores(perma) ;

figure(1) ; clf ;
imagesc(cat(2, Ia, Ib)) ;
axis image off ;


figure(2) ; clf ;
imagesc(cat(2, Ia, Ib)) ;

xa = fa(1,matches(1,:)) ;
xb = fb(1,matches(2,:)) + size(Ia,2) ;
ya = fa(2,matches(1,:)) ;
yb = fb(2,matches(2,:)) ;

hold on ;
h = line([xa ; xb], [ya ; yb]) ;
set(h,'linewidth', 1, 'color', 'b') ;

vl_plotframe(fa(:,matches(1,:))) ;
fb(1,:) = fb(1,:) + size(Ia,2) ;
vl_plotframe(fb(:,matches(2,:))) ;
axis image off ;






