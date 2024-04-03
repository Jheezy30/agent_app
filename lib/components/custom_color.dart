import 'package:flutter/material.dart';

class CustomColors {
  static Map<int, Color> color = {
    50: const Color.fromRGBO(236, 24, 68, .1),
    100: const Color.fromRGBO(236, 24, 68, .2),
    200: const Color.fromRGBO(236, 24, 68, .3),
    300: const Color.fromRGBO(236, 24, 68, .4),
    400: const Color.fromRGBO(236, 24, 68, .5),
    500: const Color.fromRGBO(236, 24, 68, .6),
    600: const Color.fromRGBO(236, 24, 68, .7),
    700: const Color.fromRGBO(236, 24, 68, .8),
    800: const Color.fromRGBO(236, 24, 68, .9),
    900: const Color.fromRGBO(236, 24, 68, 1),
  };

  static MaterialColor customColor = MaterialColor(0xffec1844, color);

}
