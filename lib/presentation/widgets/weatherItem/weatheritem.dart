import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weathery/presentation/Manger/app_manger/cubit_cubit.dart';

class WeatherItem extends StatelessWidget {
  final String? lottie;
  final String? itemName;
  final dynamic property;
  WeatherItem(
      {required this.lottie, required this.itemName, required this.property});
  @override
  Widget build(BuildContext context) {
    var color =  ModeCubit.get(context).isDark == true
        ? const Color(0xffffffff)
        : const Color(0xff212525);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          lottie!,
          width: 100,
          height: 80,
        ),
        Text(
          itemName!,
          style:  TextStyle(
            color: color,
            fontSize: 20,
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          ' $property',
          style:  TextStyle(
            color: color,
            fontSize: 20,
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}