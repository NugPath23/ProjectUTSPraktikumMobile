import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator Kabataku',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Kalkulator Kabataku'),
        ),
        body: const KalkulatorForm(),
      ),
    );
  }
}

class KalkulatorForm extends StatefulWidget {
  const KalkulatorForm({super.key});

  @override
  State<KalkulatorForm> createState() => _KalkulatorFormState();
}

class _KalkulatorFormState extends State<KalkulatorForm> {
  final TextEditingController _angka1Controller = TextEditingController();
  final TextEditingController _angka2Controller = TextEditingController();
  String _hasil = "";

  void _hitung(String operasi) {
    double angka1 = double.tryParse(_angka1Controller.text) ?? 0;
    double angka2 = double.tryParse(_angka2Controller.text) ?? 0;
    double result = 0;

    switch (operasi) {
      case '+':
        result = angka1 + angka2;
        break;
      case '-':
        result = angka1 - angka2;
        break;
      case 'x':
        result = angka1 * angka2;
        break;
      case '/':
        if (angka2 != 0) {
          result = angka1 / angka2;
        } else {
          setState(() {
            _hasil = "Error: Tidak bisa dibagi 0";
          });
          return;
        }
        break;
    }

    setState(() {
      _hasil = "Hasil: $result";
    });
  }

  @override
  void dispose() {
    _angka1Controller.dispose();
    _angka2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: _angka1Controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Angka Pertama",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _angka2Controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Angka Kedua",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () => _hitung('+'), child: const Text('+')),
              ElevatedButton(
                  onPressed: () => _hitung('-'), child: const Text('-')),
              ElevatedButton(
                  onPressed: () => _hitung('x'), child: const Text('x')),
              ElevatedButton(
                  onPressed: () => _hitung('/'), child: const Text('/')),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            _hasil,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
