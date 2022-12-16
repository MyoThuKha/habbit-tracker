import 'package:flutter/material.dart';
import 'package:habit_tracker/components/create.dart';
import 'package:habit_tracker/components/tile.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool checked = false;

  void checkBoxTogggle(bool? val, index) {
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

  TextEditingController controller = TextEditingController();

  void addTask() {
    if (controller.text != "") {
      setState(() {
        task.insert(0, {"text": controller.text, "finished": false});
      });
    }
    Navigator.pop(context);
    controller.clear();
  }

  void editTask(int index) {
    if (controller.text != "") {
      setState(() {
        task[index]['text'] = controller.text;
      });
    }
    Navigator.pop(context);
    controller.clear();
  }

  void deleteTask(int index) {
    setState(() {
      task.removeAt(index);
    });
  }

  Future showDialogBox(String text, int index) {
    return showDialog(
      context: context,
      builder: (context) {
        return CreateHabit(
          controller: controller,
          initialText: text,
          addTask: addTask,
          editTask: () => {editTask(index)},
        );
      },
    );
  }

  final data = Hive.box('HABITS_DB');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialogBox("", 0),
        child: const Icon(Icons.add_rounded),
      ),
      body: ListView.builder(
        itemCount: task.length,
        itemBuilder: ((context, index) {
          return HabitTile(
            text: task[index]["text"],
            checked: task[index]["finished"],
            checkBoxToggle: ((value) => checkBoxTogggle(value, index)),
            deleteTask: ((context) => deleteTask(index)),
            showDialogBox: (context) =>
                showDialogBox(task[index]["text"], index),
          );
        }),
      ),
    );
  }
}
