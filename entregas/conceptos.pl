
% Nombre: Gonzalo Ulloa

% Parte 1: Representar Enunciados como Hechos
% Predicados
pelicula(inception, ciencia_ficcion).
actor(leonardo_dicaprio, inception).
director(christopher_nolan, inception).
actor(tom_hanks, forrest_gump).
pelicula(forrest_gump, drama).
director(steven_spielberg, jurassic_park).
pelicula(jurassic_park, aventura).

% 5 hechos mas
pelicula(nueve_reinas, thriller).
actor(ricardo_darin, nueve_reinas).
director(fabian_bielinsky, nueve_reinas).

pelicula(el_secreto_de_sus_ojos, drama).
actor(ricardo_darin, el_secreto_de_sus_ojos).
director(juan_jose_campanella, el_secreto_de_sus_ojos).

pelicula(relatos_salvajes, comedia_negra).
actor(ricardo_darin, relatos_salvajes).
director(damian_szifron, relatos_salvajes).

pelicula(esperando_la_carrosa, comedia_negra).
actor(antonio_gasalla, esperando_la_carrosa).
actor(luis_brandoni, esperando_la_carrosa).
director(alejandro_doria, esperando_la_carrosa).

pelicula(argentina_1985, drama_judicial).
actor(ricardo_darin, argentina_1985).
director(santiago_mitre, argentina_1985).

% Parte 2: Consultas sobre Hechos

% An�lisis: prolog resuelve consultas unificando variables con hechos en
% orden secuencial (de arriba abajo). Si hay varias coincidencias usa
% " backtracking" para encontrar todas las soluciones
% "El acto de reconsidera una elecci�n previa es llamado �backtracking�. El backtracking es implementado en PROLOG por pilas. Lo importante es que si existen varias posibles respuestas para una consulta, PROLOG con el backtracking encuentra a todas"
% Si no hay coincidencia devuelve 'false'.

% a) �Cu�les pel�culas dirige Christopher Nolan?
% Consulta: ?- director(christopher_nolan, TituloPelicula).
% Resultados: TituloPelicula = inception ; false.
% Explicaci�n: unifica el primer argumento con 'christopher_nolan' en
% los hechos de director. Solo encuentra 'inception'
%
% b) �Cu�les actores act�an en pel�culas de ciencia ficci�n?
% Consulta: ?- pelicula(TituloPelicula, ciencia_ficcion), actor(NombreActor, TituloPelicula).
%resultados: TituloPelicula = inception, NombreActor=leonardo_dicaprio ; false.
%explicaci�n: Primero unifica pelicula(T,ciencia_ficcion) -> T=inception.
% despues unifica actor(A, inception) -> A = leonardo_dicaprio.
% si hubiera m�s pel�culas de ciencia ficcion o actores backtrackearia
% para encontrarlas.

% c) Lista todas las pel�culas y sus g�neros.
% Consulta: ?- pelicula(TituloPelicula, Genero).
% Resultados: Va mostrando pares como inception/ciencia_ficcion, forrest_gump/drama y as� con todas las pel�culas hasta que termina con false.
% Explicaci�n: Unifica variables con todos los hechos de pelicula en
% orden, el backtracking recorre toda la base de ehchos

% d) �Hay alg�n actor que act�e en Inception y en otra pel�cula?
% Consulta: ?- actor(NombreActor, inception), actor(NombreActor, OtraPelicula), OtraPelicula \= inception.
% Resultado: false.
%
% Agrego 2 consultas propias similares:
% e) �Cu�les pel�culas argentinas act�a Ricardo Dar�n?
% Consulta: ?- actor(ricardo_darin, TituloPelicula).
% Res: TituloPelicula = nueve_reinas ; TituloPelicula = el_secreto_de_sus_ojos ; TituloPelicula = relatos_salvajes ; TituloPelicula = argentina_1985 ; false.

% exp: busca todos los hechos donde ricardo_darin aparece como actor,
% unificando TituloPelicula con cada pel�cula en la que act�a.

% f) �Qui�n dirige Relatos Salvajes?
% Consulta: ?- director(NombreDirector, relatos_salvajes).
% res: NombreDirector = damian_szifron ; false.

