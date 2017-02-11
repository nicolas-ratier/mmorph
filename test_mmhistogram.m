clear all;
close all;
img=imread(‘yourimage.png’);
figure(),imhist(img)


stem(count);
xlabel('pixel');
ylabel('Level');