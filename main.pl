% PARADIGMAS DE LA PROGRAMACIÓN
% SECCIÓN DEL CURSO: 0-A-1
% PROFESOR DE TEORÍA: EDMUNDO LEIVA
% PROFESOR DE LABORATORIO: EDMUNDO LEIVA
%
% AUTOR
% NOMBRE: Cristian Alexis Romero Martinez
% RUT: 19.800.734-k 
% CARRERA: Ingenieria en Ejecucion en Informatica
% VERSIÓN SWI-PROLOG: 8.4.2

%HECHOS

%REGLAS

%PREDICADOS

%IMPORTACION DE LIBRERIAS PARA FECHA.

:- use_module(library(date)).

mi_fecha(Fecha) :-
    get_time(Stamp),
    stamp_date_time(Stamp, DateTime, 'UTC'),
    date_time_value(year, DateTime, Año),
    date_time_value(month, DateTime, Mes),
    date_time_value(day, DateTime, Día),
    Fecha = (Día, Mes, Año).

%-----------------------------------------------------------------------------------------------------------------------------------

option(Codigo,Mensaje,ChatbotCodeLink,InitialFlowCodeLink,Keywords,[Codigo,Mensaje,ChatbotCodeLink,InitialFlowCodeLink,Keywords]).

addOptionToOption(NuevaOption,Options,ListaActualizada):-
	append(Options,[NuevaOption],ListaActualizada).

%SELECTORES
% Descripcion: Predicado que obtiene el codigo de la opcion dada.
% Dominio: Option X Codigo
% Metas Primarias: getCodigoOption
% Metas Secundarias: option
getCodigoOption(Option,Codigo):-
	option(Codigo,_,_,_,_,Option).

getMensajeOption(Option,Mensaje):-
	option(_,Mensaje,_,_,_,Option).

getChatbotCodeLinkOption(Option,ChatbotCodeLink):-
	option(_,_,ChatbotCodeLink,_,_,Option).

getInitialFlowCodeLinkOption(Option,InitialFlowCodeLink):-
	option(_,_,_,InitialFlowCodeLink,_,Option).

getKeywordsOption(Option,Keywords):-
	option(_,_,_,_,Keywords,Option).
		
setCodigoOption(Option,NuevoCodigo,NuevaOption):-
	option(_,Mensaje,ChatbotCodeLink,InitialFlowCodeLink,Keywords,Option),
	option(NuevoCodigo,Mensaje,ChatbotCodeLink,InitialFlowCodeLink,Keywords,NuevaOption).

setMensajeOption(Option,NuevoMensaje,NuevaOption):-
	option(Codigo,_,ChatbotCodeLink,InitialFlowCodeLink,Keywords,Option),
	option(Codigo,NuevoMensaje,ChatbotCodeLink,InitialFlowCodeLink,Keywords,NuevaOption).

setChatbotCodeLinkOption(Option,NuevoChatbotCodeLink,NuevaOption):-
	option(Codigo,Mensaje,_,InitialFlowCodeLink,Keywords,Option),
	option(Codigo,Mensaje,NuevoChatbotCodeLink,InitialFlowCodeLink,Keywords,NuevaOption).

setInitialFlowCodeLinkOption(Option,NuevoInitialFlowCodeLink,NuevaOption):-
	option(Codigo,Mensaje,ChatbotCodeLink,_,Keywords,Option),
	option(Codigo,Mensaje,ChatbotCodeLink,NuevoInitialFlowCodeLink,Keywords,NuevaOption).

setKeywordsOption(Option,NuevoKeywords,NuevaOption):-
	option(Codigo,Mensaje,ChatbotCodeLink,InitialFlowCodeLink,_,Option),
	option(Codigo,Mensaje,ChatbotCodeLink,InitialFlowCodeLink,NuevoKeywords,NuevaOption).	

flow(Id,Msg,Option,Flow):-
	filterOptions(Id, Option, FilteredOptions),
    removeDuplicates(FilteredOptions, UniqueOptions),
    Flow = [Id, Msg, UniqueOptions].

getIdFlow(Flow, Id) :-
    Flow = [Id | _].

getMsgFlow(Flow, Msg) :-
    Flow = [_, Msg | _].

getOptionFlow(Flow,Option):-
	Flow = [_,_|Option].

setIdFlow(Flow, NuevoID, NuevoFlow) :-
    Flow = [ _ , Msg |  Resto],
    NuevoFlow = [NuevoID, Msg | Resto].

