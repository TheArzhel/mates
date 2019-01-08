function varargout = trackBall(varargin)
% TRACKBALL MATLAB code for trackBall.fig
%      TRACKBALL, by itself, creates a new TRACKBALL or raises the existing
%      singleton*.
%
%      H = TRACKBALL returns the handle to a new TRACKBALL or the handle to
%      the existing singleton*.
%
%      TRACKBALL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRACKBALL.M with the given input arguments.
%
%      TRACKBALL('Property','Value',...) creates a new TRACKBALL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before trackBall_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to trackBall_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help trackBall

% Last Modified by GUIDE v2.5 04-Jan-2019 22:47:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @trackBall_OpeningFcn, ...
                   'gui_OutputFcn',  @trackBall_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


function trackBall_OpeningFcn(hObject, eventdata, handles, varargin)


set(hObject,'WindowButtonDownFcn',{@my_MouseClickFcn,handles.axes1});
set(hObject,'WindowButtonUpFcn',{@my_MouseReleaseFcn,handles.axes1});
axes(handles.axes1);

handles.Cube=DrawCube(eye(3));

set(handles.axes1,'CameraPosition',...
    [0 0 5],'CameraTarget',...
    [0 0 -5],'CameraUpVector',...
    [0 1 0],'DataAspectRatio',...
    [1 1 1]);

set(handles.axes1,'xlim',[-3 3],'ylim',[-3 3],'visible','off','color','none');


handles.output = hObject;


guidata(hObject, handles);


function varargout = trackBall_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

function my_MouseClickFcn(obj,event,hObject)

handles=guidata(obj);
xlim = get(handles.axes1,'xlim');
ylim = get(handles.axes1,'ylim');
mousepos=get(handles.axes1,'CurrentPoint');
xmouse = mousepos(1,1);
ymouse = mousepos(1,2);

if xmouse > xlim(1) && xmouse < xlim(2) && ymouse > ylim(1) && ymouse < ylim(2)
    Global_Vec(RotVec(3,xmouse,ymouse));
    set(handles.figure1,'WindowButtonMotionFcn',{@my_MouseMoveFcn,hObject});
end
guidata(hObject,handles)

function my_MouseReleaseFcn(obj,event,hObject)
handles=guidata(hObject);
set(handles.figure1,'WindowButtonMotionFcn','');
guidata(hObject,handles);

function my_MouseMoveFcn(obj,event,hObject)

handles=guidata(obj);
xlim = get(handles.axes1,'xlim');
ylim = get(handles.axes1,'ylim');
mousepos=get(handles.axes1,'CurrentPoint');
xmouse = mousepos(1,1);
ymouse = mousepos(1,2);

