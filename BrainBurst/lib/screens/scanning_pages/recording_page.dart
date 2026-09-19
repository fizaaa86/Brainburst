import 'package:brainburst/constants/colors.dart';
import 'package:brainburst/screens/scanning_pages/scanning_index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class RecordingPage extends StatefulWidget {
  const RecordingPage({super.key});

  @override
  State<RecordingPage> createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage> {
  bool showText = true;
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 852,
      width: 393,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.39, 0.92),
          end: Alignment(-0.39, -0.92),
          colors: [Color(0xFFF7D5E5), Color(0x00FA99C8)],
        ),
      ),
      child: Column(
        children: [
          const ScanningPageLogo(),
          Padding(
            padding: const EdgeInsets.only(top: 150, bottom: 100),
            child: MaterialButton(
                onPressed: _listen,
                child: Image.asset('assets/recording_page/recording_logo.png')),
          ),
          Text(_isListening ? 'Listening...' : 'Start Listening',style: GoogleFonts.inknutAntiqua( 
                        color: Clr.darkSpringGreen, 
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),),
          Text(
            _text,
            style: const TextStyle(
              color:Clr.darkPurple ,
              fontSize: 48,
              fontFamily: 'Marko One',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          )
        ],
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      print('listening');
      bool available = await _speech.initialize(
        onStatus: (status) => print('onStatus: $status'),
        onError: (error) => print('onError: $error'),
      );

      if (available) {
        print('available');
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) => setState(() => _text = result.recognizedWords),
          localeId: 'ml_IN', // Malayalam (India)
        );
      }
    } else {
      print('not listening');
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  void dispose() {
    _speech.stop();
    super.dispose();
  }
}
