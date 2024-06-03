program frans;
const 
	valorAlto = 'ZZZ';
type
	asistente = record
		DNI:integer;
		nombrecompleto: string[36];
		numasistente:integer;
		mail:string[36];
		telefono:integer;
	end;
	
	archivoAsis=file of asistente;
	
procedure LeerEmpleado (var e:asistente);
begin
	writeln ('ingrese el apellido del empleado: ');
	readln(e.nombrecompleto);
	if (e.nombrecompleto <> 'fin') then begin
		writeln ('ingrese el Edad del empleado: ');
		readln(e.telefono);
		writeln ('ingrese el nombre del empleado: ');
		readln(e.mail);
		writeln ('ingrese el DNI del empleado: ');
		readln(e.DNI);
		writeln ('ingrese el Numero de Empleado del empleado: ');
		readln(e.numasistente);
	end;
end;

procedure CargarEmpleados (var archi:archivoAsis);
var
	act,e:asistente;
begin
	LeerEmpleado(e);
	rewrite(archi);
	while( e.nombrecompleto <> 'fin') do begin
		write(archi,e);
		LeerEmpleado(e);
	end;
	close(archi);
end;

procedure BajasMenor (var archi:archivoAsis);
var
	reg:asistente;
begin
	reset (archi)
	while not eof(archi) do begin
		read(archi,reg);
		if (reg.numasistente < 100) then begin
			reg.nombrecompleto:= '@' + reg.nombrecompleto;
			seek(archi, filePos(archi)-1);
			write(archi,reg);
		end;
	end;
	close(archi);
end;

var
	archivo:archivoAsis;
begin
	assign (archivo, 'asistentes.dat');
	
end.
