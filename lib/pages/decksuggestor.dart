import 'package:flutter/material.dart';

class DeckSuggestor extends StatelessWidget {
  final Map<String, dynamic> data;

  const DeckSuggestor({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final entries = data.entries
        .toList();
    final deckList = data.entries
        .map(
          (e) => {
            "title": e.key,
            "points": e.value["points"],
            "cards": e.value["cards"]
          },
        )
        .toList();
    return Scaffold(
      appBar: AppBar(title: const Text("Decki")),
      body: ListView.builder(
        itemCount: deckList.length,
        itemBuilder: (context, index) {
          final deck = deckList[index];
          return ExpansionTile(
            title: Text("${deck["title"]}   ${deck["points"].toString()}/100"),
            children: [Text("Cards in deck: ${deck["cards"].join(", ")}"),]
          );
        },
      ),
    );
  }
}
