program Frans;
const
	valorAlto=30000;
type
	novela = record
		codigo:integer;
		genero:string[20];
		nombre:string[41];
		duracion:real;
		precio:real;
		director:string[41];
	end;
	
	archivoNovela = file of novela;
	
procedure LeerEmpleado (var e:novela);
begin
	writeln ('ingrese el apellido del empleado: ');
	readln(e.codigo);
	if (e.codigo <> valorAlto) then begin
		writeln ('ingrese el Edad del empleado: ');
		readln(e.genero);
		writeln ('ingrese el nombre del empleado: ');
		readln(e.nombre);
		writeln ('ingrese el DNI del empleado: ');
		readln(e.duracion);
		writeln ('ingrese el Numero de Empleado del empleado: ');
		readln(e.precio);
		readln(e.director);
	end;
end;

	
procedure cargarArchivo (var archi : archivoNovela);
var
	reg:novela;
begin
	rewrite(archi);
	reg.codigo=0;
	write(archi, reg);
	while (reg.codigo <> valorAlto) do begin
		LeerEmpleado(reg);
		write(archi,reg);
	end;
	close(archi);
end;

procedure darDeAlta ( var archi : archivoNovela ; elem : novela ) ; 
var
	reg:novela;
	index:integer;
begin
	reset (archi);
	read(archi,reg);
	if (reg.codigo <> 0) then begin
		seek (archi, reg.codigo * -1);
		read(archi,reg);
		index:=reg.codigo);
		seek(archi, filePos(archi)-1);
		reg:=elem;
		write(archi,reg);
		seek(archi,0);
		read(archi,reg);
		reg.codigo:=index;
		seek(archi,0);
		write(archi,reg);
	end;
	close(archi);
end;

procedure darDeBaja (var archi : archivoNovela ; pos : integer);
var
	reg:novela;
	index:integer;
begin
	reset(archi);
	read(archi,reg);
	if (reg.codigo<>0) then begin
		seek(archi,reg.codigo *-1);
		read(archi,reg);
		index:=reg.codigo;
		seek(archi,0);
		read(archi,reg);
		reg.codigo:=pos*-1;
		seek(archi,0);
		write(archi,reg);
		seek(archi,pos);
		read(archi,reg);
		reg.codigo:=index;
		seek(archi, filePos(archi)-1);
		write(archi,reg);
	end
	else begin
		reg.codigo:=pos*-1;
		seek(archi,filePos(archi)-1);
		write(archi,reg);
		seek(archi,pos);
		read(archi,reg);
		reg.codigo:=0;
		seek(archi, filePos(archi)-1);
		write(archi,reg);
	end;
	close(archi);
end;

