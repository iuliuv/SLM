%offsets and spans - 16 bit integers...
%phase in radians

function SaveImageCentersSpans(phase, Centers, spans, file_name_prefix)
    
  
  phase = wrapTo2Pi(phase);
  for iCenter = Centers
    for iSpan = spans
        phase_im = uint16(mod(iCenter - iSpan/2 + iSpan*phase/2/pi, 2^16));
        imwrite(phase_im, 
          [file_name_prefix '_center' sprintf('%05i', iCenter) '_spn' sprintf('%05i', iSpan) '.tif'],
          'tiff');
    end
  end  
  

endfunction