setMsgFlow(Flow, NuevoMsg, NuevoFlow) :-
    Flow = [ID | [ _ | Resto]],
    NuevoFlow = [ID, NuevoMsg | Resto].

setOptionFlow(Flow,NuevoOption,NuevoFlow):-
	Flow = [ID | [Msg | _]],
    NuevoFlow = [ID, _ | NuevoOption].

filterOptions(_, [], []) :- !.
filterOptions(Id, [Option|RestOptions], FilteredOptions) :-
    option(Codigo, Mensaje, ChatbotCodeLink, InitialFlowCodeLink, Keywords, Option),
    (InitialFlowCodeLink = Id -> FilteredOptions = [Option|RestFilteredOptions] ; FilteredOptions = RestFilteredOptions),
    filterOptions(Id, RestOptions, RestFilteredOptions).

removeDuplicates([], []).
removeDuplicates([X | Xs], Ys) :-
    member(X, Xs),
    removeDuplicates(Xs, Ys).
removeDuplicates([X | Xs], [X | Ys]) :-
    \+ member(X, Xs),
    removeDuplicates(Xs, Ys).

flowAddOption(Flow, Option, NuevoFlow) :-
	append(Flow,[Option],NuevoFlow),
	filterOptions(Id, [Option], FilteredOptions),
    removeDuplicates(FilteredOptions, UniqueOptions).

chatbot(ChatbotId, Nombre, MensajeBienvenida, StartFlowInitial, Flows, Chatbot) :-
    filterFlows(Flows, StartFlowInitial, FilteredFlows),
    removeDuplicates(FilteredFlows,UniqueFlows),
    Chatbot = [ChatbotId, Nombre, MensajeBienvenida, StartFlowInitial, UniqueFlows].

filterFlows([], _, []).
filterFlows([Flow|RestFlows], StartFlowInitial, FilteredFlows) :-
    Flow = [ID | _],
    (ID = StartFlowInitial -> FilteredFlows = [Flow|RestFilteredFlows] ; FilteredFlows = RestFilteredFlows),
    filterFlows(RestFlows, StartFlowInitial, RestFilteredFlows).

getChatbotId(Chatbot,Id):-
	Chatbot = [Id|_].

getChatbotNombre(Chatbot,Nombre):-
	Chatbot = [_,Nombre|_].

getChatbotMensajeBienvenida(Chatbot,MensajeBienvenida):-
	Chatbot = [_,_,MensajeBienvenida|_].

getChatbotStartFlowInitial(Chatbot,StartFlowInitial):-
	Chatbot = [_,_,_,StartFlowInitial|_].

getChatbotFlows(Chatbot,Flow):-
	Chatbot = [_,_,_,_|Flow].

setIdChatbot(Chatbot, NuevoID, NuevoChatbot) :-
    Chatbot = [ _,Nombre,MensajeBienvenida,StartFlowInitial |  Flow],
    NuevoChatbot = [NuevoID, Nombre,MensajeBienvenida,StartFlowInitial | Flow].

setNombreChatbot(Chatbot, NuevoNombre, NuevoChatbot) :-
    Chatbot = [ ChatbotId,_,MensajeBienvenida,StartFlowInitial |  Flow],
    NuevoChatbot = [ChatbotId, NuevoNombre,MensajeBienvenida,StartFlowInitial | Flow].

setMensajeBienvenidaChatbot(Chatbot, NuevoMensajeBienvenida, NuevoChatbot) :-
    Chatbot = [ ChatbotId,Nombre,_,StartFlowInitial |  Flow],
    NuevoChatbot = [ChatbotId, Nombre,NuevoMensajeBienvenida,StartFlowInitial | Flow].

setStarFlowInitialChatbot(Chatbot, NuevoStarFlowInitial, NuevoChatbot) :-
    Chatbot = [ ChatbotId,Nombre,MensajeBienvenida,_ |  Flow],
    NuevoChatbot = [ChatbotId, Nombre,MensajeBienvenida,NuevoStartFlowInitial | Flow].

setFlowsChatbot(Chatbot, NuevoFlow, NuevoChatbot) :-
    Chatbot = [ ChatbotId,Nombre,MensajeBienvenida,StartFlowInitial |  _],
    NuevoChatbot = [ChatbotId, Nombre,MensajeBienvenida,StartFlowInitial | NuevoFlow].

