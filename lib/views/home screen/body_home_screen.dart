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
              key: UniqueKey(),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: Sizes.size20,
                      horizontal: Sizes.size20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                                color: Colors.black,
                                fontSize: Sizes.size20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              NumberFormat().format(
                                  addAndRemoveCoin.coinsOnScreen[index].price),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: Sizes.size20,
                              ),
                            ),
                          ],
                        ),
                        Gaps.v5,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              addAndRemoveCoin.coinsOnScreen[index].symbol,
                              style: const TextStyle(
                                color: Color(0xff989898),
                                fontSize: Sizes.size16,
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
                                        ? const Color.fromARGB(255, 46, 230, 0)
                                        : const Color(0xffFF0000),
                                    fontSize: Sizes.size16,
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
                                      ? const Color.fromARGB(255, 46, 230, 0)
                                      : const Color(0xffFF0000),
                                  size: Sizes.size14,
                                )
                              ],
                            ),
                          ],
                        ),
                        Gaps.v16,
                        TextFormField(
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                              fillColor: const Color(0xffF8F8F8),
                              filled: true,
                              contentPadding: const EdgeInsets.all(0),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius:
                                      BorderRadius.circular(Sizes.size10)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(Sizes.size10),
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor))),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: Sizes.size20,
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
                  Gaps.v16
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
