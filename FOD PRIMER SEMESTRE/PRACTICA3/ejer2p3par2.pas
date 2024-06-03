program frans;
type
	votos = record
		codlocalidad:integer;
		nmmesa:integer; 
		cantvotos:integer;
	end;
	
	votoAux = record
		codlocalidad:integer;
		totalvotosM:integer;
	end;
		
	maestroResultado = file of votoAux;
	Amaestro=file of votos;
	
	
procedure CargarResul(var maestro:Amaestro; var maestroResul:maestroResultado; var totalVotos:integer);
var
	regm:votos;
	regMR:votoAux;
	esta:boolean;
begin
	reset(maestro);
	rewrite(maestroResul);
	while not eof(maestro) do begin
		read(maestro,regm);
		esta:=false;
		read(maestroResul,regMR);
		totalVotos:= totalVotos + regm.cantvotos;
		while (regMR.codlocalidad <> regm.codlocalidad) and not eof(maestroResul)do begin
			read(maestroResul,regMR);
			if (regMR.codlocalidad = regm.codlocalidad) then esta:=true;
		end;
		if not(esta) then begin
			regMR.codlocalidad:= regm.codlocalidad;
			regMR.totalvotosM:=regm.cantvotos;
			write(maestroResul,regMR);
		end
		else begin
			regMR.totalvotosM:= regMR.totalvotosM + regm.cantvotos;
			seek (maestroResul, filePos(maestroResul)-1);
			write(maestroResul, regMR);
		end;
		reset(maestroResul);	
	end;
	close(maestro);
	close(maestroResul);
end;

procedure mostrarResul(var maestroResul:maestroResultado; total:integer);
var
	reg:votoAux;
begin
	reset(maestroResul);
	writeln ('codigo localidad                total de Votos');
	while not eof(maestroResul) do begin
		read(maestroResul,reg);
		writeln(reg.codlocalidad, '                ',reg.totalvotosM);
	end;
	writeln('Total genearl de votos:  ', total);
	close(maestroResul);
end;
	
var
	maestro: Amaestro;
	maestroResul:maestroResultado;
	total:integer;
begin
	total:=0;
	assign(maestro,'maestroVotos.dat');
	assign(maestroResul, 'ResultadoElec.dat');
	CargarResul(maestro,maestroResul,total);
	mostrarResul(maestroResul,total);
end.
