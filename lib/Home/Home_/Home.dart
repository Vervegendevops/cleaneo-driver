import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:cleaneo_driver_app/Global/global.dart';
import 'package:cleaneo_driver_app/Home/CashCollected/CashCollected.dart';
import 'package:cleaneo_driver_app/Home/Delivery/Delivery.dart';
import 'package:cleaneo_driver_app/Home/MyEarnings/MyEarnings.dart';
import 'package:cleaneo_driver_app/Home/Pickup/Pickup.dart';
import 'package:cleaneo_driver_app/Home/StartTrip/Starttrip.dart';
import 'package:cleaneo_driver_app/Home/myProfile_page.dart';
import 'package:cleaneo_driver_app/Screens/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var orderNo = 3;
  int selectedContainerIndex = -1;
  var user = "Shweta";

  TextEditingController searchController = TextEditingController();

  final List<Widget> _pages1 = [
    const PickUp(),
    const Delivery(),
  ];
  final List<Widget> _pages2 = [
    const MyEarnings(),
    const CashCollected(),
  ];
  List<Map<String, dynamic>> gridItems1 = [
    {
      "image": "assets/images/Home/Order Requests.png",
      "text": "Pickup",
    },
    {
      "image": "assets/images/Home/Delivery.png",
      "text": "Delivery",
    },
  ];
  List<Map<String, dynamic>> gridItems2 = [
    {
      "image": "assets/images/Home/My Earnings.png",
      "text": "My Earnings",
      "earnings": "₹ 1000"
    },
    {
      "image": "assets/images/Home/Cash Collected.png",
      "text": "Cash Collected",
      "earnings": "₹ 500"
    },
  ];
  bool status = false;

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);

    return Scaffold(
      drawer: MyDrawer(),
      body: Container(
        color: const Color(0xfff3fbff),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              // height: mQuery.size.height * 0.285,
              height: mQuery.size.height * 0.22,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                image: DecorationImage(
                  image: AssetImage("assets/images/Home/splash.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: ListView(
                // padding: EdgeInsets.zero,
                // physics: ClampingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Builder(
                          builder: (BuildContext context) {
                            return IconButton(
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                              icon: const Icon(
                                Icons.menu,
                                size: 30,
                              ),
                              color: Colors.white,
                            );
                          },
                        ),
                        SvgPicture.asset(
                          "assets/images/Home/mainlogo.svg",
                          width: 30,
                          height: 22,
                        ),
                        // const Expanded(child: SizedBox()),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) {
                        //           return MyProfilePage();
                        //         },
                        //       ),
                        //     );
                        //   },
                        //   child: const ProfilePicture(
                        //     name: "",
                        //     radius: 16,
                        //     fontsize: 10,
                        //     img:
                        //         "https://a.storyblok.com/f/191576/1200x800/faa88c639f/round_profil_picture_before_.webp",
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  // SizedBox(height: mQuery.size.height*0.01,),
                  Column(
                    children: [
                      SizedBox(height: mQuery.size.height * 0.006),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Welcome Back!",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: mQuery.size.height * 0.02,
                                  fontFamily: 'SatoshiBold'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Container(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          // "$user",
                          'Delivery Agent',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: mQuery.size.height * 0.018,
                              fontFamily: 'SatoshiMedium'),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StartTripPage()),
                            );
                          },
                          child: Container(
                            width: mQuery.size.width * 0.3,
                            height: mQuery.size.height * 0.04,
                            decoration: BoxDecoration(
                                color: const Color(0xff29b2fe),
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/route.svg",
                                    width: mQuery.size.width * 0.015,
                                    height: mQuery.size.height * 0.02,
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    "Start Trip",
                                    style: TextStyle(
                                        fontSize: mQuery.size.width * 0.029,
                                        color: Colors.white,
                                        fontFamily: 'SatoshiBold'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: mQuery.size.height * 0.01,
                        // ),
                        // Row(
                        //   children: [
                        //     Text(
                        //       status ? 'Online' : 'Offline',
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //         fontFamily: 'SatoshiMedium',
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: mQuery.size.width * 0.012,
                        //     ),
                        //     Transform.scale(
                        //       scale: 0.7,
                        //       child: Switch(
                        //         value: status,
                        //         activeTrackColor: Colors.white,
                        //         onChanged: (newValue) {
                        //           setState(() {
                        //             status = newValue;
                        //           });
                        //         },
                        //         thumbColor:
                        //             MaterialStateProperty.resolveWith<Color?>(
                        //           (Set<MaterialState> states) {
                        //             // Set thumb color to green when switch is active (on)
                        //             if (states
                        //                 .contains(MaterialState.selected)) {
                        //               return Colors.green;
                        //             }
                        //             // Return null to use default color for other states
                        //             return null;
                        //           },
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                  // Expanded(child: SizedBox()),
                  // SizedBox(height: 32,),
                  // Container(
                  //   margin: const EdgeInsets.symmetric(horizontal: 16),
                  //   height: mQuery.size.height * 0.055,
                  //   padding: const EdgeInsets.only(left: 16),
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(14),
                  //   ),
                  //   child: TextField(
                  //     cursorColor: Colors.grey,
                  //     controller: searchController,
                  //     decoration: InputDecoration(
                  //       contentPadding: EdgeInsets.only(top: 5),
                  //       border: InputBorder.none,
                  //       hintText: "Search",
                  //       hintStyle: TextStyle(
                  //           color: const Color.fromARGB(255, 179, 179, 179),
                  //           fontFamily: 'SatoshiMedium'),
                  //       suffixIcon: const Icon(Icons.search,
                  //           color: Color.fromARGB(255, 179, 179, 179)),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            //First
            Expanded(
              child: ListView(
                children: [
                  // Row(
                  //   children: List.generate(gridItems1.length, (index) {
                  //     var item = gridItems1[index];
                  //     return Expanded(
                  //       child: GestureDetector(
                  //         onTap: () {
                  //           Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //               builder: (context) => _pages1[index],
                  //             ),
                  //           );
                  //         },
                  //         child: Container(
                  //           width: mQuery.size.width * 0.4,
                  //           height: mQuery.size.height * 0.14,
                  //           margin: EdgeInsets.symmetric(horizontal: 20),
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(12),
                  //             color: Colors.white,
                  //             boxShadow: [
                  //               BoxShadow(
                  //                 color: Colors.grey.withOpacity(0.5),
                  //                 spreadRadius: 0,
                  //                 blurRadius: 7,
                  //                 offset: const Offset(0, 0),
                  //               ),
                  //             ],
                  //           ),
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               SizedBox(
                  //                 width: mQuery.size.width * 0.15,
                  //                 height: mQuery.size.height * 0.07,
                  //                 child: Image.asset(
                  //                   item["image"],
                  //                 ),
                  //               ),
                  //               SizedBox(height: mQuery.size.height * 0.006),
                  //               Text(
                  //                 item["text"],
                  //                 style: TextStyle(
                  //                   fontSize: mQuery.size.height * 0.014,
                  //                   fontFamily: 'SatoshiBold',
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   }),
                  // ),

                  // SizedBox(height: mQuery.size.height * 0.04),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => StartTripPage()),
                  //     );
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 24),
                  //     child: SizedBox(
                  //       width: mQuery.size.width * 0.5,
                  //       child: Container(
                  //         width: mQuery.size.width * 0.5,
                  //         height: mQuery.size.height * 0.03,
                  //         decoration: BoxDecoration(
                  //             color: const Color(0xff29b2fe),
                  //             borderRadius: BorderRadius.circular(20)),
                  //         child: Center(
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             children: [
                  //               SvgPicture.asset(
                  //                 "assets/route.svg",
                  //                 width: mQuery.size.width * 0.015,
                  //                 height: mQuery.size.height * 0.02,
                  //               ),
                  //               const SizedBox(
                  //                 width: 10.0,
                  //               ),
                  //               Text(
                  //                 "Start Trip",
                  //                 style: TextStyle(
                  //                     fontSize: mQuery.size.width * 0.029,
                  //                     color: Colors.white,
                  //                     fontFamily: 'SatoshiBold'),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: mQuery.size.height * 0.04),

                  //second
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => _pages2[0],
                              ),
                            );
                          },
                          child: Container(
                            width: mQuery.size.width * 0.4,
                            height: mQuery.size.height * 0.14,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 7,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: mQuery.size.width * 0.15,
                                  height: mQuery.size.height * 0.05,
                                  child: Image.asset(
                                    gridItems2[0]["image"],
                                  ),
                                ),
                                SizedBox(height: mQuery.size.height * 0.006),
                                Text(
                                  gridItems2[0]["text"],
                                  style: TextStyle(
                                    fontSize: mQuery.size.height * 0.014,
                                    fontFamily: 'SatoshiBold',
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  width: mQuery.size.width * 0.13,
                                  height: mQuery.size.height * 0.022,
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50.0)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      gridItems2[0]["earnings"],
                                      style: TextStyle(
                                        fontSize: mQuery.size.height * 0.012,
                                        fontFamily: 'SatoshiBold',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => _pages2[1],
                              ),
                            );
                          },
                          child: Container(
                            height: mQuery.size.height * 0.14,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 7,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: mQuery.size.width * 0.15,
                                  height: mQuery.size.height * 0.05,
                                  child: Image.asset(
                                    gridItems2[1]["image"],
                                  ),
                                ),
                                SizedBox(height: mQuery.size.height * 0.006),
                                Text(
                                  gridItems2[1]["text"],
                                  style: TextStyle(
                                    fontSize: mQuery.size.height * 0.014,
                                    fontFamily: 'SatoshiBold',
                                  ),
                                ),
                                Container(
                                  width: mQuery.size.width * 0.13,
                                  height: mQuery.size.height * 0.022,
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50.0)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      gridItems2[1]["earnings"],
                                      style: TextStyle(
                                        fontSize: mQuery.size.height * 0.012,
                                        fontFamily: 'SatoshiBold',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: mQuery.size.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 2,
                        width: MediaQuery.of(context).size.width * 0.3,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 215, 215, 215),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        'New Orders',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 215, 215, 215),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        height: 2,
                        width: MediaQuery.of(context).size.width * 0.3,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 215, 215, 215),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  NewOrders()
                ],
              ),
            ),
          ],
        ),
      ),
      // drawer: const MyDrawer(),
    );
  }
}

