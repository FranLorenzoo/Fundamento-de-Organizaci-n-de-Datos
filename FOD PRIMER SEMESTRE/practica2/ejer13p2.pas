program frans;
const
	valorAlto='ZZZ';
type
	viaje = record
		destino: string[40];
		fecha : string [11];
		asientoDis :integer;
		duracion : real;
	end;
	
	archiMaes = file of viaje;
	archiDet = file of viaje;
	
	Lista = ^Nodo;
	
	Nodo = record
		dato:viaje;
		sig:Lista;
	end;
	

	
procedure Leer (var archi:archiDet; var Al:viaje);
begin
	if not (eof(archi)) then begin
			read(archi,Al)
	end
	else Al.destino:=valorAlto;
end;	

	
procedure minimo (var min: viaje; var detalle1: viaje; var detalle2: viaje ; var det1,det2:archiDet);
begin
	if (detalle1.destino >= detalle2.destino) and (detalle1.destino <> valorAlto) then begin
		if ( detalle1.destino = detalle2.destino ) and ( detalle1.fecha <= detalle2.fecha) then begin
			if  (detalle1.fecha = detalle2.fecha) and (detalle1.duracion <= detalle2.duracion) then begin
				min:= detalle1;
				leer (det1 , detalle1);
			end
			else begin
				min:= detalle2;
				leer (det1, detalle2);
			end;
		end
		else begin
			min:= detalle2;
			leer (det1, detalle2);
		end;
	end
	else begin
		min:= detalle2;
		leer (det1, detalle2);
	end;
end;
	

procedure ActualizarMaestro ( var Maestro : archiMaes );
var
	det1,det2:archiDet;
	regd1,regd2,elemDet,regm : viaje;
begin
	assign (det1, 'detviajes1.dat');
	assign (det2, 'detviajes2.dat');
	reset(det1);
	reset(det2);
	reset(Maestro);
	leer(det1,regd1);
	leer(det2,regd2);
	minimo(elemDet, regd1, regd2, det1,det2);
	read(Maestro,regm);
	while (elemDet.destino <> valorAlto) do begin
		while (elemDet.destino <> regm.destino) do read (Maestro, regm);
		seek (Maestro,filePos(Maestro) -1);
		while (elemDet.destino = regm.destino) do begin
			while (elemDet.fecha <> regm.fecha) do read(Maestro, regm);
			seek (Maestro,filePos(Maestro) -1);
			while(elemDet.fecha = regm.fecha) do begin
				while(elemDet.duracion <> regm.duracion) do read(Maestro,regm);
			    seek (Maestro,filePos(Maestro) -1);
			    while (elemDet.duracion = regm.duracion) do begin
					minimo(elemDet, regd1, regd2, det1,det2);
					regm.asientoDis:= regm.asientoDis - elemDet.asientoDis;
				end;
				write(Maestro, regm);
			end;
		end;
	end;
end;
	
procedure cargarAlFinal( var L:Lista;elem:viaje);
var
	act,nue:Lista;
begin
	new(nue); nue^.dato:=elem; nue^.sig:=nil;
	if (L=nil) then 
		L:=nue
	else begin
		act:=L;
		while(act^.sig <> nil) do act:= act^.sig;
		act^.sig:=nue;
	end;
end;
	
procedure HacerLista (var Maestro:archiMaes);
var
	cantEs:integer;
	L : Lista;
	elem:viaje;
begin
	reset(Maestro);
	L:=nil;
	read(cantEs);
	while not (eof(Maestro)) do begin
		read(Maestro,elem);
		if(elem.asientoDis < cantEs) then cargarAlFinal(L,elem);
	end;
end;
	
var
	Maestro:archiMaes;
begin
	assign (Maestro, 'ViajesMaestro.dat');
	ActualizarMaestro(Maestro);
end.
