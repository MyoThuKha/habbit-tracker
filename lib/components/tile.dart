import 'package:flutter/material.dart';

class HabitTile extends StatelessWidget {
  final String text;
  final bool checked;
  final void Function(bool?) handleCheck;
  const HabitTile(
      {super.key,
      required this.text,
      required this.checked,
      required this.handleCheck});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Checkbox(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          value: checked,
          onChanged: handleCheck,
        ),
        title: Text(text),
      ),
    );
  }
}
