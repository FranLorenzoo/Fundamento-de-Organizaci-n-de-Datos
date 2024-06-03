program frans;
type 

	empleado= record
		NumeroEmpleado:integer;
		apellido:String;
		nombre:String;
		Edad:integer;
		DNI:integer;
	end;
	
	archivo= file of empleado;

procedure LeerEmpleado (var e:empleado);
begin
	writeln ('ingrese el apellido del empleado: ');
	readln(e.apellido);
	if (e.apellido <> 'fin') then begin
		writeln ('ingrese el Edad del empleado: ');
		readln(e.Edad);
		writeln ('ingrese el nombre del empleado: ');
		readln(e.nombre);
		writeln ('ingrese el DNI del empleado: ');
		readln(e.DNI);
		writeln ('ingrese el Numero de Empleado del empleado: ');
		readln(e.NumeroEmpleado);
	end;
end;

procedure CargarEmpleados (var archi:archivo);
var
	act,e:empleado;
	valido:boolean;
begin
	LeerEmpleado(e);
	while( e.apellido <> 'fin') do begin
		reset(archi);
		valido:=true;
		read (archi,act);
		while (valido)and not(EOF(archi)) do begin
			read(archi,act);
			if (e.NumeroEmpleado = act.NumeroEmpleado) then 
				valido:=false;
		end;
		if (valido) then
			write(archi,e);
		LeerEmpleado(e);
	end;
end;

procedure ModificarEdad (var archi:archivo);
var
	act:empleado;
	edad,numero:integer;
begin
	writeln ('inserte la nueva edad del Empleado : ');
	readln(edad);
	writeln ('inserte el numero de empleado a buscar : ');
	readln(numero);
	reset(archi);
	read(archi,act);
	while (act.NumeroEmpleado = numero)and not(EOF(archi)) do begin
		read(archi,act);
	end;
	if not(EOF(archi)) then begin
		seek (archi, filePos(archi)-1);
		act.Edad:=edad;
		write(archi,act);
	end;
end;

procedure ExportarTodo (var archi:archivo);
var
	act:empleado;
	archi2:archivo;
begin
	writeln ('estoy en EXPORTARTODO');
	assign(archi2, 'C:\Users\usuario\Desktop\Fran\2024 FACULTAD\FOD PRIMER SEMESTRE\todos_empleados.dat');
	rewrite(archi2);
	reset(archi);
	while not(EOF(archi)) do begin
		read(archi,act);
		write(archi2,act);
	end;
	close(archi);
end;


procedure ExportarSinDNI (var archi:archivo);
var
	act:empleado;
	archi2:archivo;
begin
	assign(archi2, 'C:\Users\usuario\Desktop\Fran\2024 FACULTAD\FOD PRIMER SEMESTRE\faltaDNIempleado.dat');
	rewrite(archi2);
	reset(archi);
	while not(EOF(archi)) do begin
		read(archi,act);
		if (act.DNI = 00) then
			write(archi2,act);
	end;
	close(archi2);
end;

Var
	archi:archivo;
begin
	assign (archi,'C:\Users\usuario\Desktop\Fran\2024 FACULTAD\FOD PRIMER SEMESTRE\empleados.dat');
	CargarEmpleados(archi);
	ModificarEdad(archi);
	ExportarTodo(archi);
	ExportarSinDNI(archi);
	close(archi);
end.
