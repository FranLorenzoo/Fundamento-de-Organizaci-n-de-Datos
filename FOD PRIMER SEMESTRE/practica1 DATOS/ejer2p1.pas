program frans;
type
	archi = file of integer;
Var
	archivo : archi;
	a:integer;
begin
	assign (archivo, 'C:\Users\usuario\Desktop\Fran\2024 FACULTAD\FOD PRIMER SEMESTRE\pe.dat');
	reset (archivo);
	while not (EOF(archivo)) do begin
		read(archivo,a);
		if (a <= 1500)then
			writeln (a);
	end;
	close(archivo);
end.
