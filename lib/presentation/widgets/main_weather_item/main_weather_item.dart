import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weathery/presentation/Manger/weather_manger/AppCubit.dart';
import 'package:weathery/presentation/Manger/weather_manger/AppStates.dart';
import 'package:weathery/presentation/Manger/app_manger/cubit_cubit.dart';

class MainWeatherItem extends StatelessWidget {
  const MainWeatherItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = AppCubit.get(context);
            var color =  ModeCubit.get(context).isDark == true
                ? const Color(0xffffffff)
                : const Color(0xff212525);
            return Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Text(
                            '${cubit.temperature}°',
                            style:  TextStyle(
                              color: color,
                                fontSize: 70,
                                fontFamily: 'Ubuntu'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                '${cubit.maxTemp}°/${cubit.minTemp}°',
                                style:  TextStyle(
                                    color: color,
                                    fontSize: 20,
                                    fontFamily: 'Ubuntu'),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '''${DateFormat('EE').format((DateTime.now()))}, ${DateFormat('h:mm a').format(DateTime.now())}''',
                                style:
                                     TextStyle(
                                        color: color,
                                        fontSize: 15,
                                        fontFamily: 'Ubuntu'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${cubit.main}',
                      style:
                           TextStyle(
                               color: color,
                               fontSize: 20,
                               fontFamily: 'Ubuntu'),
                    ),
                  ],
                ),
                const Spacer(),
                Center(
                  child: Image.network("https://merakiapp.be/wp-content/uploads/2022/04/${cubit.currentWeather['weather'][0]['icon']}.png",
                    height: 100,

                  ),
                )
              ],
            );
          });

  }
}
