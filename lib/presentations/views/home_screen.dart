import 'dart:typed_data';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:diseases/constants/colors.dart';
import 'package:diseases/presentations/widgets/custom_drawer.dart';
import 'package:diseases/presentations/widgets/success_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:speech_to_text/speech_to_text.dart';


import '../../constants/constants.dart';
import '../../routes.dart' as route;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // create a function to determine the right greeting message depending on the time of the day

  var text = 'Tap mic to speak';
  var isListening = false;

  // store the message together with the greeting message in a variable
  var message =
      '${greetingMessage()}, what symptoms have been experiencing lately?';

  SpeechToText speech = SpeechToText();
  final TextEditingController _symptomsController = TextEditingController();







  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.primary,
          iconTheme: const IconThemeData(color: Colors.white, size: 40),
        ),
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
              child: Center(
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
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
                AvatarGlow(
                  endRadius: size.width / 5,
                  animate: isListening,
                  duration: const Duration(milliseconds: 2000),
                  repeat: true,
                  repeatPauseDuration: const Duration(milliseconds: 100),
                  showTwoGlows: true,
                  glowColor: AppColors.greyLightColor,
                  child: GestureDetector(
                    onTap: () async {
                      print("clicked");
                      if (!isListening) {
                        var available = await speech.initialize(
                          onStatus: (status) {
                            if (status == 'notListening') {
                              setState(() {
                                isListening = false;
                                text = 'Tap mic to speak';
                              });
                              successDialog(
                                context: context,
                                title: 'Confirm',
                                success: true,
                                focusNodes: true,
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(
                                      context, route.suggestionsScreen);
                                },
                                input: true,
                                controller: _symptomsController,
                                message: 'Do you want to send this message?',
                              );
                            }
                          },
                          onError: (error) {
                            Fluttertoast.showToast(msg: error.errorMsg);
                            setState(() {
                              isListening = false;
                              text = 'Tap mic to speak';
                            });
                          },
                        );
                        if (available) {
                          setState(() {
                            isListening = true;
                            text = 'Listening...';
                          });

                          speech.listen(
                            onResult: (value) => setState(() {
                              message = value.recognizedWords;
                            }),
                          );
                        } else {
                          message = 'Speech recognition not available';
                        }
                      } else {
                        speech.stop();
                        setState(() {
                          isListening = false;
                          text = 'Tap mic to speak';
                        });
                      }
                    },
                    child: Image.asset('assets/images/mic 1.png',
                        width: size.width / 4, height: size.width / 3),
                  ),
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
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
