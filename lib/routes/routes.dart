import 'package:flutter/widgets.dart';
import '../screens/screens.dart';

class AppRoutes {
  static String initialRoute = 'homeScreen';
  static Map<String, Widget Function(BuildContext)> getRoutes = {
    'homeScreen': (BuildContext context) => const HomeScreen(),
    'addMakiScreen': (BuildContext context) => const AddMakiScreen(),
    'addComboScreen': (BuildContext context) => const AddComboScreen(),
    'makisScreen': (BuildContext context) => const MakisScreen(),
  };

}