chatbotAddFlow(Chatbot, Flow, NuevoChatbot) :-
	append(Chatbot,[Flow],NuevoChatbot),
	filterFlows([Flow],StartFlowInitial, FilteredFlows),
    removeDuplicates(FilteredFlows, UniqueFlows).

chatHistory(Nombre,InitialChatbotCodeLink,Chatbot,Usuarios,UsuarioLogeado,Fecha,[Nombre,InitialChatbotCodeLink,Chatbot,Usuarios,UsuarioLogeado,Fecha] ).


% Descripcion: Predicado que crea un sistema vacío con un nombre específico.
% Dominio: NombreSistema X InitialChatbotCodeLink X Chatbot X Sistema.
% Metas Primarias: system.
% Metas Secundarias: filterChatbot, removeDuplicates, ChatHistory.
    system(Nombre,InitialChatbotCodeLink,Chatbot, Sistema) :-
    string(Nombre), number(InitialChatbotCodeLink),
    filterChatbot(Chatbot, InitialChatbotCodeLink, FilteredChatbot),
    removeDuplicates(FilteredChatbot,UniqueChatbot),
    mi_fecha(Fecha),
    %Sistema = [Nombre, InitialChatbotCodeLink, UniqueChatbot],
    chatHistory(Nombre,InitialChatbotCodeLink,UniqueChatbot,[],[],Fecha, Sistema),!.
    %filesystem(Nombre, [], [], [], [], [], [], [], Sistema),!.

filterChatbot([], _, []).
filterChatbot([Chatbot|RestChatbot], InitialChatbotCodeLink, FilteredChatbot) :-
   Chatbot = [ChatbotId|_],
   (ChatbotId = InitialChatbotCodeLink -> FilteredChatbot = [Chatbot|RestFilteredChatbot] ; FilteredChatbot = RestFilteredChatbot),
   filterChatbot(RestChatbot, InitialChatbotCodeLink, RestFilteredChatbot).

systemAddChatbot(Sistema, Chatbot, NuevoSistema) :-
    append(Sistema,[Chatbot],NuevoSistema),
    filterChatbot([Chatbot],InitialChatbotCodeLink, FilteredChatbot),
    removeDuplicates(FilteredChatbot,UniqueChatbot).

usuario(NombreUsuario,[NombreUsuario]).

getNombreUsuario(Usuario,NombreUsuario):-
    usuario(NombreUsuario,Usuario).

setNombreUsuario(Usuario,NuevoNombre,NuevoUsuario):-
    usuario(_,Usuario),
    usuario(NuevoNombre,NuevoUsuario).

addUsuario(NuevoUsuario,Usuarios,NuevosUsuarios):-
    append(Usuarios,[NuevoUsuario],NuevosUsuarios).

getUsuarios(Sistema, Usuario):-
    usuario([_|Usuario],Sistema).
getUsuarios(Sistema, Usuarios) :-
    findall(NombreUsuario, usuario(NombreUsuario, Sistema), Usuarios).

% Descripcion: Predicado que registra un usuario en un sistema.
% Dominio: Sistema X NombreUsuario X NuevoSistema.
% Metas Primarias: systemAddUser.
% Metas Secundarias: string, getNombreSystem, getInitialChatbotCodeLinkSystem, getChatbotSystem, getFechaSystem, usuario,getUsuarios, member , ChatHistory.
systemAddUser(Sistema, NombreUsuario, NuevoSistema) :-
    string(NombreUsuario),
    getNombreSystem(Sistema,Nombre),
    getInitialChatbotCodeLinkSystem(Sistema,InitialChatbotCodeLink),
    getChatbotSystem(Sistema,Chatbot),
    getFechaSystem(Sistema,Fecha),
    usuario(NombreUsuario, NuevoUsuario),
    getUsuarios(Sistema, Usuarios),
    \+ member(NuevoUsuario, Usuarios), % Verifica que el usuario no está presente en Usuarios
    addUsuario(NuevoUsuario, Usuarios, NuevosUsuarios),
    %setUsuarios(Sistema, NuevosUsuarios, NuevoSistema),
    chatHistory(Nombre,InitialChatbotCodeLink,Chatbot,NuevoUsuario,[],Fecha, NuevoSistema),!.

