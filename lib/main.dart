import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF202124),
      ),
      home: const CalculadoraGoogle(),
    );
  }
}

class CalculadoraGoogle extends StatefulWidget {
  const CalculadoraGoogle({super.key});

  @override
  State<CalculadoraGoogle> createState() => _CalculadoraGoogleState();
}

class _CalculadoraGoogleState extends State<CalculadoraGoogle> {
  String display = "0";

 void onKeyPress(String label) {
    setState(() {
      if (label == "AC") {
        display = "0";
      } else if (label == "=") {
        try {
          // Identifica qual operador está no display
          String operador = "";
          if (display.contains('+')) operador = '+';
          else if (display.contains('-')) operador = '-';
          else if (display.contains('×')) operador = '×';
          else if (display.contains('÷')) operador = '÷';

          if (operador.isNotEmpty) {
         
            List<String> partes = display.split(operador);
            
            if (partes.length == 2 && partes[1].isNotEmpty) {
              double num1 = double.parse(partes[0].replaceAll(',', '.'));
              double num2 = double.parse(partes[1].replaceAll(',', '.'));
              double resultado = 0;

              if (operador == '+') resultado = num1 + num2;
              if (operador == '-') resultado = num1 - num2;
              if (operador == '×') resultado = num1 * num2;
              if (operador == '÷') resultado = num1 / num2;

          
              display = resultado % 1 == 0 
                  ? resultado.toInt().toString() 
                  : resultado.toStringAsFixed(2);
            }
          }
        } catch (e) {
          display = "Erro";
        }
      } else {
    
        if (display == "0" && label != '.') {
          display = label;
        } else {
          display += label;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
      
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(Icons.history, color: Colors.grey, size: 28),
                  const Spacer(),
                  Text(
                    display,
                    style: const TextStyle(fontSize: 80, color: Colors.white, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ),
      
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFF202124),
              ),
              child: Column(
                children: [
                  buildRow(['Deg', 'Rad', 'x!', '(', ')', '%', 'AC'], isTopRow: true),
                  buildRow(['Inv', 'sin', 'ln', '7', '8', '9', '÷']),
                  buildRow(['π', 'cos', 'log', '4', '5', '6', '×']),
                  buildRow(['e', 'tan', '√', '1', '2', '3', '-']),
                  buildRow(['Ans', 'EXP', 'xʸ', '0', '.', '=', '+'], isLastRow: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRow(List<String> labels, {bool isTopRow = false, bool isLastRow = false}) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: labels.map((label) => buildButton(label)).toList(),
      ),
    );
  }

  Widget buildButton(String label) {
    bool isNumeric = RegExp(r'[0-9.]').hasMatch(label);
    bool isBlue = label == '=';
    
  
    Color textColor = Colors.white;
    Color bgColor = const Color(0xFF303134);

    if (isBlue) {
      bgColor = const Color(0xFFD2E3FC);
      textColor = const Color(0xFF202124);
    } else if (!isNumeric && label != 'AC') {
      bgColor = const Color(0xFF3C4043); 
      textColor = const Color(0xFFBDC1C6);
    } else if (label == 'AC') {
       textColor = const Color(0xFFBDC1C6);
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          onPressed: () => onKeyPress(label),
          child: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: isNumeric ? 24 : 18,
              fontWeight: isNumeric ? FontWeight.normal : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}