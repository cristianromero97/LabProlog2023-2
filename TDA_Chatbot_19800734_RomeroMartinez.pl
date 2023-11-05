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

%IMPORTACIONES DE ARCHIVOS (ambas formas son equivalentes).
% :-use_module(tda_Option_19800734_RomeroMartinez,[option/6]).
% :-use_module(tda_Flow_19800734_RomeroMartinez,[flow/4,removeDuplicates/2]).
% :-include(tda_Option_19800734_RomeroMartinez).
:-include(tda_Flow_19800734_RomeroMartinez).

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