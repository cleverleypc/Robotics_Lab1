function [ ] = Inverse( x,y,z )%input the X,Y and Z coordinates of the final point in the base frame,
%and you will get the rotation angle along with each of  the axises

%Inverse problem for the Lab1
%Inver kinematics - Geometric method

%The inverse problem in the XOY plane
x0=x; y0=y;
if y0==0
    if x0>0
        Theta0=-pi/2;
    else x0<0
        Theta0=pi/2;
    end
elseif x0*y0>=0
    Theta0 = -atan2(x0,y0);
else
    Theta0 = atan2(x0,-y0)+pi;

fprintf('The rotation angle along the axis z1 in the first frame,Theta0 is %.2f ��\n', rad2deg(Theta0));

%The inverse problem in the ZOX_Y plane
x1=sqrt(x^2+y^2); y1=z-190;
lArm1=100;
lArm2=100;
Theta2=acos((x1^2+y1^2-lArm1^2-lArm2^2)/(2*lArm1*lArm2));

Beta=atan2(y1,x1);
Phi=acos((x1^2+y1^2+lArm1^2-lArm2^2)/(2*lArm1*sqrt(x1^2+y1^2)));
Theta1=Beta-Phi;
fprintf('The rotation angle along the axis x1 in the first frame,Theta1 is %.2f ��\n', rad2deg(Theta1));
fprintf('The rotation angle along the axis x2 in the first frame,Theta2 is %.2f ��\n', rad2deg(Theta2));
end

