import 'package:c_app/data/add_and_remove_coin.dart';
import 'package:c_app/data/cal_total_data.dart';
import 'package:flutter/material.dart';

class BodyHomeScreen extends StatefulWidget {
  const BodyHomeScreen({super.key});

  @override
  State<BodyHomeScreen> createState() => _BodyHomeScreenState();
}

class _BodyHomeScreenState extends State<BodyHomeScreen> {
  final List<TextEditingController> searchControllerList = [];

  @override
  void initState() {
    addAndRemoveCoin.hiveCoinData();
    calTotal.hiveTotalData();
    super.initState();
  }

  @override
  void dispose() {
    for (var eachController in searchControllerList) {
      eachController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: addAndRemoveCoin,
      builder: (context, child) => ListView.builder(
        itemCount: addAndRemoveCoin.coinsOnScreen.length,
        itemBuilder: (context, index) {
          searchControllerList.add(TextEditingController());
          return Dismissible(
            onDismissed: (direction) {
              searchControllerList.removeAt(index);
              calTotal.removeInput(index);
              addAndRemoveCoin.removeCoin(index);
            },
            key: Key(addAndRemoveCoin.coinsOnScreen[index].coin),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(addAndRemoveCoin.coinsOnScreen[index].coin),
                    Text(addAndRemoveCoin.coinsOnScreen[index].price),
                  ],
                ),
                TextFormField(
                  controller: searchControllerList[index],
                  onChanged: (value) {
                    // hvData.saveTextField(value);
                    calTotal.calTotal(value, index);
                  },
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
