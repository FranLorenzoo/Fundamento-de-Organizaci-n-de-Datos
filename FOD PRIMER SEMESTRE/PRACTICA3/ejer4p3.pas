program frans;
const
	valorAlto=30000;
type
	regflor=record
		nombre: string [45];
		codigo:integer;
	end;
	
	archivo: file of regflor;
	
procedure agregarFlor (var archi:archivo; elem:regflor);
var
	reg:regflor;
	index:integer;
begin
	reset(archi);
	read(archi,reg);
	if (reg.codigo<>0) then begin
		seek(archi,reg.codigo *-1);
		read(archi,reg);
		index:=reg.codigo;
		seek(archi,filePos(archi)-1);
		write(archi,elem);
		seek(archi,0);
		read(archi,reg);
		reg.codigo:=index;
		seek(archi,0);
		write(archi,reg);
	end
	else begin
		seek(archi,fileSize(archi)-1);
		write(archi,elem);
	end;
	close(archi);
end;	

procedure eliminarFlor (var archi:archivo; flor:regflor);
var
	reg:regflor;
	index:integer;
begin
	reset(archi);
	read(archi,reg);
	index:=reg.codigo;
	while not eof(archi) and (reg.codigo <> flor.codigo) do read(archi,reg);
	seek(archi, filePos(archi)-1);
	reg.codigo:=index;
	write(archi,reg);
	index:=filePos(archi);
	seek(archi,0);
	read(archi,reg);
	reg.codigo:=index*-1;
	seek(archi,0);
	write(archi,reg);

	close(archi);
end;
	
var
	archi:archivo;
begin
	assign(archivo, 'archivoflores.dat');
end.
