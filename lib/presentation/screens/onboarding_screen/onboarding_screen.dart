import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weathery/presentation/Manger/weather_manger/AppCubit.dart';
import 'package:weathery/presentation/Manger/weather_manger/AppStates.dart';
import 'package:weathery/presentation/Manger/app_manger/cubit_cubit.dart';
import 'package:weathery/presentation/screens/home_screen/home_screen.dart';
import '../../../models/boarding_model/Boarding_Model.dart';
import '../../widgets/build_Boarding_Screen_Item/buildBoardingItem.dart';
import '../../widgets/logo/logo.dart';
import '../../widgets/main_button/mainbutton.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardingController = PageController();

  bool isEnd = false;

  @override
  Widget build(BuildContext context) {
    var color = ModeCubit.get(context).isDark == true
        ? const Color(0xffffffff)
        : const Color(0xff212525);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => HomeScreen()),
                    ModalRoute.withName('/'),
                  );
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xff009688)),
                  elevation: MaterialStateProperty.all(10),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Logo(
                    logoSize: 60.0,
                  ),
                ],
              ),
            ]),
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardingController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    print('last');
                    setState(() {
                      isEnd = true;
                    });
                  } else {
                    print('not last');
                    setState(() {
                      isEnd = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index], color),
                itemCount: boarding.length,
              ),
            ),
            Column(
              children: [
                SmoothPageIndicator(
                    controller: boardingController,
                    count: boarding.length,
                    effect: const ScrollingDotsEffect(
                      activeStrokeWidth: 3,
                      activeDotColor: Color(0xff009688),
                      activeDotScale: 1.3,
                      maxVisibleDots: 5,
                      radius: 5,
                      spacing: 10,
                      dotHeight: 8,
                      dotWidth: 12,
                    )),
                SizedBox(
                  height: 20,
                ),
                MainButton(
                  onTabbed: () {
                    if (isEnd == true) {
                      print('done');
                      Navigator.pushAndRemoveUntil<void>(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                 HomeScreen()),
                        ModalRoute.withName('/'),
                      );
                    } else if (isEnd == false) {
                      print('not done');
                      boardingController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  myColor: const Color(0xff009688),
                  myStyle: const Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
