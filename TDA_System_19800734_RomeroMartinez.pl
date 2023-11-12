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

%IMPORTACIONES DE ARCHIVOS
:-include(tda_ChatHistory_19800734_RomeroMartinez).
:-include(tda_Chatbot_19800734_RomeroMartinez).
:-include(tda_User_19800734_RomeroMartinez).
:- use_module(library(date)).
%:-use_module(tda_User_19800734_RomeroMartinez,[usuario/2, addUserToUsers/3,getUsuarios/2,getNombreUsuario/2,setNombreUsuario/2,addUsuario/3]).

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
    %chatHistory(Nombre,InitialChatbotCodeLink,UniqueChatbot,[],[],[],Fecha, Sistema),!. %version para filtros
    chatHistory(Nombre,InitialChatbotCodeLink,UniqueChatbot,[],[],[],Fecha, Sistema),!.
    

% Descripcion: Predicado filtrador de sistea para filtrar chatbot en base al InitialChatbotCodeLink y el ID.
% Dominio: list x list x list.
% Metas Primarias: filterChatbot.
% Metas Secundarias: filterChatbot, chatbot , chatbotId.
filterChatbot([], _, []).
filterChatbot([Chatbot|RestChatbot], InitialChatbotCodeLink, FilteredChatbot) :-
   Chatbot = [ChatbotId|_],
   (ChatbotId = InitialChatbotCodeLink -> FilteredChatbot = [Chatbot|RestFilteredChatbot] ; FilteredChatbot = RestFilteredChatbot),
   filterChatbot(RestChatbot, InitialChatbotCodeLink, RestFilteredChatbot).

%VERIFICADOR DE ID
%Se puede ocupar una manera de hacer sin el verificador y seria aplicar el filter
hasChatbotID(Chatbot, ID) :-
    getChatbotId(Chatbot, ID).

%MODIFICADOR
% Descripcion: Predicado para añadir un nuevo chatbot a un sistema creado.
% Dominio: Sistema X Chatbot X NuevoSistema.
% Metas Primarias: systemAddChatbot.
% Metas Secundarias: removeDuplicates, filterChatbot , append.
systemAddChatbot(Sistema, NuevoChatbot, NuevoSistema) :-
    getNombreSystem(Sistema, Nombre),
    getInitialChatbotCodeLinkSystem(Sistema, InitialChatbotCodeLink),
    getChatbotSystem(Sistema, Chatbots),
    getFechaSystem(Sistema,Fecha),
    % Filtrar chatbots con el mismo InitialChatbotCodeLink
    include(hasChatbotID(InitialChatbotCodeLink), Chatbots, FilteredChatbots),    
    % Verificar si NuevoChatbot ya está en el sistema
    \+ member(NuevoChatbot, FilteredChatbots),    
    % Agregar NuevoChatbot a la lista de chatbots
    append(FilteredChatbots, [NuevoChatbot], NuevosChatbots),    
    % Crear el nuevo sistema
    chatHistory(Nombre, InitialChatbotCodeLink, NuevosChatbots, [], [], [], Fecha, NuevoSistema).

% Verifica si un usuario ya existe en el sistema
userExists(NombreUsuario, Usuarios) :-
    member(usuario(NombreUsuario), Usuarios).

% Descripcion: Agrega un nuevo usuario al sistema si no existe previamente.
% Dominio: Sistema X NombreUsuario X NuevoSistema.
% Metas Primarias: addUserToSystem.
% Metas Secundarias: userExists, append,getFechaSystem,getChatbotSystem,getNombreSystem,getInitialChatbotCodeLinkSystem,chatHistory.
addUserToSystem(Sistema, NombreUsuario, NuevoSistema) :-
    getUsuariosSystem(Sistema, Usuarios),
    \+ userExists(NombreUsuario, Usuarios), % Verifica que el usuario no exista
    % Agrega el nuevo usuario al sistema
    append(Usuarios, [usuario(NombreUsuario)], NuevosUsuarios),
    % Crea el nuevo sistema
    getNombreSystem(Sistema, Nombre),
    getInitialChatbotCodeLinkSystem(Sistema, InitialChatbotCodeLink),
    getChatbotSystem(Sistema, Chatbot),
    getFechaSystem(Sistema,Fecha),
    getNuevosChatbotsSystem(Sistema,NuevosChatbots),
    chatHistory(Nombre, InitialChatbotCodeLink, Chatbot, NuevosChatbots, NuevosUsuarios, [], Fecha, NuevoSistema).


