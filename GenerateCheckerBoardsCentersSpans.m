function GenerateCheckerBoardsCentersSpans(ImSize, SqSize, Centers, spans, file_name_prefix);
  SaveImageCentersSpans(CheckerBoard(ImSize, SqSize)*2*pi, Centers, spans, file_name_prefix);  
endfunction