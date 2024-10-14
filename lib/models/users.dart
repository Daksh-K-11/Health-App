import 'package:flutter_riverpod/flutter_riverpod.dart';


class User {
  final int id;           
  final String name;      
  final String email;
  final String phoneNumber; 

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
    };
  }
}



class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  void setUser(User user) {
    state = user;
  }

  void clearUser() {
    state = null;
  }
}


final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier();
});
