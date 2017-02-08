clear all

pkg load image
pkg load communications
pkg load mapping

imsize     = 512;
wavelength = 700;
iterations = 15;

offset = 0;
a = zeros(imsize);

radius = 5;
cx=imsize/2-offset;
cy=imsize/2-offset;
for x=cx-radius:cx+radius
  dy=round(sqrt(radius^2-(x-cx)^2));
  a(x, cy-dy:cy+dy) = ones(1, dy*2+1);
end


radius = 5;
cx=imsize/2-offset-10;
cy=imsize/2-offset-30;
for x=cx-radius:cx+radius
  dy=round(sqrt(radius^2-(x-cx)^2));
  %a(x, cy-dy:cy+dy) = ones(1, dy*2+1);
end


radius = 5;
cx=imsize/2-offset-30;
cy=imsize/2-offset-20;
for x=cx-radius:cx+radius
  dy=round(sqrt(radius^2-(x-cx)^2));
  %a(x, cy-dy:cy+dy) = ones(1, dy*2+1);
end


sx=100;
sy=400;
ss=30;
for x=sx-ss/2:sx+ss/2-1
  %aa(x,sy-ss:sy+ss-1) = ones(1, ss*2);
end

a = imread('images\love.bmp');
a = double(a); 
a = fliplr(a);
a = flipud(a);

%a = ones(imsize);

%a = [ a fliplr(a) ; fliplr(a) a ];
%a(1:128, 1:128) = zeros(128);
%a(1:128, 385:512) = zeros(128);
%a(129:256, 385:512) = zeros(128);
%a(385:512, 1:128) = zeros(128);
 

%a =  a.*exp(2i*pi*rand(imsize));
a =  fftshift(a); 
 
 
light = fspecial('gaussian',imsize,imsize/2)*100;
light = light/mean(mean(light));

lmask=zeros(imsize);
radius = 254;
cx=imsize/2;
cy=imsize/2;
for x=cx-radius:cx+radius
  dy=round(sqrt(radius^2-(x-cx)^2));
  lmask(x, cy-dy:cy+dy) = ones(1, dy*2+1);
end

%light = light .* lmask;


  
  
figure(1)
subplot(2,3,1);
imagesc(ifftshift(abs(a)));
axis equal;
title('original image');
colorbar

subplot(2,3,3);
imagesc(light);
axis equal;
title('actual laser intensity');
colorbar

r = a;
for i=1:iterations
  f = ifft2(abs(a).*exp(1i*angle(r)));  
  r = fft2(light*mean(mean(abs(f))).*exp(1i*angle(f)));
  angle_w_noise = angle(f);
  angle_w_noise = wrapTo2Pi(angle_w_noise);
  %angle_w_noise = SLMCompensation(angle_w_noise);
  angle_w_noise = angle_w_noise/2;
  intensity_w_noise = light*mean(mean(abs(f)));
  %angle_w_noise(1:256,:) = -angle_w_noise(257:512,:);
  %angle_w_noise(1:256, :) = zeros(256, imsize);
  %intensity_w_noise = circshift(intensity_w_noise, 50);
  %angle_w_noise = -circshift(angle_w_noise, 50);
  im_noise = fft2(intensity_w_noise.*exp(1i*angle_w_noise));


  subplot(2,3,2);
  imagesc(abs(ifftshift(f)));
  axis equal;
  title('ideal laser intensity');
  colorbar
  
  subplot(2,3,4);
  phase = angle(ifftshift(f));
  phase = fliplr(phase);
  imagesc(phase);
  axis equal;
  title(sprintf('Phase, iteration: %2.0f', i));
  colorbar;

  subplot(2,3,5);
  r_abs=abs(r);
  imagesc(ifftshift(r_abs));
  axis equal;
  colorbar;
  title(sprintf('Expected image, iterations: %2.0f, contrast:%4.2f', i, ImageContrast(r_abs, a)));
  
  subplot(2,3,6);
  im_noise_abs=abs(im_noise);
  imagesc(ifftshift(im_noise_abs));
  axis equal;
  title(sprintf('Expected image including sensor noise, contrast:%4.2f', ImageContrast(im_noise_abs, a)));
  colorbar;

  drawnow
  
  %waitforbuttonpress;
  
end

dir = 'uni';

%SaveImageCentersSpans(phase, 50000, 30000, [dir '\linear']); 
%SaveImageCentersSpans(SaturateTo2Pi(SLMCompensation(phase, 0.2, 0.3)), 
%                       50000, 20000:2000:30000, [dir '\saturate']); 
SaveImageLocalLUT(SaturateTo2Pi(SLMCompensation(phase, 0.2, 0.3)), 
                       700, [dir '\sat_uni' ]); 
SaveImageLocalLUT(SaturateTo2Pi(SLMCompensation(phase, 0.2, 0.3)), 
                       1064, [dir '\sat_uni']);

                       % SaveImageCentersSpans(ScaleTo2Pi(SLMCompensation(phase, 0.2, 0.3)), 
%      50000, 30000, [dir '\scale']); 

%for Shift = 0:0.1:(4*pi)      
%  SaveImageCentersSpans(SaturateTo2Pi(Shift+SLMCompensation(phase, 0.2, 0.3)), 
%                        50000, 30000, [dir '\sat_shift_' sprintf('%3.1f', Shift)]); 
%end



%SaveImageCentersSpans(phase, 32767, 65534, [dir '\linear']); 
%SaveImageLocalLUT(phase, 1064, [dir '\lut']);
%SaveImageLocalLUT(phase, 700, [dir '\lut']);

%phase(1:256,:) = zeros(256,imsize);
%imwrite(apply_lut(phase, wavelength), ['out_lut_' num2str(700) '.tiff'], 'tiff');