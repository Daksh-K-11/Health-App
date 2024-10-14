import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shriwin/models/users.dart';

final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier();
});
