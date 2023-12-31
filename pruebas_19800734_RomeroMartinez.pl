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

% IMPORTACION 
%Atencion: Todas estas importaciones en caso de que fallen o no se puedan ejecutar, ir al archivo main o general y probar los ejemplos alli.
%tda_system al llamar a todos los demas tambien funciona.
%Ambos archivos son validos
%:-include(main_19800734_RomeroMartinez). %Todos los archivos funcionan, es decir, son equivalentes
:-include(general_19800734_RomeroMartinez).
%:-include(tda_system_19800734_RomeroMartinez).
%:-consult("main_19800734_RomeroMartinez.pl").  %Para consultas, sino funciona dicho comando ir al archivo main, copiar y pegar los scripts de pruebas y ejemplos alli 
%:-consult("general_19800734_RomeroMartinez.pl"). %Lo mismo en caso de que no funcione dicho comando.

% INSTRUCCIONES INICIALES
%El siguiente programa contiene los Script N1 y N2 del laboratorio Scheme adaptados a su formato Prolog
%Para ello existe una version personal y la version final entregada por el profesor
%Ambas versiones tienen algunos ajustes para permitirle un mejor funcionamiento segun mi implementacion
%Ademas se entregaran 3 ejemplos para cada TDA al igual que el Pruebas anterior

% READAPTANDO CODIGOS DE SCHEME A SU VERSION PROLOG

%SCRIPT DE PRUEBAS Nº1 LABORTARIO DE SCHEME ADAPTADO A PROLOG
%Adapte un poco este script para hacer funcionar mi implementacion
%He dejado algunas cuantas instrucciones comentadas a lo largo de la implementacion
%Favor de seguir al pie de la letra dichas instrucciones
%Para el caso de system, puede surgir un error en sistemas Windows debido a la implementacion de mi_fecha
%Dicho error es aislado y no ocure en otros entornos como SWI-Prolog online, mac o linux.
%Esta es una readaptacion personal el script entregado por el profesor se encuentra mas abajo 
%Tomese esto como un ejemplo en conjunto

option(1,"1 - viajar",2 , 4 , ["viajar","turistear","conocer"],O1),
option(2,"2 - estudiar", 3 , 1 ,["estudiar","aprender","perfeccionarme"],O2),
flow(1,"Flujo 1 : Mensaje de prueba",[O1, O2 , O2 , O2 ,O1],F10),
flowAddOption(F10,O1,F11),
chatbot(0,"Inicial","Bienvenido\n¿Que te gustaria hacer?",1,[F10,F10,F10],CB0),
system("Chatbots Paradigmas",0,[CB0],S0),
systemAddChatbot(S0,CB0,S100),  % Para no generar errores con lo demas se utiliza una salida que no afecte al siguiente codigo
systemAddUser(S0,"user1",S1),
systemAddUser(S1,"user2",S2),
%systemAddUser(S2,"user2",S3), %saltara false porque se repite el usuario
systemAddUser(S2,"user3",S3),
systemLogin(S3,"user3",S4),
systemLogout(S4,S5),
%systemAddUser(S5,"user2",S6), %saltara false porque ya se añadio el usuario
systemLogin(S5,"user2",S6),
systemLogout(S6,S7),
%systemAddUser(S7,"user1",S8), %saltara false porque ya se añadio el usuario
systemLogin(S7,"user1",S8),
systemLogout(S8,S9).

%systemAddUser(S0,"user99",S2), %añadiendo otro usario  
%systemLogin(S3,"user8",S4), %Esto saldra false, ya que no es el mismo usuario de la funcion anterior

%SCRIPT DE PRUEBAS Nº2 LABORATORIO SCHEME ADAPATADO A PROLOG
%Adapte un poco este script para hacer funciona mi implementacion
%Esta es una adapatacion personal, puede diferir con respecto a la implementacion del profesor
%Tomese como ejemplo en conjunto

