import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:weathery/presentation/Manger/weather_manger/AppCubit.dart';
import 'package:weathery/presentation/Manger/weather_manger/AppStates.dart';
import 'package:weathery/presentation/Manger/app_manger/cubit_cubit.dart';
import 'package:weathery/presentation/screens/home_screen/home_screen.dart';
import 'package:weathery/presentation/widgets/Custom_form_field/text_form_field.dart';
import 'package:weathery/presentation/widgets/divider/divider.dart';
import 'package:weathery/presentation/widgets/sun_condtion/sun_condtion.dart';
import 'package:weathery/presentation/widgets/weather_properties/weather_properties.dart';

class CityScreen extends StatelessWidget {
  const CityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var color = ModeCubit.get(context).isDark == true
              ? const Color(0xffffffff)
              : const Color(0xff212525);
          var cubit = AppCubit.get(context);
            var mode = ModeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Text(
                    '${cubit.name}',
                    style: const TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    FontAwesomeIcons.locationDot,
                    size: 15,
                  ),
                ],
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil<void>(
                    context,
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) => HomeScreen()),
                    ModalRoute.withName('/'),
                  );
                },
                icon: Icon(Icons.chevron_left, color: color),
              ),
              elevation: 2,
            ),
            body: ConditionalBuilder(
                condition: cubit.weatherCityCounter.isNotEmpty,
                builder: (context) =>
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                      Row(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${cubit.cityTemperature}°',
                              style: TextStyle(
                                  color: color,
                                  fontSize: 70,
                                  fontFamily: 'Ubuntu'),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${cubit.cityMain}',
                                  style: TextStyle(
                                      color: color,
                                      fontSize: 20,
                                      fontFamily: 'Ubuntu'),
                                ),

                          ],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${cubit.maxCityTemp}°/${cubit.minCityTemp}°',
                          style: TextStyle(
                              color: color,
                              fontSize: 20,
                              fontFamily: 'Ubuntu'),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Image.network(
                              "https://merakiapp.be/wp-content/uploads/2022/04/${cubit.cityWeather}.png",
                              height: 100,
                            ),
                          ),
                        ),
                      ]),

                    const MyDivider(),
                    SunCondtion(
                      holderSunRise: cubit.citySunrise,
                      holderSunSet: cubit.citySunset,
                    ),
                    WeatherProperties(
                        humadity: cubit.cityHumidity,
                        uvIndex: cubit.listOfForecast[0]['uvi'],
                        wind:  cubit.wind,
                        mode: mode, cubit: cubit, ),
                  ],
                ),
              ),
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        });
  }
}
