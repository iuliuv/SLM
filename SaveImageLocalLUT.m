function SaveImageLocalLUT(Image, Wavelength, FileNamePrefix)
  
  imwrite(ApplyLUT(Image, Wavelength), [FileNamePrefix '_LLUT' num2str(Wavelength) '.tiff'], 'tiff');

endfunction