%chatbot 0
option(1, "1 - viajar", 1 , 1 ,["viajar","turistear","conocer"],O1),
option(2, "2 - estudiar", 2 , 1 ,["estudiar","aprender","perfeccionarme"],O2),
flow(1,"Flujo Principal Chatbot\n Bienvenido ¿Que te gustaria hacer?",[O1,O2,O1,O1,O2],F10),
flowAddOption(F10,O1,F11),
chatbot(0,"Inicial","Bienvenido\n ¿Que te gustaria hacer?",1,[F10,F10],CB0),

%chatbot 1

option(3, "1 - New York,USA",1,2,["USA","Estados Unidos","New York"],O3),
option(4, "2 - Paris,Francia",1,1,["Paris","Eifel"],O4),
option(5, "3 - Torres del Paine,Chile",1,1,["Torres","Paine","Chile","Torres del paine"],O5),
option(4, "4 - Volver", 0 ,1 , ["Regresar","Salir","Volver"],O6),

%Opciones segundo flujo Chatbot1
option(1,"1 - Central Park",1,2,["Central Park","Central Park"],O7),
option(2,"2 - Museos",1,2,["Museo"],O8),
option(3,"3 - Ningun otro atractivo",1,3,["Museo"],O9),
option(4,"4 - Cambiar destino",1,1,["Cambiar","Volver","Salir"],O10),
option(1,"1 - Solo",1,3,["Solo"],O11),
option(2,"2 - En pareja",1,3,["Pareja"],O12),
option(3,"3 - En familia",1,3,["Familia"],O13),
option(4,"4 - Agregar mas atractivos",1,2,["Volver","Atractivos"],O14),
option(5,"5 - En realidad quiero otro destino",1,1,["Cambiar destino"],O15),
flow(1,"Flujo 1 Chatbot1\n ¿Donde te gustaria ir?",[O3,O4,O5,O6],F20),
flow(2,"Flujo 2 Chatbot1\n ¿Que atractivos te gustaria visitar?",[O7,O8,O9,O10],F21),
flow(3,"Flujo 3 Chatbot1\n ¿Vas solo o acompañado",[O11,O12,O13,O14,O15],F22),
chatbot(1,"Agencia Viajes","Bienvenido\n ¿Donde quieres viajar?",1,[F20,F21,F22],CB1),

%chatbot 2

option(1,"1 - Carrera Tecnica",2,1,["Tecnica"],O16),
option(2,"2 - Postgrado",2,1,["Doctorado","Magister","Postgrado"],O17),
option(3,"3 - Volver",0,1,["Volver","Salir","Regresar"],O18),
flow(1,"Flujo 1 Chatbot2\n ¿Que te gustaria estudiar?",[O16,O17,O18],F30),
chatbot(2,"Orientador Academico","Bienvenido\n ¿Que te gustaria estudiar?",1,[F30],CB2),

%Sistema
%En este aspecto del codigo he puesto varios comentarios para poder usar correctamente los adduser, login y logout

system("Chatbots Paradigmas",0,[CB0,CB0,CB1,CB2],S0),
systemAddChatbot(S0,CB0,S99), 
systemAddUser(S0,"user1",S1),   
systemAddUser(S1,"user2",S2),
$systemAddUser(S2,"user2",S3), %saltara un false, ya que se repite el usuario
systemAddUser(S2,"user3",S5),
%systemLogin(S5,"user8",S6), %saltara un false, no esta registrado y no es igual al valor antes indicado en adduser
systemLogin(S5,"user1",S6), %Para que funcione el valor del usuario debe ser igual al ultimo valor registrado por addUser
systemLogin(S6,"user3",S7), 
systemLogin(S7,"user2",S8),
%systemLogin(S7,"user2",S8), %Dara el resultado debido a que es el mismo valor que el anterior, como es repetido queria ver que pasaba
systemLogout(S8,S9).


