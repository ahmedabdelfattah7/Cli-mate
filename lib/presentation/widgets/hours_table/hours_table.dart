import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:weathery/presentation/Manger/weather_manger/AppCubit.dart';
import 'package:weathery/presentation/Manger/app_manger/cubit_cubit.dart';
import 'package:weathery/models/weather_model/weather_model.dart';
import 'package:weathery/presentation/widgets/divider/divider.dart';

class HoursTable extends StatelessWidget {
  const HoursTable({
    Key? key,
    required this.mode,
    required this.hours,
    required this.weather,
    required this.color,
    required this.cubit,
  }) : super(key: key);

  final ModeCubit mode;
  final hours;
  final WeatherModel weather;
  final Color color;
  final AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(

          width: double.infinity,
          height: 100,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              width: 10,
            ),

            shrinkWrap: true,
             scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              dynamic temp = hours[index]['temp'];
              int tempreture = temp.toInt();
              var date = hours[index]['dt'];
              var condition = hours[index]['weather'][0]['id'];
              String weatherIcon = weather.getWeatherIcon(condition!);
              return Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                  color: mode.isDark == true
                      ? const Color(0xff212525)
                      : const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(25),
                ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Text(
                          DateFormat('h:mm a').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  date * 1000,
                                  isUtc: false)),
                          style:  TextStyle(
                            color: color,
                            fontSize: 19,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network("https://merakiapp.be/wp-content/uploads/2022/04/${hours[index]['weather'][0]['icon']}.png",
                              height: 25,

                              ),
                              SizedBox(width: 4,),
                              Text(
                                '$tempreture°',
                                style:
                                TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: color,
                                    fontSize: 19,
                                    fontFamily: 'Ubuntu'),
                              ),
                            ],
                          ),


                      ],
                    ),
                  ),

              );
            },
            itemCount: cubit.listOfHourlyWeather.length,
          ),
        ),
      );
  }
}
