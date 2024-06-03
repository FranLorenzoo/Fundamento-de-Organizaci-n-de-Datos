program frans;
type
	prenda = record
		codprenda:integer; 
		descripción:string[100]; 
		colores:string[26]; 
		tipoprenda:string[26]; 
		stock:integer; 
		precio:real;
	end;

	archiPrenda = file of prenda;
	archiContenido = file of integer;
	
procedure actualizar (var maestro : archiPrenda;  var contenido : archiContenido);
var
	regm : prenda;
	regc : integer;
begin
	reset (maestro);
	reset (contenido);
	while not eof(contenido) do begin
		read(contenido, regc);
		read(maestro, regm);
		while (regm.codprenda <> regc) do read(maestro,regm);
		seek(maestro, filePos(maestro)-1);
		regm.stock:= regm.stock *-1;
		write(maestro,regm);
		reset(maestro);
	end;
	close(maestro);
	close(contenido);
end;
	
procedure efectivizarLogicas (var maestro: archiPrenda);
var
	regm:prenda;
	nueMaestro : archiPrenda;
begin
	assign (nueMaestro, 'maestroPrendas1.dat');
	rewrite (nueMaestro);
	reset(maestro)
	while not eof(maestro) do begin
		read (maestro, regm);
		if (regm.stock > 0) then write(nueMaestro, regm);
	end;
	Erase(maestro);
	rename (nueMaestro, 'maestroPrendas.dat');
	close(maestro);
	close(nueMaestro);
end;
	
var
	Maestro : archiPrenda;
	contenido : archiContenido;
begin
	assign (Maestro , 'maestroPrendas.dat');
	assign (contenido, 'contenidoeliminar.dat');
end.