%Aparpatado de Ejemplos Extra
%En esta seccion se encuentran otros ejemplos fuera de los Scripts de pruebas.
%Ejemplos de Opciones 
option(1,"1 - Comer",2,3,["Alimentarse","Comer","Almorzar"],O95),
option(2,"2 - Beber",2,3,["Tomar","Beber"],O96),
option(3,"3 - Ambas",2,3,["Ambas respuestas"],O97),
%Ejemplos de flujos
flow(3,"Flujo 1 ¿Que actividad quieres hacer?",[O95,O96,O97],F095),
flow(3,"Flujo 2 ¿Que prefieres",[O95],F096),
flow(3,"Flujo 3 ¿Que no prefiereres?",[O96],F097),
flowAddOption(F097,O95,F000),
flowAddOption(F097,O96,F001),
flowAddOption(FO96,O97,F002),
%Ejemplos de Chatbots
chatbot(1,"Chatbot 1 Electivo","Bienvenido ¿Que actividad prefieres?",3,[F095],CB001),
chatbot(1,"Chatbot 2 Electivo","Bienvenido ¿Que actividad prefieres?",3,[F096],CB002),
chatbot(1,"Chatbot 3 Electivo","Bienvenido ¿Que actividad prefieres?",3,[F095,F096],CB003),
chatbotAddFlow(CB001,F096,CBC11), 
chatbotAddFlow(CB002,F095,CBC12),
chatbotAddFlow(CB003,F096,CBC13),
%Ejemplos de system
system("Chatbot electivo de actividades random",1,[CB001],S10001),
system("Chatbot electivo de actividades random",1,[CB002],S10002),
system("Chatbot electivo de actividades random",1,[CB003],S10003),
%Ejemplos AddUser, login , logout.
systemAddUser(S10001,"user1",S99),
systemLogin(S99,"user1",S100),
systemLogout(S100,S101),
systemAddUser(S101,"user2",S102),
systemLogin(S102,"user2",S103),
systemLogout(S103,S104),
systemAddUser(S104,"user3",S105),
systemLogin(S105,"user3",S106),
systemLogout(S106,S107),
systemAddUser(S107,"user99",S200). %La idea se vuelve a repetir si se desea ingresar otros usuarios.


%SCRIPT N1 DE PRUEBAS 
%he realizado algunos ajustes, para que pueda implementarse correctamente, sobre todo a la parte de adduser, login y logout
%Ademas hay una adaptacion personal que he realizado, readaptando el codigo scheme a prolog, puede diferir de este codigo

option(1, "1) Viajar", 2, 1, ["viajar", "turistear", "conocer"], OP1),
option(2, "2) Estudiar", 2, 1, ["estudiar", "aprender", "perfeccionarme"], OP2),
option(3, "3) Comer", 2, 1, ["comer", "aprender"], OP3),
flow(1, "flujo1", [OP1, OP2], F10),
flowAddOption(F10, OP3, F11),
%flowAddOption(F10, OP2, F12), %si esto se descomenta, debe dar false, porque es opción con id duplicada.
chatbot(0, "Inicial", "Bienvenido\n¿Qué te gustaría hacer?", 1, [F11], CB0), %solo añade una ocurrencia de F11
system("Chatbots Paradigmas", 0, [CB0], S0),
%systemAddChatbot(S0, CB0, S1), %si esto se descomenta, debe dar false, porque es chatbot id duplicado.
systemAddUser(S0, "user1", S2),
systemAddUser(S2, "user2", S3),
%systemAddUser(S3, "user2", S4), %si esto se descomenta, debe dar false, porque es username duplicado
systemAddUser(S3, "user3", S5),
%systemLogin(S5, "user8", S6), %si esto se descomenta, debe dar false ;user8 no existe.
systemLogin(S5, "user1", S7),
%systemLogin(S7, "user2", S8), %si esto se descomenta, debe dar false, ya hay usuario con login
systemLogout(S7, S9),
systemLogin(S9, "user2", S10).


%SCRIPT N1 DE PRUEBAS VERSION DEFINITIVA

