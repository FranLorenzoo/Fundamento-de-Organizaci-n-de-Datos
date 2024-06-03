program Frans;
const
	valorAlto = 30000;
type
	alumno = record
		cursadasAprob: integer;
		finalesAprob: integer;
		codigoAl: integer;
		nombre: string [30];
		end;
		
	deta = record;
		codigoAl: integer;
		aproboFinal: boolean;
	end;
	
	detalle = file of deta;
	maestro = file of alumno;
	
	
procedure Leer (var archi:detalle; var Al:deta);
begin
	if not (eof(archi)) then begin
			read(archi,Al)
	end
	else Al.codigoAl:=valorAlto;
end;	
	
procedure ActualizarMaestro ( var Maestro:maestro ; var Detalle : detalle );
var
	act:deta;
	regm:alumno;
	Finales, cursadas:integer;
begin
	reset (Maestro);
	reset (Detalle);
	Leer (Detalle, act);
	read (Maestro , regm);
	while not (act.codigoAl <> valorAlto) do begin
		//ubico al archivo maestro en la posicion a actualizar
		while (act.codigoAl <> regm.codigoAl) do read (Maestro, regm);
		if (act.codigoAl <> regm.codigoAl) then seek (Maestro , filePos (Maestro) - 1);
		//empiezo con la lectura del archivo detalle
		Finales:=0;
		cursadas:=0;
		while (regm.codigoAl = act.codigoAl) do begin
			if (act.aproboFinal) then begin 
				Finales:= Finales + 1;
				cursadas:= cursadas - 1;
				end
			else cursadas:= cursadas + 1;
			Leer (Detalle, act);
		end;
		//actualizo el archivo maestro
		regm.finalesAprob := regm.finalesAprob + Finales;
		regm.cursadasAprob := regm.cursadasAprob + cursadas;
		write(Maestro, regm);
		if not (eof(Maestro) then read (Maestro , regm);
	end;
	close (Maestro);
	close (Detalle);
end;

procedure ListarMas (var Maestro : maestro);
var
	nuevoArchi:text;
	al:alumno
begin
	assign (nuevoArchi, 'alumnosConMasFinalesAprobados.txt');
	rewrite (nuevoArchi);
	reset (Maestro);
	while not (eof(Maestro) do begin
		read (Maestro,al);
		if (al.finalesAprob > al.cursadasAprob) then write (nuevoArchi, al.codigoAl, ' ' , al.finalesAprob, ' ' , al.cursadasAprob, ' ', al.nombre);
	end;
	close (Maestro);
	close (nuevoArchi);
end;

	
var
	Maestro : maestro;
	Detalle : detalle;
begin
	assign (Maestro , 'InformacionFacultad.dat');
	assign (Detalle, 'InfoMateria.dat');
	ActualizarMaestro (Maestro,Detalle);
	ListarMas (Maestro);
end.
