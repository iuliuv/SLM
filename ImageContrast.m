function c = ImageContrast(im, mask)
  imsize = size(im, 1);
  brightness = sum(sum(im.*mask)) / sum(sum(mask));
  dark_mask  = ones(imsize)-mask;
  darkness   = sum(sum(im.*dark_mask)) / sum(sum(dark_mask));
  c = brightness / darkness;
end
