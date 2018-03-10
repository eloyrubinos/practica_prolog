% 1

% Defino estados
estado_inicial(e1).
estado_final(e3).

% Defino transiciones
t(e1,a,e1).
t(e1,b,e1).
t(e1,a,e2).
t(e2,b,e3).
t(e3,b,e4).
l(e2,e4).
l(e3,e1).

% Defino movimientos
aceptar(X):- estado_inicial(Z), trans(Z, X).
trans(X,[Y|Z]):- t(X,Y,Nuevo), trans(Nuevo,Z).
trans(X,[Y|Z]):- l(X,Nuevo), trans(Nuevo, [Y|Z]).
trans(X,[]):- l(X,Nuevo), trans(Nuevo,[]).
trans(X,[]):- estado_final(X).

/* Para consultar qué cadenas de longitud 3 acepta: ?-aceptar([X,Y,Z]).
   length(L,X) rellena la lista L con variables libres hasta ser de longitud X.
   between (1,X,Z) genera valores entre 1 y X y los guarda en Z, de uno en uno. */

aceptarlon(L,X):- length(L,X), aceptar(L).

aceptarlonmax(L,X):- between(1,X,Z), aceptarlon(L,Z).



% 2
/* hacer(ESTADO, ACCIÓN, ESTADO)
   - El "comando" 'hacer' toma un estado inicial, una acción y devuelve un estado final.
   
   ESTADO(MONO, SILLA, PLATANO)
   - Los estados se componen de tres elementos que se detallan a continuación:
      MONO(puerta, suelo)
      MONO(centro, suelo)
      MONO(ventana, suelo)
      MONO(puerta, silla)
      MONO(centro, silla)
      MONO(ventana, silla)

      SILLA(puerta)
      SILLA(centro)
      SILLA(ventana)

      PLATANO(SIP)
      PLATANO(NOPE)

   - Las acciones posibles son: coger (el plátano), subir (a la silla), caminar (desde posición inicial hasta posición final) y mover (la silla, desde posición inicial hasta posición final).
   - Las posiciones posibles son: puerta, centro y ventana.
*/

hacer(e((centro,silla),centro,nope), coger, e((centro,silla),centro,sip)).
hacer(e((A,suelo), A, B), subir, e((A,silla), A, B)).
hacer(e((A,suelo), A, B), mover(A,Nuevo), e((Nuevo,suelo), Nuevo, B)).
hacer(e((A,suelo), B, C), caminar(A,Nuevo), e((Nuevo,suelo), B, C)).

llega(e((_,_), _, sip)).
llega(E1):- hacer(E1, _, E2), llega(E2).