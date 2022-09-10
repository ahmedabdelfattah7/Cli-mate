import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  var logoSize;
  Logo({required this.logoSize});
  @override
  Widget build(BuildContext context) {
    return Text(
      'Cli -Mate',
      style: GoogleFonts.lobster(
        textStyle: TextStyle(
          color: const Color(0xff02a497),
          fontSize: logoSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
