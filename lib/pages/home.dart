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

  TextEditingController controller = TextEditingController();

  void addTask() {
    setState(() {
      task.insert(0, {"text": controller.text, "finished": false});
    });
  }

  Future showAddBox() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Task"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: "Abc...",
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      controller.clear();
                    },
                    child: const Text("Cancel")),
                TextButton(
                    onPressed: () {
                      addTask();
                      Navigator.pop(context);
                      controller.clear();
                    },
                    child: const Text("Confirm")),
              ],
            ),
          ],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        );
      },
    );
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
        onPressed: () {
          showAddBox();
        },
        child: const Icon(Icons.add_rounded),
      ),
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
