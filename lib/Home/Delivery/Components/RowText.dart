import 'package:cleaneo_driver_app/Home/Delivery/Components/deliveredDetails.dart';
import 'package:cleaneo_driver_app/Home/Delivery/Components/deliveryPending.dart';
import 'package:cleaneo_driver_app/Home/Delivery/Components/deliveryPickedUP.dart';
import 'package:cleaneo_driver_app/Home/Home_/Home.dart';
import 'package:cleaneo_driver_app/Home/Pickup/Components/Rowof2Text.dart';
import 'package:cleaneo_driver_app/Home/Pickup/Components/pendingDetailsPage.dart';
import 'package:cleaneo_driver_app/Home/Pickup/Components/rating_page.dart';
import 'package:cleaneo_driver_app/Home/StartTrip/Starttrip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_svg/svg.dart';

class TwoText extends StatefulWidget {
  const TwoText({Key? key}) : super(key: key);

  @override
  _TwoTextState createState() => _TwoTextState();
}

class _TwoTextState extends State<TwoText> {
  int _selectedIndex = 0;
  final List<String> _tabNames = ['Pending', 'Delivered'];

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    final List<List<Map<String, List<Map<String, String>>>>> _todaytabData = [
      [
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
                          fontWeight: FontWeight.bold,
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
        if (_selectedIndex == 0) DeliveryNewOrdersss(),

        if (_selectedIndex == 1) DeliveryNewPickedUpOrders()
      ],
    );
  }
}
