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

%IMPORTACION DE LIBRERIAS PARA FECHA

:- use_module(library(date)).

% Descripcion: Predicado que construye una fecha en el siguiente formato (Dia,Mes,Año).
% Dominio: Fecha.
% Metas Primarias: Fecha.
% Metas Secundarias: list.
% Error al ejecutar: Por alguna razon para sistema Windows el predicado fecha tiene un error, esto no sucede en otros entornos como prolog online, linux o mac.
% El error es un error de sintaxis o que el programa no encuentra la meta definida, lo he revisado varias veces y no encontre a que se refiere esto ultimo, ya que aun asi funciona en otros entornos.
mi_fecha(Fecha):-
    get_time(Stamp),
    stamp_date_time(Stamp, DateTime, 'UTC'),
    date_time_value(year, DateTime, Año),
    date_time_value(month, DateTime, Mes),
    date_time_value(day, DateTime, Día),
    Fecha = (Día, Mes, Año).


%-----------------------------------------------------------------------------------------------------------------------------------

%CONSTRUCTOR
% Descripcion: Predicado constructor que crea una opcion.
% Dominio: Codigo X Mensaje X ChatbotCodeLink X InitialFlowCodeLink X Keywords X Option.
% Metas Primarias: option.
% Metas Secundarias: option(list).
option(Codigo,Mensaje,ChatbotCodeLink,InitialFlowCodeLink,Keywords,[Codigo,Mensaje,ChatbotCodeLink,InitialFlowCodeLink,Keywords]).

% Descripcion: Predicado crea una nueva opcion y lo mete en una lista.
% Dominio: NuevaOption X Option X ListaConOptions
% Metas Primarias: addOptionToOption.
% Metas Secundarias: append.
addOptionToOption(NuevaOption,Options,ListaActualizada):-
	append(Options,[NuevaOption],ListaActualizada).

%SELECTORES
% Descripcion: Predicado que obtiene el codigo de la opcion dada.
% Dominio: Option X Codigo.
% Metas Primarias: getCodigoOption.
% Metas Secundarias: option.
getCodigoOption(Option,Codigo):-
	option(Codigo,_,_,_,_,Option).

% Descripcion: Predicado que obtiene el mensaje de la opcion dada.
% Dominio: Option X Mensaje.
% Metas Primarias: getMensajeOption..
% Metas Secundarias: option.
getMensajeOption(Option,Mensaje):-
	option(_,Mensaje,_,_,_,Option).

% Descripcion: Predicado que obtiene el ChatbotCodeLink de la opcion dada.
% Dominio: Option X ChatbotCodeLink.
% Metas Primarias: getChatbotCodeLinkOption.
% Metas Secundarias: option.
getChatbotCodeLinkOption(Option,ChatbotCodeLink):-
	option(_,_,ChatbotCodeLink,_,_,Option).

% Descripcion: Predicado que obtiene el InitialFlowCodeLink de la opcion dada.
% Dominio: Option X InitialFlowCodeLink.
% Metas Primarias: getInitialFlowCodeLinkOption.
% Metas Secundarias: option.
getInitialFlowCodeLinkOption(Option,InitialFlowCodeLink):-
	option(_,_,_,InitialFlowCodeLink,_,Option).

% Descripcion: Predicado que obtiene el Keywords de la opcion dada.
% Dominio: Option X Keywords.
% Metas Primarias: getKeywordsOption.
% Metas Secundarias: option.
getKeywordsOption(Option,Keywords):-
	option(_,_,_,_,Keywords,Option).

%MODIFICADORES
% Descripcion: Predicado que actualiza el codigo de la opcion y devuelve la nueva opcion.
% Dominio: Option X NuevoCodigo X NuevaOption.
% Metas Primarias: setCodigoOption.
% Metas Secundarias: option.		
setCodigoOption(Option,NuevoCodigo,NuevaOption):-
	option(_,Mensaje,ChatbotCodeLink,InitialFlowCodeLink,Keywords,Option),
	option(NuevoCodigo,Mensaje,ChatbotCodeLink,InitialFlowCodeLink,Keywords,NuevaOption).

