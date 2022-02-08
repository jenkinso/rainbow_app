import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyStatefulRainbow(title: 'Rainbow app'),
    );
  }
}

class MyStatefulRainbow extends StatefulWidget {
  const MyStatefulRainbow({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyStatefulRainbow> createState() => _MyStatefulRainbowState();
}

class _MyStatefulRainbowState extends State<MyStatefulRainbow> {
  bool _isTextVisible = false;
  static AudioCache player = AudioCache(prefix: 'assets/wav/');
  static const audioFiles = ['note1.wav', 'note2.wav', 'note3.wav',
    'note4.wav', 'note5.wav', 'note6.wav', 'note7.wav'];

  _MyStatefulRainbowState() {
    // pre-load all audio files for music notes
    player.loadAll(audioFiles);
  }

  /// toggle visibility of the rainbow colour labels
  void _toggleTextVisibility() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _isTextVisible without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _isTextVisible = !_isTextVisible;
    });
  }

  /// handler for onTap event on rainbow: play a note
  void _handleRainbowTap(String file) {
    player.play(file, mode: PlayerMode.LOW_LATENCY);
  }

  /// return an Expanded Container representing a single coloured band of the rainbow
  Expanded _buildRainbowBand({required Color? colour, required String text, required String file}) {
    return Expanded(
      child: GestureDetector(
        onTap: () { _handleRainbowTap(file); },
        child: Container(
          color: colour,
          child: Visibility(
            child: Text(text, style: const TextStyle(fontSize: 30, color: Colors.white)),
            visible: _isTextVisible,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _toggleTextVisibility method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildRainbowBand(colour: Colors.red, text: 'Red', file: audioFiles[0]),
          _buildRainbowBand(colour: Colors.orange, text: 'Orange', file: audioFiles[1]),
          _buildRainbowBand(colour: Colors.yellow, text: 'Yellow', file: audioFiles[2]),
          _buildRainbowBand(colour: Colors.green, text: 'Green', file: audioFiles[3]),
          _buildRainbowBand(colour: Colors.blue, text: 'Blue', file: audioFiles[4]),
          _buildRainbowBand(colour: Colors.indigo, text: 'Indigo', file: audioFiles[5]),
          _buildRainbowBand(colour: Colors.purple, text: 'Violet', file: audioFiles[6]),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleTextVisibility,
        tooltip: 'Toggle visibility of rainbow colour labels',
        child: const Icon(Icons.info_outline),
      ),
    );
  }
}