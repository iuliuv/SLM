function generate_checker_board(imsize, sqsize, offsets, spans, file_name_prefix);
  if mod(imsize, sqsize*2) != 0
    error('imsize must be multiple of 2*sqsize');
  end
  im = repmat([zeros(sqsize), ones(sqsize) ; ones(sqsize), zeros(sqsize)], imsize/2/sqsize);
  save_image_offset_span(im*2*pi, offsets, spans, file_name_prefix);  
endfunction