program Frans;
const
	valorAlto = 32000;
type
	novela = record
		precio:real;
		codigoNovela:integer;
		genero:String[16];
		Nombre:String[30];
		end;
		
	archivo = file of novela;
	

procedure Leer (var archi:archivo; var Nov:novela);
begin
	if not (eof(archi)) then begin
			read(archi,Nov)
	end
	else Nov.codigoNovela:=valorAlto;
end;

procedure leerNovela (var n:novela);
begin
	writeln ('ingresar nombre: ');
	read(n.Nombre);
	writeln ('ingresar codigo de la novela: ');
	read(n.codigoNovela);
	writeln ('ingresar precio de la novela: ');
	read(n.precio);
	writeln ('ingresar genero de la novela: ');
	read(n.genero);
end;

procedure CargarBinario (var novelas:text; var archi:archivo);
var
	n:novela;
begin
	rewrite (archi);
	reset(novelas);
	while not(eof(novelas)) do begin
		read(novelas, n.precio, n.codigoNovela, n.genero,
				n.Nombre);
		write(archi,n);
	end;
	close(novelas);
	close(archi);
end;

procedure BuscarNovela (var archi:archivo);
var
	act,n:novela;
begin
	reset(archi);
	writeln('ingresar el codigo de la novela a buscar: ');
	readln (n.codigoNovela);
	leer(archi,act);
	while (act.codigoNovela<>valorAlto)and(act.codigoNovela<>n.codigoNovela) do begin
		leer(archi,act);
	end;
	if (act.codigoNovela = n.codigoNovela) then writeln('Nombre: ', n.Nombre, 
														'Precio: ', n.precio,
														'Genero de la novela: ', n.genero,
														'Codigo de la novela: ', n.codigoNovela)
	else writeln ('no se encontro la novela que buscabas.');
	close(archi);
end;

procedure AgregarNovela( var archi:archivo);
var
	n:novela;
begin
	reset (archi);
	writeln('ingrese los siguientes datos de la novela que desea agregar... ');
	leerNovela(n);
	seek(archi, fileSize(archi));
	write(archi,n);
	close(archi);
end;

procedure ModificarNovela (var archi:archivo);
var
	n,act:novela;
begin
	reset(archi);
	writeln('ingresar el codigo de la novela a buscar: ');
	readln (n.codigoNovela);
	leer(archi,act);
	while (act.codigoNovela<>valorAlto)and(act.codigoNovela<>n.codigoNovela) do begin
		leer(archi,act);
	end;
	if (act.codigoNovela = n.codigoNovela) then begin
		writeln ('ingrese los nuevos datos de la novela a modificar...');
		leerNovela(n);
		seek(archi,filePos(archi)-1);
		write(archi,n);
	end;
	close(archi);
end;

var
	archi:archivo;
	novelas: text;
	opcion : char;
begin
	assign (novelas, 'novelas.txt');
	assign (archi, 'novelas.dat');
	CargarBinario(novelas,archi);
	repeat
		writeln('ingrese 1 si desea modificar una novela | ingrese 2 si desea agregar una novela | ingrese 3 si desea buscar una novela por su codigo | ingrese F si desea la finalizacion del programa :');
		readln (opcion);
		case opcion of
			'1' : ModificarNovela(archi);
			'2' : AgregarNovela(archi);
			'3' : BuscarNovela(archi);
		end;
	until (opcion = 'F');
end.
