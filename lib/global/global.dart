import 'package:flutter/material.dart';
import '../enums/theme.dart';

ValueNotifier<Themes> globaltheme = ValueNotifier(Themes.LIGHT);
ValueNotifier<Color> col = ValueNotifier(Colors.white);
Color textColor = Colors.purple;
var cacheDirectory;
late double maxWidth, maxHeight;
ValueNotifier<String> lang = ValueNotifier("en");
