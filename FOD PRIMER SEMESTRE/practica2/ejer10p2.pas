program Frans;
const
	valorAlto=30000;
type
	cate = 1..15;
	empleado = record
		departamento: string [30];
		división: string [30]; 
		numeroempleado:integer; 
		categoría: cate;
		horasextras: real;
	end;
	
	valorHoraCate = array [cate] of real;
	
	archivo = file of empleado;

procedure cargarArreglo (var arreglo : valorHoraCate; var categoriasValor: text);
var
	i:integer;
	valor:real;
begin
	i:=1;
	reset (categoriasValor);
	while not (eof(categoriasValor)) do begin
		read (categoriasValor, valor[i]);
		i:= i + 1;
	end;
	close (categoriasValor);
end;
	
	
procedure informarFormato (var archiEmp:archivo; arreglo : valorHoraCate);
var
	TotDivision, TotDepartamento, MonDivision, MonDepartamento:real;
	regm,act:empleado;
begin
	reset (archiEmp);
	while not (eof(archiEmp)) do begin
		read (archiEmp, act);
		regm:= act;
		TotDepartamento:= 0;
		MonDepartamento:= 0;
		writeln(regm.departamento);
		while (regm.departamento = act.departamento) do begin
			writeln(regm.division);
			TotDivision:=0;
			MonDivision:=0;
			writeln ('Número de Empleado   Total de Hs.   Importe a cobrar');
			while (regm.division = act.division) do begin
				MonDivision:= MonDivision + (arreglo[act.categoria]*act.horasextra);
				TotDivision:= TotDivision + act.horasextra;
				writeln (act.numeroempleado, '  ', act.horasextra, '  ', arreglo[act.categoria]*act.horasextra);
				read (archiEmp, act);
			end;
			writeln ('Total Horas Division: ', TotDivision;);
			writeln ('Total Monto Division: ', MonDivision);
			regm.division:= act.division;
			MonDepartamento:= MonDepartamento + MonDivision;
			TotDepartamento:= TotDepartamento + TotDivision;
		end;
		writeln ('Total Horas Departamento: ', TotDepartamento;);
		writeln ('Total Monto Departamento: ', MonDepartamento);
	end;
end;
	
var
	categoriasValor : text;
	archiEmp: archivo;
	arreglo: calorHoraCate;
begin
	assign (categoriasValor, 'ValorPorCategoria.txt');
	assign (archiEmp ,  'maestroEmpleados.dat');
	cargarArreglo (arreglo, categoriasValor);
	informarFormato(archiEmp, arreglo);
end.
