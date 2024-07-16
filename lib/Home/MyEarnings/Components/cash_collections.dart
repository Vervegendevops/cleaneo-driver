import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../model/cash_collection.dart';
import '../../../model/tips.dart';
import '../../../services/api_provider.dart';

class MyEarningstabs extends StatefulWidget {
  const MyEarningstabs({Key? key}) : super(key: key);

  @override
  _MyEarningstabsState createState() => _MyEarningstabsState();
}

class _MyEarningstabsState extends State<MyEarningstabs> {
  int _selectedIndex = 0;
  final List<String> _tabNames = ['Tips', 'Incentives'];
  List<Tip> tiplist = [];
  TransactionResponse? transactionResponse;
  List<CashCollection> cashCollectionList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    tiplist = await ApiProvider().getTips();
    transactionResponse = await ApiProvider().getCashCollection();
    cashCollectionList = transactionResponse!.data;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _tabNames.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                child: Container(
                  width: mQuery.size.width * 0.47,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: _selectedIndex == index
                            ? const Color(0xFF29B2FE)
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      _tabNames[index],
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'SatoshiBold',
                        color: _selectedIndex == index
                            ? const Color(0xFF29B2FE)
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _selectedIndex == 0 ? tiplist.length : cashCollectionList.length,
            itemBuilder: (BuildContext context, int index) {
              if (_selectedIndex == 0) {
                var orderr = tiplist[index];
                return Container(
                  height: mQuery.size.height * 0.08,
                  margin: const EdgeInsets.only(bottom: 21.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: 7,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (orderr.tipMethod == "upi")
                            SizedBox(
                                height: 30,
                                width: 30,
                                child: SvgPicture.asset(
                                  "assets/earning1.svg",
                                )),
                          if (orderr.tipMethod != "upi")
                            SizedBox(
                                height: 31,
                                width: 31,
                                child: SvgPicture.asset("assets/earning2.svg",
                                    color: const Color(0xFF13A32B))),
                          const SizedBox(
                            width: 16.0,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order: ${orderr.id}',
                                style: const TextStyle(
                                    fontSize: 13.0,
                                    fontFamily: 'SatoshiBold'),
                              ),
                              Text(
                                '${orderr.createdAt}',
                                style: const TextStyle(
                                    fontSize: 10.0,
                                    fontFamily: 'SatoshiMedium',
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            '${orderr.amount}',
                            style: TextStyle(
                              fontSize: 13.0,
                              fontFamily: "SatoshiBold",
                              color: orderr.tipMethod == "upi"
                                  ? const Color(0xFF29B2FE)
                                  : const Color(0xFF13A32B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                var cashCollection = cashCollectionList[index];
                return Container(
                  height: mQuery.size.height * 0.08,
                  margin: const EdgeInsets.only(bottom: 21.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: 7,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                            width: 30,
                            child: SvgPicture.asset(
                              "assets/earning1.svg",
                            ),
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order: ${cashCollection.orderId}',
                                style: const TextStyle(
                                    fontSize: 13.0,
                                    fontFamily: 'SatoshiBold'),
                              ),
                              Text(
                                '${cashCollection.transactionDate}',
                                style: const TextStyle(
                                    fontSize: 10.0,
                                    fontFamily: 'SatoshiMedium',
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            '${cashCollection.amount}',
                            style: const TextStyle(
                                fontSize: 13.0,
                                fontFamily: "SatoshiBold",
                                color: Color(0xFF29B2FE)),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
