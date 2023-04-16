import 'package:c_app/const/sizes.dart';
import 'package:c_app/data/add_and_remove_coin.dart';
import 'package:c_app/data/api_data.dart';
import 'package:c_app/data/search_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShowBottomScreen extends StatelessWidget {
  const ShowBottomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextFormField(
          initialValue: searchData.textResult,
          onChanged: (value) => searchData.getResults(value),
        ),
      ),
      body: FutureBuilder(
        future: apiData.getCoins(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AnimatedBuilder(
              animation: searchData,
              builder: (context, child) => ListView.builder(
                itemCount: searchData.initialResults.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      addAndRemoveCoin.addCoin(index);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          searchData.initialResults[index].coin,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: Sizes.size24,
                          ),
                        ),
                        Text(
                          NumberFormat()
                              .format(searchData.initialResults[index].price),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: Sizes.size24,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
