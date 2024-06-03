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

var
	archi, archi2:archivo;
	e:empleado;
begin
	assign (archi, 'C:\Users\usuario\Desktop\Fran\2024 FACULTAD\FOD PRIMER SEMESTRE\todos_empleados.dat');
	assign (archi2, 'C:\Users\usuario\Desktop\Fran\2024 FACULTAD\FOD PRIMER SEMESTRE\faltaDNIempleado.dat');
	reset (archi);
	writeln ('todos los empleados ...');
	while not (EOF(archi)) do begin
		read(archi,e);
		writeln ('datos del empleado ---> apellido : ',e.apellido,'| nombre : ', e.nombre, '| numero de empleado : ', e.NumeroEmpleado, '| DNI : ', e.DNI, '| Edad : ', e.Edad);
	end;
	reset(archi2);
	writeln ('todos los empleados sin DNI ...');
	while not (EOF(archi2)) do begin
		read(archi2,e);
		writeln ('datos del empleado ---> apellido : ',e.apellido,'| nombre : ', e.nombre, '| numero de empleado : ', e.NumeroEmpleado, '| DNI : ', e.DNI, '| Edad : ', e.Edad);
	end;
	close(archi);
	close(archi2);
end.
