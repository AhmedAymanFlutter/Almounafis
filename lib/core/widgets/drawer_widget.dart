// import 'package:flutter/material.dart';

// class CustomStyledDrawer extends StatelessWidget {
//   const CustomStyledDrawer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: Colors.grey[100],
//       width: 280, // Custom width
//       child: Column(
//         children: [
//           Container(
//             height: 200,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [Colors.purple, Colors.deepPurple],
//               ),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CircleAvatar(
//                   radius: 40,
//                   backgroundColor: Colors.white,
//                   child: Icon(
//                     Icons.person,
//                     size: 40,
//                     color: Colors.purple,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'Sarah Johnson',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   'sarah.j@example.com',
//                   style: TextStyle(
//                     color: Colors.white70,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView(
//               padding: EdgeInsets.zero,
//               children: [
//                 _buildCustomListTile(
//                   icon: Icons.dashboard,
//                   title: 'Dashboard',
//                   color: Colors.blue,
//                 ),
//                 _buildCustomListTile(
//                   icon: Icons.shopping_cart,
//                   title: 'Orders',
//                   color: Colors.green,
//                 ),
//                 _buildCustomListTile(
//                   icon: Icons.favorite,
//                   title: 'Favorites',
//                   color: Colors.red,
//                 ),
//                 _buildCustomListTile(
//                   icon: Icons.notifications,
//                   title: 'Notifications',
//                   color: Colors.orange,
//                 ),
//                 _buildCustomListTile(
//                   icon: Icons.history,
//                   title: 'History',
//                   color: Colors.grey,
//                 ),
//                 Divider(),
//                 _buildCustomListTile(
//                   icon: Icons.help_outline,
//                   title: 'Help Center',
//                   color: Colors.teal,
//                 ),
//                 _buildCustomListTile(
//                   icon: Icons.info_outline,
//                   title: 'About',
//                   color: Colors.indigo,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
 
      
    
//   }

//   Widget _buildCustomListTile({
//     required IconData icon,
//     required String title,
//     required Color color,
//   }) {
//     return ListTile(
//       leading: Container(
//         padding: EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: color.withOpacity(0.2),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Icon(icon, color: color),
//       ),
//       title: Text(title),
//       onTap: () {
//         // Handle navigation
//       },
//     );
//   }
// }