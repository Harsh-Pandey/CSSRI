function []=skewing()
I=imread('image.jpg');
shx=input('enter the shearing  factor shx    ');
shy=input('enter the shearing  factor shy     ');
F=[1 shx 0;shy 1 0;0 0 1];
K=maketform('affine',F);
L=imtransform(I,K,'FillValues',[100;12;51]);
figure(1),imshow(L)
end
