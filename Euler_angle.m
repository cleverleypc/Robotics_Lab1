function [] = Euler_angle( rotationMatrix ) %Input a 3*3 Rotation Matrix
%Given a rotation matrix, determine Euler angles of the final orientation
%Euler angles ZYZ

%re-define the elements of the given matrix
r11=rotationMatrix(1,1);r12=rotationMatrix(1,2);r13=rotationMatrix(1,3);
r21=rotationMatrix(2,1);r22=rotationMatrix(2,2);r23=rotationMatrix(2,3);
r31=rotationMatrix(3,1);r32=rotationMatrix(3,2);r33=rotationMatrix(3,3);

%Determine the rotation angle around z-axis
if ( r13 ~= 0 ) && ( r23 ~= 0)
    angle_z1_axis = atan2( r23,r13 );
elseif  ( r23 == 0 )
    angle_z1_axis = 0;
elseif  ( r23 > 0 )
    angle_z1_axis = pi/2;
else  
    angle_z1_axis = -pi/2;    
end

%Determine the rotation angle around y-axis
if  sqrt( r13^2+r23^2 ) == 0 
    angle_y1_axis = 0 ;
elseif ( sqrt( r13^2+r23^2 ) ~= 0 ) && ( r33 == 0 )
   angle_y1_axis =  pi/2;
elseif ( sqrt( r13^2+r23^2 ) ~= 0 ) && ( r33 ~= 0 )
    angle_y1_axis = atan2( sqrt(r13^2+r23^2) , r33 );
end

%Determine the rotation angle around z-axis
if  r31 ~= 0 
    angle_z2_axis = atan2( r32,-r31 );
elseif ( r32>0 )
    angle_z2_axis = pi/2;  
elseif ( r32<0 )
    angle_z2_axis = -pi/2;
else 
    angle_z2_axis = 0;
end

%Draw the figure
quiver3(0,0,0,r11,r21,r31,'r');
hold on
quiver3(0,0,0,r12,r22,r32,'g');
quiver3(0,0,0,r13,r23,r33,'b');
hold off
xlabel('x-axis'); ylabel('y-axis'); zlabel('z-axis');
axis( [-1,1,-1,1,-1,1] );
title({'Determination of Euler Angles ZYZ by a given Rotation Matrix' ; 'Color of the Vector~Axis of the Orientation' ; 
    'Red~X-axis   Green~Y-axis   Blue~Z-axis'});
fprintf('The rotation angle around z1-axis is %.2f бу\n', rad2deg(angle_z1_axis) );
fprintf('The rotation angle around y1-axis is %.2f бу\n', rad2deg(angle_y1_axis) );
fprintf('The rotation angle around z2-axis is %.2f бу\n', rad2deg(angle_z2_axis) );
end

