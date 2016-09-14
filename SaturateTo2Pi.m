function Result = SaturateTo2Pi(Image)
   N = size(Image, 1);
   MeanVal = mean(mean(Image));
   
   MaskMax = Image<=(MeanVal+pi);
   MaskMin = Image>=(MeanVal-pi);
   
   Result = Image .* MaskMax .* MaskMin ...
     + pi*(ones(N) - MaskMax) ...
     - pi*(ones(N) - MaskMin);
   
endfunction
