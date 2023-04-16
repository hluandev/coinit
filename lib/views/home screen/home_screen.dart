import 'package:c_app/const/sizes.dart';
import 'package:c_app/data/cal_total_data.dart';
import 'package:c_app/views/home%20screen/body_home_screen.dart';
import 'package:c_app/views/home%20screen/show_bottom_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

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
        centerTitle: true,
        backgroundColor: const Color(0xff0A0A0A),
        elevation: 0,
        title: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: AnimatedBuilder(
            animation: calTotal,
            builder: (context, child) => Text(
              NumberFormat.simpleCurrency(locale: 'en-US', decimalDigits: 0)
                  .format(calTotal.totalPrice),
              style: const TextStyle(
                fontSize: Sizes.size40,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: const BodyHomeScreen(),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size14,
          horizontal: Sizes.size16,
        ),
        color: const Color(0xff0A0A0A),
        child: GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => const ShowBottomScreen(),
            );
            // addAndRemoveCoin.updateCoin();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: Sizes.size10),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(
                  Sizes.size16,
                )),
            child: const Icon(
              FontAwesomeIcons.angleUp,
              size: Sizes.size28,
            ),
          ),
        ),
      ),
    );
  }
}
