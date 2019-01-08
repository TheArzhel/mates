function R = EulerAxisAngle_To_Matrix(u_vector,phi)

% this function returns the rotation matrix when introducing an euler axis
% and angle
% u_vector: is the euler axis.Please note that the euler axis needs to be
% normalized.
% phi: the euler angle. Please not that angles must be in radians


%% check introducced values

% number of arguments
if nargin <1
    u_vector=[1 0 0];
elseif nargin <2
    phi=pi/2;
else
    flag=0;
end


% length of vector
 if length(u_vector)~=3
    disp('the vector axis needs to have 3 values')
    flag=1;
 end 
 
 % normalize the vector just in case
 u_vector = u_vector/norm(u_vector);
    

 if phi>2*pi
        %disp('Angle must be in radians')
 end

 
 %% once the values are correct
    
 disp (' from euler axis angle to rotation matrix ')
    if (flag == 0)
    
     u_vector = reshape(u_vector,[3,1]); %assure that the vector is in 3 rows1 colum
     
    % get the matrix needed for the rodriguez formula
     Ux= [0 -u_vector(3,1)  u_vector(2,1); 
         u_vector(3,1)  0  -u_vector(1,1);
         -u_vector(2,1) u_vector(1,1) 0];
     
     %define a identity matrix
      I=eye(3);
     
     %Rodrigues formula
    disp('after Rodriguez formula')
     R = I*cos(phi)+(1-cos(phi))*(u_vector*u_vector')+Ux*sin(phi)
     
    end 
        
    return 
end 