% Descripcion: Predicado que actualiza el mensaje de la opcion y devuelve la nueva opcion.
% Dominio: Option X NuevoMensaje X NuevaOption.
% Metas Primarias: setMensajeOption.
% Metas Secundarias: option.    
setMensajeOption(Option,NuevoMensaje,NuevaOption):-
	option(Codigo,_,ChatbotCodeLink,InitialFlowCodeLink,Keywords,Option),
	option(Codigo,NuevoMensaje,ChatbotCodeLink,InitialFlowCodeLink,Keywords,NuevaOption).

% Descripcion: Predicado que actualiza el ChatbotCodeLink de la opcion y devuelve la nueva opcion.
% Dominio: Option X NuevoChatbotCodeLink X NuevaOption.
% Metas Primarias: setChatbotCodeLinkOption.
% Metas Secundarias: option.    
setChatbotCodeLinkOption(Option,NuevoChatbotCodeLink,NuevaOption):-
	option(Codigo,Mensaje,_,InitialFlowCodeLink,Keywords,Option),
	option(Codigo,Mensaje,NuevoChatbotCodeLink,InitialFlowCodeLink,Keywords,NuevaOption).

% Descripcion: Predicado que actualiza el InitialFlowCodeLink de la opcion y devuelve la nueva opcion.
% Dominio: Option X NuevoInitialFlowCodeLink X NuevaOption.
% Metas Primarias: setInitialFlowCodeLinkOption.
% Metas Secundarias: option.    
setInitialFlowCodeLinkOption(Option,NuevoInitialFlowCodeLink,NuevaOption):-
	option(Codigo,Mensaje,ChatbotCodeLink,_,Keywords,Option),
	option(Codigo,Mensaje,ChatbotCodeLink,NuevoInitialFlowCodeLink,Keywords,NuevaOption).

% Descripcion: Predicado que actualiza el Keywords de la opcion y devuelve la nueva opcion.
% Dominio: Option X NuevoKeywords X NuevaOption.
% Metas Primarias: setKeywordsOption.
% Metas Secundarias: option.    
setKeywordsOption(Option,NuevoKeywords,NuevaOption):-
	option(Codigo,Mensaje,ChatbotCodeLink,InitialFlowCodeLink,_,Option),
	option(Codigo,Mensaje,ChatbotCodeLink,InitialFlowCodeLink,NuevoKeywords,NuevaOption).	

%-----------------------------------------------------------------------------------------------------------------------------------

%CONSTRUCTOR
% Descripcion: Predicado constructor que crea un flujo dada una opcion.
% Dominio: Id X Msg X Option X Flow.
% Metas Primarias: flow.
% Metas Secundarias: filterOptions,removeDuplicates,Flow.
flow(Id,Msg,Option,Flow):-
	filterOptions(Id, Option, FilteredOptions),
    removeDuplicates(FilteredOptions, UniqueOptions),
    Flow = [Id, Msg, UniqueOptions].

%SELECTORES
% Descripcion: Predicado que obtiene el Id de un flujo dado.
% Dominio: Flow X ID.
% Metas Primarias: getIdFlow.
% Metas Secundarias: Flow.
getIdFlow(Flow, Id) :-
    Flow = [Id | _].

% Descripcion: Predicado que obtiene el Msg de un flujo dado.
% Dominio: Flow X Msg.
% Metas Primarias: getMsgFlow.
% Metas Secundarias: Flow.
getMsgFlow(Flow, Msg) :-
    Flow = [_, Msg | _].

% Descripcion: Predicado que obtiene la Option de un flujo dado.
% Dominio: Flow X Option.
% Metas Primarias: getOptionFlow.
% Metas Secundarias: Flow.
getOptionFlow(Flow,Option):-
	Flow = [_,_|Option].

%MODIFICADORES
% Descripcion: Predicado que actualiza el Id del flujo y devuelve el nuevo flujo.
% Dominio: Flow X NuevoId X NuevoFlow
% Metas Primarias: setIdFlow.
% Metas Secundarias: Flow, NuevoFlow.        
setIdFlow(Flow, NuevoID, NuevoFlow) :-
    Flow = [ _ , Msg |  Resto],
    NuevoFlow = [NuevoID, Msg | Resto].

