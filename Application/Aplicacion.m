function varargout = Aplicacion(varargin)
% APLICACION MATLAB code for Aplicacion.fig
%      APLICACION, by itself, creates a new APLICACION or raises the existing
%      singleton*.
%
%      H = APLICACION returns the handle to a new APLICACION or the handle to
%      the existing singleton*.
%
%      APLICACION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APLICACION.M with the given input arguments.
%
%      APLICACION('Property','Value',...) creates a new APLICACION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Aplicacion_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Aplicacion_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Aplicacion

% Last Modified by GUIDE v2.5 11-Jun-2017 17:37:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Aplicacion_OpeningFcn, ...
                   'gui_OutputFcn',  @Aplicacion_OutputFcn, ...
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


% --- Executes just before Aplicacion is made visible.
function Aplicacion_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Aplicacion (see VARARGIN)

% Choose default command line output for Aplicacion
handles.output = hObject;

% Update handles structure
handles.Arriba=0;
handles.Abajo=0;
handles.Izquierda=0;
handles.Derecha=0;
handles.Tiempo=0;
global Tiempomax;
Tiempomax=7;  % Valor por defecto
global Cerrar;
Cerrar=0;
global Parar;
Parar=1;
global varArriba;
varArriba=0;
global varAbajo;
varAbajo=0;
global varIzquierda;
varIzquierda=0;
global varDerecha;
varDerecha=0;
global subirVida;
subirVida=0;

cam = webcam(1);
handles.cam=cam;
guidata(hObject,handles);
textLabel = sprintf('Tiempo = %f', Tiempomax);
set(handles.text5, 'String', textLabel);

% Cargar Base de Datos Secreta
try
    load secret.mat
    handles.Vida=Vida;
    guidata(hObject,handles);
catch
    set(handles.text3,'String','No existe ???. Falta ???.mat');
end
% UIWAIT makes Aplicacion wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Aplicacion_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cam=handles.cam;
cam.resolution ='640x480';
global Cerrar;
cerrar=Cerrar;
x=110;
y=110;
altura=60;
ancho=60;
while(cerrar==0)
    global Tiempomax;
    global Parar;
    parar=Parar;
    global varArriba;
    movArriba=varArriba;
    global varAbajo;
    movAbajo=varAbajo;
    global varIzquierda;
    movIzquierda=varIzquierda;
    global varDerecha;
    movDerecha=varDerecha;
    global subirVida;
    subirvida=subirVida;
    pause(0.01);
    if(parar==0)
       if(movDerecha==1)
           if((x+35)>(320-60))
               set(handles.text3,'String','No se puede mover a la Derecha. Límite alcanzado');
           else
               set(handles.text3,'String','Moviendo a la Derecha');
               x=x+35;
           end
           varDerecha=0;
       end
       if(movIzquierda==1)
           if((x-35)<1)
               set(handles.text3,'String','No se puede mover a la Izquierda. Límite alcanzado');
           else
               set(handles.text3,'String','Moviendo a la Izquierda');
               x=x-35;
           end
           varIzquierda=0;
       end
       if(movArriba==1)
           if((y-35)<1)
               set(handles.text3,'String','No se puede mover Arriba. Límite alcanzado');
           else
               set(handles.text3,'String','Moviendo Arriba');
               y=y-35;
           end
           varArriba=0;
       end
       if(movAbajo==1)
           if((y+35)>(240-60))
               set(handles.text3,'String','No se puede mover Abajo. Límite alcanzado');
           else
               set(handles.text3,'String','Moviendo Abajo');
               y=y+35;
           end
           varAbajo=0;
       end
       if(subirvida==1)
           Tiempomax=100;
           set(handles.text3,'String','Easter Egg: Subiendo la vida');
           subirVida=0;
       end
       textLabel = sprintf('Tiempo = %f', Tiempomax);
       set(handles.text5, 'String', textLabel);
       img = snapshot(cam);
       img = imresize(img,0.5);
       rojo = img(:,:,1);
       verde= img(:,:,2);
       azul= img(:,:,3);
       esPiel = [];
       img2 = [];
       rVerde = rojo-verde;
       for i=1:size(verde,1)
           for j=1:size(verde,2)
               if(rojo(i,j)>95 && verde(i,j)>40 && azul(i,j)>20)&& ...
                  ((max([rojo(i,j),verde(i,j),azul(i,j)]) - min([rojo(i,j),verde(i,j),azul(i,j)]))>15) && ...
                  (abs(rojo(i,j)-verde(i,j))>15 && rojo(i,j)>verde(i,j) && rojo(i,j)>azul(i,j))
                    img2(i,j)=1;
               else
                   img2(i,j)=0;
               end
           end
       end
       ele = strel('disk',2);
       img2 = imopen(img2,ele);
       img3 = edge(img2,'roberts');
       imshow(img3)
       cuadrado = ones(320,240);
       cuadrado(x:(x+60),y:(y+60))=0;
       colision = img2' + cuadrado;
       colision = colision(x:(x+60),y:(y+60));
       numcolision = find(colision==1);
       if(length(numcolision)>150)
           % Se produce colisión
           x=round((320-61)*rand+1);    %320
           y=round((240-61)*rand+1);    %240
           Tiempomax= Tiempomax-1;
           if(Tiempomax==0)
               [s1,s2] = audioread('Victory.mp3');
               sound(s1,s2)
               h = msgbox('Bien hecho!');
               clear handles.img;
               Cerrar=1;
               set(handles.text3,'String','Fin de la aplicación. Puede cerrarla ahora');
           end
       end
       %imshow(colision)
       rectangle('Position',[x y altura ancho],'EdgeColor','b');
    else
        imshow(zeros(480,640));
    end
    cerrar=Cerrar;
