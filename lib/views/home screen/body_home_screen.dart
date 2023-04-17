import 'package:c_app/const/gaps.dart';
import 'package:c_app/const/sizes.dart';
import 'package:c_app/data/add_and_remove_coin.dart';
import 'package:c_app/data/cal_total_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class BodyHomeScreen extends StatefulWidget {
  const BodyHomeScreen({super.key});

  @override
  State<BodyHomeScreen> createState() => _BodyHomeScreenState();
}

class _BodyHomeScreenState extends State<BodyHomeScreen> {
  @override
  void initState() {
    addAndRemoveCoin.hiveCoinData();
    calTotal.hiveUserInputValue();
    calTotal.hiveTotalData();
    calTotal.hiveUserInputValueForTotal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
      child: AnimatedBuilder(
        animation: addAndRemoveCoin,
        builder: (context, child) => ListView.builder(
          itemCount: addAndRemoveCoin.coinsOnScreen.length,
          itemBuilder: (context, index) {
            return Dismissible(
              onDismissed: (direction) {
                calTotal.removeInput(index);
                addAndRemoveCoin.removeCoin(index);
              },
              key: Key(addAndRemoveCoin.coinsOnScreen[index].coin),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: Sizes.size16,
                      horizontal: Sizes.size20,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xff202020),
                      borderRadius: BorderRadius.circular(Sizes.size10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              addAndRemoveCoin.coinsOnScreen[index].coin,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.size24,
                              ),
                            ),
                            Text(
                              NumberFormat().format(
                                  addAndRemoveCoin.coinsOnScreen[index].price),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.size24,
                              ),
                            ),
                          ],
                        ),
                        Gaps.v4,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              addAndRemoveCoin.coinsOnScreen[index].symbol,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 170, 170, 170),
                                fontSize: Sizes.size20,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${NumberFormat().format(
                                    double.parse(addAndRemoveCoin
                                        .coinsOnScreen[index].percent24h),
                                  )}%',
                                  style: TextStyle(
                                    color: double.parse(addAndRemoveCoin
                                                .coinsOnScreen[index]
                                                .percent24h) >
                                            0
                                        ? Theme.of(context).primaryColor
                                        : const Color.fromARGB(
                                            255, 170, 170, 170),
                                    fontSize: Sizes.size20,
                                  ),
                                ),
                                Icon(
                                  double.parse(addAndRemoveCoin
                                              .coinsOnScreen[index]
                                              .percent24h) >
                                          0
                                      ? FontAwesomeIcons.arrowUp
                                      : FontAwesomeIcons.arrowDown,
                                  color: double.parse(addAndRemoveCoin
                                              .coinsOnScreen[index]
                                              .percent24h) >
                                          0
                                      ? Theme.of(context).primaryColor
                                      : const Color.fromARGB(
                                          255, 170, 170, 170),
                                  size: Sizes.size14,
                                )
                              ],
                            ),
                          ],
                        ),
                        Gaps.v12,
                        TextFormField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff404040),
                                width: Sizes.size2,
                              ),
                            ),
                          ),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: Sizes.size24,
                          ),
                          initialValue: calTotal.userInputValue[index]
                                      .toStringAsFixed(0) ==
                                  '0'
                              ? ''
                              : calTotal.userInputValue[index]
                                  .toStringAsFixed(0),
                          onChanged: (value) {
                            calTotal.calTotal(value, index);
                          },
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                  Gaps.v8
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
