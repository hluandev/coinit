import 'package:c_app/data/cal_total_data.dart';
import 'package:c_app/views/home%20screen/body_home_screen.dart';
import 'package:c_app/views/home%20screen/show_bottom_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedBuilder(
          animation: calTotal,
          builder: (context, child) => Text('${calTotal.totalPrice}'),
        ),
      ),
      body: const BodyHomeScreen(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: GestureDetector(
          onTap: () => showModalBottomSheet(
            context: context,
            builder: (context) => const ShowBottomScreen(),
          ),
          child: const Text(
            '+',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}
