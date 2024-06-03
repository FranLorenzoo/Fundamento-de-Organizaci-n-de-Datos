program ejer1;
const
	orden = 3;
type
	alumnos = record
		nombrecom : string[50];
		dni:integer;
		legajo:integer;
		anioingreso:integer;
	end;
	
	lista=^nodo2;
	nodo2=record
		dato:longint;
		sig:lista;
	end;
	
	nodo = record
		cantclaves:integer;
		claves:array[1..orden-1] of longint;
		enlaces:array[1..orden-1] of integer;
		hijos:array[1..orden] of integer;
		datos:lista;
	end;
	arbolB+ = file of nodo;
	archivo = file of alumnos;
