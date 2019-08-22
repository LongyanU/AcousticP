clear;
clc;
close all
%first order normal-grid pseudo spectrum method Aug 11
nt=700;
dx=10;
dz=10;
h=dx;
nx=355;
nz=355;

v=ones(nz,nx)*2500;
v(1:floor(100),:)=1500;
isnap=40;    % snapshot sampling

%define the axes
x=(0:nx-1)*dx;
z=(0:nz-1)*dz;
dt=0.001;

%define source wavelet
f0=45;
t=(1:nt)*dt;
t0=4/f0;                       % initialize time axis
src=10^6*exp(-f0^2*(t-t0).*(t-t0));              % source time function
src=-(diff(src))/dx^2;				% time derivative to obtain gaussian
seis_record=zeros(nt,nx);

zs=60;
xs=floor(nz/2);
p=zeros([nz nx]); Vx=p; Vz=p;
coeff=[ 1.57866, -0.296598, 0.0949307, -0.0344762, 0.0120067, -0.00344529, 0.000605554];

tic
for it=1:nt-2,
    d2px11=circshift(p,[0 -1])-circshift(p,[0 0]);
    d2px12=(circshift(p,[0 -2])-circshift(p,[0 1]));
    d2px13=(circshift(p,[0 -3])-circshift(p,[0 2]));
    d2px14=(circshift(p,[0 -4])-circshift(p,[0 3]));
    d2px15=(circshift(p,[0 -5])-circshift(p,[0 4]));
    d2px16=(circshift(p,[0 -6])-circshift(p,[0 5]));
    d2px17=(circshift(p,[0 -7])-circshift(p,[0 6]));
    
    d2pz11=(circshift(p,[1 0])-circshift(p,[0 0]));
    d2pz12=(circshift(p,[2 0])-circshift(p,[-1 0]));
    d2pz13=(circshift(p,[3 0])-circshift(p,[-2 0]));
    d2pz14=(circshift(p,[4 0])-circshift(p,[-3 0]));
    d2pz15=(circshift(p,[5 0])-circshift(p,[-4 0]));
    d2pz16=(circshift(p,[6 0])-circshift(p,[-5 0]));
    d2pz17=(circshift(p,[7 0])-circshift(p,[-6 0]));
    
    d2px=coeff(1)*d2px11+coeff(2)*d2px12+coeff(3)*d2px13+coeff(4)*d2px14+coeff(5)*d2px15+coeff(6)*d2px16...
        +coeff(7)*d2px17;
    d2pz=(coeff(1)*d2pz11+coeff(2)*d2pz12+coeff(3)*d2pz13+coeff(4)*d2pz14+coeff(5)*d2pz15+coeff(6)*d2pz16...
        +coeff(7)*d2pz17);
    
    Vx=Vx-dt*d2px/h;
    Vz=Vz-dt*d2pz/h;
    Vx(zs,xs)=  Vx(zs,xs)+src(it)*dt^2;
    Vz(zs,xs)=  Vz(zs,xs)+src(it)*dt^2;
    
    [Vx,Vz]=spongeABC(Vx,Vz,nx,nz,45,45,0.009);
    
    d2vx1=(circshift(Vx,[0 0])-circshift(Vx,[0 1]));
    d2vz1=(circshift(Vz,[0])-circshift(Vz,[-1]));
    
    p=p-dt*v.^2.*(d2vx1+d2vz1)/h;
    [p,p]=spongeABC(p,p,nx,nz,45,45,0.009);
    
    
    if rem(it,isnap)== 0,
        imagesc(x,z,p), axis equal
        colormap gray
        xlabel('x'),ylabel('z')
        title(sprintf(' Time step: %i - Max ampl: %g ',it,max(max(p))))
        drawnow
    end
end

toc
save SGFDP.mat
