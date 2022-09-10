import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:weathery/presentation/Manger/weather_manger/AppCubit.dart';
import 'package:weathery/presentation/Manger/weather_manger/AppStates.dart';
import 'package:weathery/presentation/Manger/app_manger/cubit_cubit.dart';
import 'package:weathery/models/weather_model/weather_model.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class DailyForecastTable extends StatelessWidget {
  const DailyForecastTable({
    Key? key,
    required this.data,
    required this.weather,
    required this.cubit,
  }) : super(key: key);

  final dynamic data;
  final WeatherModel weather;
  final AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var color =  ModeCubit.get(context).isDark == true
            ? const Color(0xffffffff)
            : const Color(0xff212525);
        return Padding(
          padding: const EdgeInsets.only(top:20),
          child: Container(
            height: 260,
            decoration: BoxDecoration(
              color: ModeCubit.get(context).isDark == true
                  ? const Color(0xff212525)
                  : const Color(0xffffffff),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ConditionalBuilder(
              condition: cubit.listOfForecastCount.isNotEmpty,
              builder: (context) => ListView.builder(
                itemBuilder: (context, index) {
                  dynamic min = data[index]['temp']['min'];
                  int minimumTemp = min.toInt();
                  dynamic max = data[index]['temp']['max'];
                  int maximumTemp = max.toInt();
                  var date = data[index]['dt'];
                  var condition = data[index]['weather'][0]['id'];
                  String weatherIcon = weather.getWeatherIcon(condition!);
                  return Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                            bottom: 8,
                            left: 10,
                          ),
                          child: Text(
                            DateFormat('MMMM d,EEEE').format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            date * 1000,
                                            isUtc: false)) ==
                                    DateFormat('MMMM d,EEEE')
                                        .format(DateTime.now())
                                ? 'Today'
                                : DateFormat.EEEE().format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        date * 1000,
                                        isUtc: false)),
                            style:  TextStyle(
                              color: color,
                              fontSize: 20,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      const Icon(
                        FontAwesomeIcons.droplet,
                        color: Color(0xff5abcd8),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          '${data[index]['humidity']}%',
                          style:  TextStyle(
                            color: color,
                            fontSize: 20,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Image.network("https://merakiapp.be/wp-content/uploads/2022/04/${data[index]['weather'][0]['icon']}.png",
                          height: 25,

                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          '$minimumTemp°/$maximumTemp°',
                          style:
                               TextStyle(
                                color: color,
                                  fontSize: 20,
                                  fontFamily: 'Ubuntu'),
                        ),
                      ),
                    ],
                  );
                },
                itemCount: cubit.listOfForecastCount.length-2,
              ),
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      },
    );
  }
}
