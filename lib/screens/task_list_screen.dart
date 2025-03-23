import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/task_provider.dart';
import '../widgets/task_card.dart';
import '../widgets/add_task_modal.dart';
import '../constants/app_constants.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch tasks when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final tasksProvider = Provider.of<TaskProvider>(context, listen: false);
      tasksProvider.fetchTasks().catchError((e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('خطا در بارگذاری وظایف: $e')));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final tasksProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.taskListTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: AppConstants.logoutTooltip,
            onPressed: () async {
              try {
                await authProvider.signOut();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text(AppConstants.logoutSuccess)),
                );
              } catch (e) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('$e')));
              }
            },
          ),
        ],
      ),
      body:
          tasksProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : tasksProvider.tasks.isEmpty
              ? const Center(
                child: Text(
                  AppConstants.noTasksFound,
                  style: TextStyle(fontFamily: 'Vazir', fontSize: 18),
                ),
              )
              : ListView.builder(
                itemCount: tasksProvider.tasks.length,
                itemBuilder: (context, index) {
                  final task = tasksProvider.tasks[index];
                  return TaskCard(task: task);
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddTaskModal(context),
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
