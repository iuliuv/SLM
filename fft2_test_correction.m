N = 512;

a = CheckerBoard(N, 16)-0.5;

figure(1);

subplot(1,2,1);
imagesc(a);
colorbar;
axis('equal');

subplot(1,2,2);
b = fftshift(fft2(a));
imagesc(abs(b));
colorbar;
axis('equal');

figure(2);

subplot(1,2,1);
c = [ N/2:-1:1 1:(N/2) ]/N*2;
c = 1 + 0.36*c + 0.56*c.^2;
c = repmat(c, N, 1);
c = c .* c';
imagesc(c);
colorbar;
axis('equal');

subplot(1,2,2);
d = ifft2(ifftshift(b .* c));
imagesc(real(d));
colorbar;
axis('equal');