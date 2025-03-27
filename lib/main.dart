import 'dart:math';
import 'package:flutter/material.dart';

const List<String> list = <String>['Masculino', 'Feminino'];

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Remove a marca d'água "DEBUG"
    home: const Saude(),
    theme: ThemeData(hintColor: Colors.green, primaryColor: Colors.white),
  ));
}

class Saude extends StatefulWidget {
  const Saude({super.key});

  @override
  State<Saude> createState() => _Saude();
}

class _Saude extends State<Saude>{
  var txtAltura =
  TextEditingController();

  var txtPeso =
  TextEditingController();

  var txtIdade =
  TextEditingController();

  late double altura;
  late double peso;
  late double idade;
  late double fator;

  String dropdownValue = list.first;

  double _resultImc = 0;
  double _resultIg = 0;

  @override
  Widget build(BuildContext context){
    return(Scaffold(
      appBar: AppBar(
        title: const Text('Calculos Saudaveis'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(
          Icons.accessibility_new,
          color: Colors.lightBlue,
          size: 180.0,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: txtAltura,
                decoration: const InputDecoration(
                  labelText: 'Altura',
                  labelStyle: TextStyle(
                    color: Colors.lightBlue,
                  ),
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(color: Colors.lightBlue, fontSize: 25.0),
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: txtPeso,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  labelText: 'Peso',
                  labelStyle: const TextStyle(color: Colors.lightBlue),
                  border: const OutlineInputBorder(),
                ),
                style: const TextStyle(color: Colors.lightBlue, fontSize: 25.0),

                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: txtIdade,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  labelText: 'Idade',
                  labelStyle: const TextStyle(color: Colors.lightBlue),
                  border: const OutlineInputBorder(),
                ),
                style: const TextStyle(color: Colors.lightBlue, fontSize: 25.0),

                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center( // Envolve o DropdownButton para centralizá-lo
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.lightBlue),
                  underline: Container(height: 2, color: Colors.deepPurpleAccent),
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(value: value, child: Text(value));
                  }).toList(),
                ),
              ),
            ),

            Center(
              child: FittedBox(
                child: FloatingActionButton(
                  backgroundColor: Colors.lightBlue,
                  onPressed: _calculaSaude,
                  child: const Text('OK'),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Text('Seu imc é de $_resultImc'),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Text('Seu ig é de $_resultIg'),
            ),
          ],
        )
      ]),
    ));
  }

  void _calculaSaude(){
    altura = double.parse(txtAltura.text);
    peso = double.parse(txtPeso.text);
    idade = double.parse(txtIdade.text);
    fator = dropdownValue == 'Masculino' ? 1 : 0.8;


    setState(() {
      _resultImc = double.parse((peso / pow(altura, 2)).toStringAsFixed(2));
      _resultIg = double.parse(((1.2 * _resultImc) + (0.23 * idade -10.8 * fator) - 5.4).toStringAsFixed(2));

    });
  }
}