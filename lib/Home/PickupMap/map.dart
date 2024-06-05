import 'dart:async';
import 'dart:convert';
import 'package:cleaneo_driver_app/Home/Pickup/Components/receive_otp.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cleaneo_driver_app/Home/BotNav.dart';
import 'package:cleaneo_driver_app/Home/PickupMap/tes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

Map userVendor = {};

Future<Object> fetchResponse() async {
  final url = 'https://drycleaneo.com/CleaneoDriver/api/user_vendor/000000127';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // String responseBody = jsonDecode(response.body);
      userVendor = jsonDecode(response.body);
      print(userVendor);
      return response.body == 'true';
    } else {
      throw Exception('Failed to fetch data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching data: $e');
    return false;
  }
}
// https://drycleaneo.com/CleaneoDriver/api/user_vendor/000000127

class PickupMap extends StatefulWidget {
  Map order;
  PickupMap({super.key, required this.order});

  @override
  State<PickupMap> createState() => _PickupMapState();
}

List<LatLng> polyLineCoordinates = [];

class _PickupMapState extends State<PickupMap> {
  @override
  void initState() {
    super.initState();
    getPolyPoints();
    fetchResponse();
  }




  bool showMapSample = polyLineCoordinates.isNotEmpty;
  void openGoogleMaps() async {
    // Replace latitude and longitude with the actual location you want to open.

    String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=${double.parse(widget.order['UserLatitude'])}, ${double.parse(widget.order['UserLongitude'])}';

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

  Future<void> getPolyPoints() async {
    polyLineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    print(double.parse(widget.order['UserLatitude']));
    print(double.parse(widget.order['UserLongitude']));

    try {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          "AIzaSyDnWZjHoz1I8bgvQjBSa4MEpTRE3cnBzPA",
          PointLatLng(30.32428, 78.04128),
          PointLatLng(double.parse(widget.order['UserLatitude']),
              double.parse(widget.order['UserLongitude'])));
      if (result.points.isNotEmpty) {
        setState(() {
          result.points.forEach((PointLatLng point) {
            polyLineCoordinates.add(LatLng(point.latitude, point.longitude));
          });
        });
      }
      print(polyLineCoordinates);
    } catch (error) {
      print(error);
    }
  }

  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    List items = jsonDecode(widget.order['Items']);

