import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:weathery/presentation/Manger/weather_manger/AppCubit.dart';
import 'package:weathery/presentation/Manger/weather_manger/AppStates.dart';
import 'package:weathery/presentation/screens/city_screen/city_screen.dart';
import 'package:weathery/presentation/Manger/app_manger/cubit_cubit.dart';
import 'package:weathery/presentation/widgets/Custom_form_field/text_form_field.dart';
import 'package:weathery/presentation/widgets/divider/divider.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var color = ModeCubit.get(context).isDark == true
            ? const Color(0xffffffff)
            : const Color(0xff212525);
        var cubit = AppCubit.get(context);
        String? cityNameGet;
        return Drawer(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(children: [
              Center(
                child: DrawerHeader(
                  child: Container(
                    child: Lottie.asset(
                      'assets/drawer.json',
                    ),
                  ),
                ),
              ),
              MyDivider(),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                 Padding(
                   padding: const EdgeInsets.only(top: 10,bottom: 20,left: 10,right: 10),
                   child: Column(
                     children: [
                       Row(
                         children:   [
                           const Icon(Icons.favorite,
                           color: Colors.redAccent,
                           ),
                           const SizedBox(width: 5,),
                           Text('Favorite Location',
                             style:  TextStyle(
                               color: color,
                               fontSize: 20,
                               fontFamily: 'Ubuntu',
                               fontWeight: FontWeight.w500,
                             ),
                           ),
                         ],
                       ),
                       const SizedBox(
                         height: 20,
                       ),
                       Row(

                         children: [
                           Text(
                             '${cubit.cityName}',
                             style:  TextStyle(
                               color: color,
                               fontFamily: 'Ubuntu',
                               fontSize: 20,
                             ),
                           ),
                           const SizedBox(
                             width: 10,
                           ),
                           Text(
                             '${cubit.temperature}°',
                             style:  TextStyle(
                                 color: color,
                                 fontSize: 25,
                                 fontFamily: 'Ubuntu'),
                           ),
                          const Spacer(),
                            Icon(
                             FontAwesomeIcons.locationDot,
                             size: 15,
                             color: color,
                           ),
                         ],
                       ),
                     ],
                   ),
                 ),
                    MyDivider(),
                    const SizedBox(
                      height: 20,
                    ),
                    MyFormField(
                        Controller: searchController,
                        textInputType: TextInputType.text,
                        hintText: 'Enter City Name',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Ubuntu',
                          fontSize: 15,
                        ),
                        style: TextStyle(
                          color: color,
                          fontFamily: 'Ubuntu',
                          fontSize: 20,
                        ),
                        prefix:
                        IconButton(
                          onPressed: () {
                            cubit.getCityWeather(cityName: cityNameGet);
                            searchController.clear();
                          },
                          icon: Icon(Icons.search, color: color),
                        ),
                        onChanged: (value) {
                          cityNameGet=value;
                        },
                      ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomButton(
                      color: color,
                      labelName: 'Discover ',
                      icon: Icon(
                        FontAwesomeIcons.earthAfrica,
                        size: 25,
                        color: color,
                      ),
                      onPressed: () {
                        cubit.getCityWeather(cityName: cityNameGet);
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => CityScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomButton(
                      color: color,
                      onPressed: () {
                        ModeCubit.get(context).changeAppMode();
                      },
                      icon: Icon(
                        FontAwesomeIcons.lightbulb,
                        size: 25,
                        color: color,
                      ),
                      labelName: 'Mode',
                    ),

                  ],
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton(
      {required this.color,
      required this.labelName,
      required this.onPressed,
      required this.icon});
  final Icon icon;
  final VoidCallback onPressed;
  final String? labelName;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ModeCubit.get(context).isDark == true
            ? const Color(0xff212525)
            : const Color(0xffffffff),
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon,
        label: Text(
          labelName!,
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.w400,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            ModeCubit.get(context).isDark == true
                ? const Color(0xff212525)
                : const Color(0xffffffff),
          ),
        ),
      ),
    );
  }
}
