import 'dart:convert';
import 'dart:math';
import 'package:cleaneo_driver_app/Global/global.dart';
import 'package:cleaneo_driver_app/Screens/Auth/OTP.dart';
import 'package:cleaneo_driver_app/Screens/WelcomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:country_code_picker/country_code_picker.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phonenoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool ispressed = false;
  PhoneNumber? phoneNumber;
  String selectedCountryCode = 'IN';
  double _opacity = 0.5;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  Future<Object> fetchResponse(String phoneNumber) async {
    final url =
        'https://drycleaneo.com/CleaneoDriver/api/signedUp/$phoneNumber';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print(response.body);
        String responseBody = response.body;

// Print the value of the "status" field

        if (responseBody == 'false') {
          setState(() {
            ispressed = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('User does not exists. Please Sign up.'),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.all(16.0),
            ),
          );
        } else {
          print('hello');
          Map<String, dynamic> responseData = json.decode(responseBody);
          loginData = responseData;
          String status = responseData['status'];
          print(status);
          OTP = (1000 + Random().nextInt(9000)).toString();

          if (status == 'P') {
            setState(() {
              ispressed = false;
            });
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return pendingg();
              },
            );
          } else if (status == 'R') {
            setState(() {
              ispressed = false;
            });
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return rejected();
              },
            );
          } else {
            fetchResponse2(phoneNumber);
          }
        }
        return response.body == 'true';
      } else {
        // If the response status code is not 200, throw an exception or handle
        // the error accordingly.
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions if any occur during the request.
      print('Error fetching data: $e');
      return false; // Return false in case of an error.
    }
  }

  Future<Object> fetchResponse2(String phoneNumber) async {
    final url =
        'http://app.pingbix.com/SMSApi/send?userid=cleaneoapp&password=EghpgNS3&sendMethod=quick&mobile=$phoneNumber&msg=Hello+${loginData['name']}%2C%0D%0AYour+OTP+for+Cleaneo+login%2Fsignup+is+%3A+$OTP.%0D%0AThank+You&senderid=CLE123&msgType=text&dltEntityId=&dltTemplateId=1207171510723882445&duplicatecheck=true&output=json';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print('otp Sent');
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return OTPPage();
        }));
        return response.body == 'true';
      } else {
        // If the response status code is not 200, throw an exception or handle
        // the error accordingly.
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions if any occur during the request.
      print('Error fetching data: $e');
      return false; // Return false in case of an error.
    }
  }

  bool tnss = false;
  @override
  Widget build(BuildContext context) {
    auth = 'login';
    var mQuery = MediaQuery.of(context);
    return AnimatedOpacity(
      opacity: _opacity, // Use the opacity variable
      duration: Duration(milliseconds: 500),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xff006acb),
          ),
          child: Column(
            children: [
              SizedBox(height: mQuery.size.height * 0.034),
              Padding(
                padding: EdgeInsets.only(
                  top: mQuery.size.height * 0.058,
                  bottom: mQuery.size.height * 0.03,
                  left: mQuery.size.width * 0.045,
                  right: mQuery.size.width * 0.045,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return WelcomePage();
                          }));
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                    SizedBox(
                      width: mQuery.size.width * 0.045,
                    ),
                    Text(
                      "Log In",
                      style: TextStyle(
                        fontSize: mQuery.size.height * 0.027,
                        color: Colors.white,
                        fontFamily: 'SatoshiBold',
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: mQuery.size.height * 0.03,
                        ),
                        // PHONE NUMBER
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: mQuery.size.width * 0.045),
                          child: Text(
                            "Phone Number*",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'SatoshiBold',
                              fontSize: mQuery.size.height * 0.02,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.01,
                        ),

                        Container(
                          width: double.infinity,
                          height: mQuery.size.height * 0.066,
                          margin: EdgeInsets.symmetric(
                              horizontal: mQuery.size.width * 0.045),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: mQuery.size.width * 0.03),
                              Icon(Icons.phone_outlined),
                              CountryCodePicker(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                dialogTextStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                onChanged: (code) {
                                  setState(() {
                                    selectedCountryCode = code.dialCode!;
                                  });
                                },
                                initialSelection: 'IN',
                                favorite: ['+91', 'IN'],
                                showCountryOnly: false,
                                showFlag: true,
                                showOnlyCountryWhenClosed: false,
                                alignLeft: false,
                              ),
                              // "|" symbol
                              SizedBox(
                                height: mQuery.size.height * 0.03,
                                child: VerticalDivider(
                                  thickness: 1.5,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(width: mQuery.size.width * 0.01),
                              // Phone number input
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  cursorColor: Colors.grey,
                                  controller: phonenoController,
                                  maxLength: 10,
                                  onChanged: (value) {
                                    setState(() {
                                      Loginphone = value;
                                    });
                                  },
                                  onSubmitted: (value) {
                                    setState(() {
                                      Loginphone = value;
                                    });
                                  },
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter
                                        .digitsOnly // Allow only numeric input
                                  ],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'SatoshiMedium'),
                                  decoration: InputDecoration(
                                    hintText: "Enter Phone Number*",
                                    hintStyle: TextStyle(
                                      fontSize: mQuery.size.height * 0.02,
                                      fontFamily: 'SatoshiMedium',
                                      color: Color(0xffABAFB1),
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 2),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    counter: SizedBox.shrink(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        (Loginphone.length > 0 && Loginphone.length < 10)
                            ? Padding(
                                padding: EdgeInsets.only(
                                    left: mQuery.size.width * 0.045),
                                child: Text(
                                  "*Please enter a valid mobile number.",
                                  style: TextStyle(
                                      fontSize: mQuery.size.height * 0.013,
                                      fontFamily: 'SatoshiMedium',
                                      color: Colors.red),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.only(
                                    left: mQuery.size.width * 0.045),
                                child: Text(
                                  "*We'll send a one time 4-digit OTP to your phone",
                                  style: TextStyle(
                                      fontSize: mQuery.size.height * 0.013,
                                      fontFamily: 'SatoshiMedium',
                                      color: Colors.grey),
                                ),
                              ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                checkColor: Color(0xffffffff),
                                activeColor: Color(0xff29b2fe),
                                value: tnss,
                                onChanged: (value) {
                                  setState(() {
                                    tnss = !tnss;
                                  });
                                },
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "By Continuing, you agree to our  ",
                                        style: TextStyle(
                                          fontSize: mQuery.size.width * 0.025,
                                          color: tnss == false
                                              ? Colors.grey
                                              : Colors.black,
                                          fontFamily: 'SatoshiRegular',
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // Navigator.push(context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) {
                                          // return TS();
                                          // }));
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.5,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(20),
                                                            topRight:
                                                                Radius.circular(
                                                                    20))),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "Terms of Service",
                                                        style: TextStyle(
                                                          fontSize: mQuery
                                                                  .size.height *
                                                              0.027,
                                                          color: Colors.black,
                                                          fontFamily:
                                                              'SatoshiBold',
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        "Welcome to our demo service! Before you begin using our platform, please read the following Terms of Service carefully. By accessing or using our service, you agree to be bound by these Terms. If you do not agree to these Terms, please do not use our service.",
                                                        style: TextStyle(
                                                            fontSize: mQuery
                                                                    .size
                                                                    .height *
                                                                0.0165,
                                                            fontFamily:
                                                                'SatoshiMedium'),
                                                      ),
                                                      SizedBox(
                                                          height: mQuery
                                                                  .size.height *
                                                              0.01),
                                                      Text(
                                                        "Welcome to our demo service! Before you begin using our platform, please read the following Terms of Service carefully. By accessing or using our service, you agree to be bound by these Terms. If you do not agree to these Terms, please do not use our service.",
                                                        style: TextStyle(
                                                            fontSize: mQuery
                                                                    .size
                                                                    .height *
                                                                0.0165,
                                                            fontFamily:
                                                                'SatoshiMedium'),
                                                      ),
                                                      SizedBox(
                                                          height: mQuery
                                                                  .size.height *
                                                              0.01),
                                                      Text(
                                                        "Welcome to our demo service! Before you begin using our platform, please read the following Terms of Service carefully. By accessing or using our service, you agree to be bound by these Terms. If you do not agree to these Terms, please do not use our service.",
                                                        style: TextStyle(
                                                            fontSize: mQuery
                                                                    .size
                                                                    .height *
                                                                0.0165,
                                                            fontFamily:
                                                                'SatoshiMedium'),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Terms of Service ",
                                              style: TextStyle(
                                                fontSize:
                                                    mQuery.size.width * 0.025,
                                                color: tnss == false
                                                    ? Colors.grey
                                                    : Colors.black,
                                                fontFamily: 'SatoshiMedium',
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor: tnss == false
                                                    ? Colors.grey
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        ' , ',
                                        style: TextStyle(
                                          fontSize: mQuery.size.width * 0.025,
                                          color: tnss == false
                                              ? Colors.grey
                                              : Colors.black,
                                          fontFamily: 'SatoshiMedium',
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // Navigator.push(context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) {
                                          // return PP();
                                          // }));
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.5,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(20),
                                                            topRight:
                                                                Radius.circular(
                                                                    20))),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "Privacy Policy",
                                                        style: TextStyle(
                                                          fontSize: mQuery
                                                                  .size.height *
                                                              0.027,
                                                          color: Colors.black,
                                                          fontFamily:
                                                              'SatoshiBold',
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        "Welcome to our demo service! Before you begin using our platform, please read the following Terms of Service carefully. By accessing or using our service, you agree to be bound by these Terms. If you do not agree to these Terms, please do not use our service.",
                                                        style: TextStyle(
                                                            fontSize: mQuery
                                                                    .size
                                                                    .height *
                                                                0.0165,
                                                            fontFamily:
                                                                'SatoshiMedium'),
                                                      ),
                                                      SizedBox(
                                                          height: mQuery
                                                                  .size.height *
                                                              0.01),
                                                      Text(
                                                        "Welcome to our demo service! Before you begin using our platform, please read the following Terms of Service carefully. By accessing or using our service, you agree to be bound by these Terms. If you do not agree to these Terms, please do not use our service.",
                                                        style: TextStyle(
                                                            fontSize: mQuery
                                                                    .size
                                                                    .height *
                                                                0.0165,
                                                            fontFamily:
                                                                'SatoshiMedium'),
                                                      ),
                                                      SizedBox(
                                                          height: mQuery
                                                                  .size.height *
                                                              0.01),
                                                      Text(
                                                        "Welcome to our demo service! Before you begin using our platform, please read the following Terms of Service carefully. By accessing or using our service, you agree to be bound by these Terms. If you do not agree to these Terms, please do not use our service.",
                                                        style: TextStyle(
                                                            fontSize: mQuery
                                                                    .size
                                                                    .height *
                                                                0.0165,
                                                            fontFamily:
                                                                'SatoshiMedium'),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Privacy Policy",
                                              style: TextStyle(
                                                fontSize:
                                                    mQuery.size.width * 0.025,
                                                color: tnss == false
                                                    ? Colors.grey
                                                    : Colors.black,
                                                fontFamily: 'SatoshiMedium',
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor: tnss == false
                                                    ? Colors.grey
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        ' and ',
                                        style: TextStyle(
                                          fontSize: mQuery.size.width * 0.025,
                                          color: tnss == false
                                              ? Colors.grey
                                              : Colors.black,
                                          fontFamily: 'SatoshiMedium',
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // Navigator.push(context,
                                          //     MaterialPageRoute(builder: (context) {
                                          // return CP();
                                          // }));
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.5,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(20),
                                                            topRight:
                                                                Radius.circular(
                                                                    20))),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "Content Policies",
                                                        style: TextStyle(
                                                          fontSize: mQuery
                                                                  .size.height *
                                                              0.027,
                                                          color: Colors.black,
                                                          fontFamily:
                                                              'SatoshiBold',
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        "Welcome to our demo service! Before you begin using our platform, please read the following Terms of Service carefully. By accessing or using our service, you agree to be bound by these Terms. If you do not agree to these Terms, please do not use our service.",
                                                        style: TextStyle(
                                                            fontSize: mQuery
                                                                    .size
                                                                    .height *
                                                                0.0165,
                                                            fontFamily:
                                                                'SatoshiMedium'),
                                                      ),
                                                      SizedBox(
                                                          height: mQuery
                                                                  .size.height *
                                                              0.01),
                                                      Text(
                                                        "Welcome to our demo service! Before you begin using our platform, please read the following Terms of Service carefully. By accessing or using our service, you agree to be bound by these Terms. If you do not agree to these Terms, please do not use our service.",
                                                        style: TextStyle(
                                                            fontSize: mQuery
                                                                    .size
                                                                    .height *
                                                                0.0165,
                                                            fontFamily:
                                                                'SatoshiMedium'),
                                                      ),
                                                      SizedBox(
                                                          height: mQuery
                                                                  .size.height *
                                                              0.01),
                                                      Text(
                                                        "Welcome to our demo service! Before you begin using our platform, please read the following Terms of Service carefully. By accessing or using our service, you agree to be bound by these Terms. If you do not agree to these Terms, please do not use our service.",
                                                        style: TextStyle(
                                                            fontSize: mQuery
                                                                    .size
                                                                    .height *
                                                                0.0165,
                                                            fontFamily:
                                                                'SatoshiMedium'),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Text(
                                          "Content Policies",
                                          style: TextStyle(
                                            fontSize: mQuery.size.width * 0.025,
                                            color: tnss == false
                                                ? Colors.grey
                                                : Colors.black,
                                            fontFamily: 'SatoshiMedium',
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: tnss == false
                                                ? Colors.grey
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: mQuery.size.height * 0.47,
                        ),
                        GestureDetector(
                          onTap: tnss == false || Loginphone.length != 10
                              ? () {
                                  print(tnss);
                                }
                              : () {
                                  setState(() {
                                    ispressed = true;
                                  });
                                  if (Loginphone.length == 10) {
                                    fetchResponse(Loginphone);
                                  } else {
                                    setState(() {
                                      ispressed = false;
                                    });
                                  }

                                  // Navigator.push(context,
                                  //     MaterialPageRoute(builder: (context) {
                                  //   return OTPPage();
                                  // }));
                                },
                          // onTap: () {
                          //   auth = 'login';
                          //   Navigator.push(context,
                          //       MaterialPageRoute(builder: (context) {
                          //     return OTPPage();
                          //   }));
                          // },
                          child: Container(
                            width: double.infinity,
                            height: mQuery.size.height * 0.06,
                            margin: EdgeInsets.symmetric(
                                horizontal: mQuery.size.width * 0.045),
                            decoration: BoxDecoration(
                                color: tnss == false || Loginphone.length != 10
                                    ? Color.fromARGB(145, 41, 179, 254)
                                    : Color(0xff29b2fe),
                                borderRadius: BorderRadius.circular(6)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    ispressed == false
                                        ? "Log In"
                                        : "Sending OTP",
                                    style: TextStyle(
                                      fontSize: mQuery.size.height * 0.02,
                                      color: Colors.white,
                                      fontFamily: 'SatoshiBold',
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  if (ispressed == true)
                                    GFLoader(
                                      type: GFLoaderType.ios,
                                      loaderColorOne: Colors.white,
                                      loaderColorThree: Colors.white,
                                      loaderColorTwo: Colors.white,
                                    )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.034,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: mQuery.size.height * 0.02,
                                fontFamily: 'SatoshiBold',
                              ),
                            ),
                            SizedBox(
                              width: mQuery.size.width * 0.02,
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigator.push(context,
                                //     MaterialPageRoute(builder: (context) {
                                //   return SignUpPage();
                                // }));
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: mQuery.size.height * 0.02,
                                    fontFamily: 'SatoshiBold',
                                    color: Color(0xff29b2fe)),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class pendingg extends StatelessWidget {
  const pendingg({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/pending.png',
              height: 100,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Sign up processing.',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                Text(
                  'Please wait while we verify.',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class rejected extends StatelessWidget {
  const rejected({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/rejected.png',
              height: 100,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign Up rejected by Admin.',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                Text(
                  'Contact your Administrator Cell.',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
