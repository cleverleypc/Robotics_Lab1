function [ ] = inverseKinematics( P,A )
% Input three coordinates of point P as the position of the end-effector
% Input the orientation matrix of the end-effector

% Extract the Y axis from the orientation matrix
VectorX = A(1,2);
VectorY = A(2,2);
VectorZ = A(3,2);

% construct and normalize the vector
Vector = [VectorX; VectorY; VectorZ];
Vector = Vector / sqrt(sum(Vector.*Vector));

% Get P3
P3 = P - 130 * Vector;

% Get zeta0, zeta1, zeta2
[zeta0,zeta1,zeta2] = auxiliaryFunction2(P3(1),P3(2),P3(3));
if zeta2 > 0
    zeta2 = -zeta2;
end

% Get P2
R01 = [cosd(zeta0),-sind(zeta0),0;sind(zeta0),cosd(zeta0),0;0,0,1];
R12 = [1,0,0;0,cosd(zeta1),-sind(zeta1);0,sind(zeta1),cosd(zeta1)];
R23 = [1,0,0;0,cosd(zeta2),-sind(zeta2);0,sind(zeta2),cosd(zeta2)];
P01 = [0;0;0];
P12 = [0;0;190];
P23 = [0;200;0];

P33S = R23*[0;0;0]+P23;
P32S = R12*P33S+P12;
P2 = R01*P32S+P01;

% Solution to determine zeta3
P1 = [0; 0; 190];
LP2P3 = P3-P2;
zeta3 = acosd((sum(LP2P3.*Vector))/(norm(LP2P3)*norm(Vector)));


%Auxiliary correction for the accuracy problem in Matlab
nP = auxiliaryFunction1(zeta0,zeta1,zeta2,zeta3,0);
if nP(1)-P(1)>0.01
    zeta3 = -zeta3;
end

%determine P3 from the P4 and the final orientation
zeta4=0;
R01 = [cosd(zeta0),-sind(zeta0),0;sind(zeta0),cosd(zeta0),0;0,0,1];
R12 = [1,0,0;0,cosd(zeta1),-sind(zeta1);0,sind(zeta1),cosd(zeta1)];
R23 = [1,0,0;0,cosd(zeta2),-sind(zeta2);0,sind(zeta2),cosd(zeta2)];
R34 = [1,0,0;0,cosd(zeta3),-sind(zeta3);0,sind(zeta3),cosd(zeta3)];
R45 = [cosd(zeta4),0,sind(zeta4);0,1,0;-sind(zeta4),0,cosd(zeta4)];
nA = R01*R12*R23*R34*R45;
V1 = [nA(1,1);nA(2,1);nA(3,1)];
V2 = [A(1,1);A(2,1);A(3,1)];
zeta4 = acosd((sum(V1.*V2))/(norm(V1)*norm(V2)));
R45 = [cosd(zeta4),0,sind(zeta4);0,1,0;-sind(zeta4),0,cosd(zeta4)];
nA = R01*R12*R23*R34*R45;
if nA(2,1)-A(2,1)>0.01
    zeta4 = 360 - zeta4;
end

fprintf('Corresponding solutions in the angles space:\n');
fprintf('Firstly, the rotation angle along the axis z1, zeta0 = %.2f��\n', zeta0 );
fprintf('Then, the rotation angle along the axis x1, zeta1 = %.2f��\n', zeta1 );
fprintf('Next, the rotation angle along the axis x2, zeta2 = %.2f��\n', zeta2 );
fprintf('After that, the rotation angle along the axis x3, zeta3 = %.2f��\n', zeta3 );
fprintf('Finally, the rotation angle along the axis y1, zeta4 = %.2f��\n', zeta4 );

end
