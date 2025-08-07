import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(const MyApp());
}

// Główna aplikacja Fluttera
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Formularz',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyFormPage(), // <-- formularz jako osobny ekran
    );
  }
}

// Ekran z formularzem
class MyFormPage extends StatefulWidget {
  const MyFormPage({super.key});

  @override
  State<MyFormPage> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _playerTag = TextEditingController();

  @override
  void dispose() {
    _playerTag.dispose();
    super.dispose();
  }

  void _submit() async{
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));

  if (response.statusCode == 200) {
    print('Dane: ${response.body}');
  } else {
    print('Błąd: ${response.statusCode}');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formularz')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _playerTag,
                decoration: const InputDecoration(
                  hintText: 'Insert your plater tag',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please insert valid player tag';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Wyślij'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