% Descripcion: Predicado que actualiza el Msg del flujo y devuelve el nuevo flujo.
% Dominio: Flow X NuevoMsg X NuevoFlow
% Metas Primarias: setMsgFlow.
% Metas Secundarias: Flow, NuevoFlow.        
setMsgFlow(Flow, NuevoMsg, NuevoFlow) :-
    Flow = [ID | [ _ | Resto]],
    NuevoFlow = [ID, NuevoMsg | Resto].

% Descripcion: Predicado que actualiza el Option del flujo y devuelve el nuevo flujo.
% Dominio: Flow X NuevoOption X NuevoFlow
% Metas Primarias: setOptionFlow.
% Metas Secundarias: Flow, NuevoFlow.        
setOptionFlow(Flow,NuevoOption,NuevoFlow):-
	Flow = [ID | [Msg | _]],
    NuevoFlow = [ID, _ | NuevoOption].

% Descripcion: Predicado que filtra las opciones en base al InitialFlowCodeLink y el Id del flujo para asignarlo.
% Dominio: ID X list x list
% Metas Primarias: filterOptions.
% Metas Secundarias: option, filterOptions.  
filterOptions(_, [], []) :- !.
filterOptions(Id, [Option|RestOptions], FilteredOptions) :-
    option(Codigo, Mensaje, ChatbotCodeLink, InitialFlowCodeLink, Keywords, Option),
    (InitialFlowCodeLink = Id -> FilteredOptions = [Option|RestFilteredOptions] ; FilteredOptions = RestFilteredOptions),
    filterOptions(Id, RestOptions, RestFilteredOptions).

% Descripcion: Predicado para remover duplicados, puede ser una opcion, un flujo o un chatbot.
% Dominio: list x list
% Metas Primarias: removeDuplicates.
% Metas Secundarias: removeDuplicates, member.
removeDuplicates([], []).
removeDuplicates([X | Xs], Ys) :-
    member(X, Xs),
    removeDuplicates(Xs, Ys).
removeDuplicates([X | Xs], [X | Ys]) :-
    \+ member(X, Xs),
    removeDuplicates(Xs, Ys).

%MODIFICADOR
% Descripcion: Predicado para añadir una nueva opcion a un flujo creado.
% Dominio: Flow X Option X NuevoFlow
% Metas Primarias: flowAddOption.
% Metas Secundarias: removeDuplicates, filterOptions , append.
flowAddOption(Flow, Option, NuevoFlow) :-
	append(Flow,[Option],NuevoFlow),
	filterOptions(Id, [Option], FilteredOptions),
    removeDuplicates(FilteredOptions, UniqueOptions).

%-----------------------------------------------------------------------------------------------------------------------------------

%CONSTRUCTOR
% Descripcion: Predicado constructor que crea un chatbot dado un flujo.
% Dominio: ChatbotId X setNombreChatbot X MensajeBienvenida X StartFlowInitial X Flows X Chatbot.
% Metas Primarias: chatbot.
% Metas Secundarias: filterFlows,removeDuplicates,Chatbot.
chatbot(ChatbotId, Nombre, MensajeBienvenida, StartFlowInitial, Flows, Chatbot) :-
    filterFlows(Flows, StartFlowInitial, FilteredFlows),
    removeDuplicates(FilteredFlows,UniqueFlows),
    Chatbot = [ChatbotId, Nombre, MensajeBienvenida, StartFlowInitial, UniqueFlows].

% Descripcion: Predicado filtrador de chatbots para filtrar flujos en base al ID y el StartFlowInitial.
% Dominio: list x list x list
% Metas Primarias: filterFlows.
% Metas Secundarias: filterFlows, Flow , ID.
filterFlows([], _, []).
filterFlows([Flow|RestFlows], StartFlowInitial, FilteredFlows) :-
    Flow = [ID | _],
    (ID = StartFlowInitial -> FilteredFlows = [Flow|RestFilteredFlows] ; FilteredFlows = RestFilteredFlows),
    filterFlows(RestFlows, StartFlowInitial, RestFilteredFlows).

