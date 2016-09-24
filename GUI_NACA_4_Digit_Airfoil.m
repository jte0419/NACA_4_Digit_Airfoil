% NACA 4-Digit Airfoil GUI
% Written by: JoshTheEngineer
% Started: 03/08/15
% Updated: 03/08/15
%          08/14/16 - Rearranged layout
%                   - Made code a little more efficient
%          08/22/16 - Added output formatting for Inventor files
%          09/22/16 - Added output formatting for Gmsh files

function varargout = GUI_NACA_4_Digit_Airfoil(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_NACA_4_Digit_Airfoil_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_NACA_4_Digit_Airfoil_OutputFcn, ...
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

% --- Executes just before GUI_NACA_4_Digit_Airfoil is made visible.
function GUI_NACA_4_Digit_Airfoil_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = GUI_NACA_4_Digit_Airfoil_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

% INITIALIZATION
evalin('base','clear');
evalin('base','clc');

flagPlot        = 1;                                                        % (Flag) indicating whether you can plot
typeNACA        = get(handles.editAirfoil,'String');                        % Type of airfoil [####]
aoa             = str2double(get(handles.editAoA,'String'));                % Angle of attack [deg]
gridPts         = str2double(get(handles.editGridPoints,'String'));         % Number of grid points [#]
radioShowCamber = 0;                                                        % Show camber line or not [1 = Show, 0 = Don't Show]
saveFilename    = get(handles.editSaveFilename,'String');                   % Filename for saving data

% Assign variables into base workspace
assignin('base','flagPlot',flagPlot);
assignin('base','typeNACA',typeNACA);
assignin('base','aoa',aoa);
assignin('base','gridPts',gridPts);
assignin('base','radioShowCamber',radioShowCamber);
assignin('base','saveFilename',saveFilename);
assignin('base','flagPlot',flagPlot);

% Change units for GUI to normalized so we can resize it
set(handles.figure1,'Resize','on');
set(handles.figure1,'Units','Normalized');
set(handles.textTitle,'Units','Normalized');
set(handles.textAirfoil,'Units','Normalized');
set(handles.textAoA,'Units','Normalized');
set(handles.textGridPoints,'Units','Normalized');
set(handles.textGridType,'Units','Normalized');
set(handles.textTE,'Units','Normalized');
set(handles.textPlotAs,'Units','Normalized');
set(handles.editAirfoil,'Units','Normalized');
set(handles.editAoA,'Units','Normalized');
set(handles.editGridPoints,'Units','Normalized');
set(handles.popGridType,'Units','Normalized');
set(handles.popTE,'Units','Normalized');
set(handles.popPlotAs,'Units','Normalized');
set(handles.radioShowCamberLine,'Units','Normalized');
set(handles.pushPlotAirfoil,'Units','Normalized');
set(handles.textStatus,'Units','Normalized');
set(handles.plotAirfoil,'Units','Normalized');
set(handles.textSaveFilename,'Units','Normalized');
set(handles.textSaveType,'Units','Normalized');
set(handles.editSaveFilename,'Units','Normalized');
set(handles.popSaveType,'Units','Normalized');
set(handles.pushSaveData,'Units','Normalized');
set(handles.pushExit,'Units','Normalized');

% Disable the save button
set(handles.pushSaveData,'Enable','off');

% Plot titles and axes
axes(handles.plotAirfoil);
title('Airfoil Plot');
xlabel('x/c []');
ylabel('y/c []');

% ----------------------------------------------------------------------- %
% ----------------------------------------------------------------------- %
% --------------------------- INITIALIZATION ---------------------------- %
% ----------------------------------------------------------------------- %
% ----------------------------------------------------------------------- %

% EDIT ----------------------- Airfoil Type -------------------------------
function editAirfoil_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% EDIT -------------------- Angle of Attack -------------------------------
function editAoA_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% EDIT ---------------------- Grid Points ---------------------------------
function editGridPoints_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% EDIT ---------------------- Save Filename -------------------------------
function editSaveFilename_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% EDIT -------------- Chord Length for Inventor Output --------------------
function editChord_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% POP ---------------------- Grid Type ------------------------------------
function popGridType_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% POP --------------------- Type of TE ------------------------------------
function popTE_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% POP -------------------------- Plot As ----------------------------------
function popPlotAs_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% POP ------------------------- Save Style --------------------------------
function popSaveType_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% POP ---------------- Airfoil Units for Inventor Output ------------------
function popUnits_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% ----------------------------------------------------------------------- %
% ----------------------------------------------------------------------- %
% ----------------------------- CALLBACKS ------------------------------- %
% ----------------------------------------------------------------------- %
% ----------------------------------------------------------------------- %

% EDIT ---------------------- Airfoil Type --------------------------------
function editAirfoil_Callback(hObject, eventdata, handles)
typeNACA = get(handles.editAirfoil,'String');
assignin('base','typeNACA',typeNACA);

% Check if it's exactly 4 digits
[~,sizeInput] = size(typeNACA);
if (sizeInput == 4)
    set(handles.textStatus,'String','Ready to Plot');
    set(handles.textStatus,'ForegroundColor',[0 0 0]);
    drawnow();
    set(handles.pushPlotAirfoil,'Enable','on');
else
    set(handles.textStatus,'String','Enter a 4-digit airfoil!');
    set(handles.textStatus,'ForegroundColor',[1 0 0]);
    drawnow();
    set(handles.pushPlotAirfoil,'Enable','off');
end

% EDIT -------------------- Angle of Attack -------------------------------
function editAoA_Callback(hObject, eventdata, handles)
% Do nothing, get value in pushPlotAirfoil_Callback

% EDIT ---------------------- Grid Points ---------------------------------
function editGridPoints_Callback(hObject, eventdata, handles)
gridPts = str2double(get(hObject,'String'));
assignin('base','gridPts',gridPts);

% Make sure we have more than two grid points
if (gridPts > 2)
    set(handles.textStatus,'String','Ready to Plot');
    set(handles.textStatus,'ForegroundColor',[0 0 0]);
    drawnow();
    set(handles.pushPlotAirfoil,'Enable','on');
else
    set(handles.textStatus,'String','Enter value larger than 2');
    set(handles.textStatus,'ForegroundColor',[1 0 0]);
    drawnow();
    set(handles.pushPlotAirfoil,'Enable','off');
end

% EDIT -------------------- Save Filename ---------------------------------
function editSaveFilename_Callback(hObject, eventdata, handles)
% Do nothing, get string in pushSaveData_Callback

% EDIT -------------- Chord Length for Inventor Output --------------------
function editChord_Callback(hObject, eventdata, handles)
% Do nothing, get value in pushSaveData_Callback

% POP ----------------------- Grid Type -----------------------------------
function popGridType_Callback(hObject, eventdata, handles)
% Do nothing, get value in pushPlotAirfoil_Callback

% POP --------------------- Trailing Edge ---------------------------------
function popTE_Callback(hObject, eventdata, handles)
% Do nothing, get value in pushPlotAirfoil_Callback

% POP ----------------------- Plot As -------------------------------------
function popPlotAs_Callback(hObject, eventdata, handles)
% Do nothing, get value in pushPlotAirfoil_Callback

% POP ----------------------- Save Style ----------------------------------
function popSaveType_Callback(hObject, eventdata, handles)
% Enable/disable certain features for saving depending on selection
if (get(hObject,'Value') == 1 || get(hObject,'Value') == 2)
    set(handles.editChord,'Enable','off');
    set(handles.popUnits,'Enable','off');
    set(handles.editSaveFilename,'String','NACA.txt');
elseif (get(hObject,'Value') == 3)
    set(handles.editChord,'Enable','on');
    set(handles.popUnits,'Enable','on');
    set(handles.editSaveFilename,'String','NACA.xlsx');
elseif (get(hObject,'Value') == 4)
    set(handles.editChord,'Enable','on');
    set(handles.popUnits,'Enable','on');
    set(handles.editSaveFilename,'String','NACA.geo');
end

% POP ---------------- Airfoil Units for Inventor Output ------------------
function popUnits_Callback(hObject, eventdata, handles)
% Do nothing, get value in pushSaveData_Callback

% RADIO ------------------ Show Camber Line -------------------------------
function radioShowCamberLine_Callback(hObject, eventdata, handles)
if (get(hObject,'Value') == get(hObject,'Max'))
    radioShowCamber = 1;
else
    radioShowCamber = 0;
end
assignin('base','radioShowCamber',radioShowCamber);

% PUSH ---------------------- Plot Airfoil --------------------------------
function pushPlotAirfoil_Callback(hObject, eventdata, handles)
typeNACA        = evalin('base','typeNACA');
gridPts         = evalin('base','gridPts');
radioShowCamber = evalin('base','radioShowCamber');

% Show that we are plotting (even though it doesn't take long)
set(handles.pushPlotAirfoil,'ForegroundColor','r');
drawnow();

% Get angle of attack
aoa = str2double(get(handles.editAoA,'String'));

% Get popup menu values
popGridType = get(handles.popGridType,'Value');
popTE       = get(handles.popTE,'Value');
popPlotAs   = get(handles.popPlotAs,'Value');

% Extract values from type of airfoil string
Minit = str2double(typeNACA(1));
Pinit = str2double(typeNACA(2));
Tinit = str2double(typeNACA(3:4));

% Actual percentage values of airfoil properties
M = Minit/100;
P = Pinit/10;
T = Tinit/100;

% Constants used in thickness calculation
a0 = 0.2969;
a1 = -0.1260;
a2 = -0.3516;
a3 = 0.2843;
if (popTE == 1)
    a4 = -0.1015;                                                           % Open trailing edge
elseif (popTE == 2)
    a4 = -0.1036;                                                           % Closed trailing edge
end

% Airfoil X points
if (popGridType == 1)                                                       % Uniform spacing
    x = linspace(0,1,gridPts)';
elseif (popGridType == 2)                                                   % Non-uniform spacing
    beta = linspace(0,pi,gridPts)';
    x = (0.5*(1-cos(beta)));
end

% Camber line and camber line gradient
yc     = ones(gridPts,1);
dyc_dx = ones(gridPts,1);
theta  = ones(gridPts,1);
for i = 1:1:gridPts
    if (x(i) >= 0 && x(i) < P)
        yc(i)     = (M/P^2)*((2*P*x(i))-x(i)^2);
        dyc_dx(i) = ((2*M)/(P^2))*(P-x(i));
    elseif (x(i) >=P && x(i) <=1)
        yc(i)     = (M/(1-P)^2)*(1-(2*P)+(2*P*x(i))-(x(i)^2));
        dyc_dx(i) = ((2*M)/((1-P)^2))*(P-x(i));
    end
    theta(i) = atan(dyc_dx(i));
end

% Thickness distribution
yt = 5*T.*((a0.*sqrt(x)) + (a1.*x) + (a2.*x.^2) + (a3.*x.^3) + (a4.*x.^4));

% Upper surface points
xu = x(:)  - yt(:).*sin(theta);
yu = yc(:) + yt(:).*cos(theta);

% Lower surface points
xl = x(:) + yt(:).*sin(theta);
yl = yc(:) - yt(:).*cos(theta);

% Camber line X points
xc = x;

% Get rotation axis (quarter chord)
x_qc = 0.25;
y_qc = 0;

% Rotation parameters
axisOfRot = [0 0 1];                                                        % Rotate about Z-axis
origin    = [x_qc y_qc 0];                                                  % Origin of rotation is at the quarter-chord
thetaRot  = -aoa;                                                           % Rotate clockwise

% Select correct plot and get ready for plotting
axes(handles.plotAirfoil);                                                  % Select axis for plotting
cla; hold on; grid on;
title('Airfoil Plot');                                                      % Title
xlabel('x/c []');                                                           % X-axis label
ylabel('y/c []');                                                           % Y-axis label
axis equal;

% Plot the airfoil
if (popPlotAs == 1)                                                         % Plot as: LINE
    plotU = plot(xu,yu,'k-');                                                   % Plot the upper surface (black-line)
    plotL = plot(xl,yl,'k-');                                                   % Plot the lower surface (black-line)
    if (radioShowCamber == 1)                                                   % If the camber line is to be plotted
        plotC = plot(xc,yc,'r-');                                                   % Plot the camber line (red-line)
    end
elseif (popPlotAs == 2)                                                     % Plot as: CIRCLE
    plotU = plot(xu,yu,'ko');                                                   % Plot the upper surface (black-circles)
    plotL = plot(xl,yl,'ko');                                                   % Plot the lower surface (black-cicles)
    if (radioShowCamber == 1)                                                   % If the camber line is to be plotted
        plotC = plot(xc,yc,'ro');                                                   % Plot the camber line (red-circles)
    end
elseif (popPlotAs == 3)                                                     % Plot as: DOT
    plotU = plot(xu,yu,'k.');                                                   % Plot the upper surface (black-dots)
    plotL = plot(xl,yl,'k.');                                                   % Plot the lower surface (black-dots)
    if (radioShowCamber == 1)                                                   % If the camber line is to be plotted
        plotC = plot(xc,yc,'r.');                                                   % Plot the camber line (red-dots)
    end
elseif (popPlotAs == 4)                                                     % Plot as: FILLED
    plotF = fill([xu xl],[yu yl],'k');                                          % Plot the black-filled polygon
    if (radioShowCamber == 1)                                                   % If the cmber line is to be plotted
        plotC = plot(xc,yc,'r-');                                                   % Plot the camber line (red-line)
    end
end

% Rotate plot based on angle of attack
if (popPlotAs == 4)                                                         % For the FILLED plot
    rotate(plotF,axisOfRot,thetaRot,origin);                                    % Rotate the polygon
else                                                                        % For all other plot types
    rotate(plotU,axisOfRot,thetaRot,origin);                                    % Rotate the upper surface
    rotate(plotL,axisOfRot,thetaRot,origin);                                    % Rotate the lower surface
end
if (radioShowCamber == 1)                                                   % When the camber line is plotted
    rotate(plotC,axisOfRot,thetaRot,origin);                                    % Rotate the camber line
end

% Assignn in the base (for saving later)
assignin('base','xu',xu);
assignin('base','xl',xl);
assignin('base','yu',yu);
assignin('base','yl',yl);

% Enable data saving
set(handles.pushSaveData,'Enable','on');

% Show that we are done plotting
set(handles.pushPlotAirfoil,'ForegroundColor','k');
drawnow();

% PUSH ----------------------- Save Data ----------------------------------
function pushSaveData_Callback(hObject, eventdata, handles)
xu           = evalin('base','xu');                                         % Upper surface X values
xl           = evalin('base','xl');                                         % Lower surface X values
yu           = evalin('base','yu');                                         % Upper surface Y values
yl           = evalin('base','yl');                                         % Lower surface Y values
gridPts      = evalin('base','gridPts');                                    % Number of grid points

% Show that we are saving the data file
set(handles.pushSaveData,'ForegroundColor','r');
drawnow();

% Get save type from popup menu
popSaveType = get(handles.popSaveType,'Value');

% Get chord length from edit box
chord    = str2double(get(handles.editChord,'String'));
unitsStr = get(handles.popUnits,'String');
unitsVal = get(handles.popUnits,'Value');
assignin('base','unitsStr',unitsStr);
assignin('base','unitsVal',unitsVal);

% Get filename to which we are saving data
saveFilename = get(handles.editSaveFilename,'String');

% Flip arrays based on which save type
if (popSaveType == 1)                                                       % LE to TE (flip lower data)
    xl = flipud(xl);
    yl = flipud(yl);
elseif (popSaveType == 2 || popSaveType == 3 || popSaveType == 4)           % TE to LE (flip upper data)
    xu = flipud(xu);
    yu = flipud(yu);
end

if (popSaveType == 1 || popSaveType == 2)
    % File writing
    fid = fopen(saveFilename,'w');                                          % Open file for writing
    fprintf(fid,'    x        y \n');                                       % Print the single header line

    % Write upper data
    for i = 1:1:gridPts
        fprintf(fid,'%2.6f %2.6f\n',xu(i),yu(i));
    end

    % Write lower data
    if (popSaveType == 1)                                                   % LE to TE
        for i = 1:1:gridPts
            fprintf(fid,'%2.6f %2.6f\n',xl(i),yl(i));
        end
    elseif (popSaveType == 2)                                               % TE to LE
        for i = 2:1:gridPts
            fprintf(fid,'%2.6f %2.6f\n',xl(i),yl(i));
        end
    end

    % Close the written file
    fclose(fid);
elseif (popSaveType == 3)
    % Multiply coordinates by the chord length
    xl = xl*chord;                                                          % Multiply lower X data by chord
    xu = xu*chord;                                                          % Multiply upper X data by chord 
    yl = yl*chord;                                                          % Multiply lower Y data by chord
    yu = yu*chord;                                                          % Multiply upper Y data by chord
    
    % Create array for writing
    ind = 1;
    for i = 1:1:gridPts
        writeArray(ind,1) = xu(i);                                          % Write upper X data
        writeArray(ind,2) = yu(i);                                          % Write upper Y data
        ind = ind + 1;                                                      % Increment writing index
    end
    for i = 2:1:gridPts                                                     % Don't duplicate leading edge point
        writeArray(ind,1) = xl(i);                                          % Write lower X data
        writeArray(ind,2) = yl(i);                                          % Write lower Y data
        ind = ind + 1;                                                      % Increment writing index
    end
    
    % Close trailing edge by specifying our first write point
    writeArray(end,1) = xu(1);                                              % Close trailing edge X data
    writeArray(end,2) = yu(1);                                              % Close trailing edge Y data
    
    % Write data to the file
    header = {unitsStr{unitsVal},'';'x','y'};                               % Header lines with units
    xlswrite(saveFilename,header,1,'A1');                                   % Write the header line in file
    xlswrite(saveFilename,writeArray,1,'A3');                               % Write the data in file
elseif (popSaveType == 4)
    % Multiply coordinates by the chord length
    xl = xl*chord;                                                          % Multiply lower X data by chord
    xu = xu*chord;                                                          % Multiply upper X data by chord 
    yl = yl*chord;                                                          % Multiply lower Y data by chord
    yu = yu*chord;                                                          % Multiply upper Y data by chord
    
    % Create array for writing
    point = zeros(2*gridPts-1,3);
    ind = 1;
    for i = 1:1:gridPts
        point(ind,1) = xu(i);
        point(ind,2) = yu(i);
        point(ind,3) = 0;
        point(ind,4) = 1.0;
        ind = ind + 1;
    end
    for i = 2:1:gridPts
        point(ind,1) = xl(i);
        point(ind,2) = yl(i);
        point(ind,3) = 0;
        point(ind,4) = 1.0;
        ind = ind + 1;
    end
    assignin('base','point',point);
    
    % Number of points and lines
    numPts = length(point(:,1));
    numLns = numPts;
    
    % Write data to the .geo file
    fid = fopen(saveFilename,'w');
    for i = 1:1:numPts
        fprintf(fid,'Point(%i) = {%g, %g, %g, %g};\r\n',i,point(i,1),point(i,2),...
                                                    point(i,3),point(i,4));
    end
    for i = 1:1:numLns
        if (i ~= numLns)
            fprintf(fid,'Line(%i) = {%i, %i};\r\n',i,i,i+1);
        else
            fprintf(fid,'Line(%i) = {%i, %i};',i,i,1);
        end
    end
    
    % Close the written file
    fclose(fid);
end

% Show that we are done saving the data file
set(handles.pushSaveData,'ForegroundColor','k');
drawnow();

% PUSH -------------------------- Exit ------------------------------------
function pushExit_Callback(hObject, eventdata, handles)
% Clear the command line
clc;

% Clear the variables
evalin('base','clear all');

% Delete the figure
delete(handles.figure1);
