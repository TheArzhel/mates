
% From Lab 2 we have two functions:
%
% *  Given principal Euler axis/angle, returns the rotation matrix.
% *  Given a set of Euler angles, returns the rotation matrix.
%
% We used the past functions and the function Cubeplot/Cubeplot2 to transform the
% orientation of the cube given by M
%

M = [    -1  -1 1;   %Node 1
    -1   1 1;   %Node 2
    1   1 1;   %Node 3
    1  -1 1;   %Node 4
    -1  -1 -1;  %Node 5
    -1   1 -1;  %Node 6
    1   1 -1;  %Node 7
    1  -1 -1]'; %Node 8

%
% Now it is time to complete all the transformations, 
% adding also the quaternions representation
%
% If not completed in Lab 2:
%
%% Exercise 0
% Create a function that implements the quaternion multiplication.
% Create a function that given a vector and a quaternion, returns the vector
% rotated by the attitude encoded in the quaternion using quaternion
% multiplications.
% Test it an argument/demonstrate why your function is well implemented.
disp ('exercise 0')

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

disp ('----------')


%
%% Exercise 1
% Create functions that:
%
disp ('exercise 1')

% *  Given a rotation matrix, returns the Euler rotation angles.
disp('rotation matrix to euler angles')
[Pitch,Roll,Yaw]=RotMat_To_EulerAngles(Rot_Matrix_1);

% *  Given a rotation matrix, returns the principal Euler axis/angle.
disp('rotation matrix to euler axis angle')
[Axis,Angle]=RotMat_To_AxisAngle(Rot_Matrix_1);

% *  Given principal Euler axis/angle, returns the quaternion.
disp('euler axis angle to quaternion')
Quat=AxisAngle_To_Quat(Axis,Angle)

% *  Given a quaternion, returns the principal Euler axis/angle.
disp('quaternion to euler axis angle')
[Axis,Angle] = Quat_To_AxisAngle(Quat)

% *  Given principal Euler axis/angle, returns the rotation vector.
disp('euler axis angle to rotation vector')
RotVec=AxisAngle_To_RotationVec(Axis,Angle)

% *  Given the rotation vector, returns principal Euler axis/angle.
disp('rotation vector to euler axis angle')
[Axis,Angle]=RotVec_To_Axis_Angle(RotVec)

%
% Check the past functions and the function Cubeplot/Cubeplot2 to transform the
% orientation of the cube given by M

disp ('----------')
%
%% Exercise 2
% Create a function that:
%
% *  Given {a rotation matrix or Euler rotation angles
%    or principal Euler axis/angle or quaternion or rotation vector},
%    returns {a rotation matrix and Euler rotation angles
%    and principal Euler axis/angle and quaternion and rotation vector}
%
% Hint: use a letter 'r,e,p,q,v' to inform the function which are the
%       input arguments. 
%
disp ('exercise 2')


[flag,RotMat,Quat,RotVec,EulerAxis,Angle,Pitch,Roll,Yaw] = RotationTransformation(pi,0,0);
[flag,RotMat,Quat,RotVec,EulerAxis,Angle,Pitch,Roll,Yaw] = RotationTransformation(Quat);
[flag,RotMat,Quat,RotVec,EulerAxis,Angle,Pitch,Roll,Yaw] = RotationTransformation(RotMat);
[flag,RotMat,Quat,RotVec,EulerAxis,Angle,Pitch,Roll,Yaw] = RotationTransformation(RotVec);
[flag,RotMat,Quat,RotVec,EulerAxis,Angle,Pitch,Roll,Yaw] = RotationTransformation(EulerAxis,Angle);




disp ('----------')