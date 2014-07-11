%test
clear;clc;

Ia = imread('test1.jpg');
image(Ia) ; colormap gray ;
axis equal ; axis off ; axis tight ;

Ias = uint8(rgb2gray(Ia));
clf ; imagesc(Ias) ; colormap(gray(256)) ;
axis equal ; axis off ; axis tight ;


%delta = [10 30 50 70 90];
[r,f] = vl_mser(Ias,'MinDiversity',0.7,'MaxVariation',0.2,'Delta',10) ;

% compute regions mask
M = zeros(size(Ias)) ;
for x=r'
  s = vl_erfill(Ias,x) ;
  M(s) = M(s) + 1;
end

% adjust convention
f = vl_ertr(f) ;

figure(1) ;
hold on ;
h1 = vl_plotframe(f) ; set(h1,'color','y','linewidth',3) ;
h2 = vl_plotframe(f) ; set(h2,'color','k','linewidth',1) ;
%vl_demo_print('mser_basic_frames') ;

figure(2) ; clf ; imagesc(Ias) ; hold on ;
colormap(gray(256)) ;
if vl_isoctave()
  [c,h]=contour(M,(0:max(M(:)))+.5,'y','linewidth',3) ;
else
  [c,h]=contour(M,(0:max(M(:)))+.5) ;
  set(h,'color','y','linewidth',3) ;
end
axis equal ; axis off ;