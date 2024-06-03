program repaso;
type
	lisdato = record
		fecha:string[11];
		montopedidos:real;
	end;
	
		
	telefono = record
		DNI:integer;
		nombrecli:string[50];
		clientedatos:lisdato;
	end;
	
	lista=^nodoL;
	
	nodoL = record
		dato:lisdato;
		sig:lista;
	end;


	ardato= record
		DNI:integer;
		nombrecli:string[50];
		listacompras:lista;
	end;
	
	arbol=^nodoA;
	
	nodoA = record
		dato:ardato;
		HI:arbol;
		HD:arbol;
	end;
	
procedure agregarAtras(var L:lista; elem:lisdato);
var
	nue,act:lista;
begin
	new (nue);
	nue^.dato:=elem;
	nue^.sig:=nil;
	if (L=nil) then L:=nue
	else begin
		act:=L;
		while (act^.sig <> nil) do act:= act^.sig;
		act^.sig:=nue;
	end;
end;

procedure insertarArbol (var a: arbol; elem:telefono);

begin
	if (a = nil ) or (a^.dato.DNI = elem.DNI) then begin
		if (a = nil) then begin 
			a^.dato.listacompras:=nil;
			a^.dato.DNI:=elem.DNI;
			a^.dato.nombrecli:=elem.nombrecli;
		end;
		a^.HI:=nil;
		a^.HD:=nil;
		agregarAtras(a^.dato.listacompras, elem.clientedatos);
	end
	else begin
		if(a^.dato.DNI < elem.DNI) then insertarArbol(a^.HD, elem)
		else insertarArbol(a^.HI, elem);
	end;
end;

procedure leerDato(var e:telefono);
begin
	writeln('monto(0 en caso de terminar): ');
	readln(e.clientedatos.montopedidos);
	if (e.clientedatos.montopedidos <> 0) then begin
		writeln('DNI cliente: ');
		readln(e.DNI);
		writeln('nombre cliente: ');
		readln(e.nombrecli);
		writeln('fecha de compra: ');
		read(e.clientedatos.fecha);
	end;
end;

procedure cargarEstructura(var a:arbol);
var
	elem:telefono;
begin
	a:=nil;
	leerDato(elem);
	while (elem.clientedatos.montopedidos <> 0) do begin
		insertarArbol(a,elem);
		leerDato(elem);
	end;
end;

Function informarcantLista (L:lista; fecha:string): integer;
var
	cant:integer;
begin
	cant:=0;
	while (L<>nil) do begin
		if (L^.dato.fecha = fecha) then cant:= cant +1;
		L:=L^.sig;
	end;
	informarcantLista:=cant;
end; 

Function informarCantidad ( a:arbol; fecha:string):integer;
begin
	if (a<>nil) then begin
		informarCantidad:= informarCantidad(a^.HI,fecha) + informarCantidad(a^.HD, fecha) + informarcantLista(a^.dato.listacompras,fecha);
	end;
	if (a = nil) then informarCantidad:=0;
end;


var
	cant:integer;
	a:arbol;
begin

	cargarEstructura(a);
	cant:=informarCantidad(a,'8/8/2003');
	writeln('cantidad de compras realizadas en la fecha: ', cant);
end.