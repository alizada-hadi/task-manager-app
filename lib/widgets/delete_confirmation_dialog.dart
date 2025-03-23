import 'package:flutter/material.dart';
import "../providers/task_provider.dart";
import 'package:provider/provider.dart';

Future<bool> showDeleteConfirmationDialog(
  BuildContext context,
  String taskId,
) async {
  return await showDialog<bool>(
        context: context,
        builder: (context) {
          final tasksProvider = Provider.of<TaskProvider>(
            context,
            listen: false,
          );
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: const Text(
              'حذف وظیفه',
              style: TextStyle(
                fontFamily: 'Vazir',
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textDirection: TextDirection.rtl,
            ),
            content: const Text(
              'آیا مطمئن هستید که می‌خواهید این وظیفه را حذف کنید؟',
              style: TextStyle(fontFamily: 'Vazir'),
              textDirection: TextDirection.rtl,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text(
                  'لغو',
                  style: TextStyle(fontFamily: 'Vazir', color: Colors.teal),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await tasksProvider.deleteTask(taskId);
                  Navigator.pop(context, true);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('وظیفه با موفقیت حذف شد')),
                  );
                },
                child: const Text(
                  'حذف',
                  style: TextStyle(fontFamily: 'Vazir', color: Colors.red),
                ),
              ),
            ],
          );
        },
      ) ??
      false;
}
