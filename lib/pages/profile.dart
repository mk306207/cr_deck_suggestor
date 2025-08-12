import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Profile extends StatelessWidget {
  final String text;
  final http.Response responsePlayer, responseDecks;
  Profile({
    Key? key,
    required this.text,
    required this.responsePlayer,
    required this.responseDecks,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final jsondata = json.decode(responsePlayer.body);
    print(jsondata["achievements"]);
    return Scaffold(
      appBar: AppBar(
        title: Text(jsondata["name"]),
        backgroundColor: Colors.teal,
        bottom: PreferredSize(
          preferredSize: Size(10, 200),
          child: Column(children: [Text("aha"), Text("aha1")]),
        ),
      ),
    );
  }
}
