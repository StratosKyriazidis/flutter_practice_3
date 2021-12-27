import 'package:flutter/material.dart';
import 'package:flutter_practice_3/little_icons.dart';
import 'package:flutter_practice_3/question_state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<QuestionState>(
      create: (context) => QuestionState(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(backgroundColor: Colors.black),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<LittleIcons> list = [];

  void _checkAnswer(bool answer) {
    var state = QuestionState.of(context, listen: false);
    state.userAnswered(answer);
    updateList();
  }

  List<LittleIcons> updateList() {
    var state = QuestionState.of(context, listen: false);
    list.clear();
    if (state.answersNum > 0) {
      for (var item in state.answers) {
        list.add(LittleIcons(isCorrect: item.userAnswered));
      }
      return list;
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<QuestionState>(
        builder: (context, state, _) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.error != null) {
            return Center(
              child: Text(state.error!),
            );
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  state.currentQuestion.questionText,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              ColoredBox(
                color: Colors.green,
                child: InkWell(
                  onTap: () => _checkAnswer(true),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'True',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              ColoredBox(
                color: Colors.red,
                child: InkWell(
                  onTap: () => _checkAnswer(false),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'False',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 15,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return list[index];
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