    Map<String, List<String>> groupedItems = {};
    for (var item in items) {
      if (!groupedItems.containsKey(item['type'])) {
        groupedItems[item['type']] = [];
      }
      groupedItems[item['type']]!.add(item['name']);
    }
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);

        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            showMapSample
                ? MapSample(
                    orders: widget.order,
                  )
                : Center(child: CircularProgressIndicator()),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.05,
              child: IconButton(
                onPressed: () {
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (_) => Alogin()));
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            Positioned(
                child: SlidingUpPanelWidget(
                    controlHeight: MediaQuery.of(context).size.height * 0.3,
                    panelController: SlidingUpPanelController(),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                          children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: 4,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 197, 197, 197),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: const Divider(
                                  color: Color.fromARGB(255, 197, 197, 197),
                                  thickness: 2,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.shopping_bag_outlined),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Order ID :",
                                        style: TextStyle(
                                          fontFamily: "Inter",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff1e2a52),
                                          height: 19 / 16,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        widget.order['OrderID'],
                                        // mapdata.isEmpty
                                        //     ? "Loading"
                                        //     : "${mapdata[0]['order_ID'].toString().substring(0, 5)}",
                                        style: TextStyle(
                                          fontFamily: "Inter",
                                          fontSize: 8,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff1e2a52),
                                          height: 19 / 16,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  openGoogleMaps();
                                },
                                child: Container(
                                  height: 30,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "Show Direction",
                                    style: TextStyle(color: Colors.blue),
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: mQuery.size.height*0.016,),
                            Divider(),
                            SizedBox(height: mQuery.size.height*0.016,),
                            /// here  the List of
                            /// services here

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
                            SizedBox(height: mQuery.size.height*0.016,),
                            Padding(
                              padding: const EdgeInsets.only(left: 25, right: 25),
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Color.fromARGB(255, 212, 212, 212),
                                          spreadRadius: 1,
                                          blurRadius: 10)
                                    ]),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width:
                                      MediaQuery.of(context).size.width * 0.2,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'esgvsxb',
                                            // mapdata.isEmpty
                                            //     ? "Loading"
                                            //     : "Rs. ${mapdata[0]['Drivers_earning']}",
                                            style: TextStyle(
                                              fontFamily: "Inter",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff1e2a52),
                                              height: 19 / 16,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          AutoSizeText(
                                            "Total Earning",
                                            minFontSize: 7,
                                            maxFontSize: 10,
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
                                      color:
                                      const Color.fromARGB(255, 207, 207, 207),
                                    ),
                                    Container(
                                      width:
                                      MediaQuery.of(context).size.width * 0.2,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'dvsb',
                                            // mapdata.isEmpty
                                            //     ? "Loading"
                                            //     : "Rs. ${mapdata[0]['Total_price']}",
                                            style: TextStyle(
                                              fontFamily: "Inter",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff1e2a52),
                                              height: 19 / 16,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          AutoSizeText(
                                            "Total Billing Amount",
                                            minFontSize: 7,
                                            maxFontSize: 10,
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
                            ),
                        SizedBox(height: mQuery.size.height*0.032,),


                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color.fromARGB(255, 212, 212, 212),
                                      spreadRadius: 1,
                                      blurRadius: 10)
                                ]),
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                   Row(
                                     children: [
                                       Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Row(
                                             children: [
                                               Text(
                                                 "Sender's Name :",
                                                 style: TextStyle(
                                                   fontFamily: "Inter",
                                                   color: Color(0xff1e2a52),
                                                   height: 19 / 16,
                                                 ),
                                                 textAlign: TextAlign.left,
                                               ),
                                               Text(
                                                 '${userVendor['UserName']}',
                                                 style: TextStyle(
                                                   fontFamily: "Inter",
                                                   color: Color(0xff1e2a52),
                                                   height: 19 / 16,
                                                 ),
                                                 textAlign: TextAlign.left,
                                               ),
                                             ],
                                           ),
                                           Text(
                                             "Sender's Mob.: "
                                                 "${userVendor['UserPhone']}",
                                             style: TextStyle(
                                               fontFamily: "Inter",
                                               color: Color(0xff1e2a52),
                                               height: 19 / 16,
                                             ),
                                             textAlign: TextAlign.left,
                                           ),
                                         ],
                                       ),
                                       Expanded(child: SizedBox()),
                                       SvgPicture.asset("assets/images/TelephoneIcon.svg",
                                         width: mQuery.size.width*0.07,
                                         color: Color(0xff29b2fe),)
                                     ],
                                   ),
                                    SizedBox(height: mQuery.size.height*0.016,),
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
                                      "Floor : ${widget.order['Floor']}\n${widget.order['Caddress']}\nHow to Reach : ${widget.order['HTReach']}",
                                      style: TextStyle(
                                        fontFamily: "Inter",
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff1e2a52),
                                        height: 12 / 10,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                        SizedBox(height: mQuery.size.height*0.023,),


                        /// ????
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color.fromARGB(255, 212, 212, 212),
                                      spreadRadius: 1,
                                      blurRadius: 10)
                                ]),
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Sender's Name :",
                                                  style: TextStyle(
                                                    fontFamily: "Inter",
                                                    color: Color(0xff1e2a52),
                                                    height: 19 / 16,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                                Text(
                                                  '${userVendor['VendorName']}',
                                                  style: TextStyle(
                                                    fontFamily: "Inter",
                                                    color: Color(0xff1e2a52),
                                                    height: 19 / 16,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "Sender's Mob.: "
                                                  "${userVendor['VendorPhone']}",
                                              style: TextStyle(
                                                fontFamily: "Inter",
                                                color: Color(0xff1e2a52),
                                                height: 19 / 16,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                        Expanded(child: SizedBox()),
                                        SvgPicture.asset("assets/images/TelephoneIcon.svg",
                                          width: mQuery.size.width*0.07,
                                          color: Color(0xff29b2fe),)
                                      ],
                                    ),

                                    SizedBox(height: mQuery.size.height*0.016,),
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

                                    SizedBox(
                                      height: 10,
                                    ),

                                    Text(
                                      "${widget.order['VendorAddress']}",
                                      style: TextStyle(
                                        fontFamily: "Inter",
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff1e2a52),
                                        height: 12 / 10,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),



                                  ]),
                            ),
                          ),
                        ),
                        SizedBox(height: mQuery.size.height*0.023,),


                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: TextButton(
                              onPressed: () {
                                // Navigator.push(context,
                                //     MaterialPageRoute(builder: (_) => otp1()));
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                                  return ReceiveOTPage();
                                }),
                                        (route) => false);
                              },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.060,
                                width: MediaQuery.of(context).size.width * 0.86,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 0, 128, 0))),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Receive Order",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color:
                                              Color.fromARGB(255, 0, 128, 0)),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                      ]),
                    )))
          ],
        ),
      ),
    );
  }
}

class MapSample extends StatefulWidget {
  Map orders;
  MapSample({super.key, required this.orders});

  @override
  State<MapSample> createState() => MapSampleState();
}

List<Map<String, dynamic>> mapdata = [];
List<Map<String, dynamic>> mapdata2 = [];

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.32428, 78.04128),
    zoom: 16.4746,
  );

  @override
  Widget build(BuildContext context) {
    print(double.parse(widget.orders['UserLongitude']));
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 1,
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          polylines: {
            Polyline(
              polylineId: PolylineId('route'),
              points: polyLineCoordinates,
              width: 3,
              color: Color.fromARGB(255, 185, 05, 05),
            ),
          },
          markers: {
            // ignore: prefer_const_constructors
            Marker(
                markerId: MarkerId('Source'),
                position: LatLng(30.32428, 78.04128),
                infoWindow: InfoWindow(title: "Your Location")),
            Marker(
                markerId: MarkerId('Destination'),
                position: LatLng(double.parse(widget.orders['UserLatitude']),
                    double.parse(widget.orders['UserLongitude'])),
                infoWindow: InfoWindow(title: "Destination Location"))
          },
          // onMapCreated: (GoogleMapController controller) {
          //   _controller.complete(controller);
          // },
        ),
      ),
    );
  }
}
