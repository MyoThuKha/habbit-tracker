import "package:flutter/material.dart";

class CreateHabit extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback addTask;
  const CreateHabit(
      {super.key, required this.controller, required this.addTask});

  @override
  Widget build(BuildContext context) {
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
                child: const Text("Discard")),
            TextButton(onPressed: () => addTask(), child: const Text("Add")),
          ],
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
