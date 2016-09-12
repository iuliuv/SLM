function generate_checker_board(ImSize, sqsize, offsets, spans, file_name_prefix);
  save_image_offset_span(CheckerBoard(ImSize, SqSize)*2*pi, offsets, spans, file_name_prefix);  
endfunction