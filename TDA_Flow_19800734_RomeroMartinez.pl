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

%IMPORTACIONES DE ARCHIVOS (ambas formas son equivalentes).
%:-use_module(tda_option_19800734_RomeroMartinez,[option/6]).
:-include(tda_Option_19800734_RomeroMartinez).

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
