import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatefulWidget {
  final String taskname;
  final bool taksCompleted;
  final Function(bool?)? onchanged;
  final Function(BuildContext)? deleteTask;

  TodoTile({
    super.key,
    required this.taskname,
    required this.taksCompleted,
    required this.onchanged,
    required this.deleteTask,
  });

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, top: 24.0, right: 24.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: widget.deleteTask,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 215, 193, 252),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Checkbox(
                value: widget.taksCompleted,
                onChanged: widget.onchanged,
                activeColor: Colors.black,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  widget.taskname,
                  style: TextStyle(
                    decoration: widget.taksCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
