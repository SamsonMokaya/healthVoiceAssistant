import 'package:diseases/constants/colors.dart';
import 'package:flutter/material.dart';
import '../../routes.dart' as route;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.primary,
        body: Column(
          children: [
            Image.asset('assets/images/second_logo.png'),
            Container(
              width: 260,
              height: 100,
              decoration: ShapeDecoration(
                color: AppColors.greyLightColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            )
          ],
        ));
  }
}
