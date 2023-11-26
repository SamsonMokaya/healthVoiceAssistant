import 'dart:typed_data';

import 'package:diseases/business_logic/bloc/authentication/authentication_bloc.dart';
import 'package:diseases/business_logic/cubit/togglePassword/toggle_password_cubit.dart';
import 'package:diseases/constants/colors.dart';
import 'package:diseases/presentations/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;

import '../../../routes.dart' as route;

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();

  void testModel() async {
    try {
      // Your input data as a string of 1s and 0s
      String dataString = "0 0 0 0 0 1 0 1 0 1 1 0 1 1 0 1 0 0 1 0 1 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 1 0 1 0 1 0 0 0 0 0 0 1 1 0 1 0 1 1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0";

      var classMappings = {
        15: 'Fungal infection',
        4: 'Allergy',
        16: 'GERD',
        9: 'Chronic cholestasis',
        14: 'Drug Reaction',
        33: 'Peptic ulcer diseae',
        1: 'AIDS',
        12: 'Diabetes ',
        17: 'Gastroenteritis',
        6: 'Bronchial Asthma',
        23: 'Hypertension ',
        30: 'Migraine',
        7: 'Cervical spondylosis',
        32: 'Paralysis (brain hemorrhage)',
        28: 'Jaundice',
        29: 'Malaria',
        8: 'Chicken pox',
        11: 'Dengue',
        37: 'Typhoid',
        40: 'hepatitis A',
        19: 'Hepatitis B',
        20: 'Hepatitis C',
        21: 'Hepatitis D',
        22: 'Hepatitis E',
        3: 'Alcoholic hepatitis',
        36: 'Tuberculosis',
        10: 'Common Cold',
        34: 'Pneumonia',
        13: 'Dimorphic hemmorhoids(piles)',
        18: 'Heart attack',
        39: 'Varicose veins',
        26: 'Hypothyroidism',
        24: 'Hyperthyroidism',
        25: 'Hypoglycemia',
        31: 'Osteoarthristis',
        5: 'Arthritis',
        0: '(vertigo) Paroymsal  Positional Vertigo',
        2: 'Acne',
        38: 'Urinary tract infection',
        35: 'Psoriasis',
        27: 'Impetigo'
      };

      // Convert the string of 1s and 0s to a list of integers
      List<int> dataList = dataString.split(' ').map((e) => int.parse(e)).toList();

      // Define the desired shape
      List<int> desiredShape = [1, 132]; // Adjust the shape to match your model's input shape

      // Convert the list to a 2D array with the desired shape
      List<List<int>> inputArray = [];
      int index = 0;
      for (int i = 0; i < desiredShape[0]; i++) {
        List<int> row = [];
        for (int j = 0; j < desiredShape[1]; j++) {
          row.add(dataList[index]);
          index++;
        }
        inputArray.add(row);
      }

      // Load the model
      final interpreter = await tfl.Interpreter.fromAsset('assets/model.tflite');

      // Define input and output tensors
      var input = inputArray.expand((element) => element).toList();
      var output = List.filled(1 * 41, 0).reshape([1, 41]); // Adjust the shape

      // Run inference
      interpreter.runForMultipleInputs([input], {0: output});


      List<double> predictions = output[0];

      // Create a list of tuples containing index and percentage
      var percentageTuples = List.generate(predictions.length, (index) => Tuple2(index, predictions[index]));

      // Sort the list of tuples in descending order based on the percentage
      percentageTuples.sort((a, b) => b.item2.compareTo(a.item2));

      // Get the top 4 percentages
      var top4Percentages = percentageTuples.take(4);

      // Print the top 4 predictions and their corresponding percentages
      for (var entry in top4Percentages) {
        var index = entry.item1;
        var percentage = entry.item2 * 100;
        var disease = classMappings[index];
        print('$disease: ${percentage.toStringAsFixed(2)}%');
      }

      // Close the interpreter when done
      interpreter.close();
    } catch (e) {
      print('Error running the model: $e');
    }
  }



  @override
  void initState() {
    super.initState();
    testModel(); // Call the testModel function when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TogglePasswordCubit>().state;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary,
                AppColors.lightPrimary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ]),
              height: size.height * .55,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColor),
                  ),
                  Container(
                    height: 3.7,
                    width: 40,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary,
                          AppColors.lightPrimary,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextField(
                        label: 'Email',
                        controller: _usernameController,
                        prefixIcon: const Icon(Icons.person_2_sharp),
                        placeholder: 'example@gmail.com',
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      CustomTextField(
                        label: 'Enter Password',
                        controller: _passwordController,
                        obsecurePassword: state.passwordLoginVisible,
                        password: true,
                        login: true,
                        prefixIcon: const Icon(Icons.lock_outline),
                        placeholder: '********',
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            gradient: const LinearGradient(
                                colors: [
                                  AppColors.primary,
                                  AppColors.lightPrimary,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight)),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            fixedSize: Size(size.width, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            if (_usernameController.text.isEmpty ||
                                _passwordController.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: 'All fields are required!');
                            } else {
                              context.read<AuthBloc>().add(Login(
                                  email: _usernameController.text,
                                  password: _passwordController.text,
                                  otp: ''));
                            }
                          },
                          child: BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state is LoginInProgress) {
                                return const CupertinoActivityIndicator(
                                  color: AppColors.whiteColor,
                                );
                              } else {
                                return const Text(
                                  'Login',
                                  style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontSize: 20,
                                      color: AppColors.whiteColor),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // InkWell(
                          //   onTap: () {},
                          //   child: Container(
                          //     margin: const EdgeInsets.only(top: 15),
                          //     child: const Text(
                          //       'Forgot Password?',
                          //       style: TextStyle(
                          //         fontFamily: 'Ubuntu',
                          //         fontWeight: FontWeight.bold,
                          //         textBaseline: TextBaseline.alphabetic,
                          //         color: AppColors.primary,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(route.registerScreen);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 15),
                              child: const Text('Create an account',
                                  style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.bold,
                                      textBaseline: TextBaseline.alphabetic,
                                      color: AppColors.lightPrimary)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



class Tuple2<T1, T2> {
  final T1 item1;
  final T2 item2;

  Tuple2(this.item1, this.item2);
}