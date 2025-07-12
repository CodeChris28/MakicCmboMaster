import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:makicombomaster/firebase_options.dart';
import 'package:makicombomaster/providers/combo_provider.dart';
import 'package:makicombomaster/providers/maki_provider.dart';
import 'package:makicombomaster/providers/navigation_provider.dart';
import 'package:makicombomaster/routes/routes.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers:[
      ChangeNotifierProvider(create: (_) => MakiProvider()),
      ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ChangeNotifierProvider(create: (_) => ComboProvider()),
    ],
    child: MaterialApp(
      title: 'Maki Combo Master',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 235, 227)),
      ),
      routes: AppRoutes.getRoutes,
      initialRoute: AppRoutes.initialRoute,
    )
    );
  }
}
