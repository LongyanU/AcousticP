clear;
clc
close all;


load('SGFDVx.mat')
plotimage(sign(real(Vz)) .*sqrt(real(Vz).^2+ imag(Vz).^2))

load('SG.mat')
plotimage(sign(real(Vz)) .*sqrt(real(Vz).^2+ imag(Vz).^2))

load('SG2.mat')
plotimage(sign(real(Vz)) .*sqrt(real(Vz).^2+ imag(Vz).^2))

