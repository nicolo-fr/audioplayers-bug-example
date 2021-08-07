import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static final AudioPlayer advancedPlayer = AudioPlayer();
  static final AudioCache audioCache = AudioCache(fixedPlayer: advancedPlayer);
  Stream<void> completionEvent = advancedPlayer.onPlayerCompletion;
  int trackPlaying = 3;

  Future<void> play(int trackNbr) async {
    try {
      await audioCache.play('$trackNbr.flac');
      print('track playing : $trackNbr.flac');
    } catch (e) {}

    if (trackNbr < 10) {
      completionEvent.listen(
        (event) {
          play(trackNbr + 1);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Example'),
        ),
        body: Center(
          child: ElevatedButton(
            child: Text('Play tracks'),
            onPressed: () {
              play(3);
            },
          ),
        ),
      ),
    );
  }
}
