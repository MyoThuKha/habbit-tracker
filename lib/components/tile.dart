import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  final String text;
  final bool checked;
  final void Function(bool?) checkBoxToggle;
  final Function(BuildContext)? deleteTask;
  const HabitTile({
    super.key,
    required this.text,
    required this.checked,
    required this.checkBoxToggle,
    required this.deleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {},
              borderRadius: BorderRadius.circular(12),
              icon: CupertinoIcons.pen,
              backgroundColor: Colors.blue,
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: deleteTask,
              borderRadius: BorderRadius.circular(12),
              icon: CupertinoIcons.delete,
              backgroundColor: Colors.red,
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              value: checked,
              onChanged: checkBoxToggle,
            ),
            title: Text(text),
          ),
        ),
      ),
    );
  }
}
