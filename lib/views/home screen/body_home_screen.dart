import 'package:c_app/const/sizes.dart';
import 'package:c_app/data/add_and_remove_coin.dart';
import 'package:c_app/data/cal_total_data.dart';
import 'package:flutter/material.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: Sizes.size5),
      child: AnimatedBuilder(
        animation: addAndRemoveCoin,
        builder: (context, child) => RefreshIndicator(
          onRefresh: () => addAndRemoveCoin.updateCoin(),
          child: ListView.builder(
            itemCount: addAndRemoveCoin.coinsOnScreen.length,
            itemBuilder: (context, index) {
              return Dismissible(
                onDismissed: (direction) {
                  calTotal.removeInput(index);
                  addAndRemoveCoin.removeCoin(index);
                },
                key: Key(addAndRemoveCoin.coinsOnScreen[index].coin),
                child: Container(
                  color: const Color(0xff0A0A0A),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            addAndRemoveCoin.coinsOnScreen[index].coin,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: Sizes.size28,
                            ),
                          ),
                          Text(
                            NumberFormat().format(
                                addAndRemoveCoin.coinsOnScreen[index].price),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: Sizes.size28,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            width: 100,
                            child: Container(
                              color: Colors.black,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                ),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: Sizes.size28,
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
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
