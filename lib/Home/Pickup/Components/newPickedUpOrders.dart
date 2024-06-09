import 'dart:convert';
import 'package:cleaneo_driver_app/Global/global.dart';
import 'package:cleaneo_driver_app/Home/PickupMap/map.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class NewPickedUpOrders extends StatefulWidget {
  const NewPickedUpOrders({super.key});

  @override
  State<NewPickedUpOrders> createState() => _NewPickedUpOrdersState();
}

class _NewPickedUpOrdersState extends State<NewPickedUpOrders> {
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
                        print(orders[index]['status']);
                        int Counter =
                            jsonDecode(orders[index]['status']).length;
                        print(Counter);
                        // print(Counter);
                        int countItems =
                            jsonDecode(orders[index]['Items']).length;

                        return Counter == 2
                            ? GestureDetector(
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
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                              Counter == 1
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
                                              Counter == 1
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
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 22,
                                              width: 72,
                                              decoration: BoxDecoration(
                                                  color: Counter == 1
                                                      ? Color(0xff29b2fe)
                                                      : Colors.red,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5))),
                                              child: Center(
                                                  child: Text(
                                                Counter == 1
                                                    ? 'Pick Up'
                                                    : "Delivery",
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
                              )
                            : Container();
                      },
                    ),
            ),
          );
  }
}
