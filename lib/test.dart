import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends State<MyApp> {
String numero = 'Número' ;

double primeiroNumero = 0.0;

void calcular(String tecla) {
 switch (tecla) {

  case '0':
  case '1':
  case '2':
  case '3':
  case '4':
  case '5':
  case '6':
  case '7':
  case '8':
  case '9':
  case ',':
  setState(() {
    numero += tecla;

    numero = numero.replaceAll(',', '.');

    if (numero.contains ('.')) {

    } else {
      int numeroInt = int.parse(numero);
      numero = numeroInt.toString();
    }
    numero = numero.replaceAll('.', ',');
  
  });

  break
  
 }
}


}
