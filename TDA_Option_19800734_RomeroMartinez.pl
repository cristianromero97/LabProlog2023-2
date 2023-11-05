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

%:-module(tda_Option_19800734_RomeroMartinez,[option/6]).

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
