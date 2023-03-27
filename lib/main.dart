import 'package:diaco_test/providers/login_provider.dart';
import 'package:diaco_test/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'ui/pages/login_page.dart';
import 'ui/style/theme.dart';

void main() async {

  await Hive.initFlutter();
  await Hive.openBox('users');
  await Hive.openBox('messages');
  runApp(ChangeNotifierProvider<ThemeProvider>(
    create: (_)=>ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context,provider,child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: MyTheme.lightTheme,
            darkTheme: MyTheme.darkTheme,
            themeMode:provider.isDark?ThemeMode.dark: ThemeMode.light,
            home: ChangeNotifierProvider<LoginProvider>(
              create: (context) => LoginProvider()..init(),
              lazy: false,
              child:  LoginPage(),
            ));
      }
    );
  }
}
