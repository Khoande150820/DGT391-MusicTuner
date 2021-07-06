function varargout = Tuner(varargin)
% TUNER MATLAB code for Tuner.fig
%      TUNER, by itself, creates a new TUNER or raises the existing
%      singleton*.
%
%      H = TUNER returns the handle to a new TUNER or the handle to
%      the existing singleton*.
%
%      TUNER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TUNER.M with the given input arguments.
%
%      TUNER('Property','Value',...) creates a new TUNER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Tuner_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Tuner_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Tuner

% Last Modified by GUIDE v2.5 06-Jul-2021 08:53:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Tuner_OpeningFcn, ...
                   'gui_OutputFcn',  @Tuner_OutputFcn, ...
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


% --- Executes just before Tuner is made visible.
function Tuner_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Tuner (see VARARGIN)

% Choose default command line output for Tuner
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Tuner wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Tuner_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_e.
function pushbutton_e_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_e (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

w = 329.63; % Frequency of E4 string
set(handles.edit_standard, 'String', num2str(w));
% recording object
Fs = 44100; % Sampling frequency
noc = 1; % single channel
nob = 16; % no bit per sample
recObj = audiorecorder(Fs,nob,noc); % recording object
record(recObj);
pause(2);
stop(recObj);
y = getaudiodata(recObj);
axes(handles.axes1);
% time domain
t = linspace(0, length(y)/Fs, length(y));
plot(t,y);
xlabel('time');
ylabel('amplitude');

% Frequency domain
axes(handles.axes2);
ydft = fft(y);
ydft = ydft(1:length(y)/2+1);
YDFT = abs(ydft);
freq = 0:Fs/length(y):Fs/2;
plot(freq,YDFT);
xlabel('Hz');
ylabel('Amplitude');
xlim([0 1000]);

% Find pitch
[maxYValue, indexAtMaxY] = max(YDFT);
pitch = freq(indexAtMaxY(1));
set(handles.edit_current, 'String', num2str(pitch));
% Compare to true frequency

stringPerfect = 'Perfect tone';
stringHigh = 'Frequency should be decrease'; 
stringLow = 'Frequency should be increase';
if (1.005 * w) < pitch,
    set(handles.edit_result, 'String',stringHigh);
elseif (0.995 * w) > pitch,
    set(handles.edit_result, 'String', stringLow);
else
    set(handles.edit_result, 'String', stringPerfect);
end

% --- Executes on button press in pushbutton_c.
function pushbutton_c_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

w = 261.63; % Frequency of C4 string
set(handles.edit_standard, 'String', num2str(w));
% recording object
Fs = 44100; % Sampling frequency
noc = 1; % single channel
nob = 16; % no bit per sample
recObj = audiorecorder(Fs,nob,noc); % recording object
record(recObj);
pause(2);
stop(recObj);
y = getaudiodata(recObj);
axes(handles.axes1);
% time domain
t = linspace(0, length(y)/Fs, length(y));
plot(t,y);
xlabel('time');
ylabel('amplitude');

% Frequency domain
axes(handles.axes2);
ydft = fft(y);
ydft = ydft(1:length(y)/2+1);
YDFT = abs(ydft);
freq = 0:Fs/length(y):Fs/2;
plot(freq,YDFT);
xlabel('Hz');
ylabel('Amplitude');
xlim([0 1000]);

% Find pitch
[maxYValue, indexAtMaxY] = max(YDFT);
pitch = freq(indexAtMaxY(1));
set(handles.edit_current, 'String', num2str(pitch));

% Compare to true frequency

stringPerfect = 'Perfect tone';
stringHigh = 'Frequency should be decrease'; 
stringLow = 'Frequency should be increase';
if (1.005 * w) < pitch,
    set(handles.edit_result, 'String',stringHigh);
elseif (0.995 * w) > pitch,
    set(handles.edit_result, 'String', stringLow);
else
    set(handles.edit_result, 'String', stringPerfect);
end

% --- Executes on button press in pushbutton_a.
function pushbutton_a_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

w = 440; % Frequency of A4 string
set(handles.edit_standard, 'String', num2str(w));
% recording object
Fs = 44100; % Sampling frequency
noc = 1; % single channel
nob = 16; % no bit per sample
recObj = audiorecorder(Fs,nob,noc); % recording object
record(recObj);
pause(2);
stop(recObj);
y = getaudiodata(recObj);
axes(handles.axes1);
% time domain
t = linspace(0, length(y)/Fs, length(y));
plot(t,y);
xlabel('time');
ylabel('amplitude');

% Frequency domain
axes(handles.axes2);
ydft = fft(y);
ydft = ydft(1:length(y)/2+1);
YDFT = abs(ydft);
freq = 0:Fs/length(y):Fs/2;
plot(freq,YDFT);
xlabel('Hz');
ylabel('Amplitude');
xlim([0 1000]);

% Find pitch
[maxYValue, indexAtMaxY] = max(YDFT);
pitch = freq(indexAtMaxY(1));
set(handles.edit_current, 'String', num2str(pitch));

% Compare to true frequency

stringPerfect = 'Perfect tone';
stringHigh = 'Frequency should be decrease'; 
stringLow = 'Frequency should be increase';
if (1.005 * w) < pitch,
    set(handles.edit_result, 'String',stringHigh);
elseif (0.995 * w) > pitch,
    set(handles.edit_result, 'String', stringLow);
else
    set(handles.edit_result, 'String', stringPerfect);
end



% --- Executes on button press in pushbutton_g.
function pushbutton_g_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_g (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

w = 392; % Frequency of C4 string
set(handles.edit_standard, 'String', num2str(w));
% recording object
Fs = 44100; % Sampling frequency
noc = 1; % single channel
nob = 16; % no bit per sample
recObj = audiorecorder(Fs,nob,noc); % recording object
record(recObj);
pause(2);
stop(recObj);
y = getaudiodata(recObj);
axes(handles.axes1);
% time domain
t = linspace(0, length(y)/Fs, length(y));
plot(t,y);
xlabel('time');
ylabel('amplitude');

% Frequency domain
axes(handles.axes2);
ydft = fft(y);
ydft = ydft(1:length(y)/2+1);
YDFT = abs(ydft);
freq = 0:Fs/length(y):Fs/2;
plot(freq,YDFT);
xlabel('Hz');
ylabel('Amplitude');
xlim([0 1000]);

% Find pitch
[maxYValue, indexAtMaxY] = max(YDFT);
pitch = freq(indexAtMaxY(1));
set(handles.edit_current, 'String', num2str(pitch));

% Compare to true frequency

stringPerfect = 'Perfect tone';
stringHigh = 'Frequency should be decrease'; 
stringLow = 'Frequency should be increase';
if (1.005 * w) < pitch,
    set(handles.edit_result, 'String',stringHigh);
elseif (0.995 * w) > pitch,
    set(handles.edit_result, 'String', stringLow);
else
    set(handles.edit_result, 'String', stringPerfect);
end




function edit_result_Callback(hObject, eventdata, handles)
% hObject    handle to edit_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_result as text
%        str2double(get(hObject,'String')) returns contents of edit_result as a double


% --- Executes during object creation, after setting all properties.
function edit_result_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_close.
function pushbutton_close_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closereq(); 



function edit_standard_Callback(hObject, eventdata, handles)
% hObject    handle to edit_standard (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_standard as text
%        str2double(get(hObject,'String')) returns contents of edit_standard as a double


% --- Executes during object creation, after setting all properties.
function edit_standard_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_standard (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_current_Callback(hObject, eventdata, handles)
% hObject    handle to edit_current (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_current as text
%        str2double(get(hObject,'String')) returns contents of edit_current as a double


% --- Executes during object creation, after setting all properties.
function edit_current_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_current (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
