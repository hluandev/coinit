import 'dart:async';

import 'package:c_app/const/sizes.dart';
import 'package:c_app/data/add_and_remove_coin.dart';
import 'package:c_app/data/cal_total_data.dart';
import 'package:c_app/views/home%20screen/body_home_screen.dart';
import 'package:c_app/views/home%20screen/show_bottom_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
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

  void _bodyTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _bodyTap,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: Sizes.size80,
          centerTitle: true,
          backgroundColor: const Color(0xffF1F1F1),
          elevation: 0,
          title: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: Sizes.size5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Sizes.size10),
                  ),
                  child: AnimatedBuilder(
                    animation: calTotal,
                    builder: (context, child) => Column(
                      children: [
                        Text(
                          NumberFormat.simpleCurrency(
                                  locale: 'en-US', decimalDigits: 0)
                              .format(calTotal.totalPrice),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.jura(
                            fontSize: Sizes.size36,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: const BodyHomeScreen(),
        bottomNavigationBar: BottomAppBar(
          color: const Color.fromARGB(255, 237, 237, 237),
          elevation: 0,
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
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: const Icon(
                FontAwesomeIcons.angleUp,
                size: Sizes.size28,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
