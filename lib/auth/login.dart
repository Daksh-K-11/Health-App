import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shriwin/auth/sign_up.dart';
import 'package:shriwin/const.dart';
import 'package:shriwin/models/users.dart';
import 'package:shriwin/pages/navigation_tabs.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<User?> loginUser(String email, String password) async {
    final Map<String, String> requestBody = {
      "email": email,
      "password": password,
    };

    try {
      final response = await http.post(
        Uri.parse('$api/login/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return User.fromJson(jsonResponse);
      } else {
        // print('Login failed: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey.shade100, Colors.blueGrey.shade200, Colors.blueGrey.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Mail ID',
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: const Icon(Icons.visibility),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(16),
                        ),
                        onPressed: () async {
                          final user = await loginUser(
                            emailController.text,
                            passwordController.text,
                          );

                          if (user != null) {
                            // Set the user using the userProvider
                            ref.read(userProvider.notifier).setUser(user);

                            // Navigate to the main body
                            if (context.mounted) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (ctx) => const MainBody(),
                                ),
                              );
                            }
                          } else {
                            // Handle login error
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Login failed')),
                              );
                            }
                          }
                        },
                        child:
                            const Text('Login', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpPage()),
                            );
                          },
                          child: const Text(
                            "Don't have an account?",
                            style: TextStyle(
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpPage()),
                            );
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.deepPurpleAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
