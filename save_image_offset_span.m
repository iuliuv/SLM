%offsets and spans - 16 bit integers...

function save_image_offset_span(phase, offsets, spans, file_name_prefix)
    
  pkg load mapping;
  phase = wrapTo2Pi(phase);
  for offset = offsets
    for span = spans
        phase_im = uint16(mod(offset + span*phase/2/pi, 2^16));
        imwrite(phase_im, 
          [file_name_prefix '_offs' sprintf('%05i', offset) '_spn' sprintf('%05i', span) '.tif'],
          'tiff');
    end
  end  
  

endfunction