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
      if (MediaQuery.of(context).viewInsets.bottom == 0) {
        addAndRemoveCoin.updateCoin();
      }
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
          backgroundColor: const Color(0xff1D1D1D),
          elevation: 0,
          title: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: AnimatedBuilder(
                      animation: calTotal,
                      builder: (context, child) => Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: Sizes.size10,
                            ),
                            child: Text(
                                NumberFormat.simpleCurrency(
                                        locale: 'en-US', decimalDigits: 0)
                                    .format(calTotal.totalPrice),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: 'ClashGrotesk',
                                  fontSize: Sizes.size40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: const BodyHomeScreen(),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
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