% Descripcion: Predicado que registra un usuario en un sistema.
% Dominio: Sistema X NombreUsuario X NuevoSistema.
% Metas Primarias: systemAddUser.
% Metas Secundarias: addUserToSystem.
systemAddUser(Sistema, NombreUsuario, NuevoSistema) :-
    addUserToSystem(Sistema, NombreUsuario, NuevoSistema), !.

% Descripcion: Predicado que registra un nuevo usuario en un sistema, Si el usuario ya existe, no se modifica el sistema.
% Dominio: Sistema X NombreUsuario X NuevoSistema.
% Metas Primarias: systemAddUser.
% Metas Secundarias:  systemAddUser , userExists.
systemAddUser(Sistema, NombreUser, Newsistema) :-
    userExists(NombreUsuario, Sistema).

% Descripcion: Predicado que realiza el inicio de sesión de un usuario en un sistema.
% Dominio: Sistema X NombreUsuario X NuevoSistema.
% Metas Primarias: systemLogin.
% Metas Secundarias: getUsuariosSystem , getChatbotSystem , getFechaSystem , getNombreSystem , UsuarioLogeado, usuario , ChatHistory.
systemLogin(Sistema, NombreUsuario, NuevoSistema) :- 
    getUsuariosSystem(Sistema, Usuarios),
    userExists(NombreUsuario, Usuarios), % Verifica que el usuario esté registrado
    % Verifica si ya hay un usuario logeado en el sistema
    \+ hasLoggedUser(Sistema),
    % Agrega el usuario logeado al sistema
    append(Usuarios, [usuariologeado(NombreUsuario)], NuevosUsuarios),
    % Crea el nuevo sistema con el usuario logeado
    getNombreSystem(Sistema, Nombre),
    getInitialChatbotCodeLinkSystem(Sistema, InitialChatbotCodeLink),
    getChatbotSystem(Sistema, Chatbot),
    getFechaSystem(Sistema, Fecha),
    getNuevosChatbotsSystem(Sistema, NuevosChatbots),
    chatHistory(Nombre, InitialChatbotCodeLink, Chatbot, NuevosChatbots, NuevosUsuarios, NombreUsuario, Fecha, NuevoSistema).

% Descripcion: Predicado que realiza el inicio de sesión de un usuario en un sistema, Si el usuario no está registrado o ya hay un usuario logeado, el sistema no cambia.
% Dominio: Sistema X NombreUsuario X NuevoSistema.
% Metas Primarias: systemLogin.
% Metas Secundarias: userExists.
systemLogin(Sistema, NombreUsuario, Sistema) :-
    \+ userExists(NombreUsuario, Sistema).

% Descripcion:Verifica si ya hay un usuario logeado en el sistema
% Dominio: Sistema
% Metas Primarias: hasLoggedUser.
% Metas Secundarias: getUsuarioLogeadoSystem,UsuarioLogeado.
hasLoggedUser(Sistema) :-
    getUsuarioLogeadoSystem(Sistema, UsuarioLogeado),
    UsuarioLogeado \= [].

% Descripcion: Predicado que realiza el cierre de sesión en un sistema.
% Dominio: Sistema X NuevoSistema.
% Metas Primarias: systemLogout.
% Metas Secundarias: hasLoggedUser,getUsuarioLogeadoSystem,subtractUsuarioLogeado.
systemLogout(Sistema, NuevoSistema) :-
    hasLoggedUser(Sistema), % Verifica si hay un usuario logeado
    getUsuarioLogeadoSystem(Sistema, UsuarioLogeado),  
    % Elimina al usuario logeado
    subtractUsuarioLogeado(Sistema, NuevoSistema).

% Descripcion: Predicado que realiza el cierre de sesión en un sistema, si no hay un usuario logeado, el sistema no cambia.
% Dominio: Sistema X NuevoSistema.
% Metas Primarias: systemLogout.
% Metas Secundarias: getUsuariosSystem,getNombreSystem,getChatbotSystem,getFechaSystem,getUsuarioLogeadoSystem,ChatHistory.
systemLogout(Sistema, Sistema) :-
    \+ hasLoggedUser(Sistema).

