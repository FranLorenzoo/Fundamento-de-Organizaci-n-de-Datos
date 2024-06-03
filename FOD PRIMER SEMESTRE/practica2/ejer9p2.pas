program Frans;
const
	valorAlto=30000;
type
	mesa = record
		codigoProv : integer;
		codigoLoc : integer;
		numeroMesa : integer;
		cantidadVotos : integer;
	end;
	
	maestro = file of mesa;
	
procedure imprimirFormato ( var archivo : maestro );
var
	regm, act; : mesa;
	totalGeneral,totalvotosProv, totalvotosLoc:integer;
begin 
	totalGeneral:=0;
	while not (eof(archivo)) do begin
		read (archivo, act);
		regm:= act;
		totalvotosProv:=0;
		writeln ('codigo provincia: ', regm.codigoProv);
		writeln ('codigo localidad            total de votos');
		while (act.codigoProv = regm.codigoProv) do begin
			totalvotosLoc:=0;
			while (act.codigoLoc = regm.codigoLoc) do begin
				totalvotosLoc:= totalvotosLoc + 1;
				read(archivo,act);
			end;
			writeln (regm.codigoLoc, '            ', totalvotosLoc);
			regm.codigoLoc:= act.codigoLoc;
			totalvotosProv:= totalvotosProv + totalvotosLoc;
		end;
		totalGeneral:= totalGeneral + totalvotosProv;
		writeln ('total votos provinica ' , regm.codigoProv, ': ', totalvotosProv);	
	end;
	writeln ('total votos General: ', totalGeneral);
end;
	
	
	
var
	archivo : maestro;
begin
	assign (archivo, 'datosMesas.dat');
	imprimirFormato (archivo);
end.
