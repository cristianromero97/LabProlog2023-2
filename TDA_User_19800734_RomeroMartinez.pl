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

%:- module(tda_user_19800734_RomeroMartinez, [usuario/2, addUserToUsers/3,getUsuarios/2,getNombreUsuario/2,setNombreUsuario/2,addUsuario/3]).

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
