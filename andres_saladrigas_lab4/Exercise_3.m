 clc; clear all; close all;
 %% Exercise 3.

disp ('exercise 3')
% The points described by the columns of the matrix A

A = load('AEx3.mat');
A = A.A;

% are points contained into a circle, and they are defined in a world frame W.

% A camera is situated at point
% defined in the world frame. Moreover the orientation of this camera frame
% is achieved by rotating the world frame -90 degs about its y axis followed by -20
% degrees about the resulting z axis.
 
% If the camera has a focal length of 1/34 m:

cc = [1; 6; 1];
disp ('we obtain the rotation matrices to rotate the points into de desires position')
disp(' ')

Rotation_matrix_in_Y = EulerAxisAngle_To_Matrix([0 1 0],-pi/2);
RotatedA = Rotation_matrix_in_Y * A;

Rotation_matrix_in_Z = EulerAxisAngle_To_Matrix([0 0 1],-deg2rad(20));
RotatedA = Rotation_matrix_in_Z * RotatedA;


% 3.1 Make a plot with the view of the points of the circle projected into the camera plane.
disp(' ')
disp ('3.1')
disp(' ')
disp(' proyecting into camera plain')
disp(' ')
f= 1/34;

% add traslation
RotatedA = RotatedA + cc;

Proyected_A = cameraproj(f,RotatedA);

figure;
plot(Proyected_A(1,:),Proyected_A(2,:));
title ('Exe.3.1  Proyected_A into camera')

disp ('Please note there is a plot')

% 3.2 Make also a 3D plot where all the scene is drawn in the world
% coordinates. The scene must contain the 2 reference frames (2 orthogonal sets of vectors)
% and the circle points. You can use the provided function cameraproj.
disp(' ')

disp ('3.2')

figure;

plot3(A(1,:),A(2,:),A(3,:),'r');
title('Exe.3.2   Points of A and rotated A')
hold on;
plot3(RotatedA(1,:),RotatedA(2,:),RotatedA(3,:),'g');
legend('A','Rotated A')


disp ('Please note there is a plot')
