function varargout = UserInterface(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @UserInterface_OpeningFcn, ...
                   'gui_OutputFcn',  @UserInterface_OutputFcn, ...
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
% End initialization code

% --- Executes just before UserInterface is made visible.
function UserInterface_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
%Code
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = UserInterface_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;



function input_edit_text_Callback(hObject, eventdata, handles)
% hObject    handle to input_edit_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_edit_text as text
%        str2double(get(hObject,'String')) returns contents of input_edit_text as a double


% --- Executes during object creation, after setting all properties.
function input_edit_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_edit_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function output_edit_text_Callback(hObject, eventdata, handles)
% hObject    handle to output_edit_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of output_edit_text as text
%        str2double(get(hObject,'String')) returns contents of output_edit_text as a double


% --- Executes during object creation, after setting all properties.
function output_edit_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to output_edit_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in action_button.
function action_button_Callback(hObject, eventdata, handles)
    message = get(handles.input_edit_text, 'String');
    if isempty(message)
        h = errordlg('Introduce el mensaje a cifrar');
    elseif get(handles.encrypt_radio_btn, 'value') == 1
        match = regexp(message,'[^a-zá-úñ0-9ü \-\.\,\;\:\¿\?\¡\!]','match','ignorecase', 'once');
        if match ~= 0
            h = errordlg('Lo sentimos, sólo aceptamos letras del alfabeto español, espacios, signos de puntuación y números');
        else
            set(handles.output_edit_text, 'String', encryptFunction(message));
        end
    else
        match = regexp(message,'[^a-zá-úñ0-9ü \-\.\,\;\:\¿\?\¡\!\_\$]','match','ignorecase', 'once');
        if match ~= 0
            h = errordlg('Al parecer este mensaje no fue cifrado por nosotros');
        elseif mod(length(message), 4) ~= 0
            h = errordlg('Al parecer este mensaje no fue cifrado por nosotros x2');
        else
            set(handles.output_edit_text, 'String', decryptFunction(message));
        end
    end


% --- Executes on button press in encrypt_radio_btn.
function encrypt_radio_btn_Callback(hObject, eventdata, handles)
    %set(handles.action_button, 'String' ,'Cifrar');
    set(handles.input_txt, 'String' ,'Texto a cifrar: ');
    set(handles.output_txt, 'String' ,'Texto cifrado: ');
    set(handles.input_edit_text, 'TooltipString', 'Introduce el mensaje a cifrar');


% --- Executes on button press in decrypt_radio_btn.
function decrypt_radio_btn_Callback(hObject, eventdata, handles)
    %set(handles.action_button, 'String' ,'Descifrar');
    set(handles.input_txt, 'String' ,'Texto a descifrar: ');
    set(handles.output_txt, 'String' ,'Texto descifrado: ');
    set(handles.input_edit_text, 'TooltipString', 'Introduce el mensaje a descifrar');
