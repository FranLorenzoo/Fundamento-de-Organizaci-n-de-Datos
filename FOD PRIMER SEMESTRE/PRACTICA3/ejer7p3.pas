program frans;
type
	ave=record
		codigo:integer;
		especie:string[46]; 
		familia:string[46];
		descripcion:string[101]; 
		zona:string[50];
	end;
	
	archivoAves = file of ave;
	
procedure MarcarBorrar (var maestro:archivoAves);
var
	codigoBaja:integer;
	regm:ave;
begin
	read(codigoBaja);
	while (codigoBaja <> 30000) do begin
		reset(maestro);
		read(maestro,regm);
		while (regm.codigo <> codigoBaja) do read(maestro,regm);
		seek(maestro, filePos(maestro) - 1);
		regm.codigo:= regm.codigo *-1;
	end;
end;


procedure Borrar (var maestro:archivoAves);
var
	regm:ave;
	index:integer;
begin
	reset(maestro);
	while not eof(maestro)do begin
		read(maestro, regm);
		if (regm.codigo < 0) then begin
			index:= filePos(maestro);
			seek (maestro, filePos(maestro)-1);
			read(maestro,regm);
			seek(maestro, filePos(maestro)-1);
			Truncate(maestro);
			seek(maestro, index);
			write(maestro,regm);
		end;
	end;
	close(maestro);
end;
	
var
	maestro:archivoAves;
begin
	assign(maestro,'MaestroAvesEx.dat');
	MarcarBorrar(maestro);
	Borrar(maestro);
end.
