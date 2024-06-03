program frans;
const
	valorAlto=30000;
type
	ONG = record
		Codigopcia:integer;
		nombreprovincia: string [30];
		codigodelocalidad:integer; 
		nombreloc:string[30];
 		Vsinluz:integer; 
 		Vsingas:integer; 
 		Vchapa:integer; 
 		Vsinagua:integer;  
 		Vsinsanitarios:integer;
	end;
	
	det = record
		Codigopcia:integer;
		codigodelocalidad:integer; 
		Vconluz:integer;
		Vcongas:integer; Vchapa:integer; 
		Vconagua:integer;
		Vconstruidas:integer;
		entregaSani:integer;
	end;
	
	archivoDet= file of det;
	archivoMae=file of ONG;
	archivosDet = array [1..10] of file of det;
	arreglosdetelem = array [1..10] of det;
	
procedure Leer (var archi:archivoDet; var Al:det);
begin
	if not (eof(archi)) then begin
			read(archi,Al)
	end
	else Al.Codigopcia:=valorAlto;
end;	
	
procedure Minimo (var min : det; var detalles : archivosDet; var elementos : arreglosdetelem);
var
	i,j:integer;
begin
	i:= 1;
	for j:= 1 to 5 do begin  
		if (elementos [j].Codigopcia <= elementos [i].Codigopcia) then begin
			if (elementos[j].codigodelocalidad <= elementos [i].codigodelocalidad) then i:=j;
		end;
	end;
	min:=elementos[i];
	Leer (detalles [i], elementos [i]);
end;
	
	
procedure ActualizarMaestro ( var detalles:archivosDet; var Master : archivoMae);
var
	regm:ONG;
	min:det;
	i:integer;
	elementos:arreglosdetelem;
begin
	for i:= 1 to 10 do begin
		reset (detalles[i]);
		read (detalles [i], elementos [i]);
	end;
	reset (Master);
	minimo(min, detalles, elementos);
	read(Master , regm);
	while (min.Codigopcia <> valorAlto) do begin
		while (min.Codigopcia <> regm.CodigoPcia) do read (Master, regm);
		seek (Master , filePos (Master) - 1);
		while (min.Codigopcia = regm.Codigopcia) do begin
			
			while (min.codigodelocalidad <> regm.codigodelocalidad) do read (Master, regm);
			seek (Master , filePos (Master) - 1);
			while (min.codigodelocalidad = regm.codigodelocalidad) do begin
				regm.Vsinluz:= regm.Vsinluz - min.Vconluz;
				regm.Vsingas:= regm.Vsingas - min.Vcongas;
				regm.Vsinagua:=regm.Vsinagua - min.Vconagua;
				regm.Vsinsanitarios:=regm.Vsinsanitarios - min.entregaSani;
				regm.Vchapa:=regm.Vchapa - min.Vconstruidas;
				minimo(min, detalles, elementos);
			end;
			write(Master,regm);
			if not (eof(Master)) then read (Master , regm);
		end;
	end;
	for i:= 1 to 10 do close (detalles[i]);
	close(Master);
end;
	
	
var
	maestro : archivoMae;
	detalle : archivosDet;
	i:integer;
begin
	for i:= 1 to 10 do begin
		str (i,n);
		assign (detalle[i], 'OngDetalle' + n + '.dat');
	end;
	assign (maestro, 'maestroONG.dat');
	ActualizarMaestro(detalle,maestro);
end.
