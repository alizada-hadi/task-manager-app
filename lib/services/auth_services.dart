import "package:appwrite/appwrite.dart";
// import "package:flutter/material.dart";
import "../models/User.dart";
import "../client/appwrite_client.dart";

class AuthServices {
  final AppwriteClient appwriteClient = AppwriteClient();

  Future<User> signUpWithEmail(
    String name,
    String email,
    String password,
  ) async {
    try {
      final response = await appwriteClient.account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );
      return User.fromJson(response.toMap());
    } catch (e) {
      throw Exception('خطا در ثبت‌نام با ایمیل: $e');
    }
  }

  // Log in with Email/Password
  Future<User> loginWithEmail(String email, String password) async {
    try {
      await appwriteClient.account.createEmailPasswordSession(
        email: email,
        password: password,
      );
      final user = await appwriteClient.account.get();
      return User.fromJson(user.toMap());
    } catch (e) {
      throw Exception('خطا در ورود با ایمیل: $e');
    }
  }

  // Get current user
  Future<User?> getCurrentUser() async {
    try {
      final user = await appwriteClient.account.get();
      return User.fromJson(user.toMap());
    } catch (e) {
      return null; // No active session
    }
  }

  // Log out (Updated)
  Future<void> logout() async {
    try {
      await appwriteClient.account.deleteSessions(); // Delete all sessions
    } catch (e) {
      throw Exception('خطا در خروج: $e');
    }
  }

  // // Log in with Google OAuth2
  // Future<void> loginWithGoogle() async {
  //   try {
  //     await appwriteClient.account.createOAuth2Session(
  //       provider: "Google",
  //       success:
  //           'appwrite-callback://success', // Custom success URL (configure later)
  //       failure: 'appwrite-callback://failure', // Custom failure URL
  //     );
  //     // Note: OAuth2 redirects to browser; user is logged in on return
  //   } catch (e) {
  //     throw Exception('خطا در ورود با گوگل: $e');
  //   }
  // }
}
