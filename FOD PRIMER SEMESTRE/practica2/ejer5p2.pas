program Frans;
const
	valorAlto=30000;
type
	producto = record
		codigoProd : integer;
		precioVenta : real;
		stockminimo: integer;
		stockact: integer;
		nombreComercial : string [30];
		descripcion: string [100];
	end;
	deta = record
		codigoProd : integer;
		cantidadVendido : integer;
	end;
	
	detalle = file of deta;
	
	arc_detalle= array [1..30] of file of deta;
	reg_detalle= array [1..30] of deta;
	master = file of producto;

procedure Leer (var archi:detalle; var Al:deta);
begin
	if not (eof(archi)) then begin
			read(archi,Al)
	end
	else Al.codigoProd:=valorAlto;
end;	

procedure minimo (var min: deta; var elementos: reg_detalle ; var det : arc_detalle);
var
	i,j:integer;
begin
	i:=1;
	for j:= 1 to 30 do begin
		if (elementos[j].codigoProd <= elementos[i].codigoProd) then i:=j
	end;
	min:= elementos[i];
	leer (det[i], elementos[i]);
end;
	
procedure Listar (var maestro:master);
var
	Listado:text;
	elem:producto;
begin
	assign (Listado, 'listaStockdebajo.txt');
	rewrite(Listado);
	reset(maestro);
	while not(eof(maestro)) do begin
		read (maestro,elem);
		if (elem.stockminimo>elem.stockact) then writeln (Listado, elem.stockact, ' ', elem.codigoProd, ' ' , elem.descripcion);
	end;
	close(Listado);
	close(maestro);
end;
	
var
	i,ventasTot:integer;
	maestro : master;
	detalles : arc_detalle;
	elementos : reg_detalle;
	min:deta;
	regm:producto;
	nombre:string;
begin
	for i:= 1 to 30 do begin
		str (i,nombre);
		assign (detalles[i],'det' + nombre + '.dat');
		reset(detalles[i]);
		leer (detalles[i],elementos[i]);
	end;
	assign (maestro, 'master.dat');
	reset(maestro);
	read(maestro, regm);
	minimo(min, elementos, detalles);
	while (min.codigoProd<>valorAlto) do begin
		//ubico al archivo maestro en la posicion a actualizar
		while (min.codigoProd <> regm.codigoProd) do read (maestro, regm);
		if (min.codigoProd <> regm.codigoProd) then seek (maestro , filePos (maestro) - 1);
		//empiezo con la lectura del archivo detalle
		ventasTot:=0;
		while (regm.codigoProd = min.codigoProd) do begin
			ventasTot := ventasTot + min.cantidadVendido;
			minimo(min, elementos, detalles);
		end;
		//actualizo el archivo maestro
		regm.stockact := regm.stockact - ventasTot;
		write(maestro, regm);
		if not (eof(maestro)) then read (maestro , regm);
	end;
	for i:= 1 to 30 do close (detalles[i]);
	close (maestro);
end.
