program Frans;
const
	valorAlto=30000;
type
	X = record;
		anio : integer; 
		mes : integer; 
		día : integer; 
		idUsuario : integer;  
		tiempodeacceso: real; 
	end;

	arch : file of X;

Function Existe (anio:integer, archivo:arch):boolean;
var
	elem:X;
begin
	reset (archivo);
	while not eof(archivo) do begin
		read (archivo,elem);
		if (elem.anio = anio) then begin 
			close(archivo);
			Existe:= true;
		end;
	end;
	close(archivo);
	Existe:= false;
end;


procedure imprimirFormato (var archivo : arch);
var
	anio:integer;
	regm,act:X;
	termine:boolean;
	totalUser,totaldia,totalmes,totalanio: real;
begin
	read (anio);
	termine:= false;
	if (Existe (anio,archivo)) then begin
		reset (archivo);
		while not eof(archivo) and not (termine) do begin
			totalanio:=0;
			read(archivo, act);
			writeln(anio);
			while (act.anio <> anio) do read (archivo,act);
			regm:=act;
			while (anio = act.anio) do begin
				totalmes:=0;
				writeln(regm.mes);
				while (act.mes = regm.mes) do begin
					totaldia:=0;
					writeln (regm.dia);
					while (act.dia = regm.dia) do begin
						totalUser:=0
						writeln (regm.idUsuario);
						while (act.idUsuario = regm.idUsuario) do begin	
							totalUser:= totalUser + regm.tiempodeacceso;
							read (archivo,act);
						end;
						totaldia:=totaldia + totalUser;
						write ('total de acceso del dia por el usuario: ', totalUser);
						regm.idUsuario:= act.idUsuario;
					end;
					totalmes:= totalmes + totaldia;
					writeln('total de acceso del dia: ', totaldia);
					regm.dia:= act.dia;
				end;
				totalanio:= totalanio + totalmes;
				writeln ('total de acceso del mes: ', totalmes);
				regm.mes:= act.mes;
			end;
			writeln ('total de acceso del año: ', totalanio);
			termine := true;
		end;
	end
	else writeln ('año no existente en el archivo'); 
end;


var
	archivo : arch;
begin
	assign (archivo , 'X.dat');
	imprimirFormato (archivo);
end.
