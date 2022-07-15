mesa( [carta(7,oro), carta(3, copa), carta(1,oro)]).
enMano( jugador1, [carta(sota, copa), carta(5, basto),carta(5, copa)]).
enMano( jugador2, [carta(rey, copa), carta(4, espada)]).
enMano( jugador3, [carta(2, copa), carta(3, espada)]).

tieneCarta(Jugador,Carta):-
    enMano( Jugador, Cartas),
    member(Carta,Cartas).

puntos(carta(N,_),N):-number(N),between(1,7,N).
puntos(carta(sota,_),8).
puntos(carta(caballo,_),9).
puntos(carta(rey,_),10).

suma15(Cartas):-
    findall(Puntaje,(member(Carta,Cartas),puntos(Carta,Puntaje)),Puntajes),
    sumlist(Puntajes,15).

puedeLevantar(Carta,CartasMesa,CartasLevanta):-
    sublista(CartasMesa,CartasLevanta),
    suma15([Carta|CartasLevanta]).

agregar(Elemento,Lista,[Elemento|Lista]).

sublista([],[]).
sublista([_|Cola],Sublista):-
    sublista(Cola,Sublista).
sublista([Cabeza|Cola],[Cabeza|Sublista]):-
    sublista(Cola,Sublista).


% Una versión. 

haceJugada(Jugador,Jugada):-
    mesa(CartasMesa),
    enMano(Jugador,_),
    jugadaElegida(Jugador,CartasMesa,Jugada).

jugadaElegida(Jugador,CartasMesa,tira(CartaTirada)):-
    not((tieneCarta(Jugador,Carta),puedeLevantar(Carta,CartasMesa,_))),
    tieneCarta(Jugador,CartaTirada).

jugadaElegida(Jugador,CartasMesa,levanta(Carta,CartasLevanta)):-
    not(jugadaElegida(Jugador,CartasMesa,escoba(_,_))),
    tieneCarta(Jugador,Carta),
    puedeLevantar(Carta,CartasMesa,CartasLevanta),
    forall((tieneCarta(Jugador,OtraCarta),puedeLevantar(OtraCarta,CartasMesa,OtrasCartas)), not(sonMejores(OtrasCartas, CartasLevanta))).

jugadaElegida(Jugador,CartasMesa,escoba(Carta,CartasMesa)):-
    tieneCarta(Jugador,Carta),suma15([Carta|CartasMesa]).

sonMejores(Cartas1, Cartas2):-
    length(Cartas1, Cant1),
    length(Cartas2, Cant2),
    Cant1 > Cant2.
    

% Otra versión. 
% Releyendo consigna, de las jugadas posibles que podria hacer con cada carta, un jugador elige la mejor.

haceJugada2(Jugador,Jugada):-
    jugadaPosible(Jugador,Jugada),
    forall(
        jugadaPosible(Jugador,OtraJugada),
        esMejorJugada(Jugada,OtraJugada)
    ).

esMejorJugada(escoba(_,_)       , _                 ).
esMejorJugada( _                , tira(_)           ).
esMejorJugada(levanta(_,Cartas1), levanta(_,Cartas2)):- 
    not(sonMejores(Cartas2,Cartas1)).

jugadaPosible(Jugador,Jugada):-
    mesa(CartasMesa),
    tieneCarta(Jugador,Carta), 
    jugadaConCarta(Carta,CartasMesa,Jugada).

jugadaConCarta(Carta, CartasMesa,tira(Carta)):-
    not(puedeLevantar(Carta,CartasMesa,_)).

jugadaConCarta(Carta,CartasMesa,levanta(Carta,CartasLevantadas)):-
    puedeLevantar(Carta,CartasMesa,CartasLevantadas),
    CartasMesa \= CartasLevantadas.

jugadaConCarta(Carta,CartasMesa,escoba(Carta,CartasMesa)):-
    puedeLevantar(Carta,CartasMesa,CartasMesa).

