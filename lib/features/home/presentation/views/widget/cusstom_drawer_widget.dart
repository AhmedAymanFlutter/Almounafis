// custom_drawer.dart
import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/features/auth/presentation/views/sign_up_view.dart';
import 'package:almonafs_flutter/features/servicepackadge/view/Service_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../setting/widget/languang.dart';

class CustomDrawer extends StatelessWidget {
  final Function(int) onNavigationItemTapped;
  
  const CustomDrawer({
    super.key,
    required this.onNavigationItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
       
        width: 356,
        height: 861,
        color: AppColor.mainWhite,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildDrawerHeader(),  
            _buildDrawerItem(
              context,
              iconPath: 'assets/icons/user.svg',
              title: 'profile',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpView(),
                  ),
                );
              },
            ),               
            _buildDrawerItem(
              context,
              iconPath: 'assets/icons/translate.svg',
              title: 'Language',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LanguageScreen(),
                  ),
                );
              },
            ),        
             _buildDrawerItem(
              context,
              iconPath: 'assets/icons/serves.svg',
              title: 'services',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ServicesView(),
                  ),
                );
              },
            ),        
            _buildDrawerItem(
              context,
              iconPath:'assets/icons/Packages.svg',
              title: 'Packages',
              onTap: () {
                Navigator.pop(context);
                // Navigate to settings
              },
            ),
          
            Divider(color: Colors.grey.shade300, thickness: 1),
            _buildDrawerItem(
              context,
              iconPath: 'assets/icons/About Us.svg',
              title: 'About',
              onTap: () {
                Navigator.pop(context);
                // Navigate to about
              },
            ),
            
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: const Color(0xff0e2e4f),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Image.asset('assets/splash/main_logo.png',
            width:48 ,
            height: 48,
            )
          ),
          const SizedBox(height: 12),
          Text(
            'Welcome User',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
       
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required String iconPath,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: SvgPicture.asset(
        width: 24,
        height: 24,
       iconPath ,
        color: textColor ?? const Color(0xff0e2e4f),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: textColor ?? Colors.black87,
        ),
      ),
      onTap: onTap,
      hoverColor: Colors.grey.shade100,
    );
  }
 
}