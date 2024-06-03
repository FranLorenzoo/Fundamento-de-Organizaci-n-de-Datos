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

procedure leerEmpleado (var e:empleado);
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

procedure ListarPorNombre (var archi:archivo);
var
	nombre, apellido : String;
	e:empleado;
	encontre:boolean;
begin
	reset(archi);
	encontre:= false;
	writeln ('ingrese el apellido del empleado a Buscar: ');
	readln(apellido);
	writeln ('ingrese el nombre del empleado: ');
	readln(nombre);
	while (not(encontre) and not(EOF(archi)))do begin
		read(archi,e);
		if (e.apellido = apellido) or (e.nombre = nombre) then begin
			encontre:=true;
			writeln ('datos del empleado ---> apellido : ',e.apellido,'| nombre : ', e.nombre, '| numero de empleado : ', e.NumeroEmpleado, '| DNI : ', e.DNI, '| Edad : ', e.Edad);
		end;
	end;		
end;

procedure ListarTodos (var archi:archivo);
var
	e:empleado;
begin
	reset(archi);
	while not(EOF(archi))do begin
		read(archi,e);
		writeln ('datos del empleado ---> apellido : ',e.apellido,'| nombre : ', e.nombre, '| numero de empleado : ', e.NumeroEmpleado, '| DNI : ', e.DNI, '| Edad : ', e.Edad);
	end;		
end;

procedure ListarPorJubilacion (var archi:archivo);
var
	e:empleado;
begin
	reset(archi);
	while not(EOF(archi))do begin
		read(archi,e);
		if (e.Edad >= 70) then 
			writeln ('datos del empleado ---> apellido : ',e.apellido,'| nombre : ', e.nombre, '| numero de empleado : ', e.NumeroEmpleado, '| DNI : ', e.DNI, '| Edad : ', e.Edad);
	end;		
end;

var
	archi:archivo;
	e:empleado;
begin
	assign(archi,'C:\Users\usuario\Desktop\Fran\2024 FACULTAD\FOD PRIMER SEMESTRE\empleados.dat');
	rewrite(archi);
	leerEmpleado(e);
	while (e.apellido <> 'fin') do begin
		write(archi,e);
		leerEmpleado(e);
	end;
	ListarPorNombre(archi);
	ListarTodos(archi);
	ListarPorJubilacion(archi);
	close(archi);
end.
