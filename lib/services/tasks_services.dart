import "package:appwrite/appwrite.dart";
import "package:task_management/models/Tasks.dart";
import "package:task_management/services/auth_services.dart";

import "../client/appwrite_client.dart";

class TasksServices {
  final AppwriteClient appwriteClient = AppwriteClient();
  final AuthServices authServices = AuthServices();
  // Fetch All tasks

  Future<List<Task>> fetchTasks() async {
    try {
      final user = await authServices.getCurrentUser();
      if (user == null) {
        throw Exception('کاربر وارد نشده است');
      }
      final response = await appwriteClient.databases.listDocuments(
        databaseId: appwriteClient.databaseId,
        collectionId: '67dc4f420001099bb34d', // Your Tasks Collection ID
        queries: [Query.equal('userId', user.id)],
      );
      return response.documents.map((doc) => Task.fromJson(doc.data)).toList();
    } catch (e) {
      throw Exception('خطا در دریافت وظایف: $e');
    }
  }

  // Create tasks
  Future<void> createTask(String title, String? description) async {
    try {
      final user = await authServices.getCurrentUser();
      if (user == null) {
        throw Exception('کاربر وارد نشده است');
      }
      await appwriteClient.databases.createDocument(
        databaseId: appwriteClient.databaseId,
        collectionId: "67dc4f420001099bb34d",
        documentId: ID.unique(),
        data:
            Task(
              id: "",
              title: title,
              description: description,
              completed: false,
              userId: user.id,
              categoryId: "test",
              createdAt: DateTime.now(),
            ).toJson(), // Your Tasks Collection ID
      );
    } catch (e) {
      throw Exception('خطا در ایجاد وظیفه: $e');
    }
  }

  // Mark task completion status
  Future<void> markAsComplete(Task task) async {
    try {
      await appwriteClient.databases.updateDocument(
        databaseId: appwriteClient.databaseId,
        collectionId: '67dc4f420001099bb34d',
        documentId: task.id,
        data: {'completed': !task.completed}, // Toggle completion
      );
    } catch (e) {
      throw Exception('خطا در به‌روزرسانی وظیفه: $e');
    }
  }

  // Update an existing task
  Future<Task> updateTask(Task task) async {
    try {
      final response = await appwriteClient.databases.updateDocument(
        databaseId: appwriteClient.databaseId,
        collectionId: '67dc4f420001099bb34d',
        documentId: task.id,
        data: task.toJson(),
      );
      return Task.fromJson(response.data);
    } catch (e) {
      throw Exception('خطا در به‌روزرسانی وظیفه: $e');
    }
  }

  // Delete a task
  Future<void> deleteTask(String taskId) async {
    try {
      await appwriteClient.databases.deleteDocument(
        databaseId: appwriteClient.databaseId,
        collectionId: '67dc4f420001099bb34d',
        documentId: taskId,
      );
    } catch (e) {
      throw Exception('خطا در حذف وظیفه: $e');
    }
  }
}
