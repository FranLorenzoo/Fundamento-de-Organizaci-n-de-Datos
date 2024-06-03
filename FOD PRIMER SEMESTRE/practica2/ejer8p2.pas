program Frans;
const
	valorAlto=30000;
type
	cliente=record
		codigocliente:integer;
		nombre: string [20];
		apellido: string [20];
	end;
	
	empresa = record;
		cli:cliente;
		anio:integer;
		mes:integer;
		dia:integer;
		monto:real;
	end;
	
	maestro= file of empresa;
	
procedure Informar (master:maestro);
var
	corte,emp:empresa
	montoTot,montoMens, montoAn:real;
begin
	montoTot:=0;
	reset(master);
	while not (eof(master)) do begin
		read(master,emp);
		corte:=emp;
		while (emp.cli.codigocliente=corte.cli.codigocliente)do begin
			montoAn:=0;
			writeln ('cliente : ', corte.cli.codigocliente, corte.cli.nombre, corte.cli.apellido);
			while (emp.anio = corte.anio) do begin
				montoMens:=0;
				while (emp.mes = coret.mes) do begin;
					montoMens:= montoMens + emp.monto;
					read(master,emp);
				end;
				write ('cantidad gastada en el mes de ', corte.mes, 'por el cliente fue: ', montoMens, '$');
				montoAn:= montoAn + montoMens;
			end;
			write ('cantidad gastada en el mes de ', corte.anio, 'por el cliente fue: ', montoAn, '$');
			writeln('');
		end;
	end;	
end;
	
var
	master:maestro
begin
	assign (master, 'masterVentas.dat');
	Informar(master);
end.
