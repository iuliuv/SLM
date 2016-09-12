function Rez = CheckerBoard(ImSize, SqSize)

  if mod(ImSize, SqSize*2) != 0
    error('imsize must be multiple of 2*sqsize');
  end
  Rez = repmat([zeros(SqSize), ones(SqSize) ; ones(SqSize), zeros(SqSize)], ImSize/2/SqSize);
  
endfunction