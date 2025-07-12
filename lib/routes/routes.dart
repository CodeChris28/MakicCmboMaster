import 'package:flutter/widgets.dart';
import 'package:makicombomaster/screens/login_screen.dart';
import 'package:makicombomaster/screens/singin_screen.dart';
import 'package:makicombomaster/screens/splash_screen.dart';
import '../screens/screens.dart';

class AppRoutes {
  static String initialRoute = 'splashScreen';
  static Map<String, Widget Function(BuildContext)> getRoutes = {
    'homeScreen': (BuildContext context) => const HomeScreen(),
    'addMakiScreen': (BuildContext context) => const AddMakiScreen(),
    'addComboScreen': (BuildContext context) => const AddComboScreen(),
    'makisScreen': (BuildContext context) => const MakisScreen(),
    'splashScreen': (BuildContext context) => SplashScreen(),
    'loginScreen': (BuildContext context) => LoginScreen(),
    'signinScreen': (BuildContext context) => SigninScreen(),

  };

}