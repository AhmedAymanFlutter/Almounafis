import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import '../../../../core/helper/app_images.dart';
import '../widgets/search_bar.dart';
import 'home_view.dart';

class SeeAllPage extends StatelessWidget {
  const SeeAllPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainWhite,
      appBar: AppBar(
       leading: Row(
        
         children: [
           IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeView()),
                    (route) => false,
                  );
                },
                icon: SvgPicture.asset(AppImages.arrowIconback, color: AppColor.secondaryBlack,width:24,height: 24, fit: BoxFit.scaleDown,),
              ),
              // SizedBox(width: 10,),
              //          Text('Back',style: AppTextStyle.setPoppinsSecondaryBlack(fontSize: 16, fontWeight: FontWeight.w500),),
       
         ],
       ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body:  CustomSearchBar(),
    );
  }
}