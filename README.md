# Clash royale deck suggestor
Flutter app that shows your account data and suggest you a meta deck that suits your card levels



## IMPORTANT
Before you start, this project uses a proxy server to call ClashRoyaleAPI and performs some calculations. I personally used Railway 30 days free trial for educational purposes.  
API calls that you would need to change are located in:
- `main.dart`, line **60** and **64**
- `profile.dart`, line **29**
## How to run this app?
To run this app first you need a flutter enviroment (check some YouTube guide how to install flutter) and a mobile device or a simulator on your PC. When you successfully install flutter run `flutter doctor` and see whether you are good to go. If you would like to run this app on a simulator please firstly run your simulator then check if flutter sees it as a device. To check it run `flutter device` and see if it writes down your simulator, if it's there type `flutter run` and it's here! But if you want to run it on a physical mobile device connect your device to computer and once again check if flutter sees it, but instead of `flutter run` type `flutter run --release` and you should be good to go. 
