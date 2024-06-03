program frans;
const
	valorAlto=30000;
type
	server = record
		numuser:integer;
		nuser:string[20];
		nombre:string[20];
		apellido:string[20];
		cantidadmails:integer;
	end;
	
	diario = record
		numuser:integer;
		cuerpomensaje:string[101];
		cuerpodestino[30];
	end;
	
	archivomas = file of server;
	archivodia = file of diario;

procedure actualizar (var maestro: archivomas; var dia:archivodia);
var
	elem:diario;
	regm:server;
begin
	reset (dia);
	reset (maestro);
	read (dia, elem);
	while not (eof (dia) do begin
		while (elem.numuser = regm.numuser) do read (maestro, regm);
		seek (maestro, filePos (maestro) -1);
		while (elem.numuser = regm.numuser) do begin
			regm.cantidadmails:= regm.cantidadmails + 1;
			read (dia, elem);
		end;
		write(maestro,regm);
	end;
	close (maestro);
	close (dia);
end;

procedure generarTxt( var maestro: archivomas);
var
	numero:string;
	regm:server;
	texto:text;
begin
	assign (texto, 'infoUsuarios.txt');
	reset(maestro);
	rewrite(texto);
	read(maestro, regm);
	while not (eof(maestro) do begin
			numero:= 'nro_usuario' + str(regm.numuser);
			writeln (texto, numero, ' ', regm.cantidadmails);
			read(maestro,regm);
	end;
	close(texto);
	close(maestro);
end;


var
	archidia: archivodia;
	maestro: archivomas;
begin
	assign (archidia,'logspordia.dat');
	assign (maestro, 'maestrodiario.dat');
	actualizar (maestro, dia);
	generarTxt (maestro);
end.
