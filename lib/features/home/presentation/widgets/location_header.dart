import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../setting/view/setting_screen.dart';

class LocationHeader extends StatelessWidget {
  const LocationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Your Location", style: TextStyle(color: Colors.grey)),
            Text("Mansoura, Egypt",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        Row(
          children: [   
    GestureDetector(
        onTap: () {
           
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const SittingScreen()),
          (route) => false,
        );
      },
        
      child: SvgPicture.asset('assets/icons/setting-2.svg',width:24, height: 24,fit: BoxFit.scaleDown, ))],
        )
      ],
    );
  }
}
