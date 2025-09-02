import 'package:cr_deck_suggestor/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test',
      theme: ThemeData(
        //brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 160, 134, 205),
        ),
        useMaterial3: true,
      ),
      // initialRoute: 'search',
      // routes:{
      //   'search':(context) => const MyFormPage(),
      //   'profile':(context) => Profile(text: "placeholder")
      // },
      home: const MyFormPage(),
    );
  }
}

class MyFormPage extends StatefulWidget {
  const MyFormPage({super.key});
  @override
  State<MyFormPage> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _playerTag = TextEditingController();
  bool _saving = false;
  
  @override
  void dispose() {
    _playerTag.dispose();
    super.dispose();
  }

  void _submit() async {
    setState(() {
      _saving = true;
    });
    final playerData = await http.get(
      Uri.parse(
        'https://crproxy-production-6a8c.up.railway.app/player/${_playerTag.text}',
      ),
    );
    final decksData = await http.get(
      Uri.parse('https://crproxy-production-6a8c.up.railway.app/getDecks'),
    );
    if (playerData.statusCode == 200 && decksData.statusCode == 200) {
      print('Data: ${_playerTag.text}');

      final test = json.decode(playerData.body);
      if ((test["name"]) == null) {
        Fluttertoast.showToast(
          msg: "Incorrect player tag: ${_playerTag.text}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        setState(() {
          _saving = false;
        });
      } else {
        setState(() {
          _saving = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Profile(
              text: _playerTag.text,
              responsePlayer: playerData,
              responseDecks: decksData,
            ),
          ),
        );
      }
    } else {
      setState(() {
        _saving = false;
      });
      Fluttertoast.showToast(
        msg: "Error: ${playerData.statusCode}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        progressIndicator: CircularProgressIndicator(color: Colors.teal),

        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.teal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "DECK SUGGESTOR FOR CLASH ROYALE",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Mateusz Kolber",
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 150, horizontal: 15),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black12,
                ),
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _playerTag,
                        decoration: InputDecoration(
                          hintText: 'Insert your player tag',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please insert a valid player tag';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _submit,
                        style: ButtonStyle(
                          overlayColor: getColor(Colors.white, Colors.teal),
                          foregroundColor: getColor(Colors.teal, Colors.white),
                        ),
                        child: const Text('Search'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  WidgetStateProperty<Color> getColor(Color color, Color colorPressed) {
    return WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (states.contains(WidgetState.pressed)) {
        return colorPressed;
      } else {
        return color;
      }
    });
  }
}
