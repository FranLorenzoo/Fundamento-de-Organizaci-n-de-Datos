program Frans;
const
	valorAlto = 30000;
type

	empleado = record
		codigoEmpleado : integer;
		MontoComision : real;
		nombre : string [30];
	end;
	
	Maestro = file of empleado;
procedure CargarArchivo (var archi:Maestro; var emp:text);
var
	e,act:empleado;
begin
	rewrite (archi);
	reset (emp);
	read(emp, act.codigoEmpleado, act.MontoComision, act.nombre);
	while not (eof(emp)) do begin
		e:=act;
		while (e.codigoEmpleado = act.codigoEmpleado) do begin
			e.MontoComision = e.MontoComision + act.MontoComision;
			read(emp, act.codigoEmpleado, act.MontoComision, act.nombre);
		end;
		write(archi,e);
	end;
	close(emp);
	close (archi);
end;
	
var
	archi: Maetro;
	detalle: text;
begin
	assign (detalle, 'empleados.txt');
	assign (archi, 'empleados.dat');
	CargarArchivo (archi,detalle);
end.
