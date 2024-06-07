import 'package:quizappsuperheroes/pages/models/question_model.dart';

class QuizBrain {
  List<QuestionModel> questionList = [
    QuestionModel(
      name: "Capitán América",
      question: "https://w7.pngwing.com/pngs/945/936/png-transparent-captain-america-hulk-thor-captain-america-comic-marvel-avengers-assemble-superhero-fictional-character.png", 
      answer: "capitan"),
    QuestionModel(
      name: "Iroman",
      question: "https://rukminim2.flixcart.com/image/850/1000/xif0q/poster/c/9/d/medium-poster-design-no-3303-ironman-poster-ironman-posters-for-original-imaggbyayfagz4jf.jpeg?q=90&crop=false",
      answer: "iroman"),
    QuestionModel(
      name: "Hulk",
      question: "https://m.media-amazon.com/images/S/pv-target-images/fa328f5427536c62b0e9c064b9999d5ae49f5f52203f2cdf0d4d4916f544469e._SX1080_FMjpg_.jpg",
      answer: "hulk"),
    QuestionModel(
      name: "Spiderman",
      question: "https://image.api.playstation.com/vulcan/img/rnd/202011/0714/Cu9fyu6DM41JPekXLf1neF9r.png",
      answer: "spiderman"),
    QuestionModel(
      name: "Mujer maravilla",
      question: "https://i0.wp.com/imgs.hipertextual.com/wp-content/uploads/2023/08/mujer-maravilla-3.jpg?resize=1200%2C741&quality=55&strip=all&ssl=1",
      answer: "wonderwoman"),
    QuestionModel(
      name: "Antman",
      question: "https://imagenes.20minutos.es/files/image_1920_1080/uploads/imagenes/2018/04/15/ant-man-and-wasp.jpg",
      answer: "antman"),
  ];

  int questionIndex = 0;

  String getQuestionText() {
    return questionList[questionIndex].question;
  }

  String getQuestionAnswer() {
    return questionList[questionIndex].answer;
  }

  List<QuestionModel> getOptions() {
    List<QuestionModel> shuffledList = List.from(questionList);
    shuffledList.shuffle();
    return shuffledList;
  }

  String getAnswerNumber() {
    return (questionIndex + 1).toString();
  }

  void nextQuestion() {
    if (questionIndex < questionList.length - 1) {
      questionIndex++;
    }
  }

  bool isFinished() {
    return questionIndex > questionList.length - 2 ? true : false;
  }

  void restarQuizz() {
    questionIndex = 0;
  }
}
