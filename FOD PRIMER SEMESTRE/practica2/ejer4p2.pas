program Frans;
const
	valorAlto = 'ZZZ';
type
	alfabeto = record
		nombreProv:string[30];
		cantAlfa:integer;
		totalEnc:integer;
		end;
		
	det = record
		nombreProv : string [30];
		codigoLocalidad: integer;
		cantAlfa:integer;
		cantEnc:integer;
		end;
		
	detalle = file of det;
	maestr = file of alfabeto;
	
	
procedure Leer (var archi:detalle; var Al:det);
begin
	if not (eof(archi)) then begin
			read(archi,Al)
	end
	else Al.nombreProv:=valorAlto;
end;	
	
procedure minimo (var min: det; var detalle1: det; var detalle2: det ; var det1,det2:detalle);
begin
	if (detalle1.nombreProv >= detalle2.nombreProv) and (detalle1.nombreProv <> valorAlto) then begin
		min:= detalle1;
		leer (det1 , detalle1);
	end
	else begin
		min:= detalle2;
		leer (det1, detalle2);
	end;
end;


procedure ActualizarMaestro ( var Maestro:maestr ; var Detalle1 : detalle; var Detalle2 : detalle );
var
	min, detale1, detale2:det;
	regm:alfabeto;
	encTot,alfaTot:integer;
begin
	reset (Maestro);
	reset (Detalle1);
	reset (Detalle2);
	Leer (Detalle1, detale1);
	Leer (Detalle2, detale2);
	read (Maestro , regm);
	minimo (min,detale1,detale2, Detalle1, Detalle2);
	while not (min.nombreProv <> valorAlto) do begin
		//ubico al archivo maestro en la posicion a actualizar
		while (min.nombreProv <> regm.nombreProv) do read (Maestro, regm);
		if (min.nombreProv <> regm.nombreProv) then seek (Maestro , filePos (Maestro) - 1);
		//empiezo con la lectura del archivo detalle
		alfaTot:=0;
		encTot:=0;
		while (regm.nombreProv = min.nombreProv) do  begin
			alfaTot := alfaTot + min.cantAlfa;
			encTot := alfaTot + min.cantEnc;
			minimo(min,detale1,detale2, Detalle1, Detalle2);
		end;
		//actualizo el archivo maestro
		regm.cantAlfa := regm.cantAlfa + alfaTot;
		regm.totalEnc := regm.totalEnc + encTot;
		write(Maestro, regm);
		if not (eof(Maestro)) then read (Maestro , regm);
	end;
	close (Maestro);
	close (Detalle1);
	close (Detalle2);
end;

	
var
	detalle1,detalle2:detalle;
	Maestro : maestr;
begin
	assign (detalle1, 'localidad.dat');
	assign (detalle2, 'localidad.dat');
	assign (Maestro, 'MasterProv.dat');
	ActualizarMaestro (Maestro, detalle1, detalle2);
end.
