# Escoba de 15

**Ejercicio integrador breve con recursividad sobre listas y functores**

Conociendo las cartas que hay en la mesa y las que tiene un jugador en su mano, deducir la mejor jugada que podria hacer, es decir, cuál de sus cartas jugar.
* Si con alguna de las cartas que tiene en la mano puede hacer escoba (sumar 15 puntos entre su carta y todas las de la mesa), la hace.
* Si no puede hacer escoba, intenta levantar con alguna de sus cartas (sumar 15 puntos entre su carta y algunas de las de la mesa). Si hubiera alternativas de levantar diferentes cantidades de cartas, hace alguna de las jugadas que más cartas le permite levantar.
* Si tampoco puede levantar, juega tirando cualquiera de sus cartas.

La información que se desea obtener es para cada jugador cuál es la jugada que realizaría: 
* Si hace escoba, se informa la carta que juega y las cartas que levanta, que van a ser todas las que había en la mesa.
* Si levanta, también se informa la carta que juega y las cartas que levanta.
* Si tira, sólo importa cuál es la carta que juega. 

Se juega con un mazo de 40 cartas españolas, sin ochos ni nueves. La sota vale 8 puntos, el caballo 9 y el rey 10, mientras que los números valen lo que indican.

---

*Por ejemplo:*
```
mesa( [carta(7,oro), carta(3, copa), carta(1,oro)]).
enMano( jugador1, [carta(sota, copa), carta(5, basto), carta(5, copa)]).
enMano( jugador2, [carta(rey, copa), carta(4, espada)]).
enMano( jugador3, [carta(2, copa), carta(3, espada)]).
```
* El primer jugador decide jugar cualquiera de los 5 y levanta de la mesa el 7 y el 3 (se lleva una carta más que si levantara el 7 con la sota)
* El segundo jugador hace escoba jugando el 4 (Con el rey no puede levantar nada)
* El último jugador tira el 2 o el 3.
