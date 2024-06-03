program frans;
const
	valorAlto = 30000;
type
	motos = record
		codigo:integer; 
		nombre:string[31]; 
		descripcion:string[101];
		modelo:string[31]; 
		marca:string[31]; 
		stockactual:integer; 
	end;
	
	det = record;
		codigo:integer; 
		fecha:string[11];
		precio:real;
	end;


	archivodet = file of det;
	archivomaestro = file of motos;
	arreglodetalle = array [1..10] of file of det;
	arregloelementos = array [1..10] of det;

procedure Leer (var archi:archivodet; var Al:det);
begin
	if not (eof(archi)) then begin
			read(archi,Al)
	end
	else Al.codigo:=valorAlto;
end;	
	
procedure Minimo (var min : det; var detalles : arreglodetalle; var elementos : arregloelementos);
var
	i,j:integer;
begin
	i:= 1;
	for j:= 1 to 100 do begin  
		if (elementos [j].codigo <= elementos [i].codigo) then i:=j;
	end;
	min:=elementos[i];
	Leer (detalles [i], elementos [i]);
end;
	
	
procedure ActualizarMaestro ( var detalles:arreglodetalle; var Master : archivomaestro);
var
	masvendida,regm:motos;
	min:det;
	contact,contmas,i:integer;
	
	elementos:arregloelementos;
begin
	for i:= 1 to 10 do 
		reset (detalles[i]);
	for i:= 1 to 10 do 
		read (detalles [i], elementos [i]);
	reset (Master);
	minimo(min, detalles, elementos);
	read(Master , regm);
	contmas:=0
	while (min.codigo <> valorAlto) do begin
		while (min.codigo <> regm.codigo) do read (Master, regm);
		seek (Master , filePos (Master) - 1);
		contact:=0;
		while (min.codigo = regm.codigo) do begin
				regm.stockactual := regm.stockactual - 1;
				contact:=contact +1;
				minimo(min, detalles, elementos);
		end;
		if (contact > contmas) then begin
			contmas:= contact;
			masvendida:=regm;
		end;
		write(Master,regm);
		if not (eof(Master)) then read (Master , regm);
	end;
	writeln ('la moto mas vendida fue la ', masvendida.nombre);
	for i:= 1 to 10 do close (detalles[i]);
	close(Master);
end;


var
	i:integer;
	detalle:arreglodetalle;
	maestro:archivomaestro;
begin
	for i:= 1 to 10 do begin
		str (i,n);
		assign (detalle[i], 'ConcesionariaDetalle' + n + '.dat');
	end;
	assign (maestro, 'maestroConcesionaria.dat');
	ActualizarMaestro(detalle,maestro);
end.
