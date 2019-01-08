 clc; clear all; close all;
 
%% Exercise 4

%The columns of the next matrix, represents the coordinates of 4 points
%defined in a world frame.
disp ('exercise 4')
disp(' ')
A = load('AEx4.mat');
A = A.A;

% From this 4 points, two segments are defined. The segment one, goes from
% the point defined by the first column to the point defined by the second
% column. The second segment is defined by the other two points.

% A camera frame is seeing the scene. The origin of the world frame seen
% from the camera frame is given by the vector

% origen del mundo segun la camera
wc = [4.665;3.735;-0.5395];


%And the orientation of the camera frame is obtained after rotating the
%world frame -170 degs about the direction
u = [0.01;-.2;1];

Rotation_Matrix = EulerAxisAngle_To_Matrix(u,-deg2rad(170));
Rotated_A= Rotation_Matrix * A;
Rotated_A = Rotated_A +wc;

% With the data provided determine:

% 4.1 The minimum angle that both segments forms (hint, they intersect)
disp ('4.1')
disp(' ')

% angulo
vector_1 = [A(1,1)-A(1,2),A(2,1)-A(2,2),A(3,1)-A(3,2) ];

vector_2 = [A(1,3)-A(1,4),A(2,3)-A(2,4),A(3,3)-A(3,4) ];

angle = rad2deg(acos( dot(vector_1,vector_2)/(norm(vector_1)*norm(vector_2)) ));   

disp('The minimun angle between the two lines is:')
disp(angle);
disp(' ')
% 4.2 The angle that both segments forms in the image plane
disp ('4.2')
disp(' ')

focal_lenght = 1/34;

Proyected_A = cameraproj(focal_lenght,Rotated_A);

% angulo
vector_1 = [Proyected_A(1,1)-Proyected_A(1,2),Proyected_A(2,1)-Proyected_A(2,2)];

vector_2 = [Proyected_A(1,3)-Proyected_A(1,4),Proyected_A(2,3)-Proyected_A(2,4)];

disp('The angle that both segments forms in the image plane:')
disp(' ')
angle2 = rad2deg(acos( dot(vector_1,vector_2)/(norm(vector_1)*norm(vector_2)) )) ;  
disp(angle2)
disp(' ')

% 4.3 Deliver a 3D representation of the scene with all the coordinates
% refered to the world frame
disp ('4.3')
disp(' ')
disp('please note there is a plot')
figure;

plot3([A(1,1) A(1,2)],[A(2,1) A(2,2)],[A(3,1) A(3,2)])

hold on

plot3([A(1,3) A(1,4)],[A(2,3) A(2,4)],[A(3,3) A(3,4)],'r')

title('Exe.4.3   3D representation of the scene with world frame coordinates')
legend('line 1','line 2')
disp(' ')

% 4.4 Deliver the 3D scene representations but with all the coordinates
% refered to the camera frame
disp ('4.4')
disp(' ')
disp('please note there is a plot')

figure
plot3([Rotated_A(1,1) Rotated_A(1,2)],[Rotated_A(2,1) Rotated_A(2,2)],[Rotated_A(3,1) Rotated_A(3,2)])

hold on

plot3([Rotated_A(1,3) Rotated_A(1,4)],[Rotated_A(2,3) Rotated_A(2,4)],[Rotated_A(3,3) Rotated_A(3,4)],'r')

title('Exe.4.4   3D representation of the scene with camera frame coordinates')
legend('line 1','line 2')
