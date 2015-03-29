function [n1,n2,n3] = auxiliaryFunction2( x,y,z )
%Inverse problem for the Lab1
%Input the X,Y and Z coordinates of the final point in the base frame,
%and you will get the rotation angle along with each of  the axises

%Inver kinematics - Geometric method

%The inverse problem in the XOY plane
x0=x; y0=y;
if y0==0
    if x0>0
        Theta0=-pi/2;
    else
        Theta0=pi/2;
    end
elseif x0*y0>=0
    Theta0 = -atan2(x0,y0);
else
    Theta0 = atan2(x0,-y0)+pi;
end

%The inverse problem in the ZOX_Y plane
x1=sqrt(x^2+y^2); y1=z-190;
lArm1=200;
lArm2=130;
Theta2=acos((x1^2+y1^2-lArm1^2-lArm2^2)/(2*lArm1*lArm2));

Beta=atan2(y1,x1);
Phi=acos((x1^2+y1^2+lArm1^2-lArm2^2)/(2*lArm1*sqrt(x1^2+y1^2)));
Theta1=Beta+Phi;

n1 = rad2deg(Theta0);
n2 = rad2deg(Theta1);
n3 = rad2deg(Theta2);
end
