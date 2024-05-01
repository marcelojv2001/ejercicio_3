import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roman Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RomanCalculator(),
    );
  }
}

class RomanCalculator extends StatefulWidget {
  @override
  _RomanCalculatorState createState() => _RomanCalculatorState();
}

class _RomanCalculatorState extends State<RomanCalculator> {
  TextEditingController roman1Controller = TextEditingController();
  TextEditingController roman2Controller = TextEditingController();
  TextEditingController roman3Controller = TextEditingController();

  String resultadoDecimal = '';
  String resultadoRomano = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Roman Calculator'),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          
          children: [
            TextField(
              controller: roman1Controller,
              decoration: InputDecoration(labelText: 'Número romano 1'),
            ),
            
            TextField(
              controller: roman2Controller,
              decoration: InputDecoration(labelText: 'Número romano 2'),
            ),
            TextField(
              controller: roman3Controller,
              decoration: InputDecoration(labelText: 'Número romano 3'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                calcularResultado();
              },
              child: Text('Calcular'),
            ),
            SizedBox(height: 20),
            Text('El resultado en números decimales es: $resultadoDecimal'),
            Text('El resultado en números romanos es: $resultadoRomano'),
          ],
        ),
      ),
    );
  }

  void calcularResultado() {
    String romanNumeral1 = roman1Controller.text;
    String romanNumeral2 = roman2Controller.text;
    String romanNumeral3 = roman3Controller.text;

    int decimal1 = romanToDecimal(romanNumeral1);
    int decimal2 = romanToDecimal(romanNumeral2);
    int decimal3 = romanToDecimal(romanNumeral3);

    int resultadoDecimalInt = decimal1 * decimal2 * decimal3;
    String resultadoRomanoString = decimalToRoman(resultadoDecimalInt);

    setState(() {
      resultadoDecimal = resultadoDecimalInt.toString();
      resultadoRomano = resultadoRomanoString;
    });
  }

  int romanToDecimal(String roman) {
    Map<String, int> romanMap = {
      'I': 1,
      'V': 5,
      'X': 10,
      'L': 50,
      'C': 100,
      'D': 500,
      'M': 1000
    };

    int result = 0;
    int prevValue = 0;

    for (int i = roman.length - 1; i >= 0; i--) {
      int value = romanMap[roman[i]]!;
      if (value < prevValue) {
        result -= value;
      } else {
        result += value;
      }
      prevValue = value;
    }

    return result;
  }

  String decimalToRoman(int number) {
    final romanNumerals = [
      'I',
      'IV',
      'V',
      'IX',
      'X',
      'XL',
      'L',
      'XC',
      'C',
      'CD',
      'D',
      'CM',
      'M'
    ];
    final decimalValues = [
      1,
      4,
      5,
      9,
      10,
      40,
      50,
      90,
      100,
      400,
      500,
      900,
      1000
    ];

    String result = '';
    for (int i = romanNumerals.length - 1; i >= 0; i--) {
      while (number >= decimalValues[i]) {
        result += romanNumerals[i];
        number -= decimalValues[i];
      }
    }

    return result;
  }
}
