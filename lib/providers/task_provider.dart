import "package:flutter/material.dart";
import "../services/tasks_services.dart";
import "../models/Tasks.dart";

class TaskProvider with ChangeNotifier {
  final TasksServices _tasksServices = TasksServices();
  List<Task> _tasks = [];

  bool _isLoading = false;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;

  Future<void> fetchTasks() async {
    _isLoading = true;
    notifyListeners();
    try {
      _tasks = await _tasksServices.fetchTasks();
    } catch (e) {
      throw e; // Let the UI handle errors
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createTask(
    String title,
    String? description,
    String categoryId,
  ) async {
    try {
      await _tasksServices.createTask(title, description);
      await fetchTasks();
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await _tasksServices.updateTask(task);
      await fetchTasks();
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _tasksServices.deleteTask(taskId);
      await fetchTasks();
    } catch (e) {
      throw e;
    }
  }

  Future<void> toggleTaskCompletion(Task task) async {
    try {
      await _tasksServices.markAsComplete(task);
      await fetchTasks();
    } catch (e) {
      throw e;
    }
  }
}
