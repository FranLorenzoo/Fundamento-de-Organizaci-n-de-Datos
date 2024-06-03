program francis;
const
	valorAlto = 37000;
type celular = record
		stock:integer;
		stockDisponible:integer;
		codigoCelular:integer;
		precio:real;
		marca:string[10];
		descripcion:string;
		end;
		
	archivo= file of celular;

procedure leer(var archi:archivo; var celu:celular);
begin
	if not (eof(archi)) then begin
			read(archi,celu)
	end
	else celu.stock:=valorAlto;
end;

procedure CargarAlFinal( var archi:archi);
var
	c:celular;
begin
	reset(archi);
	seek(archi,fileSize(archi)-1);
	leer (c);
	while (c.stock<>0)do begin
		write (archi,c);
		leer(c);
	end;
	close(archi);
end;

procedure 	ExportarSinStock(var archi:archivo);
var
	c:celular;
	sinStock:text;
begin
	assign(sinStock, 'SinStock.txt');
	rewrite(sinStock);
	reset(archi);
	leer(archi,c);
	while (c.stock<>valorAlto) do begin
		if(celu.stockDisponible=0)then write(sinStock, celu.stock,' ', celu.stockDisponible, ' ', celu.precio, ' ', celu.codigoCelular, ' ', celu.marca, ' ', celu.descripcion);
		leer(archi,c);
	end;
end;

var
	celulares:text;
	archi:archivo;
begin
	assign(celulares, 'celulares.txt');
	assign(archi, 'celulares.dat');
	CargarAlFinal(celulares);
	ModificarDeUnStockDado(archi);
	ExportarSinStock(archi);
	close(celulares);
	close(arch);
end;
