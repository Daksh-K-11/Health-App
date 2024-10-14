import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shriwin/auth/login.dart';
import 'package:shriwin/models/users.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userProvider);

    if (user == null) {
      return const Center(child: Text('No user logged in.'));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Center(
            child: CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                'https://www.google.com/imgres?q=person&imgurl=https%3A%2F%2Ft3.ftcdn.net%2Fjpg%2F02%2F43%2F12%2F34%2F360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg&imgrefurl=https%3A%2F%2Fstock.adobe.com%2Fsearch%2Fimages%3Fk%3Dindividual%2Bperson&docid=ugzeyx_t_gyEJM&tbnid=eVzGuDI9qigm8M&vet=12ahUKEwi1yv2T7IqJAxUt4TgGHYa4B7YQM3oECGUQAA..i&w=540&h=360&hcb=2&ved=2ahUKEwi1yv2T7IqJAxUt4TgGHYa4B7YQM3oECGUQAA',
              ),
            ),
          ),
          // const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              children: [
                ProfileInfoRow(
                  label: 'Name',
                  value: user.name,
                ),
                const Divider(
                  color: Colors.grey,
                ),
                ProfileInfoRow(
                  label: 'Email',
                  value: user.email,
                ),
                const Divider(
                  color: Colors.grey,
                ),
                ProfileInfoRow(
                  label: 'Phone',
                  value: user.phoneNumber,
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => LoginPage())),
            title: const Text('Logout'),
            trailing: const Icon(Icons.logout),
          )
        ],
      ),
    );
  }
}

class ProfileInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const ProfileInfoRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    // return Row(
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [
    //     Expanded(
    //       flex: 2,
    //       child: Text(
    //         label,
    //         style: const TextStyle(
    //           fontSize: 18,
    //           fontWeight: FontWeight.w500,
    //           color: Colors.black,
    //         ),
    //       ),
    //     ),
    //     Expanded(
    //       flex: 3,
    //       child: Text(
    //         value,
    //         style: const TextStyle(
    //           fontSize: 18,
    //           fontWeight: FontWeight.bold,
    //           color: Colors.black87,
    //         ),
    //         textAlign: TextAlign.right,
    //       ),
    //     ),
    //   ],
    // );
    return ListTile(
      leading: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      trailing: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.right,
          ),
    );
  }
}
