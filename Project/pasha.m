image=imread('image.jpg');
imshow(image);
image=imresize(image,0.1);
global a;
global c;
image
%if (image,'uint8')
%d=im2uint8(image)
%imwrite(d,'image1.jpg');
%c=uint8(reshape(double(image)*a(1,:)',size(c)));
%else
 %   c = reshape(image*a(1,:)', size(c));
%end
R = double(image)/255;
G = double(image)/255;
B = double(image)/255;
[M,N]=size(image);
s=M*N;
RGB=[reshape(R,1,s);reshape(G,1,s);reshape(B,1,s)];
a=[-1.382995,  0.249841, -0.159960;-0.265864, -1.457404,  0.933098;-1.423661,  0.167074,  1.381977;]
 
xyz=a.*RGB;

%Image2 = a * [R(:), G(:), B(:)].';
  