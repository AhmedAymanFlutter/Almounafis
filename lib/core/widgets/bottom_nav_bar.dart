// import 'package:flutter/material.dart';

// class BottomNavExample extends StatefulWidget {
//   const BottomNavExample({super.key});

//   @override
//   State<BottomNavExample> createState() => _BottomNavExampleState();
// }

// class _BottomNavExampleState extends State<BottomNavExample> {
//   int _selectedIndex = 0;

//   final List<Widget> _pages = const [
//     Center(child: Text("🏠 Home", style: TextStyle(fontSize: 25))),
//     Center(child: Text("🔍 Search", style: TextStyle(fontSize: 25))),
//     Center(child: Text("👤 Profile", style: TextStyle(fontSize: 25))),
//     Center(child: Text("👤 Profile", style: TextStyle(fontSize: 25))),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: "Home",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search),
//             label: "Search",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: "Profile",
//           ),
//            BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: "Profile",
//           ),
//         ],
//       ),
//     );
//   }
// }
