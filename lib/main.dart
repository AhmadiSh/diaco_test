import 'package:diaco_test/pages/login_page.dart';
import 'package:diaco_test/providers/login_provider.dart';
import 'package:diaco_test/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {

  await Hive.initFlutter();
  await Hive.openBox('users');
  await Hive.openBox('messages');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: MyTheme.lightTheme,
        darkTheme: MyTheme.darkTheme,
        themeMode: ThemeMode.light,
        home: ChangeNotifierProvider<LoginProvider>(
          create: (context) => LoginProvider(),
          child: const LoginPage(),
        ));
  }
}
