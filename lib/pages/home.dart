import 'package:flutter/material.dart';
import 'package:habit_tracker/components/tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool checked = false;

  void handleCheck(bool? val, index) {
    setState(() {
      task[index]["finished"] = val;
    });
  }

  List<Map> task = [
    {"text": "Meditate 10 min", "finished": false},
    {"text": "Drink 1 glass of water", "finished": false},
    {"text": "read docs", "finished": false},
    {"text": "sleep at 10pm", "finished": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: ListView.builder(
        itemCount: task.length,
        itemBuilder: ((context, index) {
          return HabitTile(
            text: task[index]["text"],
            checked: task[index]["finished"],
            handleCheck: ((value) => handleCheck(value, index)),
          );
        }),
      ),
    );
  }
}
