import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weathery/presentation/Manger/weather_manger/AppCubit.dart';
import 'package:weathery/presentation/Manger/weather_manger/AppStates.dart';
import 'package:weathery/presentation/Manger/app_manger/cubit_cubit.dart';
import 'package:weathery/models/weather_model/weather_model.dart';
import 'package:weathery/presentation/widgets/dialy_forecats_table/daily_forecast_table.dart';
import 'package:weathery/presentation/widgets/divider/divider.dart';
import 'package:weathery/presentation/widgets/hours_table/hours_table.dart';
import 'package:weathery/presentation/widgets/main_weather_item/main_weather_item.dart';
import 'package:weathery/presentation/widgets/sun_condtion/sun_condtion.dart';
import 'package:weathery/presentation/widgets/weatherItem/weatheritem.dart';
import 'package:weathery/presentation/widgets/weather_properties/weather_properties.dart';
import '../../widgets/custom_drawer/custom_drawer.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color =  ModeCubit.get(context).isDark == true
        ? const Color(0xffffffff)
        : const Color(0xff212525);
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          var data = cubit.listOfForecast;
          var hours = cubit.listOfHourlyWeather;
          List weatherCounter = cubit.listOfForecast;
          WeatherModel weather = WeatherModel();
          var mode = ModeCubit.get(context);
          return SafeArea(
            child: Scaffold(

                appBar: AppBar(
                  title: Row(
                    children: [
                      Text(
                        '${cubit.cityName}',
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
                ),
                body: ConditionalBuilder(
                  condition: weatherCounter.isNotEmpty,
                  builder: (context) =>
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MainWeatherItem(),
                                  const MyDivider(),
                                  HoursTable(mode: mode, hours: hours, weather: weather, color: color, cubit: cubit),
                                  SunCondtion(holderSunRise: cubit.sunrise,holderSunSet: cubit.sunset,),
                                  WeatherProperties(
                                      humadity: data[0]['humidity'],
                                      uvIndex: cubit.listOfForecast[0]['uvi'],
                                      wind:  cubit.wind,
                                      mode: mode, cubit: cubit, data: data),
                                  DailyForecastTable(
                                      data: data, weather: weather, cubit: cubit),


                                ],
                              ),
                  ),
                        ),
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                drawer:  CustomDrawer()),
          );
        });
  }
}