%SELECTORES
% Descripcion: Predicado que obtiene el Id de un chatbot dado.
% Dominio: Chatbot X ID.
% Metas Primarias: getChatbotId.
% Metas Secundarias: chatbot.
getChatbotId(Chatbot,Id):-
	Chatbot = [Id|_].

% Descripcion: Predicado que obtiene el Nombre de un chatbot dado.
% Dominio: Chatbot X Nombre.
% Metas Primarias: getChatbotNombre.
% Metas Secundarias: chatbot.
getChatbotNombre(Chatbot,Nombre):-
	Chatbot = [_,Nombre|_].

% Descripcion: Predicado que obtiene el MensajeBienvenida de un chatbot dado.
% Dominio: Chatbot X MensajeBienvenida.
% Metas Primarias: getChatbotMensajeBienvenida.
% Metas Secundarias: chatbot.
getChatbotMensajeBienvenida(Chatbot,MensajeBienvenida):-
	Chatbot = [_,_,MensajeBienvenida|_].

% Descripcion: Predicado que obtiene el StartFlowInitial de un chatbot dado.
% Dominio: Chatbot X StartFlowInitial.
% Metas Primarias: getChatbotStartFlowInitial.
% Metas Secundarias: chatbot.
getChatbotStartFlowInitial(Chatbot,StartFlowInitial):-
	Chatbot = [_,_,_,StartFlowInitial|_].

% Descripcion: Predicado que obtiene el Flow de un chatbot dado.
% Dominio: Chatbot X Flows.
% Metas Primarias: getChatbotFlows.
% Metas Secundarias: chatbot.
getChatbotFlows(Chatbot,Flow):-
	Chatbot = [_,_,_,_|Flow].

%MODIFICADORES
% Descripcion: Predicado que actualiza el Id del chatbot y devuelve el nuevo chatbot.
% Dominio: Chatbot X NuevoId X NuevoChatbot.
% Metas Primarias: setIdChatbot.
% Metas Secundarias: Chatbot, NuevoChatbot.  
setIdChatbot(Chatbot, NuevoID, NuevoChatbot) :-
    Chatbot = [ _,Nombre,MensajeBienvenida,StartFlowInitial |  Flow],
    NuevoChatbot = [NuevoID, Nombre,MensajeBienvenida,StartFlowInitial | Flow].

% Descripcion: Predicado que actualiza el Nombre del chatbot y devuelve el nuevo chatbot.
% Dominio: Chatbot X NuevoNombre X NuevoChatbot.
% Metas Primarias: setNombreChatbot.
% Metas Secundarias: Chatbot, NuevoChatbot.  
setNombreChatbot(Chatbot, NuevoNombre, NuevoChatbot) :-
    Chatbot = [ ChatbotId,_,MensajeBienvenida,StartFlowInitial |  Flow],
    NuevoChatbot = [ChatbotId, NuevoNombre,MensajeBienvenida,StartFlowInitial | Flow].

% Descripcion: Predicado que actualiza el MensajeBienvenida del chatbot y devuelve el nuevo chatbot.
% Dominio: Chatbot X NuevoMensajeBienvenida X NuevoChatbot.
% Metas Primarias: setMensajeBienvenidaChatbot.
% Metas Secundarias: Chatbot, NuevoChatbot.  
setMensajeBienvenidaChatbot(Chatbot, NuevoMensajeBienvenida, NuevoChatbot) :-
    Chatbot = [ ChatbotId,Nombre,_,StartFlowInitial |  Flow],
    NuevoChatbot = [ChatbotId, Nombre,NuevoMensajeBienvenida,StartFlowInitial | Flow].

% Descripcion: Predicado que actualiza el StarFlowInitial del chatbot y devuelve el nuevo chatbot.
% Dominio: Chatbot X NuevoStarFlowInitialX NuevoChatbot.
% Metas Primarias: setStarFlowInitialChatbot.
% Metas Secundarias: Chatbot, NuevoChatbot.  
setStarFlowInitialChatbot(Chatbot, NuevoStarFlowInitial, NuevoChatbot) :-
    Chatbot = [ ChatbotId,Nombre,MensajeBienvenida,_ |  Flow],
    NuevoChatbot = [ChatbotId, Nombre,MensajeBienvenida,NuevoStartFlowInitial | Flow].

