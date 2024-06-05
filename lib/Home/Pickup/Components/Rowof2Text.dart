import 'dart:convert';
import 'package:cleaneo_driver_app/Home/Pickup/Pickup.dart';
import 'package:cleaneo_driver_app/Home/PickupMap/map.dart';
import 'package:http/http.dart' as http;
import 'package:cleaneo_driver_app/Global/global.dart';
import 'package:cleaneo_driver_app/Home/Home_/Home.dart';
import 'package:cleaneo_driver_app/Home/Pickup/Components/pendingDetailsPage.dart';
import 'package:cleaneo_driver_app/Home/Pickup/Components/pickedupDetailsPage.dart';
import 'package:cleaneo_driver_app/Home/Pickup/Components/rating_page.dart';
import 'package:cleaneo_driver_app/Home/StartTrip/Starttrip.dart';
import 'package:cleaneo_driver_app/Screens/Welcome/TS_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_svg/svg.dart';

class PickupTwoText extends StatefulWidget {
  const PickupTwoText({Key? key}) : super(key: key);

  @override
  _PickupTwoTextState createState() => _PickupTwoTextState();
}

class _PickupTwoTextState extends State<PickupTwoText> {
  int _selectedIndex = 0;
  final List<String> _tabNames = ['Pending', 'Picked Up'];

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    final List<List<Map<String, List<Map<String, String>>>>> _todaytabData = [
      [
        // Daily data
        {
          "ongoing": [
            {
              "orderNumber": "1",
              "time": "10:00 AM",
              "onlineMode": "Yes",
              "earning": "₹ 180"
            },
            {
              "orderNumber": "2",
              "time": "11:30 AM",
              "onlineMode": "No",
              "earning": "₹ 200"
            },
          ]
        }
      ],
      [
        // Weekly data
        {
          "orders": [
            {
              "orderNumber": "1",
              "dateandtime": "04 Jul 2021 at 8:09 pm",
              "location": "PDPU Crossroad Kudasan",
              "name": "Shweta",
              "number": "+91 95255 26542",
              "cash": "₹250.00"
            },
            {
              "orderNumber": "1",
              "dateandtime": "04 Jul 2021 at 8:09 pm",
              "location": "PDPU Crossroad Kudasan",
              "name": "Shweta",
              "number": "+91 95255 26542",
              "cash": "₹250.00"
            },
          ]
        }
      ],
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
          child: Expanded(
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
                    width: mQuery.size.width * 0.495,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
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
        ),
        // Content based on tab selection
        if (_selectedIndex == 0) NewOrdersss(),
        if (_selectedIndex == 1)
          Expanded(
            flex: 3,
            child: ListView.builder(
              itemCount: _todaytabData[_selectedIndex][0]["orders"]!.length,
              itemBuilder: (BuildContext context, int index) {
                var order = _todaytabData[_selectedIndex][0]["orders"]![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            '${order['dateandtime']}',
                            style: TextStyle(
                                color: const Color.fromARGB(255, 181, 181, 181),
                                fontSize: mQuery.size.height * 0.016,
                                fontFamily: 'SatoshiBold'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return PickedupDetailsPage();
                          }));
                        },
                        child: Container(
                            height: mQuery.size.height * 0.3,
                            margin: const EdgeInsets.only(bottom: 21.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 0,
                                  blurRadius: 7,
                                  offset: const Offset(
                                    0,
                                    0,
                                  ), // changes the position of the shadow
                                ),
                              ],
                            ),
                            child: ListView(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 50.0,
                                  color: const Color(0xFFF3FBFF),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.shopping_bag_outlined,
                                              color: const Color(0xFF48BDFE),
                                            ),
                                            const SizedBox(
                                              width: 6.0,
                                            ),
                                            Text(
                                              'Order ${order['orderNumber']}',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: mQuery.size.height *
                                                      0.017,
                                                  fontFamily: 'SatoshiBold'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: mQuery.size.height * 0.02,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Location',
                                            style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 152, 152, 152),
                                                fontSize:
                                                    mQuery.size.height * 0.018,
                                                fontFamily: 'SatoshiBold'),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.home,
                                            color: Colors.blue,
                                            size: 16,
                                          ),
                                          const SizedBox(
                                            width: 6.0,
                                          ),
                                          Text(
                                            '${order['location']}',
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize:
                                                    mQuery.size.height * 0.014,
                                                fontFamily: 'SatoshiMedium'),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      const Divider(
                                        color:
                                            Color.fromARGB(255, 212, 212, 212),
                                        thickness: 0.7,
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Customer Detail',
                                            style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 152, 152, 152),
                                                fontSize:
                                                    mQuery.size.height * 0.016,
                                                fontFamily: 'SatoshiBold'),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        children: [
                                          const ProfilePicture(
                                            name: "",
                                            radius: 18,
                                            fontsize: 10,
                                            img:
                                                "https://a.storyblok.com/f/191576/1200x800/faa88c639f/round_profil_picture_before_.webp",
                                          ),
                                          const SizedBox(
                                            width: 10.0,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${order['name']}',
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize:
                                                        mQuery.size.height *
                                                            0.016,
                                                    fontFamily:
                                                        'SatoshiMedium'),
                                              ),
                                              Text(
                                                '${order['number']}',
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize:
                                                        mQuery.size.height *
                                                            0.015,
                                                    fontFamily:
                                                        'SatoshiMedium'),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return RatingPage();
                                    }));
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(6.0),
                                          bottomRight: Radius.circular(6.0)),
                                      color: Color(0xFF29B2FE),
                                    ),
                                    height: mQuery.size.height * 0.035,
                                    width: double.infinity,
                                    child: Center(
                                      child: Text(
                                        'SUBMIT REVIEW',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                mQuery.size.height * 0.015,
                                            fontFamily: 'SatoshiBold'),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

class NewOrdersss extends StatefulWidget {
  const NewOrdersss({super.key});

  @override
  State<NewOrdersss> createState() => _NewOrdersssState();
}

class _NewOrdersssState extends State<NewOrdersss> {
  List orders = [];

  Future<void> fetchResponse() async {
    final url =
        'https://drycleaneo.com/CleaneoDriver/api/ongoingOrders/${UserData.read('ID')}';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          orders = jsonDecode(response.body);
        });
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchResponse();
  }

  void _showOrderDetails(BuildContext context, Map order) {
    List items = jsonDecode(order['Items']);

    Map<String, List<String>> groupedItems = {};
    for (var item in items) {
      if (!groupedItems.containsKey(item['type'])) {
        groupedItems[item['type']] = [];
      }
      groupedItems[item['type']]!.add(item['name']);
    }
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
                height: 420,
                color: Colors.white,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Row(children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Order Id : ${order['OrderID']}",
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff1e2a52),
                                height: 19 / 16,
                              ),
                              textAlign: TextAlign.left,
                            ),

                            const SizedBox(
                              width: double.infinity,
                              child: Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                            ),
                            ...groupedItems.entries.map((entry) {
                              return Text(
                                "${entry.key}: ${entry.value.join(', ')}",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff1e2a52),
                                  height: 15 / 12,
                                ),
                              );
                            }).toList(),
                            // Text(
                            //   "",
                            //   style: TextStyle(
                            //     fontFamily: "Inter",
                            //     fontSize: 10,
                            //     fontWeight: FontWeight.w400,
                            //     color: Color(0xff1e2a52),
                            //     height: 15 / 12,
                            //   ),
                            //   textAlign: TextAlign.left,
                            // ),
                            // ignore: prefer_const_constructors
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                        color:
                                            Color.fromARGB(255, 212, 212, 212),
                                        spreadRadius: 1,
                                        blurRadius: 10)
                                  ]),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${order['PickupDate']}',
                                          style: TextStyle(
                                            fontFamily: "Inter",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff1e2a52),
                                            height: 19 / 16,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                          "Pickup Date",
                                          style: TextStyle(
                                            fontFamily: "Inter",
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff1e2a52),
                                            height: 17 / 14,
                                          ),
                                          textAlign: TextAlign.left,
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 30,
                                    color: const Color.fromARGB(
                                        255, 207, 207, 207),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${order['PickupTime']}",
                                          style: TextStyle(
                                            fontFamily: "Inter",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff1e2a52),
                                            height: 19 / 16,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                          "Pickup Time",
                                          style: TextStyle(
                                            fontFamily: "Inter",
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff1e2a52),
                                            height: 17 / 14,
                                          ),
                                          textAlign: TextAlign.left,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Shop/Pickup Location",
                                    style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff1e2a52),
                                      height: 19 / 16,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    "Floor : ${order['Floor']}\n${order['Caddress']}\nHow to Reach : ${order['HTReach']}",
                                    style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff1e2a52),
                                      height: 12 / 10,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Drop Location",
                                    style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff1e2a52),
                                      height: 19 / 16,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    "${order['VendorAddress']}",
                                    style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff1e2a52),
                                      height: 12 / 10,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Weight",
                                    style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff1e2a52),
                                      height: 19 / 16,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    "dfb",
                                    style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff1e2a52),
                                      height: 12 / 10,
                                    ),
                                    textAlign: TextAlign.left,
                                  )
                                ]),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 50,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                child: TextButton(
                                                  onPressed: () async {
                                                    // PickupMap
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return PickupMap(
                                                          order: order);
                                                    }));
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            1,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                            color: Color(
                                                                0xff006acb))),
                                                    child: const Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "Navigate",
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color: Color(
                                                                  0xff006acb)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return orders.length == 0
        ? Container()
        : Container(
            height: MediaQuery.of(context).size.height * 0.66,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: orders.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        int Count = jsonDecode(orders[index]['status']).length;
                        int countItems =
                            jsonDecode(orders[index]['Items']).length;

                        return GestureDetector(
                          onTap: () {
                            // _showOrderDetails(context, orders[index]);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return PickupMap(order: orders[index]);
                            }));
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            height: 75,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Row(children: [
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Order Id : ${orders[index]['OrderID']}",
                                            style: TextStyle(
                                              fontFamily: "Inter",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xff1e2a52),
                                              height: 19 / 16,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            "Total Items : $countItems",
                                            style: TextStyle(
                                              fontFamily: "Inter",
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey,
                                              height: 19 / 16,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        Count == 1
                                            ? "Pickup Date : ${orders[index]['PickupDate']}"
                                            : "Delivery Date : ${orders[index]['DeliveryDate']}",
                                        style: TextStyle(
                                          fontFamily: "Inter",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey,
                                          height: 19 / 16,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        Count == 1
                                            ? "Pickup Time : ${orders[index]['PickupTime']}"
                                            : "Delivery Time : ${orders[index]['DeliveryTime']}",
                                        style: TextStyle(
                                          fontFamily: "Inter",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey,
                                          height: 19 / 16,
                                        ),
                                        textAlign: TextAlign.left,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 22,
                                        width: 72,
                                        decoration: BoxDecoration(
                                            color: Count == 1
                                                ? Color(0xff29b2fe)
                                                : Colors.red,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        child: Center(
                                            child: Text(
                                          Count == 1 ? 'Pick Up' : "Delivery",
                                          style: TextStyle(
                                            fontFamily: "Inter",
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                            height: 12 / 10,
                                          ),
                                          textAlign: TextAlign.left,
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // const Icon(Icons.arrow_drop_down_sharp)
                            ]),
                          ),
                        );
                      },
                    ),
            ),
          );
  }
}
