function varargout = finalproject(varargin)
clc
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @finalproject_OpeningFcn, ...
                   'gui_OutputFcn',  @finalproject_OutputFcn, ...
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


function finalproject_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);

function varargout = finalproject_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
axes(handles.axes1);
imshow('C:\Users\SRINADH\OneDrive\Documents\DIP PROJECT\OMR-Sheet-Evaluation-main\OMR-Sheet-Evaluation\OMR IMAGE\restartimage.png');



function load_image_Callback(hObject, eventdata, handles)

[path,user_cance]=imgetfile();
if user_cance
    return
end
im=rgb2gray(imread(path));
siz = size(im);

if siz(1)==0 || siz(2)==0 || siz(1)<3000 || siz(2)<2400
    msgbox(sprintf('Error!! You have Selected Wrong image!'),'Error','Error');
    return
end

ok = is_img_ok(im);
if ~ok
    msgbox(sprintf('Error!This OMR can not be evaluated! Please Restart!'),'Error','Error');
    return;
end

handles.im = im;

axes = handles.axes1;
imshow(handles.im);
guidata(hObject,handles);


function qno_Callback(hObject, eventdata, handles)

function qno_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function evaluation_Callback(hObject, eventdata, handles)

qu_no = str2num(get(handles.qno,'String'));
[marks,Remark,Roll,Test] = finalver7(handles.im,handles.solution,qu_no);
handles.marks = marks;
set(handles.mark,'String',num2str(marks))
handles.Roll = Roll;
set(handles.remarks,'String',Remark)
handles.Remark= Remark;
set(handles.roll,'String',num2str(Roll))
handles.Test = Test;
set(handles.testid,'String',num2str(Test))
guidata(hObject,handles);


function about_Callback(hObject, eventdata, handles)
h = msgbox({
    'Welcome to our OMR Sheet Evaluation Toolbox', '', ...
    'This is a project for Digital Image Processing', '', ...
    'Course No. CSE 314L', '', ...
    'We are:', '', ...
    'D. Srinadh - AP21110010951', ...
    'G. Niteesh - AP21110011245', ...
    'G. Nandini - AP21110010912', ...
    'N. Subhash - AP21110010947', ...
    'G. Dhakshayani - AP21110010930', '', ...
    'Department of Computer Science and Engineering', '', ...
    'SRM University, AP', '', ...
    'Thank you!', '', ...
    'For any queries or advice, feel free to email at:', '', ...
    'srinadh_d@srmap.edu.in', ...
    'niteeshkumar_gajjala@srmap.edu.in', ...
    'nandini_gogineni@srmap.edu.in', ...
    'subhash_n@srmap.edu.in', ...
    'dhakshayani_g@srmap.edu.in'
}, 'About');



function Help_Callback(hObject, eventdata, handles)

h = msgbox({
    '🌟 Welcome to the OMR Sheet Evaluation Toolbox! 🌟', ...
    ' ', ...
    'Steps to use the tool:', ...
    '1) Load OMR Image: Click "Load Image", select an image file, and click "Open".', ...
    '2) Enter Number of Questions: Input the number of questions (max 60).', ...
    '3) Load Solution: Click "Load Solution", select your Excel solution file, and click "Open".', ...
    '4) Evaluate OMR: Click "Evaluate OMR" to see roll number, test ID, marks, and remarks.', ...
    '5) Restart Evaluation: Click "Restart" to evaluate a new sheet or if there are issues.', ...
    ' ', ...
    'Important Notes:', ...
    '- You can change the OMR image or solution file after the first evaluation until "Restart" is pressed.', ...
    ' ', ...
    'For Assistance:', ...
    'srinadh_d@srmap.edu.in', ...
    'niteeshkumar_gajjala@srmap.edu.in', ...
    'nandini_gogineni@srmap.edu.in', ...
    'subhash_n@srmap.edu.in', ...
    'dhakshayani_g@srmap.edu.in', ...
    ' ', ...
    'Thank you for using the tool! '
}, 'HELP', 'help', 'modal');



function load_solution_Callback(hObject, eventdata, handles)

[path,user_cance]=imgetfile();
if user_cance
    return
end
[~,~,sol] = xlsread(path,'A1:A60');
solution = upper(char (sol));
handles.solution = solution;
guidata(hObject,handles);



function restart_Callback(hObject, eventdata, handles)

axes(handles.axes1);
imshow('C:\Users\SRINADH\OneDrive\Documents\DIP PROJECT\OMR-Sheet-Evaluation-main\OMR-Sheet-Evaluation\OMR IMAGE\restartimage.png');


set(handles.qno,'String','');
set(handles.mark,'String','')
set(handles.remarks,'String','')
set(handles.roll,'String','')
set(handles.testid,'String','')
guidata(hObject,handles);