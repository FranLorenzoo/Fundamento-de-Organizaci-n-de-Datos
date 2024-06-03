program Frans;
const
	valorAlto = 30000;
type
	producto = record
		codigoProd : integer;
		precioVenta : real;
		stockminimo: integer;
		stockact: integer;
		nombreComercial : string [30];
	end;
	
	deta = record
		codigoProd : integer;
		cantidadVendido : integer;
	end;
	
	maestro = file of producto;
	detalle = file of deta;
	
	
procedure Leer (var archi:detalle; var Al:deta);
begin
	if not (eof(archi)) then begin
			read(archi,Al)
	end
	else Al.codigoProd:=valorAlto;
end;	

procedure ActualizarMaestro ( var Maestro:maestro ; var Detalle : detalle );
var
	act:deta;
	regm:producto;
	ventasTot:integer;
begin
	reset (Maestro);
	reset (Detalle);
	Leer (Detalle, act);
	read (Maestro , regm);
	while  (act.codigoProd <> valorAlto) do begin
		//ubico al archivo maestro en la posicion a actualizar
		while (act.codigoProd <> regm.codigoProd) do read (Maestro, regm);
		if (act.codigoProd <> regm.codigoProd) then seek (Maestro , filePos (Maestro) - 1);
		//empiezo con la lectura del archivo detalle
		ventasTot:=0;
		while (regm.codigoProd = act.codigoProd) do begin
			ventasTot := ventasTot + act.cantidadVendido;
			Leer (Detalle, act);
		end;
		//actualizo el archivo maestro
		regm.stockact := regm.stockact - ventasTot;
		write(Maestro, regm);
		if not (eof(Maestro) then read (Maestro , regm);
	end;
	close (Maestro);
	close (Detalle);
end;


var
	Maestro : maestro ;
	Detalle : detalle ;
begin
	assign (Maestro, 'maestroVentas.dat');
	assign (Detalle, 'ventasDelDia.dat');
	Actualizar(Maestro, Detalle ) ;
	Listar (Maestro);
end.
