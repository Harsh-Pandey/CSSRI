%Load data
im1Orig = double(imread('sckew.jpg'));
im2Orig = double(imread('unsckew.jpg'));
%Calculate gradients
im1 = imgradient(im1Orig);
im2 = imgradient(im2Orig);
%Get registration values
[output, Greg] = dftregistration(fft2(im1),fft2(im2),50);
%Translate image
imOut = TranslateImage(im2, output(3), output(4),'method','Fourier');
img_out = TranslateImage(img_in, rowshift, colshift)
    %% Create frequency space sampling vectors
    [numrows, numcols] = size(img_in);
    [n,m] = meshgrid(-fix(numcols/2):fix((numcols-1)/2),-fix(numrows/2):fix((numrows-1)/2));
    m = m/numrows;
    n = n/numcols;
     %% Perform translation in the Fourier domain
    img_fft = fftshift(fft2(ifftshift(double(img_in))));%Cast the input image to a double    
    shiftOtf = exp(-1i*2*pi*m*rowshift) .* exp(-1i*2*pi*n*colshift);
    img_fft_trans = img_fft .* shiftOtf;
    img_out = real(fftshift(ifft2(ifftshift(img_fft_trans))));
    return
  