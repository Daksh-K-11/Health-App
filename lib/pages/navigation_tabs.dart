// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:http/http.dart';
// import 'package:shriwin/models/users.dart';
// import 'package:shriwin/widgets/chatbot.dart';
// import 'package:shriwin/widgets/check_up.dart';
// import 'package:shriwin/widgets/home.dart';
// import 'package:shriwin/widgets/profile.dart';

// class MainBody extends ConsumerStatefulWidget {
//   const MainBody({super.key});

//   @override
//   ConsumerState<MainBody> createState() => _MainBodyState();
// }

// class _MainBodyState extends ConsumerState<MainBody> {
//   String title = 'Home';
//   int _selectedIndex = 0;
//   Widget activepage = const HomePage();

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     if (_selectedIndex == 0){
//       activepage = const HomePage();
//       title = 'Home';
//     }
//     else if (_selectedIndex == 1) {
//       activepage = CheckUp(id: user.id);
//       title = 'Check Up';
//     }
//     else if (_selectedIndex == 2) {
//       activepage = const Chatbot();
//       title = 'Ask AI';
//     }
//     else {
//       activepage = const ProfilePage();
//       title = 'Profile';
//     }
    
//     return Scaffold(
//       backgroundColor: Colors.grey[150],
//       appBar: AppBar(
//         title: Text(
//           title,
//           style: const TextStyle(color: Colors.black),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.blue[100],
//       ),
//       body: activepage,
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         currentIndex: _selectedIndex,
//         backgroundColor: Colors.blue[100],
//         onTap: (index) => setState(() {
//           _selectedIndex = index;
//         }),
//         selectedFontSize: 15,
//         unselectedFontSize: 11,
//         selectedItemColor: Colors.white,
//         elevation: 10,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home'
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.medical_services_outlined),
//             label: 'CheckUp'
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.chat),
//             label: 'ChatBot'
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile'
//           ),
//         ],
//       ),
//     );
//   }
// }











// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:http/http.dart';
// import 'package:shriwin/models/users.dart';
// import 'package:shriwin/widgets/chatbot.dart';
// import 'package:shriwin/widgets/check_up.dart';
// import 'package:shriwin/widgets/home.dart';
// import 'package:shriwin/widgets/profile.dart';

// class MainBody extends ConsumerStatefulWidget {
//   const MainBody({super.key});

//   @override
//   ConsumerState<MainBody> createState() => _MainBodyState();
// }

// class _MainBodyState extends ConsumerState<MainBody> {
//   String title = 'Home';
//   int _selectedIndex = 0;
//   Widget activepage = const HomePage();

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // Accessing the `ref` here if you need providers for logic
//     final user = ref.watch(userProvider); // Example of using ref to watch a provider

//     // Use `ref` inside the `build` method for reactive state
//     if (_selectedIndex == 0) {
//       activepage = const HomePage();
//       title = 'Home';
//     } else if (_selectedIndex == 1) {
//       // Pass `user.id` from the provider or use `ref` within the widget
//       activepage = CheckUp(id: user!.id); 
//       title = 'Check Up';
//     } else if (_selectedIndex == 2) {
//       activepage = const Chatbot();
//       title = 'Ask AI';
//     } else {
//       activepage = const ProfilePage();
//       title = 'Profile';
//     }

//     return Scaffold(
//       backgroundColor: Colors.grey[150],
//       appBar: AppBar(
//         title: Text(
//           title,
//           style: const TextStyle(color: Colors.black),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.blue[100],
//       ),
//       body: activepage,
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         currentIndex: _selectedIndex,
//         backgroundColor: Colors.blue[100],
//         onTap: (index) => setState(() {
//           _selectedIndex = index;
//         }),
//         selectedFontSize: 15,
//         unselectedFontSize: 11,
//         selectedItemColor: Colors.white,
//         elevation: 10,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.medical_services_outlined), label: 'CheckUp'),
//           BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'ChatBot'),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//         ],
//       ),
//     );
//   }
// }




















import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shriwin/models/users.dart';
import 'package:shriwin/widgets/history.dart';
import 'package:shriwin/widgets/check_up.dart';
import 'package:shriwin/widgets/home.dart';
import 'package:shriwin/widgets/profile.dart';

class MainBody extends ConsumerStatefulWidget {
  const MainBody({super.key});

  @override
  ConsumerState<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends ConsumerState<MainBody> {
  String title = 'Home';
  int _selectedIndex = 0;
  Widget activePage = const HomePage();

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider); // Example of using a provider

    if (_selectedIndex == 0) {
      activePage = const HomePage();
      title = 'Home';
    } else if (_selectedIndex == 1) {
      activePage = CheckUp(id: user!.id); // Use user ID from provider
      title = 'Check Up';
    } else if (_selectedIndex == 2) {
      activePage = History(userId: user!.id,);
      title = 'Ask AI';
    } else {
      activePage = const ProfilePage();
      title = 'Profile';
    }

    return Scaffold(
      backgroundColor: Colors.grey[150],
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[100],
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        backgroundColor: Colors.blue[100],
        onTap: (index) => setState(() {
          _selectedIndex = index;
        }),
        selectedFontSize: 15,
        unselectedFontSize: 11,
        selectedItemColor: Colors.white,
        elevation: 10,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.medical_services_outlined), label: 'CheckUp'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'ChatBot'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