% Descripcion: Predicado que actualiza el Flows del chatbot y devuelve el nuevo chatbot.
% Dominio: Chatbot X NuevoFlows X NuevoChatbot.
% Metas Primarias: setFlowsChatbot.
% Metas Secundarias: Chatbot, NuevoChatbot.  
setFlowsChatbot(Chatbot, NuevoFlow, NuevoChatbot) :-
    Chatbot = [ ChatbotId,Nombre,MensajeBienvenida,StartFlowInitial |  _],
    NuevoChatbot = [ChatbotId, Nombre,MensajeBienvenida,StartFlowInitial | NuevoFlow].

%MODIFICADOR
% Descripcion: Predicado para añadir un nuevo flujo a un chatbot creado.
% Dominio: Chatbot X Flow X NuevoChatbot.
% Metas Primarias: chatbotAddFlow.
% Metas Secundarias: removeDuplicates, filterFlows , append.
chatbotAddFlow(Chatbot, Flow, NuevoChatbot) :-
	append(Chatbot,[Flow],NuevoChatbot),
	filterFlows([Flow],StartFlowInitial, FilteredFlows),
    removeDuplicates(FilteredFlows, UniqueFlows).

%-----------------------------------------------------------------------------------------------------------------------------------

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

%-----------------------------------------------------------------------------------------------------------------------------------

%CONSTRUCTOR
% Descripcion: Predicado que crea un sistema vacío con un nombre específico.
% Dominio: NombreSistema X InitialChatbotCodeLink X Chatbot X Sistema.
% Metas Primarias: system.
% Metas Secundarias: filterChatbot, removeDuplicates, ChatHistory.
system(Nombre,InitialChatbotCodeLink,Chatbot, Sistema) :-
    string(Nombre), number(InitialChatbotCodeLink),
    filterChatbot(Chatbot, InitialChatbotCodeLink, FilteredChatbot),
    removeDuplicates(FilteredChatbot,UniqueChatbot),
    mi_fecha(Fecha), % Si hay errores poner como comente esta parte, no se vera la fecha pero no saltara el error
    %Sistema = [Nombre, InitialChatbotCodeLink, UniqueChatbot],
    %chatHistory(Nombre,InitialChatbotCodeLink,UniqueChatbot,[],[],Fecha, Sistema),!. %version para filtros
    chatHistory(Nombre,InitialChatbotCodeLink,Chatbot,[],[],Fecha, Sistema),!.
    

% Descripcion: Predicado filtrador de sistea para filtrar chatbot en base al InitialChatbotCodeLink y el ID.
% Dominio: list x list x list.
% Metas Primarias: filterChatbot.
% Metas Secundarias: filterChatbot, chatbot , chatbotId.
filterChatbot([], _, []).
filterChatbot([Chatbot|RestChatbot], InitialChatbotCodeLink, FilteredChatbot) :-
   Chatbot = [ChatbotId|_],
   (ChatbotId = InitialChatbotCodeLink -> FilteredChatbot = [Chatbot|RestFilteredChatbot] ; FilteredChatbot = RestFilteredChatbot),
   filterChatbot(RestChatbot, InitialChatbotCodeLink, RestFilteredChatbot).

%MODIFICADOR
% Descripcion: Predicado para añadir un nuevo chatbot a un sistema creado.
% Dominio: Sistema X Chatbot X NuevoSistema.
% Metas Primarias: systemAddChatbot.
% Metas Secundarias: removeDuplicates, filterChatbot , append.
systemAddChatbot(Sistema, Chatbot, NuevoSistema) :-
    append(Sistema,[Chatbot],NuevoSistema),
    filterChatbot([Chatbot],InitialChatbotCodeLink, FilteredChatbot),
    removeDuplicates(FilteredChatbot,UniqueChatbot).

%-----------------------------------------------------------------------------------------------------------------------------------

%CONSTRUCTOR
% Descripcion: Predicado para crear un usuario y asignarlo a una lista
% Dominio: NombreUsuario x list.
% Metas Primarias: usuario.
% Metas Secundarias: usuario.
usuario(NombreUsuario,[NombreUsuario]).

