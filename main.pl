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

%Option
%Dominio: code (int) x message (string) x Chatbotcodelink (int) x initialflowcodelink (int) x keywords (list) x option
%Recorrido: list
%Recursión: Natural 
%Resumen : TDA constructor de opciones
option(CODIGO, MENSAJE, CHATBOTCODELINK, INITIALFLOWCODELINK,KEYWORDS, LISTASALIDA):-
	LISTASALIDA = [CODIGO, MENSAJE, CHATBOTCODELINK, INITIALFLOWCODELINK,KEYWORDS],!.

%flow
%Dominio: id (int) x name-msg (string) x option
%Recorrido: list
%Recursión: Natural
%Resumen: TDA constructor de flujos de un chatbot
flow(ID, MENSAJE, OPCIONES, FLOW) :-
    filterOptions(ID, OPCIONES, FilteredOptions),
    removeDuplicates(FilteredOptions, UniqueOptions),
    FLOW = [ID, MENSAJE, UniqueOptions],
   !.

%filterOptions
%Dominio : id (int) x opciones (list) x listafiltrada (list)
%Recorrido: list
%Recursión: Cola
%Resumen: Predicado auxiliar para filtrar opciones por flujo igual al id
%caso base
filterOptions(_, [], []) :- !.
filterOptions(ID, [Option|RestOptions], FilteredOptions) :-
    option(CODIGO, MENSAJE, CHATBOTCODELINK, INITIALFLOWCODELINK, KEYWORDS, Option),
    (INITIALFLOWCODELINK = ID -> FilteredOptions = [Option|RestFilteredOptions] ; FilteredOptions = RestFilteredOptions),
    filterOptions(ID, RestOptions, RestFilteredOptions).

%Remover Duplicados
%Dominio: list x list
%Recorrido: list
%Recursión: No hay
%Resumen: Predicado auxiliar para remover duplicados de una lista
removeDuplicates([], []).
removeDuplicates([X | Xs], Ys) :-
    member(X, Xs),
    removeDuplicates(Xs, Ys).
removeDuplicates([X | Xs], [X | Ys]) :-
    \+ member(X, Xs),
    removeDuplicates(Xs, Ys).

%FlowAddOption
%Dominio: flow (list) x option (list) x flow (list)
%Recorrido: list
%Recursión: Cola
%Resumen: Predicado modificador para añadir opciones a un flujo
flowAddOption(FLOW, OPCIONES, FLUJOSALIDA) :-
    addOptionsToFlow(FLOW, OPCIONES,[] ,FLUJOSALIDA).

%addOptionsToFlow
%Dominio: Flow (list) x Opciones (list) x listaAuxiliar (list) x listsalida (list)
%Recorrido: list
%Recursión: Cola
%Resumen: Predicado auxiliar que me permite verificar opciones y flujos invirtiendo y comparando
addOptionsToFlow([], _, Acc, FLUJOSALIDA) :-
    reverse(Acc, FLUJOSALIDA). % Invertimos la lista acumulada para obtener el resultado final.
addOptionsToFlow([FlowOption | RestFlow], OPCIONES, Acc, FLUJOSALIDA) :-
    % Verificamos si la opción ya existe en el flujo actual
    member(FlowOption, OPCIONES),
    % Continuamos con el siguiente flujo
    addOptionsToFlow(RestFlow, OPCIONES, Acc, FLUJOSALIDA).
addOptionsToFlow([FlowOption | RestFlow], OPCIONES, Acc, FLUJOSALIDA) :-
    % La opción no existe en el flujo, la agregamos al acumulador
    addOptionsToFlow(RestFlow, OPCIONES, [FlowOption | Acc], FLUJOSALIDA).










% Ejemplos de option
%option(1, "1 - viajar", 2, 4, ["viajar", "turistear", "conocer"], O1).
%option(2, "2 - estudiar", 4, 3, ["aprender", "perfeccionarme"], O2).

% Ejemplo de flujo con opciones válidas
%flow(3, "Flujo 3: mensaje de prueba", [O1, O1 , O2], F2). 

% Ejemplo de flujo con una opción no generada por option/6
%flow(4, "Flujo 4: mensaje de prueba", [O1, O23 , O3], F4). 

%option(1, "1 - viajar", 2, 4, ["viajar", "turistear", "conocer"], O1).
%option(2, "2 - estudiar", 4, 3, ["aprender", "perfeccionarme"], O2).
%flow(3, "Flujo 3: mensaje de prueba", [O1, O2 , O4], F2). 

%option(1, "1 - viajar", 2, 4, ["viajar", "turistear", "conocer"], O1).
%option(2, "2 - estudiar", 4, 3, ["aprender", "perfeccionarme"], O2).


%flow(3, "Flujo 3: mensaje de prueba", [O1, O2 , O4], F2). 
%flow(3, "Flujo 3: mensaje de prueba", [O1, O2], F2). 


option(1, "1 - viajar", 2, 4, ["viajar", "turistear", "conocer"], O1),
option(2, "2 - estudiar", 4, 3, ["aprender", "perfeccionarme"], O2),
flow(3, "Flujo 3: mensaje de prueba", [O1, O2], F2). 