
program Frans;
const
	valorAlto=30000;
type
	locCovid = record
		codigoLoc:integer;
		codigoCepa:integer;
		casosActivos:integer;
		casosFa:integer;
		casosRecu:integer
		casosNue:integer;
	end;
	
	magisterio = record
		codigoCepa:integer;
		codigoLoc:integer;
		casosActivos:integer;
		casosFa:integer;
		casosRecu:integer
		casosNue:integer;
		nombreCepa:string [31];
	end;
	
	locDetalles = array [1..10] of file of locCovid;
	maestro = file of magisterio;
	elementosCov = array [1..10] of locCovid;
	archivoDet = file of locCovid;

procedure Leer (var archi:detalle; var Al:maquinasLogs);
begin
	if not (eof(archi)) then begin
			read(archi,Al)
	end
	else Al.codUser:=valorAlto;
end;	
	
procedure Minimo (var min : maquinasLogs; var detalles : archivosDetalle; var elementos : elementosDetalle);
var
	corte,i,j:integer;
begin
	i:= 1;
	corte=valorAlto;
	for j:= 1 to 5 do begin  
		if (elementos [j].codigoLoc <= elementos [i].codigoLoc) then begin 
			i:= j;
			corte:= elementos[j].codigoLoc;
		end
		else if (elementos[j].codigoLoc = elementos [i].codigoLoc) and (elementos [j].codigoCepa <= elementos [i].codigoCepa)then begin
			i:= j;
			corte:= elementos[j].codigoLoc;
		end;
	end;
	min:=elementos[i];
	min.codigoLoc:=corte;
	Leer (detalles [i], elementos [i]);
end;
	
	
procedure ActualizarMaestro ( var detalles:locDetalles; var Master : maestro);
var
	casosF, casosR,i:integer;
	regm:magisterio;
	min:locCovid;
	elementos:elementosCov;
begin
	for i:= 1 to 10 do begin
		reset (detalles[i]);
		read (detalles [i], elementos [i]);
	end;
	reset (Master);
	minimo(min, detalles, elementos);
	read(Master , regm);
	while (min.codigoLoc <> valorAlto) do begin

		while (min.codigoLoc <> regm.codigoLoc) do read (Master, regm);
		seek (Master , filePos (Master) - 1);
		while (min.codigoLoc = regm.codigoLoc) do begin
			casosR:=0;
			casosF:=0;
			while (min.codigoCepa <> regm.codigoCepa) do read (Master, regm);
			seek (Master , filePos (Master) - 1);
			while (min.codigoCepa = regm.codigoCepa) do begin
				casosF:= casosF + min.casosFa;
				casosR:= casosR + min.casosRecu;
				minimo(min, detalles, elementos);
			end;
			regm.casosRecu:= regm.casosRecu + casosR;
			regm.casosFa:= regm.casosFa + casosF;
			regm.casosActivos:= min.casosActivos;
			regm.casosNue:= min.casosNue;
			write(Master,regm);
			if not (eof(Master)) then read (Master , regm);
		end;
	end;
	for i:= 1 to 10 do close (detalles[i]);
	close(Master);
end;




var
	Master:maestro;
	detalles: locDetalles;
	n:string;
	i:integer;
begin
	for i:= 1 to 10 do begin
		str (i,n);
		assign (detalles[i], 'covidDetalle' + n + '.dat');
	end;
	assign (Master, 'maestroCovid.dat');
	ActualizarMaestro(Maestro,detalles);
end.
