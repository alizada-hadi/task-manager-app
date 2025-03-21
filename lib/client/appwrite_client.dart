import "package:appwrite/appwrite.dart";

class AppwriteClient {
  late Client client;
  late Databases databases;
  late Account account;
  final String databaseId = "67dc4daa003a9e6ac008";
  AppwriteClient() {
    client = Client()
        .setEndpoint("https://cloud.appwrite.io/v1")
        .setProject("67dc4d4b001865db1818");
    databases = Databases(client);
    account = Account(client);
  }
}
