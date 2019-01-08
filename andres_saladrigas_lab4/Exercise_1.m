 clc; clear all; close all;

%% Exercise 1
disp ('exercise 1 ')
disp(' ')
% The point p has coordinates
p_A = [3, 4]';
% on a frame A and coordinates
p_B = [-2.5, 0.5]';
% on a frame B

%It is known that the angle between x axis of frame {A} and the y axes from
%Frame{B} is 30 deg counterclockwise.

disp('the angle from pos A to pos B has a rotation of 300 degres counter clockwise')
disp(' ')
rotarionangle = deg2rad(300)

RotationMatrix = [cos(rotarionangle) -sin(rotarionangle);
                sin(rotarionangle) cos(rotarionangle)]
            
% axis A
Axis_A_mat = [1 0;
            0 1];
        
Rotationmatrix_from_A_to_B = RotationMatrix
                        
Rotationmatrix_from_B_to_A = Rotationmatrix_from_A_to_B'           


% 1.1 Which are the coordinates of the origin of A seen from B?

% to get the translation first we isolate
traslationA_to_B = p_B-(Rotationmatrix_from_A_to_B * p_A);

% then apply formula 
traslationB_to_A = -Rotationmatrix_from_B_to_A * traslationA_to_B;

origin_A_axis = [0 0];
origin_B_axis = [0 0];


disp (' the coordinates of A seen from B are:')
disp(' ')

OriginA_from_B = Rotationmatrix_from_A_to_B * origin_A_axis' + traslationA_to_B

% 1.2 Which are the coordinates of the origin of B seen from A?

disp (' the coordinates of B seen from A are:')
disp(' ')

OriginB_from_A = Rotationmatrix_from_B_to_A * origin_B_axis' + traslationB_to_A

% 1.3 Which are the coordinates of a point q expressed in A if
q_B = [3,1]'; %?

disp (' the coordinates of q seen from A:')
disp(' ')

q_A = Rotationmatrix_from_B_to_A * q_B + traslationB_to_A