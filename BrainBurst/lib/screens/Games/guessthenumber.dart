import 'package:flutter/material.dart';

class MCQGame extends StatefulWidget {
  const MCQGame({Key? key}) : super(key: key);

  @override
  _MCQGameState createState() => _MCQGameState();
}

class _MCQGameState extends State<MCQGame> {
  final Map<String, dynamic> _questions = {
    "പൂജ്യം": {"options": ["1", "2", "0", "3"], "answer": "0"},
    "പത്തു": {"options": ["10", "11", "12", "13"], "answer": "10"},
    "പതിനൊന്ന്": {"options": ["11", "12", "13", "14"], "answer": "11"},
    "പന്ത്രണ്ട്": {"options": ["12", "13", "14", "15"], "answer": "12"},
    "പതിമൂന്നു": {"options": ["13", "14", "15", "16"], "answer": "13"},
    "പതിനാറു": {"options": ["14", "15", "16", "17"], "answer": "16"},
  };

  int _currentQuestionIndex = 0;
  int _score = 1;
  List<String> _questionOrder = [];
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    _questionOrder = _questions.keys.toList()..shuffle();
  }

  void _handleAnswerSelection(String selectedOption) {
    String currentQuestion = _questionOrder[_currentQuestionIndex];
    String correctAnswer = _questions[currentQuestion]["answer"];
    setState(() {
      _selectedOption = selectedOption;
      if (selectedOption == correctAnswer) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _currentQuestionIndex++;
      _selectedOption = null;
    });
  }

  bool _isLastQuestion() {
    return _currentQuestionIndex == _questionOrder.length - 1;
  }

  void _restartGame() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _questionOrder.shuffle();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLastQuestion()) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('MCQ Game'),
        ),
        body: Container(
          color: Colors.lightBlueAccent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'You finished the quiz!',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                Text(
                  'Your score: $_score out of ${_questions.length}',
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _restartGame,
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Restart Game'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    String currentQuestion = _questionOrder[_currentQuestionIndex];
    Map<String, dynamic> currentQuestionData = _questions[currentQuestion];

    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text('MCQ Game'),
      ),
      body: Container(
        color: Colors.lightBlue,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  currentQuestion,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                for (String option in currentQuestionData["options"])
                  Card(
                    color: _selectedOption == option
                        ? (option == currentQuestionData["answer"]
                        ? Colors.green
                        : Colors.red)
                        : Colors.white,
                    child: ListTile(
                      title: Text(
                        option,
                        style: TextStyle(
                          color: _selectedOption == option
                              ? Colors.white
                              : Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () =>
                          _handleAnswerSelection(option),
                    ),
                  ),
                if (_selectedOption != null)
                  ElevatedButton(
                    onPressed: _nextQuestion,
                    child: Text(
                      _isLastQuestion() ? 'Finish' : 'Next',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