% Descripcion: Predicado que registra un nuevo usuario en un sistema.
% Dominio: Sistema X NombreUsuario X NuevoSistema.
% Metas Primarias: systemAddUser.
% Metas Secundarias: string, getNombreSystem, getInitialChatbotCodeLinkSystem, getChatbotSystem, getFechaSystem, usuario,getUsuarios, member , ChatHistory.
systemAddUser(Sistema, NombreUser, Newsistema) :-
    string(NombreUser),
    usuario(NombreUser, NewUser),
    getUsuarios(Sistema, Usuarios),
    \+ member(UserList, Usuarios), % Verifica que el usuario no está presente en Usuarios
    addUserToUsers(NewUser, Usuarios, UpdateUsers),
    getNombreSystem(Sistema,Nombre),
    getInitialChatbotCodeLinkSystem(Sistema,InitialChatbotCodeLink),
    getChatbotSystem(Sistema,Chatbot),
    getFechaSystem(Sistema,Fecha),
    getUsuariosSystem(System, Usuarios),
    chatHistory(Nombre,InitialChatbotCodeLink,Chatbot,[Usuarios,UpdateUsers],[ ],Fecha, NuevoSistema),!.

% Descripcion: Predicado que realiza el inicio de sesión de un usuario en un sistema.
% Dominio: Sistema X NombreUsuario X NuevoSistema.
% Metas Primarias: systemLogin.
% Metas Secundarias: getUsuariosSystem , getChatbotSystem , getFechaSystem , getNombreSystem , UsuarioLogeado, usuario , ChatHistory.
systemLogin(Sistema, NombreUsuario, NuevoSistema) :- 
    usuario(NombreUsuario, UsuarioLogeado),
    getUsuariosSystem(Sistema, UsuarioRegistrado),
    getNombreSystem(Sistema,Nombre),
    getInitialChatbotCodeLinkSystem(Sistema,InitialChatbotCodeLink),
    getChatbotSystem(Sistema,Chatbot),
    getFechaSystem(Sistema,Fecha),
    UsuarioLogeado = UsuarioRegistrado, % Restriccion con esto el usuarioLogeado debe de ser el mismo con respecto al usuarioRegistrado antes
    chatHistory(Nombre,InitialChatbotCodeLink,Chatbot,UsuarioRegistrado,UsuarioLogeado,Fecha, NuevoSistema),!.

% Descripcion: Predicado que realiza el cierre de sesión en un sistema.
% Dominio: Sistema X NuevoSistema.
% Metas Primarias: systemLogout.
% Metas Secundarias: getUsuariosSystem,getNombreSystem,getChatbotSystem,getFechaSystem,getUsuarioLogeadoSystem,ChatHistory.
systemLogout(Sistema, NuevoSistema) :-
    getNombreSystem(Sistema,Nombre),
    getInitialChatbotCodeLinkSystem(Sistema,InitialChatbotCodeLink),
    getChatbotSystem(Sistema,Chatbot),
    getFechaSystem(Sistema,Fecha),
    getUsuariosSystem(Sistema,Usuarios),
    getUsuarioLogeadoSystem(Sistema,UsuarioLogeado),
    chatHistory(Nombre,InitialChatbotCodeLink,Chatbot,Usuarios,[ ],Fecha, NuevoSistema),!.


% Modificadores Usuarios y UsuariosLogeados

setUsuarios(Sistema, NuevoUsuario, NuevoSistema) :-
    chatHistory(Nombre,InitialChatbotCodeLink,Chatbot,_,UsuarioLogeado,Fecha,Sistema).
    chatHistory(Nombre,InitialChatbotCodeLink,Chatbot,NuevoUsuario,UsuarioLogeado,Fecha,NuevoSistema ).

setUsuarioLogeado(Sistema, NuevoUsuarioLogeado, NuevoSistema) :-
    chatHistory(Nombre,InitialChatbotCodeLink,Chatbot,Usuario,_,Fecha,Sistema).
    chatHistory(Nombre,InitialChatbotCodeLink,Chatbot,Usuario,NuevoUsuarioLogeado,Fecha,NuevoSistema).

%---------------------------------------------------------------------------------------

% Selectores System 

getNombreSystem(System, Nombre) :-
    System = [Nombre, _, _, _, _, _].

getInitialChatbotCodeLinkSystem(System, InitialChatbotCodeLink) :-
    System = [_, InitialChatbotCodeLink, _, _, _, _].

getChatbotSystem(System, Chatbot) :-
    System = [_, _, Chatbot, _, _, _].

getUsuariosSystem(System, Usuarios) :-
    System = [_, _, _, Usuarios, _, _].

