import 'dart:async';

import 'package:c_app/const/sizes.dart';
import 'package:c_app/data/add_and_remove_coin.dart';
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
  void initState() {
    Timer.periodic(const Duration(seconds: 10), (timer) {
      addAndRemoveCoin.updateCoin();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Sizes.size80,
        centerTitle: true,
        backgroundColor: const Color(0xff0A0A0A),
        elevation: 0,
        title: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size10,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(Sizes.size10),
                ),
                child: AnimatedBuilder(
                  animation: calTotal,
                  builder: (context, child) => Text(
                    NumberFormat.simpleCurrency(
                            locale: 'en-US', decimalDigits: 0)
                        .format(calTotal.totalPrice),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: Sizes.size36,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: const BodyHomeScreen(),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        padding: const EdgeInsets.only(
          right: Sizes.size16,
          left: Sizes.size16,
          top: Sizes.size10,
        ),
        color: const Color(0xff0A0A0A),
        child: GestureDetector(
          onTap: () {
            addAndRemoveCoin.shownBottom = true;
            showModalBottomSheet(
              context: context,
              builder: (context) => const ShowBottomScreen(),
            ).whenComplete(() => addAndRemoveCoin.shownBottom = false);
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
