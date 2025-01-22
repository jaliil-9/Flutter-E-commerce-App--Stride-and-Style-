import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String firstname;
  String lastname;
  final String username;
  final String email;
  String phonenumber;
  String profilePicture;

  UserModel({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.email,
    required this.phonenumber,
    required this.profilePicture,
  });

  // Helper Function to get the full name
  String get fullName => '$firstname $lastname';

  // Static function to split full name to first and last name
  static List<String> nameParts(fullName) => fullName.split(" ");

  // Helper function to generate username
  static String generateUserName(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstname = nameParts[0].toLowerCase();
    String lastname = nameParts.length > 1 ? nameParts[1].toLowerCase() : " ";

    String camelCaseUsername = "$firstname$lastname";
    String usernameWithPrefix = "cwt_$camelCaseUsername";
    return usernameWithPrefix;
  }

  // Static function to create and empty user model
  static UserModel empty() => UserModel(
      id: '',
      firstname: '',
      lastname: '',
      username: '',
      email: '',
      phonenumber: '',
      profilePicture: '');

  // Convert model to Json structure for storing data ins Firebase
  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
      'email': email,
      'phonenumber': phonenumber,
      'profilePicture': profilePicture,
    };
  }

  // Factory Method to create a UserModel from a Firebase document snapshot
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstname: data['firstname'] ?? '',
        lastname: data['lastname'] ?? '',
        username: data['username'] ?? '',
        email: data['email'] ?? '',
        phonenumber: data['phonenumber'] ?? '',
        profilePicture: data['profilePicture'] ?? '',
      );
    }
    return empty();
  }
}
