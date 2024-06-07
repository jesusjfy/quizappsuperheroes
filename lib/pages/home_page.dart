import 'package:flutter/material.dart';
import 'package:quizappsuperheroes/quizz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  QuizBrain quizBrain = QuizBrain();
  List<Widget> score = [];
  int correctAnswers = 0;
  int incorrectAnswers = 0;

  void checkAnswer(String userAnswer, String numberQuestion) {
    if (quizBrain.questionList.length <= correctAnswers + incorrectAnswers) {
      Alert(
        context: context,
        type: AlertType.error,
        title: "QuizApp - Resultados",
        desc: "Respuestas correctas: $correctAnswers\n"
            "Respuestas incorrectas: $incorrectAnswers",
        buttons: [
          DialogButton(
            child: Text("Aceptar"),
            onPressed: () {
              correctAnswers = 0;
              incorrectAnswers = 0;
              quizBrain.restarQuizz();
              score.clear();
              Navigator.pop(context);
              setState(() {});
            },
          ),
        ],
      ).show();
    } else {
      String correctAnswer = quizBrain.getQuestionAnswer();
      if (correctAnswer.toLowerCase() == userAnswer.toLowerCase()) {
        correctAnswers++;
        score.add(itemScore(numberQuestion, true));
      } else {
        score.add(itemScore(numberQuestion, false));
        incorrectAnswers++;
      }
      setState(() {});
      quizBrain.nextQuestion();
    }
  }

  Widget itemScore(String numberQuestion, bool isCorrect) {
    return Row(
      children: [
        Text(
          "$numberQuestion: ",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        Icon(
          isCorrect ? Icons.check : Icons.close,
          color: isCorrect ? Colors.greenAccent : Colors.redAccent,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final imageSize = screenSize.width;
    final options = quizBrain.getOptions();

    return Scaffold(
      backgroundColor: Color(0xff2B2E42),
      appBar: AppBar(
        title: Text("Quiz App"),
        centerTitle: true,
        backgroundColor: Color(0xff2B2E42),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Center(
                child: Container(
                  width: imageSize,
                  height: imageSize,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                  ),
                  child: Image.network(
                    quizBrain.getQuestionText(),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Text(
                        'Error al cargar la imagen',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      );
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: GridView.count(
                crossAxisCount: 3,
                children: options.map((option) {
                  return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: MaterialButton(
                      color: Colors.blueAccent,
                      child: Text(
                        option.name,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        checkAnswer(option.answer, quizBrain.getAnswerNumber());
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: score,
            ),
          ],
        ),
      ),
    );
  }
}
