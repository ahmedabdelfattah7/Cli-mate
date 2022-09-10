import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: Row(children: [
        Expanded(
          child: Divider(
            color: Colors.teal[300],
            height: 1.5,
          ),
        ),
      ]),
    );
  }
}