import 'package:diseases/constants/colors.dart';
import 'package:diseases/presentations/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import '../../routes.dart' as route;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.primary,
        drawer: const CustomDrawer(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('assets/images/second_logo.png',
                width: size.width / 2, height: size.width / 1.8),
            Container(
              height: 100,
              margin: const EdgeInsets.symmetric(horizontal: 30),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: ShapeDecoration(
                color: AppColors.greyLightColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Center(
                child: Text(
                  'Good morning, what symptoms have been experiencing lately?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF2A325F),
                    fontSize: 20,
                    fontFamily: 'Istok Web',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Image.asset('assets/images/mic 1.png',
                    width: size.width / 2, height: size.width / 3),
                const Text(
                  'Tap mic to speak',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Istok Web',
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
