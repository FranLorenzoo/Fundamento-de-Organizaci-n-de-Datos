program fran;

var
	i:integer;
	fisicname:String;
	archiEnteros : file of integer;
begin
	writeln ('ingrese nombre del archivo');
	read (fisicname);
	assign(archiEnteros, fisicname);
	rewrite(archiEnteros);
	writeln ('ingrese numero a insertar en el archivo: ');
	readln (i);
	while not(i=3000) do begin
		write(archiEnteros, i);
		writeln ('ingrese numero a insertar en el archivo: ');
		readln (i);
	end;
	close(archiEnteros);
end.
