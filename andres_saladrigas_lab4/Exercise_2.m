 clc; clear all; close all;
%% Exercise 2

disp('exercise 2')
disp(' ')

% Let {A}, {B} and {C}, be 3 different reference frames. From them we know
% that:
%      - The origin of B with respect A is
oAB = [3,1,-2]';
%      - The origin of C with respect B is
oBC = [-3, 1,-2]';

% The three frames has different orientations in space.
% In fact:

%       -The set of Euler angles stored in eta as eta = (psi,theta,phi) %%
%       yaw, pitch, roll
eta = [25;145;30]; % Expressed in degrees
%        represents 3 consecutive rotations about z, y, and x
%  respectively that allows to transform from {A} to {B}


disp ('we get the rotation matrix from the euler angles')
disp(' ')
 
RotMat_A_to_B = EulerAngles_To_RotMat(deg2rad(eta(2)),deg2rad(eta(3)),deg2rad(eta(1)));

A_axis = [1 0 0;
          0 1 0;
          0 0 1];

originB = [0 0 0]';
originC = [0 0 0]';

Rotation_B_to_A = RotMat_A_to_B';

Rotation_C_to_B = eye(3,3); % allocating space

traslacion_B_to_A = -Rotation_B_to_A * oAB;

%       - The quaternion
q = 1/7*[-sqrt(3)*3.5;3;-1;-1.5];
%         will allows to express in {B} a vector defined in {C}, if {C} and {B}
%         had the same origin

%   -Let in addition v1 and v2 to be points which coordinates are known in
%   {C}.
v1_C = [0;2;0];
v2_C = [0;2;5];

 
disp ('we get the rotation matrix from quaternions')
disp(' ')

[Axis_Rot,Angle_Rot] = Quat_To_AxisAngle(q');
Rotation_C_to_B = EulerAxisAngle_To_Matrix(Axis_Rot,Angle_Rot);

traslacion_C_to_B = -Rotation_C_to_B * oBC;

v2_B= Rotation_C_to_B * v2_C + traslacion_C_to_B;

v1_B=  Rotation_C_to_B * v1_C + traslacion_C_to_B;



% With the information provided above determine:
%
%   2.1- The affine expression (no matrix here!) that allows to relate a vector originally given
%       in {C} to {B}.
disp('2.1')
disp(' ')
disp('Affine expresion')
disp(' ')
%             x'= Affine*x;
Affine = [Rotation_C_to_B  traslacion_C_to_B];
Affine = [Affine; zeros(1,4)];
Affine(4,4) = 1;

disp (' v1_b ,1 = [Rotation, traslacion; 0 1] * v1_b')
disp(' ')
disp(' the afine matrix from C to B is composed from rotation matrix and translation')
disp(Affine)
disp('Rotation matrix C to B')
disp (Rotation_C_to_B)
disp('translation from C to B')
disp (traslacion_C_to_B)


%   2.2 The affine matrix that allows to express a vector originally given
%       in {C} to {A}.
disp(' ')
disp('2.2')
disp(' ')
Rotation_C_to_A = Rotation_B_to_A * Rotation_C_to_B;

v1_A =  Rotation_B_to_A * v1_B + traslacion_B_to_A;
v2_A =  Rotation_B_to_A * v2_B + traslacion_B_to_A;

traslacion_A_to_C= v1_C- Rotation_C_to_A'*v1_A;

traslacion_C_to_A = -Rotation_C_to_A*traslacion_A_to_C;

Affine2 = [Rotation_C_to_A  traslacion_C_to_A];


disp('Affine matrix from C to A')
%             x'= Affine*x;
Affine2 = [Rotation_C_to_A  traslacion_C_to_A];
Affine2 = [Affine2; zeros(1,4)];
Affine2(4,4) = 1;

disp (Affine2)


%   2.3 The points v1_C and v2_C forms a segment. Make a 3d plot (plot3() in
%   matlab), representing how the segment is seen on {A} in red, on {B} in
%   blue and on {C} in green.
disp(' ')
disp('2.2')
disp(' ')
Aug_v1_c= [v1_C; ones(1,1)];
Aug_v2_c= [v2_C; ones(1,1)];


v1_A = Affine2 * Aug_v1_c;
v2_A = Affine2 * Aug_v2_c;

figure;

plot3([v1_A(1,1) v2_A(1,1)],[v1_A(2,1) v2_A(2,1)],[v1_A(3,1) v2_A(3,1)],'r');

title('Exe.2   Segment rotation ')
hold on;

plot3([v1_B(1,1) v2_B(1,1)],[v1_B(2,1) v2_B(2,1)],[v1_B(3,1) v2_B(3,1)],'b');

hold on;

plot3([v1_C(1,1) v2_C(1,1)],[v1_C(2,1) v2_C(2,1)],[v1_C(3,1) v2_C(3,1)],'g');

legend('v1_A','v1_B','v1_C')

disp('there is a plot figure with the segments')