class NewOrders extends StatefulWidget {
  const NewOrders({super.key});

  @override
  State<NewOrders> createState() => _NewOrdersState();
}

class _NewOrdersState extends State<NewOrders> {
  List orders = [];

  Future<void> fetchResponse() async {
    final url = 'https://drycleaneo.com/CleaneoDriver/api/orders';

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

  void _showOrderDetails(BuildContext context, Map order, int Count) {
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
                                  // Text(
                                  //   "Weight",
                                  //   style: TextStyle(
                                  //     fontFamily: "Inter",
                                  //     fontSize: 16,
                                  //     fontWeight: FontWeight.w500,
                                  //     color: Color(0xff1e2a52),
                                  //     height: 19 / 16,
                                  //   ),
                                  //   textAlign: TextAlign.left,
                                  // ),
                                  // Text(
                                  //   "dfb",
                                  //   style: TextStyle(
                                  //     fontFamily: "Inter",
                                  //     fontSize: 10,
                                  //     fontWeight: FontWeight.w400,
                                  //     color: Color(0xff1e2a52),
                                  //     height: 12 / 10,
                                  //   ),
                                  //   textAlign: TextAlign.left,
                                  // )
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
                                                    print(
                                                        'OrderID: ${order['OrderID']}');
                                                    String apiUrl =
                                                        'https://drycleaneo.com/CleaneoDriver/api/acceptOrder';
                                                    Map<String, String>
                                                        requestBody = {
                                                      'OrderID':
                                                          order['OrderID'],
                                                      'DeliveryAgentID':
                                                          UserData.read('ID'),
                                                      'DeliveryAgentName':
                                                          UserData.read('name'),
                                                      'DeliveryAgentPhone':
                                                          UserData.read(
                                                              'phone'),
                                                    };
                                                    String jsonBody =
                                                        jsonEncode(requestBody);
                                                    http.Response response =
                                                        await http.post(
                                                      Uri.parse(apiUrl),
                                                      headers: {
                                                        'Content-Type':
                                                            'application/json'
                                                      },
                                                      body: jsonBody,
                                                    );
                                                    if (response.statusCode ==
                                                        200) {
                                                      print(
                                                          'Order Accepted Successfully');
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                        return Count == 1
                                                            ? PickUp()
                                                            : Delivery();
                                                      }));
                                                      // You can handle the response here if needed
                                                    } else {
                                                      // Handle error if the request was not successful
                                                      print(
                                                          'Failed to sign up. Status code: ${response.statusCode}');
                                                    }
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
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    0,
                                                                    128,
                                                                    0))),
                                                    child: const Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "Accept",
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      0,
                                                                      128,
                                                                      0)),
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
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: orders.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  int Count = jsonDecode(orders[index]['status']).length;
                  int countItems = jsonDecode(orders[index]['Items']).length;

                  return GestureDetector(
                    onTap: () {
                      _showOrderDetails(context, orders[index], Count);
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      height: 75,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Row(children: [
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          width: MediaQuery.of(context).size.width * 0.3,
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
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
                        const Icon(Icons.arrow_drop_down_sharp)
                      ]),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
