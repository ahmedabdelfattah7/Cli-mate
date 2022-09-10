import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weathery/presentation/Manger/weather_manger/AppCubit.dart';
import 'package:weathery/presentation/Manger/app_manger/cubit_cubit.dart';

class SunCondtion extends StatelessWidget {
  const SunCondtion({
   required   this.holderSunRise,
    required    this.holderSunSet

  });

   final dynamic holderSunRise;
  final dynamic holderSunSet;
  @override
  Widget build(BuildContext context) {
    var color =  ModeCubit.get(context).isDark == true
        ? const Color(0xffffffff)
        : const Color(0xff212525);
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        height: 165,
        decoration: BoxDecoration(
          color: ModeCubit.get(context).isDark == true
              ? const Color(0xff212525)
              : const Color(0xffffffff),
          borderRadius: BorderRadius.circular(10),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                       Text(
                        'Sunrise',
                        style: TextStyle(
                          color: color,
                          fontSize: 20,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        DateFormat('h:mm a').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                holderSunRise! * 1000)),
                        style:  TextStyle(
                          color: color,
                          fontSize: 20,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Icon(
                        Icons.sunny_snowing,
                        color: Color(0xffff8100),
                        size: 80,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 30),
                child: VerticalDivider(
                  color: Colors.teal[200],
                  thickness: 1,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                       Text(
                        'Sunset',
                        style: TextStyle(
                          color: color,
                          fontSize: 20,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        DateFormat('h:mm a').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                holderSunSet * 1000)),
                        style:  TextStyle(
                          color: color,
                          fontSize: 20,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Icon(
                        Icons.sunny_snowing,
                        color: Color(0xfff3520d),
                        size: 80,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
