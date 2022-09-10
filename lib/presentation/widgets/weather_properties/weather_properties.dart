import 'package:flutter/material.dart';
import 'package:weathery/presentation/Manger/weather_manger/AppCubit.dart';
import 'package:weathery/presentation/Manger/app_manger/cubit_cubit.dart';
import 'package:weathery/presentation/widgets/weatherItem/weatheritem.dart';

class WeatherProperties extends StatelessWidget {
  const WeatherProperties({
    Key? key,
    required this.mode,
    required this.cubit,
     this.data,
  required this.uvIndex,
    required this.humadity,
    required this.wind,

  }) : super(key: key);

  final ModeCubit mode;
  final AppCubit cubit;
  final data;
final dynamic uvIndex;
  final dynamic humadity;
  final dynamic wind;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          color: mode.isDark == true
              ? const Color(0xff212525)
              : const Color(0xffffffff),
          borderRadius: BorderRadius.circular(10),
        ),
        child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                WeatherItem(
                  itemName: 'UV index',
                  lottie: 'assets/uv_index.json',
                  property:uvIndex,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 30),
                  child: VerticalDivider(
                    color: Colors.teal[200],
                    thickness: 1,
                  ),
                ),
                WeatherItem(
                  itemName: 'humidity',
                  lottie: 'assets/humidity.json',
                  property: '${humadity}%',
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 30),
                  child: VerticalDivider(
                    color: Colors.teal[200],
                    thickness: 1,
                  ),
                ),
                WeatherItem(
                  itemName: 'Wind',
                  lottie: 'assets/wind.json',
                  property: '$wind km/h',
                ),
              ],
            )),

      ),

    );
  }
}