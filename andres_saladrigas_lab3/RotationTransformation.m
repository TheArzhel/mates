function [flag,RotMat,Quat,RotVec,EulerAxis,Angle,Pitch,Roll,Yaw]=RotationTransformation(Parameter,Param2,Param3,varargin)
%%HELP
% This will transfrom any form of rotation we have seen in class into the
% other. This function allows transformation of quaternions, rotatiion matrices, rotation
% vectors, euler axis angle and euler angles into the other ones.
% Remember angles must be on radians
% -----------------
% For Rotation matrix please introduce 1 variable with size 3x3.
% Be carefull, please introduce a Rotation matrix.
% example: rotmatsample = ([1 1 1, 0 0 0, 1 1 1]);
% For a Quaternion please introduce 1 variable with size 1x4. First argument being integer
% example: quaternionsample =([1 1 1 1]);
% For a Rotation Vector please introduce 1 variable with size 1x3. First argument being vector to rotate
% example: rotationvectorsample = ([1 1 1]);
% For Euler axis/angle introduce 2 varibles. First argument beingle the axis vector, second being the angle
% example: axissample =([1 2 3]), anglesample = 2+pi;
% For a Euler angles please introduce 3 variable. Each variable being Pitch, Roll, Yaw
% example: anglesample = 2+pi;

flag =-1;


quaternionsample =([1 1 1 1]);
rotmatsample = ([1 1 1; 0 0 0;1 1 1]);
rotationvectorsample = ([1 1 1]);
axissample =([1 2 3]);
if (nargin() == 1)
    
    % introduced quaternions
    if size(Parameter) == (size (quaternionsample))
    flag=1;
            disp (' introduced quaternions');
           
            % must give: 
            Quat = Parameter;
            % rot mat
             disp('to Rotation Matrix');
             RotMat=Quat_To_RotMat(Parameter);
             
            % euler angles
            disp(' to Euler Angles');
            [Pitch,Roll,Yaw]=RotMat_To_EulerAngles(RotMat);
          

            % Euler axis/angle.
            disp(' to Euler axis/angle');
            [EulerAxis,Angle]=RotMat_To_AxisAngle(RotMat)

             % rot vector
             disp('to Rotation Vector');
             RotVec=AxisAngle_To_RotationVec(EulerAxis,Angle);
            
   

     
    % rotation matrix
    elseif size(Parameter) == (size(rotmatsample))
    flag=2;
    
    RotMat = Parameter;
            %% caculate the determinant to verify.
        if (det (RotMat)~=1)
            disp('Please check your rotation matrix. det not 1')
        end

        %% traspose equal to inverse.
        TransposeRotationMatrix = RotMat';
        if (( TransposeRotationMatrix)~=inv(RotMat))
         disp('Please check your rotation matrix. Traspose not equal to inverse')
        end
        
            % must give: 
            
            % euler angles
             disp(' to Euler Angles');
             [Pitch,Roll,Yaw]=RotMat_To_EulerAngles(Parameter);

            % euler axis angle
            disp(' to Euler axis/angle');
            [EulerAxis,Angle]=RotMat_To_AxisAngle(Parameter);

            % quaternions
             disp(' to Quaernions');
             Quat=AxisAngle_To_Quat(EulerAxis,Angle);

            % rot vector
             disp('to Rotation Vector');
             RotVec=AxisAngle_To_RotationVec(EulerAxis,Angle);


    % rotation vector
    elseif size(Parameter) == (size(rotationvectorsample))
   flag=3; 
   
            % must give: 
            RotVec = Parameter;
            % euler axis/angle
            disp('to Euler Axis/Angle');
            [EulerAxis,Angle]=RotVec_To_Axis_Angle(Parameter);
           
            % quaternions
            disp('to Quaternions');
            Quat=AxisAngle_To_Quat(EulerAxis,Angle);

            % rot mat
            disp('to Rotation Matrix');
            RotMat=Quat_To_RotMat(Quat);
            % euler angles
            disp('to Euler Angles');
            [Pitch,Roll,Yaw]=RotMat_To_EulerAngles(RotMat);
            
            
    
    else 
        disp('size may not match. Please check the HELP.')
    end
    
 

elseif nargin () == 2
    % euler axis/angle
     if size(Parameter) == size(axissample)
        flag=4;
            if Param2 <=2*pi
                % must give: 
                  EulerAxis= Parameter;
                  Angle=Param2;
                % quaternions
                disp('to Quaternions');
                Quat=AxisAngle_To_Quat(Parameter,Param2);
              
                % rot mat
                disp('to Rotation Matrix');
                RotMat=Quat_To_RotMat(Quat);

                 % euler angles
                disp('to Euler Angles');
                [Pitch,Roll,Yaw]=RotMat_To_EulerAngles(RotMat);
                
                % rot vector
                disp('to Rotation Vector');
                RotVec=AxisAngle_To_RotationVec(Parameter,Param2);
            end 
    else 
        disp('size may not match. Please check the HELP.')
    end 

elseif nargin () == 3
    % euler angles
    if (Parameter <=2*pi && Param2 <= 2*pi && Param3 <= 2*pi)
         flag=5; 

                % must give:
                Pitch = Parameter;
                Roll = Param2;
                Yaw = Param3;
                
                % rot mat
                 disp('to Rotation Matrix');
                RotMat=EulerAngles_To_RotMat(Parameter,Param2,Param3);
               

                % euler axis angle
                disp('to Euler Axis/Angle');
                [EulerAxis,Angle]=RotMat_To_AxisAngle(RotMat);
                

                % quaternions
                disp('to Quaternions');
                Quat=AxisAngle_To_Quat(EulerAxis,Angle);
               

                % rot vector
                disp('to Rotation Vector');
                RotVec=AxisAngle_To_RotationVec(EulerAxis,Angle);
                

      
   else 
        disp('size may not match. Please check the HELP.')
    end

else
    
    disp ('error please follow this guidelines in HELP.');
   
end

    return;
end