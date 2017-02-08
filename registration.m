pkg load image;

function test1(fig)
  global dmd_ccd
  global slm_ccd
  global H
  global Pos
  global dmd_ccd
 
  ui=getappdata(fig, 'ui');
  
  ang_rad = ui.angle * pi / 180;
  trmat = [ui.scale 0 0 ; 0 ui.scale 0 ; 0 0 1] * ...
     [cos(ang_rad) sin(ang_rad) 0 ; -sin(ang_rad) cos(ang_rad) 0 ; 0 0 1 ] * ...
     [ 1 0 0 ; 0 1 0 ; ui.dx -ui.dy 1];
  
  T1 = maketform('affine', trmat);
  tr_img = imtransform(slm_ccd, T1, ...
     'VData', [-Pos(1) Pos(1)], 'UData', [-Pos(2), Pos(2)], ...
     'YData', [-Pos(1)*2 Pos(1)*2], 'XData', [-Pos(2)*2, Pos(2)*2], ...
     'FillValues', 0);
  
  subplot(H);
  imshow(abs(cat(3, dmd_ccd*min(1, ui.blend*2), tr_img*min(1, 2-ui.blend*2), zeros(size(tr_img)))), 'InitialMagnification', 'fit');
  hold on
  
  sq = [ -256 256 256 -256 -256 ; -256 -256 256 256 -256 ; 1 1 1 1 1]';
  sq = sq * trmat;
  plot(sq(:,1)+512, sq(:, 2)+512);
  
  ax = gca;
  set(gca, 'Units', 'Pixel', 'Position', [1 1 640 512]);
  
  hold off
endfunction

function out = contrast(img)
  out = double(img);
  out = out - min(min(out));
  out = out / max(max(out));
endfunction

global dmd_ccd
global slm_ccd
global Pos

dmd_ccd = contrast(imread('registration\dmd love.tif'));
slm_ccd = contrast(imread('registration\slm love.tif'));

Pos = (size(dmd_ccd)-1)/2;
trmat = [1 0 0 ; 0 1 0 ; 0 0 1];
T1 = maketform('affine', trmat);
dmd_ccd = imtransform(dmd_ccd, T1, ...
     'VData', [-Pos(1) Pos(1)], 'UData', [-Pos(2), Pos(2)], ... 
     'YData', [-Pos(1)*2 Pos(1)*2], 'XData', [-Pos(2)*2, Pos(2)*2], ...
     'FillValues', 0);


  
clf
F = figure(1);
global H
H = subplot('Position', [0 0 0.8 1]);
axis equal;
ui = registrationui(F, 1, 0, 0, 0, @test1);