option(1, "1) Viajar", 2, 1, ["viajar", "turistear", "conocer"], OP1),
option(2, "2) Estudiar", 2, 1, ["estudiar", "aprender", "perfeccionarme"], OP2),
flow(1, "flujo1", [OP1], F10),
flowAddOption(F10, OP2, F11),
% flowAddOption(F10, OP1, F12), %si esto se descomenta, debe dar false, porque es opción con id duplicada.
chatbot(0, "Inicial", "Bienvenido\n¿Qué te gustaría hacer?", 1, [F11], CB0), %solo añade una ocurrencia de F11
%Chatbot1
option(1, "1) New York, USA", 1, 2, ["USA", "Estados Unidos", "New York"], OP3),
option(2, "2) París, Francia", 1, 1, ["Paris", "Eiffel"], OP4),
option(3, "3) Torres del Paine, Chile", 1, 1, ["Chile", "Torres", "Paine", "Torres Paine", "Torres del Paine"], OP5),
option(4, "4) Volver", 0, 1, ["Regresar", "Salir", "Volver"], OP6),
%Opciones segundo flujo Chatbot1
option(1, "1) Central Park", 1, 2, ["Central", "Park", "Central Park"], OP7),
option(2, "2) Museos", 1, 2, ["Museo"], OP8),
option(3, "3) Ningún otro atractivo", 1, 3, ["Museo"], OP9),
option(4, "4) Cambiar destino", 1, 1, ["Cambiar", "Volver", "Salir"], OP10),
option(1, "1) Solo", 1, 3, ["Solo"], OP11),
option(2, "2) En pareja", 1, 3, ["Pareja"], OP12),
option(3, "3) En familia", 1, 3, ["Familia"], OP13),
option(4, "4) Agregar más atractivos", 1, 2, ["Volver", "Atractivos"], OP14),
option(5, "5) En realidad quiero otro destino", 1, 1, ["Cambiar destino"], OP15),
flow(1, "Flujo 1 Chatbot1\n¿Dónde te Gustaría ir?", [OP3, OP4, OP5, OP6], F20),
flow(2, "Flujo 2 Chatbot1\n¿Qué atractivos te gustaría visitar?", [OP7, OP8, OP9, OP10], F21),
flow(3, "Flujo 3 Chatbot1\n¿Vas solo o acompañado?", [OP11, OP12, OP13, OP14, OP15], F22),
chatbot(1, "Agencia Viajes",  "Bienvenido\n¿Dónde quieres viajar?", 1, [F20, F21, F22], CB1),
%Chatbot2
option(1, "1) Carrera Técnica", 2, 1, ["Técnica"], OP16),
option(2, "2) Postgrado", 2, 1, ["Doctorado", "Magister", "Postgrado"], OP17),
option(3, "3) Volver", 0, 1, ["Volver", "Salir", "Regresar"], OP18),
flow(1, "Flujo 1 Chatbot2\n¿Qué te gustaría estudiar?", [OP16, OP17, OP18], F30),
chatbot(2, "Orientador Académico",  "Bienvenido\n¿Qué te gustaría estudiar?", 1, [F30], CB2),
system("Chatbots Paradigmas", 0, [CB0], S0),
% systemAddChatbot(S0, CB0, S1), %si esto se descomenta, debe dar false, porque es chatbot id duplicado.
systemAddChatbot(S0, CB1, S01),
systemAddChatbot(S01, CB2, S02),
systemAddUser(S02, "user1", S2),
systemAddUser(S2, "user2", S3),
% systemAddUser(S3, "user2", S4), %si esto se descomenta, debe dar false, porque es username duplicado
systemAddUser(S3, "user3", S5),
% systemLogin(S5, "user8", S6), %si esto se descomenta, debe dar false ;user8 no existe.
systemLogin(S5, "user1", S7),
% systemLogin(S7, "user2", S8), %si esto se descomenta, debe dar false, ya hay usuario con login
systemLogout(S7, S9),
systemLogin(S9, "user2", S10).
%systemTalkRec(S10, "hola", S11), %las comento porque no estan implementadas
%systemTalkRec(S11, "1", S12),
%systemTalkRec(S12, "1", S13),
%systemTalkRec(S13, "Museo", S14),
%systemTalkRec(S14, "1", S15),
%systemTalkRec(S15, "3", S16),
%systemTalkRec(S16, "5", S17),
%systemSynthesis(S17, "user2", Str1),
%systemSimulate(S02, 5, 32131, S99)
