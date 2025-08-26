import 'dart:convert';
import 'package:cr_deck_suggestor/pages/AnimatedBar.dart';
import 'package:cr_deck_suggestor/pages/card.dart';
import 'package:cr_deck_suggestor/pages/decksuggestor.dart';
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
    final decksdata = json.decode(responseDecks.body);
    final jsondata = json.decode(responsePlayer.body);
    final currentDeck = jsondata["currentDeck"];
    final commonCount = jsondata['everyCardCount']['common'];
    final rareCount = jsondata['everyCardCount']['rare'];
    final epicCount = jsondata['everyCardCount']['epic'];
    final legendaryCount = jsondata['everyCardCount']['legendary'];
    final championCount = jsondata['everyCardCount']['champion'];
    final cardsCount =
        commonCount + rareCount + epicCount + legendaryCount + championCount;

    final commonMissingCount = jsondata['missingCardCount']['common'];
    final rareMissingCount = jsondata['missingCardCount']['rare'];
    final epicMissingCount = jsondata['missingCardCount']['epic'];
    final legendaryMissingCount = jsondata['missingCardCount']['legendary'];
    final championMissingCount = jsondata['missingCardCount']['champion'];
    final missingCardsCount =
        commonMissingCount +
        rareMissingCount +
        epicMissingCount +
        legendaryMissingCount +
        championMissingCount;

    var explevel = jsondata['expLevel'];
    final wins = jsondata['wins'];
    final losses = jsondata['losses'];
    final arena = jsondata['arena']['name'];
    final trophies = jsondata['trophies'];

    var commonWidth = 90.0;
    var rareWidth = 110.0;
    var epicWidth = 100.0;
    var legendaryWidth = 75.0;
    var championWidth = 30.0;
    var level = 0;

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

    var deck = [];
    if (explevel <= 10) {
    } else {
      level = 6;
      explevel -= 10;
      var counter = 0;
      while (explevel > 0) {
        explevel -= 1;
        counter += 1;
        if (counter == 4) {
          level += 1;
          counter = 0;
        }
      }
    }
    //print(currentDeck.length);
    num cardLevels = 0;
    for (var myCard in currentDeck) {
      var c;
      var path = myCard['iconUrls'];
      try {
        var test = myCard['evolutionLevel'];
        c = crCard(myCard['name'], path['evolutionMedium'], myCard['level']);

        if (test == null) {
          c = crCard(myCard['name'], path['medium'], myCard['level']);
        }
      } on NoSuchMethodError {
        print("ERROR");
      }
      if (myCard['rarity'] == "common") {
        cardLevels += c.level;
      }
      if (myCard['rarity'] == "rare") {
        c.level += 2;
        cardLevels += c.level;
      }
      if (myCard['rarity'] == "epic") {
        c.level += 5;
        cardLevels += c.level;
      }
      if (myCard['rarity'] == "legendary") {
        c.level += 8;
        cardLevels += c.level;
      }
      if (myCard['rarity'] == "champion") {
        c.level += 10;
        cardLevels += c.level;
      }
      //print(path['medium']);
      //print(c.name);
      //print(c.image);

      deck.add(c);
    }
    //print(cardLevels);
    cardLevels = cardLevels / 8;
    //print(cardLevels);
    cardLevels = cardLevels.round();
    //cardLevels = 10;
    //print(cardLevels);
    var cardsToUpgrade = [];
    for (var myCard in deck) {
      if (myCard.level < cardLevels) {
        cardsToUpgrade.add(myCard);
      }
    }
    //print(cardLevels);
    //print(deck.length);
    //print(jsondata[5]);
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
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage("assets/crown.png"),
                    width: 40,
                    height: 50,
                    color: null,
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                  ),
                  SizedBox(width: 5),
                  Text("$level"),
                  SizedBox(width: 5),
                  Image(
                    image: AssetImage("assets/win.png"),
                    width: 50,
                    height: 50,
                    color: null,
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                  ),
                  Text("$wins"), //check it
                  SizedBox(width: 5),
                  Image(
                    image: AssetImage("assets/lose.png"),
                    width: 45,
                    height: 45,
                    color: null,
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                  ),
                  Text("$losses"), //
                  SizedBox(width: 10),
                  Image(
                    image: AssetImage("assets/deck.png"),
                    width: 35,
                    height: 35,
                    color: null,
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                  ),
                  SizedBox(width: 5),
                  Text("${cardsCount - missingCardsCount}/${cardsCount}"), //
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage("assets/arena.png"),
                    width: 35,
                    height: 35,
                    color: null,
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                  ),
                  SizedBox(width: 5),
                  Text("$arena"),
                  SizedBox(width: 10),
                  Image(
                    image: AssetImage("assets/troph.png"),
                    width: 35,
                    height: 35,
                    color: null,
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                  ),
                  SizedBox(width: 5),
                  Text("$trophies"),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Text("Current deck"),
          Container(
            height: 186.0,
            width: 364,
            //padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(143, 0, 150, 135),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
              color: const Color.fromARGB(143, 0, 150, 135),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.network(
                      deck[0].image,
                      width: 90,
                      height: 90,
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                    ),
                    Image.network(
                      deck[1].image,

                      width: 90,
                      height: 90,
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                    ),
                    Image.network(
                      deck[2].image,
                      width: 90,
                      height: 90,
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                    ),
                    Image.network(
                      deck[3].image,
                      width: 90,
                      height: 90,
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      deck[4].image,
                      width: 90,
                      height: 90,
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                    ),
                    Image.network(
                      deck[5].image,
                      width: 90,
                      height: 90,
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                    ),
                    Image.network(
                      deck[6].image,
                      width: 90,
                      height: 90,
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                    ),
                    Image.network(
                      deck[7].image,
                      width: 90,
                      height: 90,
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          //Text("Cards to upgrade: ${cardsToUpgrade.map((card) => card.name).join(", ")}")
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width:10),
              Image(
                image: cardsToUpgrade.isEmpty
                    ? AssetImage("assets/check1.png")
                    : AssetImage("assets/questionmark1.png"),
                width: 40,
                height: 40,
                color: null,
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
              ),
              SizedBox(width : cardsToUpgrade.isEmpty
                      ? 10
                      : 0),
              Flexible(
                child: (Text(
                  softWrap: true, // pozwala na zawijanie
                  overflow: TextOverflow.visible, // nic nie utnie
                  maxLines: null,
                  textAlign: TextAlign.center,
                  cardsToUpgrade.isEmpty
                      ? "Nothing to upgrade :)"
                      : "Cards to upgrade: ${cardsToUpgrade.map((card) => card.name).join(", ")}",
                ))
              ),
            ],
          ),
          SizedBox(height:150),
          ElevatedButton(
            onPressed: () {
            // tutaj używamy context z build
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DeckSuggestor(
                  playerData: jsondata,
                  decks: decksdata,
                ),
              ),
            );
          },
            style: ButtonStyle(
                overlayColor: getColor(Colors.white, Colors.teal),
                foregroundColor: getColor(Colors.teal, Colors.white),
                ),
              child: const Text('Suggest a deck'),)
                      
        ],
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