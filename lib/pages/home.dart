import 'package:flutter/material.dart';
import 'package:habit_tracker/components/create.dart';
import 'package:habit_tracker/components/summary.dart';
import 'package:habit_tracker/components/tile.dart';
import 'package:habit_tracker/data/database.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  final data = Hive.box('HABITS_DB');
  HabitDB db = HabitDB();

  @override
  void initState() {
    if (data.get('CURRENT_HABITS_LIST') == null) {
      db.createInitData();
    } else {
      db.loadData();
    }
    db.update();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void checkBoxTogggle(bool? val, index) {
    setState(() {
      db.tasks[index]["finished"] = val;
    });
    db.update();
  }

  void addTask() {
    if (controller.text != "") {
      setState(() {
        db.tasks.add({"text": controller.text, "finished": false});
      });
    }
    controller.clear();
    Navigator.pop(context);
    db.update();
  }

  void editTask(int index) {
    if (controller.text != "") {
      setState(() {
        db.tasks[index]['text'] = controller.text;
      });
    }
    controller.clear();
    Navigator.pop(context);
    db.update();
  }

  void deleteTask(int index) {
    setState(() {
      db.tasks.removeAt(index);
    });
    db.update();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialogBox("", 0),
        child: const Icon(Icons.add_rounded),
      ),
      body: ListView(
        children: [
          Summary(
            startDate: data.get('START_DATE'),
            datasets: db.heatMapDataSet,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: db.tasks.length,
            itemBuilder: ((context, index) {
              return HabitTile(
                text: db.tasks[index]["text"],
                checked: db.tasks[index]["finished"],
                checkBoxToggle: ((value) => checkBoxTogggle(value, index)),
                deleteTask: ((context) => deleteTask(index)),
                showDialogBox: (context) =>
                    showDialogBox(db.tasks[index]["text"], index),
              );
            }),
          ),
        ],
      ),
    );
  }
}
