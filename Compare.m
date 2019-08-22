clear;
clc
close all;
% 
load('SGFDP.mat')
figure;plot(Vx(:,150)   ,'b') 

% load('SGFDVx.mat')
% figure;plot(Vx(:,150)   ,'b') 

tt=Vx(:,150);
% 
% load('SG.mat')
% hold on;plot(sign(real(Vx(:,150))) .*sqrt(real(Vx(:,150)).^2+ imag(Vx(:,150)).^2)   ,'r')
% hold on; plot(sign(real(Vx(:,150))) .*sqrt(real(Vx(:,150)).^2+ imag(Vx(:,150)).^2)-tt- 5*10^-6  ,'r')

load('SG2.mat')
hold on;plot(sign(real(Vx(:,150))) .*sqrt(real(Vx(:,150)).^2+ imag(Vx(:,150)).^2)   ,'r--')

hold on; plot((sign(real(Vx(:,150))) .*sqrt(real(Vx(:,150)).^2+ imag(Vx(:,150)).^2)-tt- 5*10^-6 ) ,'r--')

load('SG3.mat')
% hold on;plot(sign(real(Vx(:,150))) .*sqrt(real(Vx(:,150)).^2+ imag(Vx(:,150)).^2)   ,'c')
% hold on;plot(sign(real(Vx(:,150))) .*sqrt(real(Vx(:,150)).^2+ imag(Vx(:,150)).^2)-tt -5*10^-6  ,'c')

load('SG4.mat')
hold on;plot(sign(real(Vx(:,150))) .*sqrt(real(Vx(:,150)).^2+ imag(Vx(:,150)).^2)   ,'m')
hold on;plot((sign(real(Vx(:,150))) .*sqrt(real(Vx(:,150)).^2+ imag(Vx(:,150)).^2)-tt-5*10^-6 )  ,'m')
axis([0 350 -6*10^-6 8*10^-6])
grid on
box on