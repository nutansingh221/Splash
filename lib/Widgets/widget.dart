import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarMain extends StatelessWidget {
  const AppBarMain({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Splash',
        style:
            TextStyle(fontSize: 20.0, letterSpacing: 2, fontFamily: 'poppins'),
      ),
    );
  }
}
