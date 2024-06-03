program Frans;
const
	valorAlto=30000;
type
	maquinasLogs = record
		codUser:integer;
		fecha:string[11];
		tiempo:real;
	end;
	
	maquina = record
		codUser:integer;
		tiempoTotal:real;
		fecha:string[11];
	end;
	
	detalle = file of maquinasLogs;
	
	archivosDetalle = array [1..5] of file of maquinasLogs;
	elementosDetalle = array [1..5] of maquinasLogs;
	Masterfile = file of maquina;
	
procedure Leer (var archi:detalle; var Al:maquinasLogs);
begin
	if not (eof(archi)) then begin
			read(archi,Al)
	end
	else Al.codUser:=valorAlto;
end;	
	
procedure Minimo (var min : maquinasLogs; var detalles : archivosDetalle; var elementos : elementosDetalle);
var
	i,j:integer;
begin
	i:= valorAlto;
	for j:= 1 to 5 do if (elementos [j].codUser <= elementos [i].codUser) then i:= j;
	min:=elementos[i];
	Leer (detalles [i], elementos [i]);
end;
	
	
procedure ActualizarMaestro ( var detalles:archivosDetalle; var Master : Masterfile);
var
	i:integer;
	regm:maquina;
	totTiempo:real;
	min:maquinasLogs;
	elementos:elementosDetalle;
begin
	for i:= 1 to 5 do begin
		reset (detalles[i]);
		read (detalles [i], elementos [i]);
	end;
	reset (Master);
	minimo(min, detalles, elementos);
	read(Master , regm);
	while (min.codUser <> valorAlto) do begin
		totTiempo:=0;
		while (min.codUser <> regm.codUser) do read (Master, regm);
		seek (Master , filePos (Master) - 1);
		while (regm.codUser = min.codUser) do begin
			totTiempo:= totTiempo + min.tiempo;
			minimo (min, detalles, elementos);
		end;
		regm.tiempoTotal:= regm.tiempoTotal + totTiempo;
		write (Master, regm);
		if not (eof(Master)) then read (Master , regm);
	end;
	for i:= 1 to 5 do close (detalles[i]);
	close(Master);
end;
	
var
	detalles:archivosDetalle;
	i:integer;
	n:string;
	Master : Masterfile;
begin
	for i:= 1 to 5 do begin 
		str(i,n);
		assign (detalles[i], 'detallesLogsMaquina'+n+'.dat');
	end;
	assign (Master,'MaestroLogs.dat');
	
end.
