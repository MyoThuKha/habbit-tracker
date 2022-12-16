import "package:flutter/material.dart";

class CreateHabit extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback addTask;
  final VoidCallback editTask;
  final String initialText;
  const CreateHabit({
    super.key,
    required this.controller,
    required this.addTask,
    required this.initialText,
    required this.editTask,
  });

  @override
  Widget build(BuildContext context) {
    final String title = initialText == "" ? "Add New Task" : "Edit Task";
    controller.text = initialText;
    return AlertDialog(
      title: Text(title),
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
              onPressed: () => {
                controller.clear(),
                Navigator.pop(context),
              },
              child: const Text("Discard"),
            ),
            TextButton(
                onPressed: () {
                  if (initialText == "") {
                    addTask();
                  } else {
                    editTask();
                  }
                },
                child: const Text("Done")),
          ],
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
