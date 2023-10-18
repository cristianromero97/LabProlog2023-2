

option(CODIGO, MENSAJE, CHATBOTCODELINK, INITIALFLOWCODELINK,KEYWORDS, LISTASALIDA):-
	LISTASALIDA = [CODIGO, MENSAJE, CHATBOTCODELINK, INITIALFLOWCODELINK,KEYWORDS],!.



flow(ID, MENSAJE, OPCIONES, FLOW) :-
    %%option(1, "1 - viajar", 2, 4, ["viajar", "turistear", "conocer"], O1),
    %%option(2, "2 - estudiar", 4, 3, ["aprender", "perfeccionarme"], O2),
    FLOW = [ID, MENSAJE, OPCIONES],!.

flow(_,_,_,_) :-
    option(CODIGO, MENSAJE, CHATBOTCODELINK, INITIALFLOWCODELINK, KEYWORDS, [CODIGO, MENSAJE, CHATBOTCODELINK, INITIALFLOWCODELINK, KEYWORDS]).
    










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