%SELECTORES
% Descripcion: Predicado que obtiene el NombreUsuario de un usuario dado.
% Dominio: Usuario X Nombre.
% Metas Primarias: getNombreUsuario.
% Metas Secundarias: usuario.
getNombreUsuario(Usuario,NombreUsuario):-
    usuario(NombreUsuario,Usuario).

% Descripcion: Predicado que obtiene el usuario del chathistory dentro del sistema 1-Forma de hacerlo.
% Dominio: Sistema X Usuario.
% Metas Primarias: getUsuarios.
% Metas Secundarias: usuario.
getUsuarios(Sistema, Usuario):-
    usuario([_|Usuario],Sistema).

% Descripcion: Predicado que obtiene el usuario del chathistory dentro del sistema.
% Dominio: Sistema X Usuario.
% Metas Primarias: getUsuarios.
% Metas Secundarias: findalll , usuario.
getUsuarios(Sistema, Usuarios) :-
    findall(NombreUsuario, usuario(NombreUsuario, Sistema), Usuarios).

%MODIFICADOR
% Descripcion: Predicado para cambiar el nombre del usuario dentro del sistema.
% Dominio: Usuario X NuevoUsuario X NuevosUsuarios.
% Metas Primarias: setNombreUsuario.
% Metas Secundarias: usuario.
setNombreUsuario(Usuario,NuevoNombre,NuevoUsuario):-
    usuario(_,Usuario),
    usuario(NuevoNombre,NuevoUsuario).

% Descripcion: Predicado para añadir un nuevo usuario a una lista de usuarios.
% Dominio: NuevoUsuuario X Usuarios X NuevosUsuarios
% Metas Primarias: addUsuario.
% Metas Secundarias: append.
addUsuario(NuevoUsuario,Usuarios,NuevosUsuarios):-
    append(Usuarios,[NuevoUsuario],NuevosUsuarios).

%-----------------------------------------------------------------------------------------------------------------------------------

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

%---------------------------------------------------------------------------------------

%SELECTORES
% Descripcion: Predicado que obtiene el Nombre de un sistema dado.
% Dominio: Sistema X Nombre.
% Metas Primarias: getNombreSystem.
% Metas Secundarias: System.
getNombreSystem(System, Nombre) :-
    System = [Nombre, _, _, _, _, _].

% Descripcion: Predicado que obtiene el InitialChatbotCodeLink de un sistema dado.
% Dominio: Sistema X InitialChatbotCodeLink.
% Metas Primarias: getInitialChatbotCodeLinkSystem.
% Metas Secundarias: System.
getInitialChatbotCodeLinkSystem(System, InitialChatbotCodeLink) :-
    System = [_, InitialChatbotCodeLink, _, _, _, _].

% Descripcion: Predicado que obtiene el Chatbot de un sistema dado.
% Dominio: Sistema X Chatbot.
% Metas Primarias: getChatbotSystem.
% Metas Secundarias: System.
getChatbotSystem(System, Chatbot) :-
    System = [_, _, Chatbot, _, _, _].

% Descripcion: Predicado que obtiene el Usuarios de un sistema dado.
% Dominio: Sistema X Usuarios.
% Metas Primarias: getUsuariosSystem.
% Metas Secundarias: System.
getUsuariosSystem(System, Usuarios) :-
    System = [_, _, _, Usuarios, _, _].

% Descripcion: Predicado que obtiene el UsuarioLogeado de un sistema dado.
% Dominio: Sistema X UsuarioLogeado.
% Metas Primarias: getUsuarioLogeadoSystem.
% Metas Secundarias: System.
getUsuarioLogeadoSystem(System, UsuarioLogeado) :-
    System = [_, _, _, _, UsuarioLogeado, _].

% Descripcion: Predicado que obtiene la Fecha de un sistema dado.
% Dominio: Sistema X Fecha.
% Metas Primarias: getFechaSystem.
% Metas Secundarias: System.
getFechaSystem(System, Fecha) :-
    System = [_, _, _, _, _, Fecha].

