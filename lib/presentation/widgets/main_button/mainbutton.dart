import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final VoidCallback? onTabbed;
  final Text? myStyle;
  final Color? myColor;
  final bool isPlatformLogin;
  final Image? platFormImage;
  MainButton(
      {required this.onTabbed, required this.myStyle, required this.myColor,this.isPlatformLogin=false,
        this.platFormImage,
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTabbed,
      child: Container(
        child: Center(
          child: myStyle,
        ),
        margin: EdgeInsets.only(top: 10.0),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: myColor,

        ),
      ),
    );
  }
}