% Descripcion: Verifica si hay un usuario logeado en el sistema
% Dominio: Sistema
% Metas Primarias: hasLoggedUser.
% Metas Secundarias: getUsuarioLogeadoSystem,UsuarioLogeado.
hasLoggedUser(Sistema) :-
    getUsuarioLogeadoSystem(Sistema, UsuarioLogeado),
    UsuarioLogeado \= [].


% Descripcion: Resta al usuario logeado del sistema
% Dominio: Sistema.
% Metas Primarias: subtractUsuarioLogeado.
% Metas Secundarias: getUsuarioLogeadoSystem, subtract,usuariologeado.
subtractUsuarioLogeado([Nombre, InitialChatbotCodeLink, Chatbot, NuevosChatbots, Usuarios, _, Fecha], [Nombre, InitialChatbotCodeLink, Chatbot, NuevosChatbots, UsuariosSinLogeado, [], Fecha]) :-
    getUsuarioLogeadoSystem([Nombre, InitialChatbotCodeLink, Chatbot, NuevosChatbots, Usuarios, _, Fecha], _),
    subtract(Usuarios, [usuariologeado(_)], UsuariosSinLogeado).


%---------------------------------------------------------------------------------------

%SELECTORES
% Descripcion: Predicado que obtiene el Nombre de un sistema dado.
% Dominio: Sistema X Nombre.
% Metas Primarias: getNombreSystem.
% Metas Secundarias: System.
getNombreSystem(System, Nombre) :-
    System = [Nombre, _, _, _, _, _,_].

% Descripcion: Predicado que obtiene el InitialChatbotCodeLink de un sistema dado.
% Dominio: Sistema X InitialChatbotCodeLink.
% Metas Primarias: getInitialChatbotCodeLinkSystem.
% Metas Secundarias: System.
getInitialChatbotCodeLinkSystem(System, InitialChatbotCodeLink) :-
    System = [_, InitialChatbotCodeLink, _, _, _, _,_].

% Descripcion: Predicado que obtiene el Chatbot de un sistema dado.
% Dominio: Sistema X Chatbot.
% Metas Primarias: getChatbotSystem.
% Metas Secundarias: System.
getChatbotSystem(System, Chatbot) :-
    System = [_, _, Chatbot, _, _, _,_].

% Descripcion: Predicado que obtiene el Usuarios de un sistema dado.
% Dominio: Sistema X Usuarios.
% Metas Primarias: getUsuariosSystem.
% Metas Secundarias: System.
getUsuariosSystem(System, Usuarios) :-
    System = [_, _, _,_, Usuarios, _, _].

% Descripcion: Predicado que obtiene el UsuarioLogeado de un sistema dado.
% Dominio: Sistema X UsuarioLogeado.
% Metas Primarias: getUsuarioLogeadoSystem.
% Metas Secundarias: System.
getUsuarioLogeadoSystem(System, UsuarioLogeado) :-
    System = [_, _, _, _, _,UsuarioLogeado, _].

% Descripcion: Predicado que obtiene la Fecha de un sistema dado.
% Dominio: Sistema X Fecha.
% Metas Primarias: getFechaSystem.
% Metas Secundarias: System.
getFechaSystem(System, Fecha) :-
    System = [_, _, _, _, _, _,Fecha].

% Descripcion: Predicado que obtiene los chatbots añadidos del sistema.
% Dominio: Sistema X NuevosChatbots.
% Metas Primarias: getNuevosChatbotsSystem.
% Metas Secundarias: System.    
getNuevosChatbotsSystem(System,NuevoChatbots):-
    System=[_,_,_,NuevoChatbots,_,_,_].
   
%MODIFICADOR
% Descripcion: Predicado para cambiar el nombre del usuario dentro del sistema, basandonos en chatHistory.
% Dominio: Sistema X NuevoNombre X NuevoSistema.
% Metas Primarias: setNombreSystem.
% Metas Secundarias: System , NuevoSystem.
setNombreSystem(System, NuevoNombre, NuevoSystem) :-
    System = [_, InitialChatbotCodeLink, Chatbot,NuevoChatbots, Usuarios, UsuarioLogeado, Fecha],
    NuevoSystem = [NuevoNombre, InitialChatbotCodeLink, Chatbot,NuevoChatbots, Usuarios, UsuarioLogeado, Fecha].

