% PARADIGMAS DE LA PROGRAMACIÓN
% SECCIÓN DEL CURSO: 0-A-1
% PROFESOR DE TEORÍA: EDMUNDO LEIVA
% PROFESOR DE LABORATORIO: EDMUNDO LEIVA
%
% AUTOR
% NOMBRE: Cristian Alexis Romero Martinez
% RUT: 19.800.734-k 
% CARRERA: Ingenieria en Ejecucion en Informatica
% VERSIÓN SWI-PROLOG: 9.0

%HECHOS

%REGLAS

%PREDICADOS

%IMPORTACION DE LIBRERIAS PARA FECHA Y ARCHIVOS
:- use_module(library(date)).
%:-include(tda_System_19800734_RomeroMartinez).

% Descripcion: Predicado que construye una fecha en el siguiente formato (Dia,Mes,Año).
% Dominio: Fecha.
% Metas Primarias: Fecha.
% Metas Secundarias: list.
mi_fecha(Fecha) :-
    get_time(Stamp),
    stamp_date_time(Stamp, DateTime, 'UTC'),
    date_time_value(year, DateTime, Año),
    date_time_value(month, DateTime, Mes),
    date_time_value(day, DateTime, Día),
    Fecha = (Día, Mes, Año).

%CONSTRUCTOR
% Descripcion: Predicado para generar un ChatHistory.
% Dominio: Nombre X InitialChatbotCodeLink X Chatbot X Usuarios X UsuarioLogeado X Fecha X ChatHistory
% Metas Primarias: chatHistory.
% Metas Secundarias: chatHistory.
chatHistory(Nombre,InitialChatbotCodeLink,Chatbot,Usuarios,UsuarioLogeado,Fecha,[Nombre,InitialChatbotCodeLink,Chatbot,Usuarios,UsuarioLogeado,Fecha] ).

%MODIFICADOR
% Descripcion: Predicado para modificar el usuario del chathistory.
% Dominio: Sistema X NuevoUsuario X NuevoSistema.
% Metas Primarias: setUsuarios.
% Metas Secundarias: chatHistory.
setUsuarios(Sistema, NuevoUsuario, NuevoSistema) :-
    chatHistory(Nombre,InitialChatbotCodeLink,Chatbot,_,UsuarioLogeado,Fecha,Sistema).
    chatHistory(Nombre,InitialChatbotCodeLink,Chatbot,NuevoUsuario,UsuarioLogeado,Fecha,NuevoSistema ).

% Descripcion: Predicado para modificar el usuarioLogeado del chathistory.
% Dominio: Sistema X NuevoUsuarioLogeado X NuevoSistema.
% Metas Primarias: setUsuarioLogeado.
% Metas Secundarias: chatHistory.
setUsuarioLogeado(Sistema, NuevoUsuarioLogeado, NuevoSistema) :-
    chatHistory(Nombre,InitialChatbotCodeLink,Chatbot,Usuario,_,Fecha,Sistema).
    chatHistory(Nombre,InitialChatbotCodeLink,Chatbot,Usuario,NuevoUsuarioLogeado,Fecha,NuevoSistema).