if xmouse > xlim(1) && xmouse < xlim(2) && ymouse > ylim(1) && ymouse < ylim(2)
    
    Init_Vector = GetGlobal_Vec();
    Axis = -cross(RotVec(3,xmouse,ymouse), Init_Vector);
    Angle = acosd((RotVec(3,xmouse,ymouse)'*Init_Vector)/(norm(RotVec(3,xmouse,ymouse))*norm(Init_Vector)))*0.2;
    
    Rot_Mat = axisangle2matrix(Axis, Angle);
    
    %quaternions
    
    if(isempty(GetGlobal_Quat()))
        Quat0 = [0;0;0;0];
    else
        Quat0 = GetGlobal_Quat();
    end
    set(handles.Quat0_0,'String',Quat0(1,1));
    set(handles.Quat0_1,'String',Quat0(2,1));
    set(handles.Quat0_2,'String',Quat0(3,1));
    set(handles.Quat0_3,'String',Quat0(4,1));

    Quat1 = TwoVec_To_Quat(Init_Vector, RotVec(3,xmouse,ymouse));
    set(handles.Quat1_0,'String',Quat1(1,1));
    set(handles.Quat1_1,'String',Quat1(2,1));
    set(handles.Quat1_2,'String',Quat1(3,1));
    set(handles.Quat1_3,'String',Quat1(4,1));

    Global_Quat(Quat1);
    
    Quat_Product = quatmult(Quat0,Quat1);
    set(handles.Quat_Product_0,'String',Quat_Product(1,1));
    set(handles.Quat_Product_1,'String',Quat_Product(2,1));
    set(handles.Quat_Product_2,'String',Quat_Product(3,1));
    set(handles.Quat_Product_3,'String',Quat_Product(4,1));

    % Euler Axis & Angle
    [Euler_Axis,Euler_Angle]=RotMatToEulerAxis_Angle(Rot_Mat);
    Euler_Axis=Euler_Axis';
    set(handles.Euler_AxisX,'String',Euler_Axis(1,1));
    set(handles.Euler_AxisY,'String',Euler_Axis(2,1));
    set(handles.Euler_AxisZ,'String',Euler_Axis(3,1));
    set(handles.Euler_Angle,'String',Euler_Angle);
   
    % Euler Angles
    [Roll,Pitch,Yaw]=RotMatToEulerAngles(Rot_Mat);
    set(handles.Pitch,'String',Pitch);
    set(handles.Roll,'String',Roll);
    set(handles.Yaw,'String',Yaw);

    %rotation vector %
    [Euler_Axis,Euler_Angle]=RotMatToEulerAxis_Angle(Rot_Mat);
     Rotation_Vector = Obt_RotVec(Euler_Axis,Euler_Angle);
    set(handles.X,'String',Rotation_Vector(1));
    set(handles.Y,'String',Rotation_Vector(2));
    set(handles.Z,'String',Rotation_Vector(3));

    
    %Rotation matrix
    Global_RotMat(Rot_Mat);

    set(handles.RotMat_Pos1_1,'String',Rot_Mat(1,1));
    set(handles.RotMat_Pos1_2,'String',Rot_Mat(1,2));
    set(handles.RotMat_Pos1_3,'String',Rot_Mat(1,3));

    set(handles.RotMat_Pos2_1,'String',Rot_Mat(2,1));
    set(handles.RotMat_Pos2_2,'String',Rot_Mat(2,2));
    set(handles.RotMat_Pos2_3,'String',Rot_Mat(2,3));

    set(handles.RotMat_Pos3_1,'String',Rot_Mat(3,1));
    set(handles.RotMat_Pos3_2,'String',Rot_Mat(3,2));
    set(handles.RotMat_Pos3_3,'String',Rot_Mat(3,3));
    
    handles.Cube = RedrawCube(Rot_Mat,handles.Cube);    
end
guidata(hObject,handles);

function h = DrawCube(R)

M0 = [    -1  -1 1;   %Node 1
    -1   1 1;   %Node 2
    1   1 1;   %Node 3
    1  -1 1;   %Node 4
    -1  -1 -1;  %Node 5
    -1   1 -1;  %Node 6
    1   1 -1;  %Node 7
    1  -1 -1]; %Node 8

M = (R*M0')';


x = M(:,1);
y = M(:,2);
z = M(:,3);


con = [1 2 3 4;
    5 6 7 8;
    4 3 7 8;
    1 2 6 5;
    1 4 8 5;
    2 3 7 6]';

x = reshape(x(con(:)),[4,6]);
y = reshape(y(con(:)),[4,6]);
z = reshape(z(con(:)),[4,6]);

c = 1/255*[255 248 88;
    0 0 0;
    57 183 225;
    57 183 0;
    255 178 0;
    255 0 0];

h = fill3(x,y,z, 1:6);

for q = 1:length(c)
    h(q).FaceColor = c(q,:);
end

function h = RedrawCube(R,hin)

h = hin;
c = 1/255*[255 248 88;
    0 0 0;
    57 183 225;
    57 183 0;
    255 178 0;
    255 0 0];

M0 = [    -1  -1 1;   %Node 1
    -1   1 1;   %Node 2
    1   1 1;   %Node 3
    1  -1 1;   %Node 4
    -1  -1 -1;  %Node 5
    -1   1 -1;  %Node 6
    1   1 -1;  %Node 7
    1  -1 -1]; %Node 8

M = (R*M0')';


x = M(:,1);
y = M(:,2);
z = M(:,3);


con = [1 2 3 4;
    5 6 7 8;
    4 3 7 8;
    1 2 6 5;
    1 4 8 5;
    2 3 7 6]';

x = reshape(x(con(:)),[4,6]);
y = reshape(y(con(:)),[4,6]);
z = reshape(z(con(:)),[4,6]);

for q = 1:6
    h(q).Vertices = [x(:,q) y(:,q) z(:,q)];
    h(q).FaceColor = c(q,:);
end


%Global Vars
function Global_Vec(v)
global initial_vector;
initial_vector = v;

function Global_RotMat(r_mat)
global rotation_mat;
rotation_mat = r_mat;

function Global_Quat(l_q)
global last_quat;
last_quat = l_q;

function Global_Cube(l_c)
global last_cube;
last_cube = l_c;

function vec = GetGlobal_Vec();
global initial_vector;
vec = initial_vector;

function mat = GetGlobal_RotMat();
global rotation_mat;
mat = rotation_mat;

function quat = GetGlobal_Quat();
global last_quat;
quat = last_quat;

function cube =GetGlobal_Cube();
global last_cube;
cube = last_cube;


%callbacks from UI
function Quat0_0_Callback(hObject, eventdata, handles)

function Quat0_0_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Quat0_1_Callback(hObject, eventdata, handles)

function Quat0_1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Quat0_2_Callback(hObject, eventdata, handles)

function Quat0_2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Quat0_3_Callback(hObject, eventdata, handles)

function Quat0_3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Quat1_0_Callback(hObject, eventdata, handles)

function Quat1_0_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Quat1_1_Callback(hObject, eventdata, handles)


function Quat1_1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Quat1_2_Callback(hObject, eventdata, handles)


function Quat1_2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Quat1_3_Callback(hObject, eventdata, handles)



function Quat1_3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Quat_Product_0_Callback(hObject, eventdata, handles)


function Quat_Product_0_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Quat_Product_1_Callback(hObject, eventdata, handles)

function Quat_Product_1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Quat_Product_2_Callback(hObject, eventdata, handles)


function Quat_Product_2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Quat_Product_3_Callback(hObject, eventdata, handles)


function Quat_Product_3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Euler_AxisX_Callback(hObject, eventdata, handles)

function Euler_AxisX_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Euler_AxisY_Callback(hObject, eventdata, handles)

function Euler_AxisY_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Euler_AxisZ_Callback(hObject, eventdata, handles)

function Euler_AxisZ_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Euler_Angle_Callback(hObject, eventdata, handles)

function Euler_Angle_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Pitch_Callback(hObject, eventdata, handles)

function Pitch_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Roll_Callback(hObject, eventdata, handles)

function Roll_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Yaw_Callback(hObject, eventdata, handles)

function Yaw_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function X_Callback(hObject, eventdata, handles)

function X_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Y_Callback(hObject, eventdata, handles)

function Y_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Z_Callback(hObject, eventdata, handles)

function Z_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%set callback from UI

function setEulerAngles_Callback(hObject, eventdata, handles)
Global_Cube(handles.Cube);

Pitch = str2double(get(handles.Pitch,'String'));
Roll = str2double(get(handles.Roll,'String'));
Yaw = str2double(get(handles.Yaw,'String'));

Rot_Mat=EulerAnglesToRotMat(Roll,Pitch,Yaw);
%Quaternions  

    if(isempty(GetGlobal_Quat()))
        Quat0 = [0;0;0;0];
    else
        Quat0 = GetGlobal_Quat();
    end
    set(handles.Quat0_0,'String',Quat0(1,1));
    set(handles.Quat0_1,'String',Quat0(2,1));
    set(handles.Quat0_2,'String',Quat0(3,1));
    set(handles.Quat0_3,'String',Quat0(4,1));

    Quat1 = EulerAngle_to_Quat(Roll,Pitch,Yaw);
    set(handles.Quat1_0,'String',Quat1(1,1));
    set(handles.Quat1_1,'String',Quat1(2,1));
    set(handles.Quat1_2,'String',Quat1(3,1));
    set(handles.Quat1_3,'String',Quat1(4,1));

    Global_Quat(Quat1);
    
    Quat_Product = quatmult(Quat0,Quat1);
    set(handles.Quat_Product_0,'String',Quat_Product(1,1));
    set(handles.Quat_Product_1,'String',Quat_Product(2,1));
    set(handles.Quat_Product_2,'String',Quat_Product(3,1));
    set(handles.Quat_Product_3,'String',Quat_Product(4,1));

    %Euler Axis & Angle
    [Euler_Axis,Euler_Angle]=RotMatToEulerAxis_Angle(Rot_Mat);
     Euler_Axis=Euler_Axis';
    set(handles.Euler_AxisX,'String',Euler_Axis(1,1));
    set(handles.Euler_AxisY,'String',Euler_Axis(2,1));
    set(handles.Euler_AxisZ,'String',Euler_Axis(3,1));
    set(handles.Euler_Angle,'String',Euler_Angle);
   
    %Euler Angles
    [Roll,Pitch,Yaw]=RotMatToEulerAngles(Rot_Mat);
    set(handles.Pitch,'String',Pitch);
    set(handles.Roll,'String',Roll);
    set(handles.Yaw,'String',Yaw);

    %rotation vector 
    [Euler_Axis,Euler_Angle]=RotMatToEulerAxis_Angle(Rot_Mat);
     Rotation_Vector = Obt_RotVec(Euler_Axis,Euler_Angle);
    set(handles.X,'String',Rotation_Vector(1));
    set(handles.Y,'String',Rotation_Vector(2));
    set(handles.Z,'String',Rotation_Vector(3));

    
    % rotation matrix
    Global_RotMat(Rot_Mat);

    set(handles.RotMat_Pos1_1,'String',Rot_Mat(1,1));
    set(handles.RotMat_Pos1_2,'String',Rot_Mat(1,2));
    set(handles.RotMat_Pos1_3,'String',Rot_Mat(1,3));

    set(handles.RotMat_Pos2_1,'String',Rot_Mat(2,1));
    set(handles.RotMat_Pos2_2,'String',Rot_Mat(2,2));
    set(handles.RotMat_Pos2_3,'String',Rot_Mat(2,3));

    set(handles.RotMat_Pos3_1,'String',Rot_Mat(3,1));
    set(handles.RotMat_Pos3_2,'String',Rot_Mat(3,2));
    set(handles.RotMat_Pos3_3,'String',Rot_Mat(3,3));
     

    last_cube = GetGlobal_Cube();
    handles.Cube = RedrawCube(Rot_Mat,last_cube);
    Global_Cube(handles.Cube);

%reset callback from UI

function reset_Callback(hObject, eventdata, handles)

handles.Cube = RedrawCube(eye(3,3) ,handles.Cube); 
set(handles.Quat0_0,'String',0);
set(handles.Quat0_1,'String',0);
set(handles.Quat0_2,'String',0);
set(handles.Quat0_3,'String',0);

set(handles.Quat1_0,'String',0);
set(handles.Quat1_1,'String',0);
set(handles.Quat1_2,'String',0);
set(handles.Quat1_3,'String',0);

Global_Quat([0;0;0;0]);

set(handles.Quat_Product_0,'String',0);
set(handles.Quat_Product_1,'String',0);
set(handles.Quat_Product_2,'String',0);
set(handles.Quat_Product_3,'String',0);

set(handles.Euler_AxisX,'String',0);
set(handles.Euler_AxisY,'String',0);
set(handles.Euler_AxisZ,'String',0);
set(handles.Euler_Angle,'String',0);

set(handles.Pitch,'String',0);
set(handles.Roll,'String',0);
set(handles.Yaw,'String',0);

set(handles.X,'String',0);
set(handles.Y,'String',0);
set(handles.Z,'String',0);

set(handles.RotMat_Pos1_1,'String',1);
set(handles.RotMat_Pos1_2,'String',0);
set(handles.RotMat_Pos1_3,'String',0);

set(handles.RotMat_Pos2_1,'String',0);
set(handles.RotMat_Pos2_2,'String',1);
set(handles.RotMat_Pos2_3,'String',0);

set(handles.RotMat_Pos3_1,'String',0);
set(handles.RotMat_Pos3_2,'String',0);
set(handles.RotMat_Pos3_3,'String',1);

%callback from UI
function axes1_CreateFcn(hObject, eventdata, handles)

function axes1_ButtonDownFcn(hObject, eventdata, handles)

%set callback from UI
function seteuleraxis_Callback(hObject, eventdata, handles)

Global_Cube(handles.Cube);

Euler_Angle = str2double(get(handles.Euler_Angle,'String'));
Euler_AxisX = str2double(get(handles.Euler_AxisX,'String'));
Euler_AxisY = str2double(get(handles.Euler_AxisY,'String'));
Euler_AxisZ = str2double(get(handles.Euler_AxisZ,'String'));

Rot_Mat=axisangle2matrix([Euler_AxisX;Euler_AxisY;Euler_AxisZ],Euler_Angle);

   %Euler Angles
    [Roll,Pitch,Yaw]=RotMatToEulerAngles(Rot_Mat);
    set(handles.Pitch,'String',Pitch);
    set(handles.Roll,'String',Roll);
    set(handles.Yaw,'String',Yaw);    

    
    %Quaternions
    if(isempty(GetGlobal_Quat()))
        Quat0 = [0;0;0;0];
    else
        Quat0 = GetGlobal_Quat();
    end
    set(handles.Quat0_0,'String',Quat0(1,1));
    set(handles.Quat0_1,'String',Quat0(2,1));
    set(handles.Quat0_2,'String',Quat0(3,1));
    set(handles.Quat0_3,'String',Quat0(4,1));

   Quat1 = EulerAngle_to_Quat(Roll,Pitch,Yaw);
    set(handles.Quat1_0,'String',Quat1(1,1));
    set(handles.Quat1_1,'String',Quat1(2,1));
    set(handles.Quat1_2,'String',Quat1(3,1));
    set(handles.Quat1_3,'String',Quat1(4,1));

    Global_Quat(Quat1);
    
    Quat_Product = quatmult(Quat0,Quat1);
    set(handles.Quat_Product_0,'String',Quat_Product(1,1));
    set(handles.Quat_Product_1,'String',Quat_Product(2,1));
    set(handles.Quat_Product_2,'String',Quat_Product(3,1));
    set(handles.Quat_Product_3,'String',Quat_Product(4,1));

    % Euler Axis & Angle
    [Euler_Axis,Euler_Angle]=RotMatToEulerAxis_Angle(Rot_Mat);
    Euler_Axis=Euler_Axis';
    set(handles.Euler_AxisX,'String',Euler_Axis(1,1));
    set(handles.Euler_AxisY,'String',Euler_Axis(2,1));
    set(handles.Euler_AxisZ,'String',Euler_Axis(3,1));
    set(handles.Euler_Angle,'String',Euler_Angle);
   

    %Rotation vector %
    [Euler_Axis,Euler_Angle]=RotMatToEulerAxis_Angle(Rot_Mat);
     Rotation_Vector = Obt_RotVec(Euler_Axis,Euler_Angle);
    set(handles.X,'String',Rotation_Vector(1));
    set(handles.Y,'String',Rotation_Vector(2));
    set(handles.Z,'String',Rotation_Vector(3));

    
    %Rotation matrix
    Global_RotMat(Rot_Mat);

    set(handles.RotMat_Pos1_1,'String',Rot_Mat(1,1));
    set(handles.RotMat_Pos1_2,'String',Rot_Mat(1,2));
    set(handles.RotMat_Pos1_3,'String',Rot_Mat(1,3));

    set(handles.RotMat_Pos2_1,'String',Rot_Mat(2,1));
    set(handles.RotMat_Pos2_2,'String',Rot_Mat(2,2));
    set(handles.RotMat_Pos2_3,'String',Rot_Mat(2,3));

    set(handles.RotMat_Pos3_1,'String',Rot_Mat(3,1));
    set(handles.RotMat_Pos3_2,'String',Rot_Mat(3,2));
    set(handles.RotMat_Pos3_3,'String',Rot_Mat(3,3));
   
    
    
    last_cube =GetGlobal_Cube();
    handles.Cube = RedrawCube(Rot_Mat,last_cube);
    Global_Cube(handles.Cube);
    
%set callback from UI
function setquaternions_Callback(hObject, eventdata, handles)

Global_Cube(handles.Cube);

Quat1(1,1) = str2double(get(handles.Quat1_0,'String'));
Quat1(2,1) = str2double(get(handles.Quat1_1,'String'));
Quat1(3,1) = str2double(get(handles.Quat1_2,'String'));
Quat1(4,1) = str2double(get(handles.Quat1_3,'String'));

[Rot_Mat]=QuatToRotMat(Quat1);

   

    %Euler Angles
    [Roll,Pitch,Yaw]=RotMatToEulerAngles(Rot_Mat);
    set(handles.Pitch,'String',Pitch);
    set(handles.Roll,'String',Roll);
    set(handles.Yaw,'String',Yaw);    

  
    %Euler Angles
    [Roll,Pitch,Yaw]=RotMatToEulerAngles(Rot_Mat);
    set(handles.Pitch,'String',Pitch);
    set(handles.Roll,'String',Roll);
    set(handles.Yaw,'String',Yaw);    

    %Quaternions
    if(isempty(GetGlobal_Quat()))
        Quat0 = [0;0;0;0];
    else
         Quat0 = GetGlobal_Quat();
    end
     Quat1 = EulerAngle_to_Quat(Roll,Pitch,Yaw);
    Global_Quat(Quat1);
    Quat_Product = quatmult(Quat0,Quat1);
    set(handles.Quat_Product_0,'String',Quat_Product(1,1));
    set(handles.Quat_Product_1,'String',Quat_Product(2,1));
    set(handles.Quat_Product_2,'String',Quat_Product(3,1));
    set(handles.Quat_Product_3,'String',Quat_Product(4,1))


    %Euler Axis & Angle
    [Euler_Axis,Euler_Angle]=RotMatToEulerAxis_Angle(Rot_Mat);
    Euler_Axis=Euler_Axis';
    set(handles.Euler_AxisX,'String',Euler_Axis(1,1));
    set(handles.Euler_AxisY,'String',Euler_Axis(2,1));
    set(handles.Euler_AxisZ,'String',Euler_Axis(3,1));
    set(handles.Euler_Angle,'String',Euler_Angle);
   

    %Rotation vector
    [Euler_Axis,Euler_Angle]=RotMatToEulerAxis_Angle(Rot_Mat);
     Rotation_Vector = Obt_RotVec(Euler_Axis,Euler_Angle);
    set(handles.X,'String',Rotation_Vector(1));
    set(handles.Y,'String',Rotation_Vector(2));
    set(handles.Z,'String',Rotation_Vector(3));

    
    %Rotation matrix
    Global_RotMat(Rot_Mat);

    set(handles.RotMat_Pos1_1,'String',Rot_Mat(1,1));
    set(handles.RotMat_Pos1_2,'String',Rot_Mat(1,2));
    set(handles.RotMat_Pos1_3,'String',Rot_Mat(1,3));

    set(handles.RotMat_Pos2_1,'String',Rot_Mat(2,1));
    set(handles.RotMat_Pos2_2,'String',Rot_Mat(2,2));
    set(handles.RotMat_Pos2_3,'String',Rot_Mat(2,3));

    set(handles.RotMat_Pos3_1,'String',Rot_Mat(3,1));
    set(handles.RotMat_Pos3_2,'String',Rot_Mat(3,2));
    set(handles.RotMat_Pos3_3,'String',Rot_Mat(3,3));
    
    last_cube =GetGlobal_Cube();
    handles.Cube = RedrawCube(Rot_Mat,last_cube);
    Global_Cube(handles.Cube);

%set callback from UI
function setrotvec_Callback(hObject, eventdata, handles)

Global_Cube(handles.Cube);

Rotation_Vector(1,1) = str2double(get(handles.X,'String'));
Rotation_Vector(2,1) = str2double(get(handles.Y,'String'));
Rotation_Vector(3,1) = str2double(get(handles.Z,'String'));

Angle = norm(Rotation_Vector);

Axis = Rotation_Vector/norm(Rotation_Vector);

Rot_Mat=axisangle2matrix(Axis,Angle);
  
  %Euler Angles
    [Roll,Pitch,Yaw]=RotMatToEulerAngles(Rot_Mat);
    set(handles.Pitch,'String',Pitch);
    set(handles.Roll,'String',Roll);
    set(handles.Yaw,'String',Yaw); 

    %Quaternions
    if(isempty(GetGlobal_Quat()))
        Quat0 = [0;0;0;0];
    else
        Quat0 = GetGlobal_Quat();
    end
    set(handles.Quat0_0,'String', Quat0(1,1));
    set(handles.Quat0_1,'String', Quat0(2,1));
    set(handles.Quat0_2,'String', Quat0(3,1));
    set(handles.Quat0_3,'String', Quat0(4,1));

    Quat1 = EulerAngle_to_Quat(Roll,Pitch,Yaw);
    set(handles.Quat1_0,'String', Quat1(1,1));
    set(handles.Quat1_1,'String', Quat1(2,1));
    set(handles.Quat1_2,'String', Quat1(3,1));
    set(handles.Quat1_3,'String', Quat1(4,1));


    Global_Quat(Quat1);
    
    Quat_Product = quatmult( Quat0, Quat1);
    set(handles.Quat_Product_0,'String',Quat_Product(1,1));
    set(handles.Quat_Product_1,'String',Quat_Product(2,1));
    set(handles.Quat_Product_2,'String',Quat_Product(3,1));
    set(handles.Quat_Product_3,'String',Quat_Product(4,1));

    % Euler Axis & Angle
    [Euler_Axis,Euler_Angle]=RotMatToEulerAxis_Angle(Rot_Mat);
    Euler_Axis=Euler_Axis';
    set(handles.Euler_AxisX,'String',Euler_Axis(1,1));
    set(handles.Euler_AxisY,'String',Euler_Axis(2,1));
    set(handles.Euler_AxisZ,'String',Euler_Axis(3,1));
    set(handles.Euler_Angle,'String',Euler_Angle);
   

    %rotation vector 
    [Euler_Axis,Euler_Angle]=RotMatToEulerAxis_Angle(Rot_Mat);
     Rotation_Vector = Obt_RotVec(Euler_Axis,Euler_Angle);
    set(handles.X,'String',Rotation_Vector(1));
    set(handles.Y,'String',Rotation_Vector(2));
    set(handles.Z,'String',Rotation_Vector(3));

    
    %Rotation matrix
    Global_RotMat(Rot_Mat);

    set(handles.RotMat_Pos1_1,'String',Rot_Mat(1,1));
    set(handles.RotMat_Pos1_2,'String',Rot_Mat(1,2));
    set(handles.RotMat_Pos1_3,'String',Rot_Mat(1,3));

    set(handles.RotMat_Pos2_1,'String',Rot_Mat(2,1));
    set(handles.RotMat_Pos2_2,'String',Rot_Mat(2,2));
    set(handles.RotMat_Pos2_3,'String',Rot_Mat(2,3));

    set(handles.RotMat_Pos3_1,'String',Rot_Mat(3,1));
    set(handles.RotMat_Pos3_2,'String',Rot_Mat(3,2));
    set(handles.RotMat_Pos3_3,'String',Rot_Mat(3,3));
    
    last_cube =GetGlobal_Cube();
    handles.Cube = RedrawCube(Rot_Mat,last_cube);
    Global_Cube(handles.Cube);

