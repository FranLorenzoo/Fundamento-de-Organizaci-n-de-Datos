program frans
const
	valorAlto = 'ZZZ';
type
	editorial = record
		fecha:string[11];
		codigoseminario:integer;
		nombreseminario:string [26];
		descripcion: string[100];
		precio:real;
		totalejemplares:integer;
		totalvendidos:real;
	end;
	
	det = record	
		fecha:string[11];
		codigoseminario:integer;
		totalvendidos:real;
	end;
	
	archivodet = file of det;
	archivomaestro = file of editorial;
	arreglodetalle = array [1..100] of file of det;
	arregloelementos = array [1..100] of det;

procedure Leer (var archi:archivodet; var Al:det);
begin
	if not (eof(archi)) then begin
			read(archi,Al)
	end
	else Al.fecha:=valorAlto;
end;	
	
procedure Minimo (var min : det; var detalles : arreglodetalle; var elementos : arregloelementos);
var
	i,j:integer;
begin
	i:= 1;
	for j:= 1 to 100 do begin  
		if (elementos [j].fecha <= elementos [i].fecha) then begin
			if (elementos[j].codigoseminario <= elementos [i].codigoseminario) then i:=j;
		end;
	end;
	min:=elementos[i];
	Leer (detalles [i], elementos [i]);
end;
	
	
procedure ActualizarMaestro ( var detalles:arreglodetalle; var Master : archivomaestro);
var
	regm:editorial;
	min:det;
	i:integer;
	elementos:arregloelementos;
begin
	for i:= 1 to 100 do 
		reset (detalles[i]);
	for i:= 1 to 100 do 
		read (detalles [i], elementos [i]);
	reset (Master);
	minimo(min, detalles, elementos);
	read(Master , regm);
	while (min.fecha <> valorAlto) do begin
		while (min.fecha <> regm.fecha) do read (Master, regm);
		seek (Master , filePos (Master) - 1);
		while (min.fecha = regm.fecha) do begin
			
			while (min.codigoseminario <> regm.codigoseminario) do read (Master, regm);
			seek (Master , filePos (Master) - 1);
			while (min.codigoseminario = regm.codigoseminario) do begin
				if (regm.totalejemplares >= min.totalvendidos) then begin
					regm.totalejemplares:= regm.totalejemplares - min.totalvendidos;
					regm.totalvendidos:= regm.totalvendidos + min.totalvendiso;
				end;
				minimo(min, detalles, elementos);
			end;
			write(Master,regm);
			if not (eof(Master)) then read (Master , regm);
		end;
	end;
	for i:= 1 to 100 do close (detalles[i]);
	close(Master);
end;

var
	i:integer;
	maestro:archivomaestro;
	detalle:arreglodetalle;
begin
	for i:= 1 to 100 do begin
		str (i,n);
		assign (detalle[i], 'EditorialDetalle' + n + '.dat');
	end;
	assign (maestro, 'maestroEditorial.dat');
	ActualizarMaestro(maestro,detalle);
end.