% Descripcion: Predicado para cambiar el InitialChatbotCodeLink del usuario dentro del sistema, basandonos en chatHistory.
% Dominio: Sistema X NuevoInitialChatbotCodeLink X NuevoSistema.
% Metas Primarias: setInitialChatbotCodeLinkSystem.
% Metas Secundarias: System , NuevoSystem.
setInitialChatbotCodeLinkSystem(System, NuevoInitialChatbotCodeLink, NuevoSystem) :-
    System = [Nombre, _, Chatbot,NuevoChatbots, Usuarios, UsuarioLogeado, Fecha],
    NuevoSystem = [Nombre, NuevoInitialChatbotCodeLink, Chatbot,NuevoChatbots, Usuarios, UsuarioLogeado, Fecha].

% Descripcion: Predicado para cambiar el Chatbot del usuario dentro del sistema, basandonos en chatHistory.
% Dominio: Sistema X NuevoChatbot X NuevoSistema.
% Metas Primarias: setChatbotSystem.
% Metas Secundarias: System , NuevoSystem.
setChatbotSystem(System, NuevoChatbot, NuevoSystem) :-
    System = [Nombre, InitialChatbotCodeLink, _, NuevoChatbots,Usuarios, UsuarioLogeado, Fecha],
    NuevoSystem = [Nombre, InitialChatbotCodeLink, NuevoChatbot, NuevoChatbots,Usuarios, UsuarioLogeado, Fecha].

% Descripcion: Predicado para cambiar el Chatbot añadido del usuario dentro del sistema, basandonos en chatHistory.
% Dominio: Sistema X NuevoChatbots X NuevoSistema.
% Metas Primarias: setNuevoChatbotsSystem.
% Metas Secundarias: System , NuevoSystem.
setNuevoChatbotsSystem(System, NuevoChatbotss, NuevoSystem) :-
    System = [Nombre, InitialChatbotCodeLink, Chatbot, _,Usuarios, UsuarioLogeado, Fecha],
    NuevoSystem = [Nombre, InitialChatbotCodeLink, Chatbot, NuevoChatbotss,Usuarios, UsuarioLogeado, Fecha].

% Descripcion: Predicado para cambiar el Usuario del usuario dentro del sistema, basandonos en chatHistory.
% Dominio: Sistema X NuevoUsuarios X NuevoSistema.
% Metas Primarias: setUsuariosSystem.
% Metas Secundarias: System , NuevoSystem.
setUsuariosSystem(System, NuevosUsuarios, NuevoSystem) :-
    System = [Nombre, InitialChatbotCodeLink, Chatbot, NuevoChatbots,_, UsuarioLogeado, Fecha],
    NuevoSystem = [Nombre, InitialChatbotCodeLink, Chatbot, NuevoChatbots,NuevosUsuarios, UsuarioLogeado, Fecha].

% Descripcion: Predicado para cambiar el UsuarioLogeado del usuario dentro del sistema, basandonos en chatHistory.
% Dominio: Sistema X NuevoUsuarioLogeado X NuevoSistema.
% Metas Primarias: setUsuarioLogeadoSystem.
% Metas Secundarias: System , NuevoSystem.
setUsuarioLogeadoSystem(System, NuevoUsuarioLogeado, NuevoSystem) :-
    System = [Nombre, InitialChatbotCodeLink, Chatbot, NuevoChatbots,Usuarios, _, Fecha],
    NuevoSystem = [Nombre, InitialChatbotCodeLink, Chatbot,NuevoChatbots, Usuarios, NuevoUsuarioLogeado, Fecha].

% Descripcion: Predicado para cambiar la Fecha del usuario dentro del sistema, basandonos en chatHistory.
% Dominio: Sistema X NuevaFecha X NuevoSistema.
% Metas Primarias: setFechaSystem.
% Metas Secundarias: System , NuevoSystem.
setFechaSystem(System, NuevaFecha, NuevoSystem) :-
    System = [Nombre, InitialChatbotCodeLink, Chatbot, NuevoChatbots,Usuarios, UsuarioLogeado, _],
    NuevoSystem = [Nombre, InitialChatbotCodeLink, Chatbot, NuevoChatbots,Usuarios, UsuarioLogeado, NuevaFecha].
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

