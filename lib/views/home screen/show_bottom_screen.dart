import 'package:c_app/const/gaps.dart';
import 'package:c_app/const/sizes.dart';
import 'package:c_app/data/add_and_remove_coin.dart';
import 'package:c_app/data/api_data.dart';
import 'package:c_app/data/search_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ShowBottomScreen extends StatelessWidget {
  const ShowBottomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: Sizes.size72,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: TextFormField(
          cursorColor: Theme.of(context).primaryColor,
          style: const TextStyle(
              color: Colors.black,
              fontSize: Sizes.size20,
              fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
                vertical: 0, horizontal: Sizes.size16),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          initialValue: searchData.textResult,
          onChanged: (value) => searchData.getResults(value),
        ),
      ),
      body: FutureBuilder(
        future: apiData.getCoins(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size14,
              ),
              child: AnimatedBuilder(
                animation: searchData,
                builder: (context, child) => ListView.builder(
                  itemCount: searchData.initialResults.length,
                  itemBuilder: (context, index) {
                    return Ink(
                      padding: const EdgeInsets.symmetric(
                        vertical: Sizes.size8,
                      ),
                      child: InkWell(
                        splashColor: Theme.of(context).primaryColor,
                        splashFactory: InkSparkle.splashFactory,
                        onTap: () {
                          addAndRemoveCoin.addCoin(index);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  searchData.initialResults[index].coin,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: Sizes.size24,
                                      fontWeight: FontWeight.bold),
                                ),
                                Gaps.v4,
                                Text(
                                  searchData.initialResults[index].symbol,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 170, 170, 170),
                                    fontSize: Sizes.size20,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  NumberFormat().format(
                                      searchData.initialResults[index].price),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: Sizes.size24,
                                      fontWeight: FontWeight.bold),
                                ),
                                Gaps.v4,
                                Row(
                                  children: [
                                    Text(
                                      '${NumberFormat().format(double.parse(searchData.initialResults[index].percent24h))}%',
                                      style: TextStyle(
                                        color: double.parse(searchData
                                                    .initialResults[index]
                                                    .percent24h) >
                                                0
                                            ? Theme.of(context).primaryColor
                                            : const Color(0xff989898),
                                        fontSize: Sizes.size20,
                                      ),
                                    ),
                                    Icon(
                                      double.parse(searchData
                                                  .initialResults[index]
                                                  .percent24h) >
                                              0
                                          ? FontAwesomeIcons.arrowUp
                                          : FontAwesomeIcons.arrowDown,
                                      color: double.parse(searchData
                                                  .initialResults[index]
                                                  .percent24h) >
                                              0
                                          ? Theme.of(context).primaryColor
                                          : const Color(0xff989898),
                                      size: Sizes.size14,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          }
        },
      ),
    );
  }
}
