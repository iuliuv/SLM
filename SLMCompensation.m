function Result = SLMCompensation(Phase, a1, a2)
  N = size(Phase, 1);
  C = [ N/2:-1:1 1:(N/2) ]/N*2;
  %C = 1 + 0.36*C + 0.56*C.^2; % original formula from the paper
  C = 1 + a1*C + a2*C.^2;
  C = repmat(C, N, 1);
  C = C .* C';
  FFT = fftshift(fft2(Phase));
  FFTC = FFT .* C;
  PhaseC = ifft2(ifftshift(FFTC));
  Result = real(PhaseC); 
endfunction


