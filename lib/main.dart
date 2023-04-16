import 'package:c_app/views/home%20screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('coin_database');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'C',
      theme: ThemeData(
        primaryColor: const Color(0xffE6FFA0),
        scaffoldBackgroundColor: const Color(0xff0A0A0A),
        textTheme: GoogleFonts.juraTextTheme(),
      ),
      home: const HomeScreen(),
    );
  }
}