getUsuarioLogeadoSystem(System, UsuarioLogeado) :-
    System = [_, _, _, _, UsuarioLogeado, _].

getFechaSystem(System, Fecha) :-
    System = [_, _, _, _, _, Fecha].

% Modificadores System 

setNombreSystem(System, NuevoNombre, NuevoSystem) :-
    System = [_, InitialChatbotCodeLink, Chatbot, Usuarios, UsuarioLogeado, Fecha],
    NuevoSystem = [NuevoNombre, InitialChatbotCodeLink, Chatbot, Usuarios, UsuarioLogeado, Fecha].

setInitialChatbotCodeLinkSystem(System, NuevoInitialChatbotCodeLink, NuevoSystem) :-
    System = [Nombre, _, Chatbot, Usuarios, UsuarioLogeado, Fecha],
    NuevoSystem = [Nombre, NuevoInitialChatbotCodeLink, Chatbot, Usuarios, UsuarioLogeado, Fecha].

setChatbotSystem(System, NuevoChatbot, NuevoSystem) :-
    System = [Nombre, InitialChatbotCodeLink, _, Usuarios, UsuarioLogeado, Fecha],
    NuevoSystem = [Nombre, InitialChatbotCodeLink, NuevoChatbot, Usuarios, UsuarioLogeado, Fecha].

setUsuariosSystem(System, NuevosUsuarios, NuevoSystem) :-
    System = [Nombre, InitialChatbotCodeLink, Chatbot, _, UsuarioLogeado, Fecha],
    NuevoSystem = [Nombre, InitialChatbotCodeLink, Chatbot, NuevosUsuarios, UsuarioLogeado, Fecha].

setUsuarioLogeadoSystem(System, NuevoUsuarioLogeado, NuevoSystem) :-
    System = [Nombre, InitialChatbotCodeLink, Chatbot, Usuarios, _, Fecha],
    NuevoSystem = [Nombre, InitialChatbotCodeLink, Chatbot, Usuarios, NuevoUsuarioLogeado, Fecha].

setFechaSystem(System, NuevaFecha, NuevoSystem) :-
    System = [Nombre, InitialChatbotCodeLink, Chatbot, Usuarios, UsuarioLogeado, _],
    NuevoSystem = [Nombre, InitialChatbotCodeLink, Chatbot, Usuarios, UsuarioLogeado, NuevaFecha].

%----------------------------------------------------------------------------------------------------------

% Verifica si el usuario ha iniciado sesión
isUsuarioLogeado(UsuarioLogeado) :- UsuarioLogeado \== [].

% Verifica si una palabra clave está en la lista de palabras clave de una opción
keywordEnOpcion(PalabraClave, Opcion) :-
    getKeywordsOption(Opcion, Keywords),
    member(PalabraClave, Keywords).

% Encuentra la opción correspondiente a una palabra clave en un flujo
opcionPorPalabraClave(PalabraClave, Flujo, Opcion) :-
    getOptionFlow(Flujo, Opciones),
    member(Opcion, Opciones),
    keywordEnOpcion(PalabraClave, Opcion).

% Obtén el Chatbot del sistema
getChatbotSistema([_, _, Chatbot, _, _, _], Chatbot).

% Predicado principal
system_tal_rec(Sistema, PalabraClave, NuevoSistema) :-
    isUsuarioLogeado(Sistema), % Verifica si el usuario ha iniciado sesión
    getChatbotSistema(Sistema, Chatbot), % Obtén el chatbot del sistema
    getFechaSystem(Sistema, Fecha), % Obtén la fecha del sistema
    getChatbotFlows(Chatbot, Flows), % Obtiene los flujos del chatbot

    % Busca la opción correspondiente a la palabra clave en los flujos del chatbot
    findall([Id, Msg, [Opcion]], (member(Flujo, Flows), opcionPorPalabraClave(PalabraClave, Flujo, Opcion), getIdFlow(Flujo, Id), getMsgFlow(Flujo, Msg)), OpcionesEnFlujos),

    % Elimina las opciones duplicadas
    flatten(OpcionesEnFlujos, OpcionesFlatten),
    list_to_set(OpcionesFlatten, OpcionesUnicas),

    % Crea un nuevo sistema con las opciones encontradas
    system(getNombreSystem(Sistema), getInitialChatbotCodeLinkSystem(Sistema), Chatbot, getUsuariosSystem(Sistema), getUsuarioLogeadoSystem(Sistema), Fecha, NuevoSistema).


