function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 15-Feb-2020 11:33:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cd query
[I, path] = uigetfile('.jpg','Select Query Image');
I=strcat(path,I);
I=imread(I);
cd ..
save I I
axes(handles.axes1);           
set(handles.edit1,'String',path);
imshow(I)


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load I
I = imresize(I,[128 128]);
c1 = Glcm(I);
tes = c1;
%--------------------------------------------
cd train
delete('*.db');
cd ..

FileNames = dir('train');
FileNames = char(FileNames.name);

  
for i=1:length(FileNames)-2
  cd train
    j=imread(strcat(num2str(i),'.jpg'));
    j=imresize(j,[128 128]);
  cd ..
  c2 = Glcm(j);
  res = c2;
  d1(i) = min(min(dist(tes,res')));
  d1(i) = abs(d1(i));
end


r=0;
 k=sort(d1);
 for i=1:length(k)
  g=find(k(i)==d1);
      r(i)=g(1);
 end
 
 cd train
 j=imread(strcat(num2str(r(1)),'.jpg'));
 axes(handles.axes2)
 imshow(imresize(j,[128 128]));
 j=imread(strcat(num2str(r(2)),'.jpg'));
 axes(handles.axes3)
 imshow(imresize(j,[128 128]));
 j=imread(strcat(num2str(r(3)),'.jpg'));
 axes(handles.axes4)
 imshow(imresize(j,[128 128]));
 j=imread(strcat(num2str(r(4)),'.jpg'));
 axes(handles.axes5)
 imshow(imresize(j,[128 128]));
  j=imread(strcat(num2str(r(5)),'.jpg'));
 axes(handles.axes6)
 imshow(imresize(j,[128 128]));
  j=imread(strcat(num2str(r(6)),'.jpg'));
 axes(handles.axes7)
 imshow(imresize(j,[128 128]));
 cd ..


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load I
I=imresize(I,[128 128]);
c1=UCILM(I);
tes=c1;
%--------------------------------------------
cd train
delete('*.db');
cd ..

FileNames = dir('train');
FileNames = char(FileNames.name);

  
for i=1:length(FileNames)-2
  cd train
    j=imread(strcat(num2str(i),'.jpg'));
    j=imresize(j,[128 128]);
  cd ..
    c2=UCILM(j);
    
     res=c2;
     d(i)=min(min(dist(tes,res')));     
end


r=0;
 k=sort(d);
 for i=1:length(k)
  g=find(k(i)==d);
  r(i)=g(1);
 end
 
 cd train
 j=imread(strcat(num2str(r(1)),'.jpg'));
 axes(handles.axes2)
 imshow(imresize(j,[128 128]));
 j=imread(strcat(num2str(r(2)),'.jpg'));
 axes(handles.axes3)
 imshow(imresize(j,[128 128]));
 j=imread(strcat(num2str(r(3)),'.jpg'));
 axes(handles.axes4)
 imshow(imresize(j,[128 128]));
 j=imread(strcat(num2str(r(4)),'.jpg'));
 axes(handles.axes5)
 imshow(imresize(j,[128 128]));
   j=imread(strcat(num2str(r(5)),'.jpg'));
 axes(handles.axes6)
 imshow(imresize(j,[128 128]));
  j=imread(strcat(num2str(r(6)),'.jpg'));
 axes(handles.axes7)
 imshow(imresize(j,[128 128]));
 cd ..

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1);imshow('matlab.jpg');
axes(handles.axes2);imshow('matlab.jpg');
axes(handles.axes3);imshow('matlab.jpg');
axes(handles.axes4);imshow('matlab.jpg');
axes(handles.axes5);imshow('matlab.jpg');
axes(handles.axes6);imshow('matlab.jpg');
axes(handles.axes7);imshow('matlab.jpg');
set(handles.edit1,'String','');

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clc
clear
close all

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