end
% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text3,'String','Empieza a hablar');
[Arriba, arriba_p]=extraer_carac();
handles.Arriba=Arriba;
guidata(hObject,handles);
set(handles.text3,'String','');
set(handles.text3,'String','Palabra Guardada');
pause(1.5);
set(handles.text3,'String','');



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA
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



% --- Executes on button press in pushbuttonabajo.
function pushbuttonabajo_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonabajo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text3,'String','Empieza a hablar');
[Abajo, abajo_p]=extraer_carac();
handles.Abajo=Abajo;
guidata(hObject,handles);
set(handles.text3,'String','');
set(handles.text3,'String','Palabra Guardada');
pause(1.5);
set(handles.text3,'String','');


% --- Executes on button press in pushbuttonizq.
function pushbuttonizq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonizq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text3,'String','Empieza a hablar');
[Izquierda, izquierda_p]=extraer_carac();
handles.Izquierda=Izquierda;
guidata(hObject,handles);
set(handles.text3,'String','');
set(handles.text3,'String','Palabra Guardada');
pause(1.5);
set(handles.text3,'String','');


% --- Executes on button press in pushbuttonder.
function pushbuttonder_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text3,'String','Empieza a hablar');
[Derecha, derecha_p]=extraer_carac();
handles.Derecha=Derecha;
guidata(hObject,handles);
set(handles.text3,'String','');
set(handles.text3,'String','Palabra Guardada');
pause(1.5);
set(handles.text3,'String','');


% --- Executes on button press in pushbuttonrec.
function pushbuttonrec_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonrec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text3,'String','Empieza a hablar');
[Test, palabra]=extraer_carac();
set(handles.text3,'String','');
% Cargar Base de Datos Secreta
try
    load secret.mat
    handles.Vida=Vida;
    guidata(hObject,handles);
catch
    set(handles.text3,'String','No existe ninguna ???. Falta ???.mat');
end
Vida=handles.Vida;
Arriba=handles.Arriba;
Abajo=handles.Abajo;
Izquierda=handles.Izquierda;
Derecha=handles.Derecha;
if(sum(Arriba(:))==0 | sum(Abajo(:))==0 | sum(Izquierda(:))==0 | sum(Derecha(:))==0)
    set(handles.text3,'String','Faltan datos. Impórtelos manualmente o cargando la base de datos');
