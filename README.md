
# Clash royale deck suggestor - Mateusz Kolber and Jakub Sobolewski
Flutter app that shows your account data and suggest you a meta deck that suits your card levels



## IMPORTANT
Before you start, this project uses a proxy server to call ClashRoyaleAPI and performs some calculations. I personally used Railway 30 days free trial for educational purposes.  
API calls that you would need to change are located in:
- `main.dart`, line **60** and **64**
- `profile.dart`, line **29**
## How to run this app?
To run this app first you need a flutter enviroment (check some YouTube guide how to install flutter) and a mobile device or a simulator on your PC. When you successfully install flutter run `flutter doctor` and see whether you are good to go. If you would like to run this app on a simulator please firstly run your simulator then check if flutter sees it as a device. To check it run `flutter device` and see if it writes down your simulator, if it's there type `flutter run` and it's here! But if you want to run it on a physical mobile device connect your device to computer and once again check if flutter sees it, but instead of `flutter run` type `flutter run --release` and you should be good to go. 
## Screens
### main.dart
Page where you need to insert your Clash Royale player tag. After pressing button app calls `_submit()` funciton which awaits 2 proxy api calls that returns player data if player with this player tag exists and meta decks.
### profile.dart
On this screen we see bunch of data for the account we are looking for (wins, loses, how many cards we have, current deck, etc.). We have 2 buttons on this screen, one in top left which can return to the previous screen and the second one that calls `_submit(jsondata, decksdata, context)` (jsondata - player json data, decksdata - json decks data that we called screen earlier, context - app context), in this function we call last API endpoint that calculates which meta deck is the best for this account.
### decksuggestor.dart
On this screen we see all the meta decks and their rating 0-100 (0 is bad, 100 is the best) this rating is calculated by proxt. From this page we can return to the previous one.