% exp:  unifica NombreDirector con el director asociado al hecho
% de relatos_salvajes, encuentra a damian_szifron y a nadie mas
%
%Parte 3:
% Definir Reglas
%
% a) actua_en_genero(NombreActor, Genero): verdadero si el actor act�a
% en una pel�cula de ese g�nero.
%
actua_en_genero(NombreActor, Genero) :- actor(NombreActor, TituloPelicula), pelicula(TituloPelicula, Genero).
%prueba: ?- actua_en_genero(ricardo_darin, Genero).
%res:
% Genero = thriller ;
% Genero = drama ;
% Genero = comedia_negra ;
% Genero = drama_judicial.
% explicaci�n: encuentra las pel�culas de Darin despues sus generos
% backtracking para m�ltiples pel�culas

% b) colaboracion(NombreActor1, NombreActor2): verdadero si dos actores
% act�an en la misma pel�cula y sean distintos
%
colaboracion(NombreActor1, NombreActor2) :- actor(NombreActor1, TituloPelicula), actor(NombreActor2, TituloPelicula), NombreActor1 \= NombreActor2.
% Prueba: ?- colaboracion(antonio_gasalla, OtroActor).
% resultado: OtroActor = luis_brandoni. ; false
%exp:
% encuentra pel�culas de Actor1 despues actores en esa pel�cula
%
% c) director_de_genero(NombreDirector, Genero): verdadero si el
%director dirige una pel�cula de ese g�nero
director_de_genero(NombreDirector, Genero) :- director(NombreDirector, TituloPelicula), pelicula(TituloPelicula, Genero).
% prueba: ?- director_de_genero(christopher_nolan, Genero).
% resultados: Genero = ciencia_ficcion ; false.
% explicaci�n: funciona igual al punto a) pero con directores

% d) pelicula_con_colaboracion(TituloPelicula): verdadero si una
% pel�cula tiene al menos dos actores distintos
%
pelicula_con_colaboracion(TituloPelicula) :- actor(Actor1, TituloPelicula), actor(Actor2, TituloPelicula), Actor1 \= Actor2.
% prueba: ?- pelicula_con_colaboracion(esperando_la_carrosa).
% resultados: true (por gasalla y brandoni);
%para una sin colaboraci�n: false.
%explicaci�n: Busca dos actores distintos en la pel�cula.
%falla si solo hay uno o ninguno.

% Agrego una regla propia: es_famosa(TituloPelicula) si tiene un director y al menos un actor.
es_famosa(TituloPelicula) :- director(_, TituloPelicula), actor(_, TituloPelicula).
% prueba: ?- es_famosa(inception).
% resultado: true.
% explicaci�n: chequea existencia de director y actor para la pel�cula
%
%

% Parte 4: An�lisis y Extensi�n

% 1. Explica en 1-2 p�rrafos c�mo Prolog resuelve una consulta compleja de la Parte 2 (Ej., chaining en b), incluyendo unificaci�n
% (matching de variables) y backtracking (prueba de soluciones alternativas).
%
%
% Para la consulta b: ?- pelicula(TituloPelicula, ciencia_ficcion), actor(NombreActor, TituloPelicula).
%
%
% prolog resuelve de izquierda a derecha (chaining).
% primero unifica 'pelicula(T, ciencia_ficcion)' con hechos: encuentra
% T=inception (el �nico matching). liga T a 'inception'.
%
% pasa al segundo subobjetivo: unifica 'actor(A, inception)' con hechos liga A a 'leonardo_dicaprio'. Muestra la soluci�n. Si presiono ';',
% backtrackea: intenta otro match para el segundo subobjetivo (si hay m�s actores en Inception) pero no hay; entonces backtrackea al
% primero, busca otra pel�cula ciencia ficcion (no hay) y falla (false).
%
% 2. Extiende la base: Agrega hechos sobre sexo de actores
% (sexo(NombreActor, masculino/femenino)).
%
% Agrego actriz
actor(kate_winslet, titanic).

sexo(leonardo_dicaprio, masculino).
sexo(tom_hanks, masculino).
sexo(ricardo_darin, masculino).
sexo(antonio_gasalla, masculino).
sexo(kate_winslet, femenino).

% define una regla como
%actriz_en_pelicula(NombreActriz, TituloPelicula)
%
actriz_en_pelicula(NombreActriz, TituloPelicula) :- actor(NombreActriz, TituloPelicula), sexo(NombreActriz, femenino).
% prueba: ?- actriz_en_pelicula(NombreActriz, titanic).
% resultado: NombreActriz = kate_winslet ; false.
% explicaci�n: filtra a actores por sexo femenino
