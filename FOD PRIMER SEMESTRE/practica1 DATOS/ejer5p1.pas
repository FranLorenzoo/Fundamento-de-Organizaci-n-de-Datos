program Frans;
const
	valorAlto = 32767;
type
	celular = record
		stock:integer;
		stockDisponible:integer;
		codigoCelular:integer;
		precio:real;
		marca:string[10];
		descripcion:string;
		end;
		
	archivo= file of celular;

procedure ListarStockMenor(var archi:archivo);
var
	celu:celular;
begin
	reset (archi);
	while not (eof(archi)) do begin
		read(archi,celu);
		if(celu.stockDisponible<celu.stock)then write(celu.stock,' ', celu.stockDisponible, ' ', celu.precio, ' ', celu.codigoCelular, ' ', celu.marca, ' ', celu.descripcion);
	end;
	close(archi);
end;

procedure leer (var archi:archivo; var celu:celular);
begin
	if not (eof(archi)) then begin
			read(archi,celu)
	end
	else celu.stock:=valorAlto;
end;
		
procedure ExportarStockMenor(var archi:archivo);
var
	celu:celular;
	archi2:text;
begin
	assign (archi2, 'celularesConStockMinimo.txt');
	rewrite(archi2);
	reset (archi);
	leer(archi,celu);
	while not (celu.stock = valorAlto) do begin
		read(archi,celu);
		write(archi2,celu.stock,' ', celu.stockDisponible, ' ', celu.precio, ' ', celu.codigoCelular, ' ', celu.marca, ' ', celu.descripcion);
	end;
	close(archi);
	close(archi2);
end;
procedure cargarArchivo (var archi:archivo; var celulares:text);
var
	celu:celular;
begin
	reset(celulares);
	rewrite(archi);
	while not(eof(celulares)) do begin
		read (celulares, celu.stock, celu.stockDisponible, celu.codigoCelular, celu.precio, celu.marca, celu.descripcion);
		write(archi,celu);
	end;
	close(archi);
	close(celulares);
end;

var
	celulares:text;
	archi:archivo;
begin
	assign(celulares, 'celulares.txt');
	assign(archi, 'celulares.dat');
	cargarArchivo(archi,celulares);
	ListarStockMenor(archi);
	close(celulares)
end.
