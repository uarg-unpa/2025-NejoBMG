precio_con_impuestos(PrecioBase,Impuesto,Total):- Total is PrecioBase + Impuesto.
precion_con_descuento(PrecioBase,Desccuento,Final):- Final is PrecioBase - Desccuento.
costo_total(Copias,PrecioUnitario,Total):- Total is Copias * PrecioUnitario.
costo_por_persona(Total, Personas, Costo):- Costo is Total / Personas.
divisible_por_5(Stock):- 0 is Stock mod 5.
area_estante(Lado,Area):- Area is Lado ^ 2.
% Operadores de comparación
es_caro(Precio):- Precio > 50.
es_barato(Precio):- Precio < 30.
apto_promocion(Stock) :- Stock >= 10.
bajo_stock(Stock) :- Stock =< 5.
precio_correcto(Precio, Base, Imp) :- Precio =:= Base + Imp.
precios_distintos(Precio1, Precio2) :- Precio1 =\= Precio2.

stock(el_principito,10).
libro_disponible_caro(Titulo, Precio, Stock):= stock(Titulo, Stock), Precio>50.

clasificar_libro(Precio, Categoria) :- Precio > 50, Categoria = caro.
clasificar_libro(Precio, Categoria) :- Precio =< 50, Categoria = economico.