% HELP:
% in this function the parameter passes must be a square matrix. this
% matrix will be checked. if the matrix has the propertie f a rotation, it
% will get flag=0, otherwise flag=1.
%
% Exercise 1
% Create and test a function that given euler axis/angle information
% returns the rotation matrix.
% Do the next verifications:
%   - Calculate the determinant
%   - Ensure that the transpose operation is equivalent to the inverse
%   - Observe what happens to a vector parallel to the axis direction
%   - Observe what happens to a vector perpendicular to the axis direction

function flag=test_exe_1(rotation_matrix, vector, axis, angle)
flag=0;

%% caculate the determinant to verify.
determinant = det(rotation_matrix)
if (det(rotation_matrix) >= 1.0000001 || det(rotation_matrix) <= 0.9) 
    flag=-1;
    disp ('determinant diferent of 1')
end

%% traspose equal to inverse.
Inverse = inv(rotation_matrix)

TransposeRotationMatrix = rotation_matrix'

 if ((TransposeRotationMatrix)~=inv(rotation_matrix))
    disp('Matrix error. Trasposed is not equal to inverse')
    flag=-1;
 end


%% Observe what happens to a vector parallel to the axis direction

rotation_matrix = EulerAxisAngle_To_Matrix(axis,angle);
rotated_vector =  rotation_matrix*vector';
rotated_vector =rotated_vector';
if vector == rotated_vector
    disp('the vector is parallel to the axis');

% Observe what happens to a vector perpendicular to the axis direction

elseif dot(vector,axis)==0
    disp('the vector is perpendicular to the axis');
    
else
        disp('the vector is neither perpendicular or parallel');
    
end


return


end
