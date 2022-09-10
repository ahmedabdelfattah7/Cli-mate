import 'package:flutter/cupertino.dart';
import 'package:weathery/presentation/Manger/app_manger/cubit_cubit.dart';
import 'package:weathery/models/boarding_model/Boarding_Model.dart';
Widget buildBoardingItem(BoardingModel model, color) {

  return Column(

    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Center(
        child: Container(
          height: 350,
          width: double.infinity,
          child: Image(
            image: AssetImage('${model.image}'),
          ),
        ),
      ),
      Center(
        child: Text(
          '${model.title}',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(
        height: 15.0,
      ),
      Text(
        '${model.body}',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: color,
            fontSize: 14.0,
        ),
      ),
      SizedBox(
        height: 10,
      )
    ],
  );
}