import 'dart:convert';
import 'package:cr_deck_suggestor/pages/AnimatedBar.dart';
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

    final commonCount = jsondata['everyCardCount']['common'];
    final rareCount = jsondata['everyCardCount']['rare'];
    final epicCount = jsondata['everyCardCount']['epic'];
    final legendaryCount = jsondata['everyCardCount']['legendary'];
    final championCount = jsondata['everyCardCount']['champion'];

    final commonMissingCount = jsondata['missingCardCount']['common'];
    final rareMissingCount = jsondata['missingCardCount']['rare'];
    final epicMissingCount = jsondata['missingCardCount']['epic'];
    final legendaryMissingCount = jsondata['missingCardCount']['legendary'];
    final championMissingCount = jsondata['missingCardCount']['champion'];

    var commonWidth = 90.0;
    var rareWidth = 110.0;
    var epicWidth = 100.0;
    var legendaryWidth = 75.0;
    var championWidth = 30.0;

    final oneCommonWidth = commonWidth / commonCount;
    final oneRareWidth = rareWidth / rareCount;
    final oneEpicWidth = epicWidth / epicCount;
    final oneLegendaryWidth = legendaryWidth / legendaryCount;
    final oneChampionWidth = championWidth / championCount;

    final missingProgressBarCommon = oneCommonWidth * commonMissingCount;
    final missingProgressBarRare = oneRareWidth * rareMissingCount;
    final missingProgressBarEpic = oneEpicWidth * epicMissingCount;
    final missingProgressBarChamp = oneLegendaryWidth * legendaryMissingCount;
    final missingProgressBarLegendary = oneChampionWidth * championMissingCount;

    commonWidth = commonWidth - missingProgressBarCommon;
    rareWidth = rareWidth - missingProgressBarRare;
    epicWidth = epicWidth - missingProgressBarEpic;
    legendaryWidth = legendaryWidth - missingProgressBarLegendary;
    championWidth = championWidth - missingProgressBarChamp;

    //final commonMissingWidth
    //print('${commonCount} - ${rareCount} - ${epicCount} - ${legendaryCount} - ${championCount}');
    return Scaffold(
      appBar: AppBar(
        title: Text(jsondata["name"]),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Column(
            children: [
              Text("Progression bar"),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      AnimatedBar(
                        targetWidth: commonWidth,
                        color: const Color.fromARGB(255, 96, 148, 191),
                      ),
                      //90 overall
                      //Text("Common", style: TextStyle(fontSize: 5),),
                    ],
                  ),
                  AnimatedBar(
                    targetWidth: missingProgressBarCommon,
                    color: const Color.fromARGB(255, 137, 136, 136),
                  ),
                  Column(
                    children: [
                      AnimatedBar(targetWidth: rareWidth, color: Colors.orange),
                      //Text("Rare", style: TextStyle(fontSize: 5),),
                    ],
                  ),
                  AnimatedBar(
                    targetWidth: missingProgressBarRare,
                    color: const Color.fromARGB(255, 137, 136, 136),
                  ),
                  Column(
                    children: [
                      AnimatedBar(targetWidth: epicWidth, color: Colors.purple),
                      //Text("Epic", style: TextStyle(fontSize: 5),),
                    ],
                  ),
                  AnimatedBar(
                    targetWidth: missingProgressBarEpic,
                    color: const Color.fromARGB(255, 137, 136, 136),
                  ),
                  Column(
                    children: [
                      AnimatedBar(
                        targetWidth: legendaryWidth,
                        color: const Color.fromARGB(255, 135, 202, 249),
                      ),
                      //Text("Legendary", style: TextStyle(fontSize: 5),),
                    ],
                  ),
                  AnimatedBar(
                    targetWidth: missingProgressBarLegendary,
                    color: const Color.fromARGB(255, 137, 136, 136),
                  ),
                  Column(
                    children: [
                      AnimatedBar(
                        targetWidth: championWidth,
                        color: Colors.yellow,
                      ),
                      //Text("Champion", style: TextStyle(fontSize: 1),),
                    ],
                  ),
                  AnimatedBar(
                    targetWidth: missingProgressBarChamp,
                    color: const Color.fromARGB(255, 137, 136, 136),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
