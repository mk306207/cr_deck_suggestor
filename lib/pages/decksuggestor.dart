import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DeckSuggestor extends StatelessWidget {
  final Map<String, dynamic>playerData, decks;

  const DeckSuggestor({
    Key? key,
    required this.playerData,
    required this.decks,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Deck Suggestor")),
      body: Center(
        child: Text("Player data loaded!"),
      ),
    );
  }
}