%MODIFICADOR
% Descripcion: Predicado para cambiar el nombre del usuario dentro del sistema, basandonos en chatHistory.
% Dominio: Sistema X NuevoNombre X NuevoSistema.
% Metas Primarias: setNombreSystem.
% Metas Secundarias: System , NuevoSystem.
setNombreSystem(System, NuevoNombre, NuevoSystem) :-
    System = [_, InitialChatbotCodeLink, Chatbot, Usuarios, UsuarioLogeado, Fecha],
    NuevoSystem = [NuevoNombre, InitialChatbotCodeLink, Chatbot, Usuarios, UsuarioLogeado, Fecha].

% Descripcion: Predicado para cambiar el InitialChatbotCodeLink del usuario dentro del sistema, basandonos en chatHistory.
% Dominio: Sistema X NuevoInitialChatbotCodeLink X NuevoSistema.
% Metas Primarias: setInitialChatbotCodeLinkSystem.
% Metas Secundarias: System , NuevoSystem.
setInitialChatbotCodeLinkSystem(System, NuevoInitialChatbotCodeLink, NuevoSystem) :-
    System = [Nombre, _, Chatbot, Usuarios, UsuarioLogeado, Fecha],
    NuevoSystem = [Nombre, NuevoInitialChatbotCodeLink, Chatbot, Usuarios, UsuarioLogeado, Fecha].

% Descripcion: Predicado para cambiar el Chatbot del usuario dentro del sistema, basandonos en chatHistory.
% Dominio: Sistema X NuevoChatbot X NuevoSistema.
% Metas Primarias: setChatbotSystem.
% Metas Secundarias: System , NuevoSystem.
setChatbotSystem(System, NuevoChatbot, NuevoSystem) :-
    System = [Nombre, InitialChatbotCodeLink, _, Usuarios, UsuarioLogeado, Fecha],
    NuevoSystem = [Nombre, InitialChatbotCodeLink, NuevoChatbot, Usuarios, UsuarioLogeado, Fecha].

% Descripcion: Predicado para cambiar el Usuario del usuario dentro del sistema, basandonos en chatHistory.
% Dominio: Sistema X NuevoUsuarios X NuevoSistema.
% Metas Primarias: setUsuariosSystem.
% Metas Secundarias: System , NuevoSystem.
setUsuariosSystem(System, NuevosUsuarios, NuevoSystem) :-
    System = [Nombre, InitialChatbotCodeLink, Chatbot, _, UsuarioLogeado, Fecha],
    NuevoSystem = [Nombre, InitialChatbotCodeLink, Chatbot, NuevosUsuarios, UsuarioLogeado, Fecha].

% Descripcion: Predicado para cambiar el UsuarioLogeado del usuario dentro del sistema, basandonos en chatHistory.
% Dominio: Sistema X NuevoUsuarioLogeado X NuevoSistema.
% Metas Primarias: setUsuarioLogeadoSystem.
% Metas Secundarias: System , NuevoSystem.
setUsuarioLogeadoSystem(System, NuevoUsuarioLogeado, NuevoSystem) :-
    System = [Nombre, InitialChatbotCodeLink, Chatbot, Usuarios, _, Fecha],
    NuevoSystem = [Nombre, InitialChatbotCodeLink, Chatbot, Usuarios, NuevoUsuarioLogeado, Fecha].

% Descripcion: Predicado para cambiar la Fecha del usuario dentro del sistema, basandonos en chatHistory.
% Dominio: Sistema X NuevaFecha X NuevoSistema.
% Metas Primarias: setFechaSystem.
% Metas Secundarias: System , NuevoSystem.
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

% Descripcion: Predicado que permite interactuar con un chatbot
% Dominio: system X mensaje (string) X system.
% Metas Primarias: system_tal_rec.
% Metas Secundarias: getchatbot,getFechaSystem,getChatbotSystem,isUsuarioLogeado,system.
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

%Funcion extra para system simulate
% Descripcion: Predicado para generar numeros aleatorios.
% Dominio: Xn x Xn1
% Metas Primarias: mulTemp.
% Metas Secundarias: MulTemp, Myrandom.
myRandom(Xn, Xn1):-
    mulTemp is 1103515245 * Xn,
    sumTemp is mulTemp + 12345,
    Xn1 is sumTemp mod 2147483648.


