import 'package:flutter/material.dart';
import '../models/Tasks.dart';
import "../providers/task_provider.dart";
import 'package:provider/provider.dart';

Future<void> showEditTaskModal(BuildContext context, Task task) async {
  final titleController = TextEditingController(text: task.title);
  final descriptionController = TextEditingController(text: task.description);

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      final tasksProvider = Provider.of<TaskProvider>(context, listen: false);
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'ویرایش وظیفه',
              style: TextStyle(
                fontFamily: 'Vazir',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'عنوان',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.title, color: Colors.teal),
              ),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'توضیحات',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.description, color: Colors.teal),
              ),
              textDirection: TextDirection.rtl,
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                try {
                  final updatedTask = Task(
                    id: task.id,
                    title: titleController.text,
                    description:
                        descriptionController.text.isEmpty
                            ? null
                            : descriptionController.text,
                    completed: task.completed,
                    userId: task.userId,
                    categoryId: task.categoryId,
                    createdAt: task.createdAt,
                  );
                  await tasksProvider.updateTask(updatedTask);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('وظیفه با موفقیت به‌روزرسانی شد'),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('خطا در به‌روزرسانی: $e')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'ذخیره',
                style: TextStyle(
                  fontFamily: 'Vazir',
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
    },
  );
}