else
    [dist1,~]=DTW(Arriba,Test);    % Prueba 1 a test 1
    disp(dist1);
    [dist2,~]=DTW(Abajo,Test);    % Prueba 2 a test 1
    disp(dist2);
    [dist3,~]=DTW(Izquierda,Test);    % Prueba 3 a test 1
    disp(dist3);
    [dist4,~]=DTW(Derecha,Test);    % Prueba 4 a test 1
    disp(dist4);
    [dist5,~]=DTW(Vida,Test);    % Prueba 5 a test 1
    disp(dist5);
    distancias=[dist1 dist2 dist3 dist4 dist5];
    [minimo, indice]=min(distancias);
    global varArriba;
    global varAbajo;
    global varIzquierda;
    global varDerecha;
    global subirVida;
    switch indice
        case 1
            varArriba=1;
            varAbajo=0;
            varIzquierda=0;
            varDerecha=0;
        case 2
            varArriba=0;
            varAbajo=1;
            varIzquierda=0;
            varDerecha=0;
        case 3
            varArriba=0;
            varAbajo=0;
            varIzquierda=1;
            varDerecha=0;
        case 4
            varArriba=0;
            varAbajo=0;
            varIzquierda=0;
            varDerecha=1;
        case 5
            subirVida=1;
    end
end



% --- Executes on button press in pushbuttondatos.
function pushbuttondatos_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttondatos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    load test.mat
    handles.Arriba=Arriba;
    guidata(hObject,handles);
    handles.Abajo=Abajo;
    guidata(hObject,handles);
    handles.Izquierda=Izquierda;
    guidata(hObject,handles);
    handles.Derecha=Derecha;
    guidata(hObject,handles);
    set(handles.text3,'String','Base de Datos cargada');
    pause(1.5);
    set(handles.text3,'String','');
catch
    set(handles.text3,'String','No existe ninguna Base de Datos');
end



% --- Executes on button press in pushbuttonguardar.
function pushbuttonguardar_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonguardar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Arriba=handles.Arriba;
Abajo=handles.Abajo;
Izquierda=handles.Izquierda;
Derecha=handles.Derecha;
if(sum(Arriba(:))==0 | sum(Abajo(:))==0 | sum(Izquierda(:))==0 | sum(Derecha(:))==0)
    set(handles.text3,'String','Faltan datos. Impórtelos manualmente');
else
    try
        save test.mat 'Arriba' 'Abajo' 'Izquierda' 'Derecha';
    catch
        set(handles.text3,'String','No hay permiso de escritura en la carpeta actual');
    end
    set(handles.text3,'String','Guardado en la Base de Datos');
    pause(1.5)
    set(handles.text3,'String','');
end


% --- Executes on button press in buttonempezar.
function buttonempezar_Callback(hObject, eventdata, handles)
% hObject    handle to buttonempezar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Mostrar captura
global Parar;
Parar=0;
set(handles.text3,'String','');
%


% --- Executes on button press in buttonparar.
function buttonparar_Callback(hObject, eventdata, handles)
% hObject    handle to buttonparar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Parar;
Parar=1;
set(handles.text3,'String','Juego pausado');



% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function vidamax_Callback(hObject, eventdata, handles)
% hObject    handle to vidamax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
vidamax=str2double(get(hObject,'String'));
global Tiempomax;
Tiempomax=vidamax;
% Hints: get(hObject,'String') returns contents of vidamax as text
%        str2double(get(hObject,'String')) returns contents of vidamax as a double


% --- Executes during object creation, after setting all properties.
function vidamax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vidamax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonCerrar.
function pushbuttonCerrar_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonCerrar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Cerrar;
Cerrar=1;
set(handles.text3,'String','Fin de la aplicación. Puede cerrarla ahora');


% --- Executes on button press in pushbuttonSecret.
function pushbuttonSecret_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonSecret (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text3,'String','Empieza a hablar');
[Vida, ~]=extraer_carac();
handles.Vida=Vida;
guidata(hObject,handles);
set(handles.text3,'String','');
set(handles.text3,'String','Palabra Guardada');
pause(1.5);
try
    save secret.mat 'Vida';
catch
    set(handles.text3,'String','No hay permiso de escritura en la carpeta actual');
end
set(handles.text3,'String','Tu botón de reconocer está en otro lugar');
pause(1.5)
set(handles.text3,'String','');
