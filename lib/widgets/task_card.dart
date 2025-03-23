import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Tasks.dart';
import '../providers/task_provider.dart';
import 'edit_task_modal.dart';
import 'delete_confirmation_dialog.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TaskProvider>(context, listen: false);

    return Dismissible(
      key: Key(task.id),
      direction: DismissDirection.horizontal,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.teal,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        child: const Icon(Icons.edit, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          await showEditTaskModal(context, task);
          return false;
        } else if (direction == DismissDirection.startToEnd) {
          return await showDeleteConfirmationDialog(context, task.id);
        }
        return false;
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          tasksProvider.deleteTask(task.id); // Already handled in dialog
        }
      },
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  task.completed
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                  color: task.completed ? Colors.green : Colors.grey,
                ),
                onPressed: () => tasksProvider.toggleTaskCompletion(task),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      task.title,
                      style: const TextStyle(
                        fontFamily: 'Vazir',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    if (task.description != null)
                      Text(
                        task.description!,
                        style: const TextStyle(
                          fontFamily: 'Vazir',
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
