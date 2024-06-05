import 'package:camera/camera.dart';
import 'package:cleaneo_driver_app/Home/BotNav.dart';
import 'package:cleaneo_driver_app/Home/StartTrip/components/pickupOrderSummary.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

import '../Pickup/Components/cameraScreen.dart';

TextEditingController searchController = TextEditingController();
TextEditingController searchController2 = TextEditingController();
TextEditingController messageController = TextEditingController();

var userName = "Shweta";
var isChecked1 = false;
var isChecked2 = false;
var isChecked3 = false;

var distance = 1.2;

class StartTripPage extends StatefulWidget {
  const StartTripPage({Key? key}) : super(key: key);

  @override
  State<StartTripPage> createState() => _StartTripPageState();
}

class _StartTripPageState extends State<StartTripPage> {




  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/maps.png"),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: mQuery.size.width * 0.045),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: mQuery.size.height * 0.08),
                Container(
                  width: double.infinity,
                  height: mQuery.size.height * 0.065,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Center(
                    child: TextField(
                      controller: searchController,
                      cursorColor: Colors.black54,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => BotNav()),
                            );
                          },
                          child: Icon(Icons.arrow_back),
                        ),
                        suffixIcon: Icon(Icons.close),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: mQuery.size.height * 0.18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: mQuery.size.width * 0.78,
                      height: mQuery.size.height * 0.08,
                      padding: EdgeInsets.symmetric(
                          horizontal: mQuery.size.width * 0.04),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              width: mQuery.size.width * 0.09,
                              height: mQuery.size.height * 0.06,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff009c1a),
                              ),
                              child: Center(
                                child: Image.asset(
                                  "assets/images/drawer-images/heart.png",
                                  color: Colors.white,
                                  width: mQuery.size.width * 0.04,
                                ),
                              ),
                            ),
                            SizedBox(width: mQuery.size.width * 0.016),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Pickup from $userName",
                                  style: TextStyle(
                                    fontFamily: 'SatoshiBold',
                                    fontSize: mQuery.size.height * 0.016,
                                  ),
                                ),
                                SizedBox(height: mQuery.size.height*0.002,),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                      return PickUpOrderSummary();
                                    }));
                                  },
                                  child: Text(
                                    "VIEW ORDER SUMMARY",
                                    style: TextStyle(
                                      color: Color(0xff29b2fe),
                                      fontSize: mQuery.size.height * 0.014,
                                      fontFamily: 'SatoshiMedium',
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // _openBottomOrderSummary(context);
                                    // OpenBottomSummary();
                                  },
                                  child: Container(
                                    width: mQuery.size.width * 0.33,
                                    color: Color(0xff29b2fe),
                                    height: mQuery.size.height * 0.002,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(width: mQuery.size.width * 0.036),
                            GestureDetector(
                              onTap: () {
                                _openBottomNotification(context);
                              },
                              child: Container(
                                width: mQuery.size.width * 0.09,
                                height: mQuery.size.height * 0.06,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffff474b),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    "assets/images/send.png",
                                    width: mQuery.size.width * 0.04,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: mQuery.size.width * 0.015),
                            Container(
                              width: mQuery.size.width * 0.09,
                              height: mQuery.size.height * 0.06,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff29b2fe),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                  size: mQuery.size.width * 0.05,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: mQuery.size.height * 0.37),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: mQuery.size.width * 0.13,
                      height: mQuery.size.height * 0.2,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Icon(Icons.location_searching),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }



  void _openBottomNotification(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        var mQuery = MediaQuery.of(context);
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: mQuery.size.height * 0.75,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: mQuery.size.height * 0.03),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: mQuery.size.width * 0.045),
                      child: Text(
                        "Send Notification",
                        style: TextStyle(
                          fontFamily: 'SatoshiBold',
                          fontSize: mQuery.size.height * 0.025,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mQuery.size.height * 0.02,
                    ),
                    Divider(),
                    SizedBox(
                      height: mQuery.size.height * 0.017,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: mQuery.size.width * 0.045),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "I have arrived",
                            style: TextStyle(
                              fontFamily: 'SatoshiMedium',
                              fontSize: mQuery.size.height * 0.022,
                            ),
                          ),
                          SizedBox(height: mQuery.size.height * 0.023),
                          buildCheckbox(
                            "I am waiting by your door",
                            isChecked1,
                            (value) {
                              setState(() {
                                isChecked1 = value!;
                              });
                            },
                          ),
                          SizedBox(height: mQuery.size.height * 0.024),
                          buildCheckbox(
                            "The door is locked",
                            isChecked2,
                            (value) {
                              setState(() {
                                isChecked2 = value!;
                              });
                            },
                          ),
                          SizedBox(height: mQuery.size.height * 0.024),
                          buildCheckbox(
                            "Wrong address mentioned",
                            isChecked3,
                            (value) {
                              setState(() {
                                isChecked3 = value!;
                              });
                            },
                          ),
                          SizedBox(height: mQuery.size.height * 0.025),
                          Divider(),
                          Text(
                            "Any other message?",
                            style: TextStyle(
                              fontFamily: 'SatoshiBold',
                              fontSize: mQuery.size.height * 0.025,
                            ),
                          ),
                          SizedBox(
                            height: mQuery.size.height * 0.02,
                          ),
                          Container(
                            width: double.infinity,
                            height: mQuery.size.height * 0.13,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0.3,
                                  blurRadius: 10,
                                  offset: Offset(0,
                                      0), // changes the position of the shadow
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: messageController,
                              cursorColor: Colors.black54,
                              maxLines: null,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Write your message here",
                                  hintStyle: TextStyle(
                                      fontSize: mQuery.size.height * 0.02,
                                      fontFamily: 'SatoshiMedium',
                                      color: Colors.black54),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 8)),
                            ),
                          ),
                          SizedBox(
                            height: mQuery.size.height * 0.055,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: double.infinity,
                              height: mQuery.size.height * 0.058,
                              decoration: BoxDecoration(
                                  color: Color(0xff29b2fe),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Center(
                                child: Text(
                                  "Notify",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'SatoshiBold',
                                      fontSize: mQuery.size.height * 0.023),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildCheckbox(
      String title, bool value, ValueChanged<bool?> onChanged) {
    var mQuery = MediaQuery.of(context);
    return Container(
      width: double.infinity,
      height: mQuery.size.height * 0.05,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          Checkbox(
            activeColor: Color(0xff29b2fe),
            value: value,
            onChanged: onChanged,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: mQuery.size.height * 0.017,
              fontFamily: 'SatoshiMedium',
            ),
          )
        ],
      ),
    );
  }

}



