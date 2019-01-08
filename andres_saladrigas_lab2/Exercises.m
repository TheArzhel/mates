%% Exercise 1
% Create and test a function that given euler axis/angle information
% returns the rotation matrix.
% Do the next verifications:
%   - Calculate the determinant
%   - Ensure that the transpose operation is equivalent to the inverse
%   - Observe what happens to a vector parallel to the axis direction
%   - Observe what happens to a vector perpendicular to the axis direction

disp ('Exercise 1')

vector = [0 1 0]
axis = [0 1 0]
angle = pi/2

RotationMatrix = EulerAxisAngle_To_Matrix(axis,angle)

% caculate the determinant to verify.
flag=1;
determinant= det (RotationMatrix);
disp ('determinant')
disp (determinant) 

 if (det(RotationMatrix) >= 1.0000001 || det(RotationMatrix) <= 0.9) 
        disp('Rotation matrix is Wrong. Determinant not equal to 1')
        flag=0;
 end
    

% traspose equal to inverse.
flag2=1;

Inverse = inv(RotationMatrix)

TransposeRotationMatrix = RotationMatrix'

 if ((TransposeRotationMatrix)~=inv(RotationMatrix))
    disp('Matrix error. Trasposed is not equal to inverse')
    flag2=0;
 end

 % if everything is ok we test. rotating vector
 if flag==1 && flag2==1
     
     RotatedVector = RotationMatrix * vector'
     
     %now we check if the result is parallel
     if (RotatedVector == vector')
             disp('the vector is parallel to the axis')
     else
            if (dot(RotatedVector,axis') == 0)
                disp('the vector is perpendicular to the axis')
            else
                disp('The vector is neither parallel or perpendicular to the axis')
            end 
     end
     
 end 
 
 disp ('--------------------------------')


%% Exercise 2
% Use the past function and the function Cubeplot/Cubeplot2 to transform the
% orientation of the cube given by M
% Find the rotation vectors that makes:
%    - The green face points in the positive z direction and the orange
%    face in the -y direction
%    - The orange face points in the -z direction and the blue face into
%    the +y direction
%    - The red face points on the -x direction and the blue face into 
%    the -y direction.

disp ('exercise 2')

M = [    -1  -1 1;   %Node 1
    -1   1 1;   %Node 2
    1   1 1;   %Node 3
    1  -1 1;   %Node 4
    -1  -1 -1;  %Node 5
    -1   1 -1;  %Node 6
    1   1 -1;  %Node 7
    1  -1 -1]'; %Node 8

Vector = [0 2 0]; 
%% to check if there is ay parallel or perpendicular to this vector
%% Finding rotations

% rotation 1
Rotation_Matrix_1=EulerAxisAngle_To_Matrix([0 1 0],pi/2);

% rotation 2
Rotation_Matrix_2_1=EulerAxisAngle_To_Matrix([1 0 0],pi/2);
Rotation_Matrix_2_2=EulerAxisAngle_To_Matrix([0 0 1],pi/2);


%rotation 3
Rotation_Matrix_3_1=EulerAxisAngle_To_Matrix([1 0 0],pi);
Rotation_Matrix_3_2=EulerAxisAngle_To_Matrix([0 0 1],-pi/2);

%% get flags

%rotation1
disp(' ');
disp('Rotation 1');
flag=test_exe_1(Rotation_Matrix_1,Vector,[0 1 0],pi/2);

%rotation2
disp(' ');
disp('rotation 2');
flag2=test_exe_1(Rotation_Matrix_2_1,Vector,[1 0 0],pi/2);
flag3=test_exe_1(Rotation_Matrix_2_2,Vector,[0 0 1],pi/2);

%rotation3
disp(' ');
disp('rotation 3');
flag4=test_exe_1(Rotation_Matrix_3_1,Vector,[1 0 0],pi);
flag5=test_exe_1(Rotation_Matrix_3_2,Vector,[0 0 1],-pi/2);

%% check flags
% if flags are true, we rotate and plot the cube.

if flag==0 && flag2==0 && flag3==0 && flag4==0 && flag5==0
    
% rotation 1
New_Matrix_1=Rotation_Matrix_1*M;
Cubeplot(New_Matrix_1');


% rotation 2
New_Matrix_2_1=Rotation_Matrix_2_1*M;

New_Matrix_2_2=Rotation_Matrix_2_2*New_Matrix_2_1;

Cubeplot(New_Matrix_2_2');


% rotation 3
New_Matrix_3_1=Rotation_Matrix_3_1*M;

New_Matrix_3_2=Rotation_Matrix_3_2*New_Matrix_3_1;

Cubeplot(New_Matrix_3_2');    
    
    
    
else
   disp('one or more matrices are not rotation matrices.'); 
    
    
end

disp ('------------------------------------')
%% Exercise 3
% Create a function that implements the quaternion multiplication.
% Create a function that given a vector and a quaternion, return the vector
% rotated by the attitude encoded in the quaternion using quaternion
% multiplications.
% Test it an argument/demonstrate why your function is well implemented.

disp ('exercise 3')

disp ('set quaternion and vector')
QuaternionToCheck = [1 1 0 0]
vec_1 = [1 1 1]

disp ('rotated vector with quat: ')
vec_rotated = Vector_Rotation_With_Quaternions(vec_1,QuaternionToCheck)
newQuatfromVec = [0 vec_rotated];

%  procede to get rot mat
disp ('rotmat form quat')
[euler_axis,angle_1] = Quat_To_AxisAngle(newQuatfromVec);
Rot_Matrix_1 = EulerAxisAngle_To_Matrix(euler_axis,angle_1)

% We plot the base cube and the rotation after that
N = Rot_Matrix_1 * M;
Cubeplot(N');

disp ('-------------------------------------')

%% Exercise 4
% Create a large set of rotation matrices (at least 100) for which the euler axis may be 
% random (not necessarily random, but not the same) and the euler angle in
% increasing order form 0 to 6 pi. (Use a FOR LOOP)
% Make a plot of the trace of this matrices with the value of the angle in
% the x axis i.e. Trace(R(phi,e)) vs. \phi . Explain what you observe.

disp ('exercise 4')
% make arrays
traceArray = zeros(1,100);
angleArray = zeros (1,100);

angle = 6*pi/100;


for i=0:100
    % selecting diferent axis
    axis = [1 0 0];
   randomizer = 1;
   if randomizer == 1
       axis = [1 0 0];
   elseif randomizer == 2;
       axis = [0 1 0];
   else randomizer == 3;
       axis = [0 0 1];
   end 
   
   %calculating the matrices and traces
    matrix = EulerAxisAngle_To_Matrix_no_display(axis,angle*i);
    tracenumber= trace(matrix);
    traceArray(:,i+1)= tracenumber;
    angleArray(:,i+1)=angle*i;
    
    % reset the number to choose axis
    randomizer=randomizer+1;
    if randomizer >=3.000
        randomizer=1;
    end
end

figure
plot (angleArray,traceArray);
grid on;
xlabel('Angle (radians)'); ylabel('Matrix trace');
title('Exercise 4: Rotation Matrices trace in acordance to angle');

% observation:
% the plot could be described perfectly as a periodic sinusoidal function.
% its axis its move yo 1 in the y axis. making it simetrical arround the
% y=1; the maximuns are near every 6 units in the x axis. it minimun its
% around every 3 units in x axis

disp ('-----------------------------------')

%% Exercise 5
 disp ('exercise 5')
 
% Create a function that given a set of euler angles, return its respective
% rotation matrix.
% Create also a function that given a rotation matrix return the
% respective rotation angles.

disp ('rot mat to euler angles')

disp (Rot_Matrix_1)
[Pitch,Roll,Yaw] = RotMat_To_EulerAngles(Rot_Matrix_1);


disp('Euler Angles to Rotation matrix:')


disp('Pitch')
disp(Pitch)

disp('Roll')
disp(Roll)

disp('Yaw')
disp(Yaw)

RotMat = EulerAngles_To_RotMat(Pitch,Roll,Yaw);



% 	-Ensure that the case for which theta = pi/2 + k*pi with k=1,2,.. is
% 	   well implemented


 disp ('----------------------------------')
